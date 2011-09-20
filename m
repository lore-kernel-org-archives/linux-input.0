From: Bastien Nocera <hadess@hadess.net>
Subject: Race with Bluetooth hid drivers?
Date: Tue, 20 Sep 2011 02:35:33 +0100
Message-ID: <1316482533.2468.6.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53899 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1ITBfi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 21:35:38 -0400
Received: from mfilter11-d.gandi.net (mfilter11-d.gandi.net [217.70.178.131])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 80FFCA8079
	for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 03:35:36 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter11-d.gandi.net (mfilter11-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id At3DezhOYBAT for <linux-input@vger.kernel.org>;
	Tue, 20 Sep 2011 03:35:35 +0200 (CEST)
Received: from [192.168.1.65] (94-192-232-89.zone6.bethere.co.uk [94.192.232.89])
	(Authenticated sender: hadess@hadess.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 01BFBA8068
	for <linux-input@vger.kernel.org>; Tue, 20 Sep 2011 03:35:34 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Heya,

I'm pretty certain that's already been discussed, but can't seem to find
the thread in question, or whether somebody sent patches for the issue.

The problem I see is that the input device is advertised really early in
its creation, and seems to be missing information when udev (and layers
above it in the stack) probes it.

Using Linux 3.1.0 rc6

Turning on a Bluetooth Wacom tablet I see the following udev events:
UDEV  [1890.604848] add      /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:42/input10 (input)
UDEV_LOG=3
ACTION=add
DEVPATH=/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:42/input10
SUBSYSTEM=input
PRODUCT=5/56a/81/100
NAME="WACOM Pen Tablet"
PHYS="00:13:EF:F1:42:B7"
UNIQ="00:13:C2:03:3D:D6"
PROP=0
EV=17
KEY=70000 0 0 0 0
REL=103
MSC=10
MODALIAS=input:b0005v056Ap0081e0100-e0,1,2,4,k110,111,112,r0,1,8,am4,lsfw
SEQNUM=2391
ID_INPUT=1
ID_INPUT_MOUSE=1
ID_PATH=pci-0000:00:1a.0-usb-0:1.1:1.0
ID_PATH_TAG=pci-0000_00_1a_0-usb-0_1_1_1_0
ID_FOR_SEAT=input-pci-0000_00_1a_0-usb-0_1_1_1_0
TAGS=:seat:

If I do a udev database dump I see:
P: /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:42/input10
E: UDEV_LOG=3
E: DEVPATH=/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/bluetooth/hci0/hci0:42/input10
E: PRODUCT=5/56a/81/100
E: NAME="WACOM Pen Tablet"
E: PHYS="00:13:EF:F1:42:B7"
E: UNIQ="00:13:C2:03:3D:D6"
E: PROP=0
E: EV=1f
E: KEY=1c63 70003 0 0 0 0
E: REL=103
E: ABS=3000003
E: MSC=11
E: MODALIAS=input:b0005v056Ap0081e0100-e0,1,2,3,4,k100,101,110,111,112,140,141,145,146,14A,14B,14C,r0,1,8,a0,1,18,19,m0,4,lsfw
E: SUBSYSTEM=input
E: ID_INPUT=1
E: ID_INPUT_MOUSE=1
E: ID_PATH=pci-0000:00:1a.0-usb-0:1.1:1.0
E: ID_PATH_TAG=pci-0000_00_1a_0-usb-0_1_1_1_0
E: ID_FOR_SEAT=input-pci-0000_00_1a_0-usb-0_1_1_1_0
E: TAGS=:seat:

See the different KEY= value, and the presence of the ABS= key. If the
tablet was probed at this point it would have the ID_INPUT_TABLET=1
property (as running input_id by hand shows).

Any ideas?

