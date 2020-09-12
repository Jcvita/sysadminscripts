#script1.sh checks what the default gateway is and uses ping check your connection to the default gatway, a remote server and the dns server.

#get gateway from ip route command
GATEWAY=$(ip route | awk '/default/ { print $3 }')
#pings the gatewy and store successful into the variable if ping works
GATEWAYCON=$(ping -c 1 $GATEWAY > /dev/null && echo "\e[42mSUCCESSFUL" || echo "\e[41mUNSUCCESSFUL")
#pings google's server and store successful if ping works
REMOTECON=$(ping -c 1 8.8.8.8 > /dev/null && echo "\e[42mSUCCEDED" || echo "\e[41mFAILED")
#pings google's server by its dns name and store successful if ping works
DNSCON=$(ping -c 1 www.google.com > /dev/null && echo "\e[42mSUCCEDED" || echo "\e[41mFAILED")
clear
echo "-----------------------------------------------"
echo "************** Beginning Test ***************"
echo "                     5"
echo "                     4"
echo "			   3"
echo " 			   2"
echo "                     1"
echo ""
echo -e "\e[49mYour default gateway is $GATEWAY"
echo ""
echo -e "\e[49mConnection to default gateway is $GATEWAYCON"
echo ""
echo -e "\e[49mRemote Connection $REMOTECON"
echo ""
echo -e "\e[49mDNS resolution $DNSCON"
echo -e "\e[49m"
echo "************* Test Complete. ****************"
echo "-----------------------------------------------"
