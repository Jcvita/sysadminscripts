GATEWAY=$(ip route | awk '/default/ { print $3 }')
GATEWAYCON=$(ping -c 1 $GATEWAY > /dev/null && echo "\e[42mSUCCESSFUL" || echo "\e[41mUNSUCCESSFUL")
REMOTECON=$(ping -c 1 8.8.8.8 > /dev/null && echo "\e[42mSUCCEDED" || echo "\e[41mFAILED")
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
