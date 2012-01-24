From: Bastien Nocera <hadess@hadess.net>
Subject: Hints needed for iCade driver
Date: Tue, 24 Jan 2012 13:03:15 +0000
Message-ID: <1327410195.31947.6.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52613 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab2AXNDT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 08:03:19 -0500
Received: from mfilter7-d.gandi.net (mfilter7-d.gandi.net [217.70.178.136])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id DAC0A1720A5
	for <linux-input@vger.kernel.org>; Tue, 24 Jan 2012 14:03:17 +0100 (CET)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter7-d.gandi.net (mfilter7-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id hA5tQl4AcfOg for <linux-input@vger.kernel.org>;
	Tue, 24 Jan 2012 14:03:16 +0100 (CET)
Received: from [192.168.1.94] (94-192-232-89.zone6.bethere.co.uk [94.192.232.89])
	(Authenticated sender: hadess@hadess.net)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7E1CE1720A1
	for <linux-input@vger.kernel.org>; Tue, 24 Jan 2012 14:03:16 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Neat! A Bluetooth input device:
http://www.ionaudio.com/products/details/icade
I've had this machine sitting in its box by my desk for 6 months, and
finally opened it.

After writing a better pairing mechanism, I'd like to see what's needed
to make this device into a "proper" joystick.

>From the developer manual:
http://www.ionaudio.com/downloads/iCade_Dev_Resource_v1.3.pdf

The device is a Bluetooth HID device. Once paired, the various buttons
and directions will generate a key press/release for each key press and
key release. For example, pressing the first button will generate:
KEY_Y press
KEY_Y release
Releasing that same first button will generate:
KEY_T press
KEY_T release

What would be the best way to handle that sort of device? Do we have any
good example of devices that behave this way, and of a barebones
joystick driver?

Cheers

