#!/bin/sh
          PATH_1="mytestingrepo/src/Kerry.SSP.Orders.API/*"
          PATH_2="mytestingrepo/src/Kerry.SSP.User.API/*"
          CHANGED_FILES=$(git diff HEAD HEAD~ --name-only)

 

                        echo "Checking for file changes..."
                        for FILE in $CHANGED_FILES; do
                          if [[ $FILE == *$PATH_1* ]]; then
                            echo "MATCH:  ${FILE} changed"
                          elif [[ $FILE == *$PATH_2* ]]; then
                            echo "MATCH:  ${FILE} changed"
                          else
                            echo "IGNORE: ${FILE} changed"
                          fi
                        done
