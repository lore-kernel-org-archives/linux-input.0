From: TJ <linux@iam.tj>
Subject: [bug 117601]  ELAN 3320KD-3100 'Smart-Pad' not supported (in Asus  T300CHI)
Date: Tue, 03 May 2016 23:24:17 +0100
Message-ID: <c740769b3960f99619149e467aa390a9@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yes.iam.tj ([109.74.197.121]:59912 "EHLO iam.tj"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756519AbcECWYT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 May 2016 18:24:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=117601

Summary:

The ELAN 3320KD-3100 multi-touch controller chip is a 64-pin QFD 
package. In the Asus T300CHI it is behind a BCM20730-A1KFBG Bluetooth 
radio controller in a detachable keyboard/trackpad dock.

It identifies with the Asus ID 0B05:8502.

It works as a mouse but there is no scroll or gesture support.

$ cat /proc/bus/input/devices
...
I: Bus=0005 Vendor=0b05 Product=8502 Version=0001
N: Name="ASUS T300CHI DOCKING"
P: Phys=34:02:86:fc:ad:59
S: 
Sysfs=/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4:1.0/bluetooth/hci0/hci0:256/0005:0B05:8502.002B/input/input57
U: Uniq=1c:b7:2c:04:c7:fe
H: Handlers=sysrq kbd mouse3 event15 leds
B: PROP=0
B: EV=12001f
B: KEY=20 0 0 2000 40000000000000 30000 1000002000007 ff9f387ad9405fff 
febeffdfffefffff fffffffffffffffe
B: REL=303
B: ABS=70000000000
B: MSC=10
B: LED=1f
