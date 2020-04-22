# Post Package install configurations

# enable reptyr
sudo echo 1 > /etc/sysctl.d/10-ptrace.conf

# mongodb
# docker                      after  gpasswd -a "$MAIN_USER_USERNAME" docker
# mutimedia                   after gpasswd -a "$MAIN_USER_USERNAME" video