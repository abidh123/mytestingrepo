#!/bin/sh
          PATH_1="src/Kerry.SSP.Orders.API"
          PATH_2="src/Kerry.SSP.User.API"
          CHANGED_FILES=$(git diff HEAD HEAD~ --name-only)

 

                        echo "Checking for file changes..."
                        for FILE in $CHANGED_FILES; do
                          if [[ $FILE == *$PATH_1* ]]; then
                            echo "MATCH:  ${FILE} changed"
                            echo "##vso[task.setvariable variable=Orders_Changed]true"
                            echo "$(Orders_Changed)"
                          elif [[ $FILE == *$PATH_2* ]]; then
                            echo "MATCH:  ${FILE} changed"
                            echo "##vso[task.setvariable variable=User_Changed]true"
                            echo "
                          else
                            echo "IGNORE: ${FILE} changed"
                          fi
                        done
