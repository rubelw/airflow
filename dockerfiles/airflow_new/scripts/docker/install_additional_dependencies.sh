# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# shellcheck shell=bash disable=SC2086
set -euo pipefail

if [ -s "${UPGRADE_TO_NEWER_DEPENDENCIES}" ]; then
    echo "UPGRADE_TO_NEWER_DEPENDENCIES should be set"
    exit 1
fi

if [ -s "${ADDITIONAL_PYTHON_DEPS}" ]; then
    echo "ADDITIONAL_PYTHON_DEPS should be set"
    exit 1
fi
if [ -s "${EAGER_UPGRADE_ADDITIONAL_REQUIREMENTS}" ]; then
    echo "EAGER_UPGRADE_ADDITIONAL_REQUIREMENTS should be set"
    exit 1
fi
if [ -s "${AIRFLOW_PIP_VERSION}" ]; then
    echo "AIRFLOW_PIP_VERSION should be set"
    exit 1
fi

# shellcheck source=scripts/docker/common.sh
source /scripts/docker/common.sh


# Installs additional dependencies passed as Argument to the Docker build command
function install_additional_dependencies() {
    if [[ "${UPGRADE_TO_NEWER_DEPENDENCIES}" != "false" ]]; then
        echo
        echo "${COLOR_BLUE}Installing additional dependencies while upgrading to newer dependencies${COLOR_RESET}"
        echo
        set -x
        pip install --upgrade --upgrade-strategy eager \
            ${ADDITIONAL_PIP_INSTALL_FLAGS} \
            ${ADDITIONAL_PYTHON_DEPS} ${EAGER_UPGRADE_ADDITIONAL_REQUIREMENTS}
        # make sure correct PIP version is used
        pip install --disable-pip-version-check "pip==${AIRFLOW_PIP_VERSION}" 2>/dev/null
        set +x
        echo
        echo "${COLOR_BLUE}Running 'pip check'${COLOR_RESET}"
        echo
        pip check
    else
        echo
        echo "${COLOR_BLUE}Installing additional dependencies upgrading only if needed${COLOR_RESET}"
        echo
        set -x
        pip install --upgrade --upgrade-strategy only-if-needed \
            ${ADDITIONAL_PIP_INSTALL_FLAGS} \
            ${ADDITIONAL_PYTHON_DEPS}
        # make sure correct PIP version is used
        pip install --disable-pip-version-check "pip==${AIRFLOW_PIP_VERSION}" 2>/dev/null
        set +x
        echo
        echo "${COLOR_BLUE}Running 'pip check'${COLOR_RESET}"
        echo
        pip check
    fi
}

common::get_colors
common::get_airflow_version_specification
common::override_pip_version_if_needed
#common::get_constraints_location
common::show_pip_version_and_location

install_additional_dependencies
