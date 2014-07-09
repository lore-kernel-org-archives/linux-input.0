From: andrea <mariofutire@googlemail.com>
Subject: PS3 controller and vibration
Date: Wed, 09 Jul 2014 20:40:46 +0100
Message-ID: <lpk5ru$5ak$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46265 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbaGITlG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 15:41:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1X4xji-0005Vc-8R
	for linux-input@vger.kernel.org; Wed, 09 Jul 2014 21:41:02 +0200
Received: from cpc17-heme9-2-0-cust39.9-1.cable.virginm.net ([82.19.7.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2014 21:41:02 +0200
Received: from mariofutire by cpc17-heme9-2-0-cust39.9-1.cable.virginm.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Wed, 09 Jul 2014 21:41:02 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I've got a PS3 controller (sixaxis written on the back)

PLAYSTATION(R)3 Controller as
/devices/pci0000:00/0000:00:1d.1/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:72/0005:054C:0268.0002/input/input10
BLUETOOTH HID v1.00 Joystick [PLAYSTATION(R)3 Controller] on 00:1a:7d:da:71:0b

using bluez 5.18 on Fedora 20, kernel 3.15.3

it is connected via bluetooth.

It does not vibrate.
I've tried to write to /dev/hidraw0 and used love2d.

I read online either than I need to enable the vibration or that the sixaxis does not support it.
I am pretty sure it has vibrated on some games on the PS3.

Does anybody know how it works?

Andrea

