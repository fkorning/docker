# .bash_ssh:        configure ssh agent and load keys with ssh-add 


# .ssh dir
mkdir -p ~/.ssh
chmod 755 ~/.ssh
 

# ssh agent

SSH_ENV="$HOME/.ssh/ssh_agent"

 
echo ""
echo "Initialising SSH agent"


# unconditionally start a new ssh agent and persist it in user .ssh dir
function start_agent {
     ssh-agent -s | sed 's/^echo.*//g' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     ssh-add ~/.ssh/*id_rsa
}
 

# main: reuse agent if it persisted and runnning otherwise start agent
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

 
echo SSH Agent: pid=${SSH_AGENT_PID} sock=${SSH_AUTH_SOCK}


ssh-add -D
ssh-add ~/.ssh/id_bitbucket
ssh-add ~/.ssh/id_sourceforge
ssh-add ~/.ssh/id_github

