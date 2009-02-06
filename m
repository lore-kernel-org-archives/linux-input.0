From: Bastien Nocera <hadess@hadess.net>
Subject: Logitech MX5000 extra keys
Date: Fri, 06 Feb 2009 19:24:39 +0000
Message-ID: <1233948279.8950.75.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:56648 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073AbZBFTZA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2009 14:25:00 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n16JOxYA013171
	for <linux-input@vger.kernel.org>; Fri, 6 Feb 2009 14:24:59 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n16JOwjV003654
	for <linux-input@vger.kernel.org>; Fri, 6 Feb 2009 14:24:59 -0500
Received: from [10.11.12.79] (vpn-12-79.rdu.redhat.com [10.11.12.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n16JOv5r018872
	for <linux-input@vger.kernel.org>; Fri, 6 Feb 2009 14:24:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Heya,

I own another keyboard, the Logitech MX5000[1], which is a
keyboard/mouse combo, with a USB dongle (which can switch between HID
and HCI/Bluetooth modes).

Some keys aren't reported at all through the input layer, but there is
code in the mx5000-tools[2] to make those keys work through hiddev.

See eventin():
http://svn.gna.org/viewcvs/mx5000tools/trunk/mx5000d/input_translate.c?rev=15&view=auto

There's a bit more scary code to enable the keys in the library part of
the module.

I was wondering what the best course of action would be to make this
code work out-of-the-box. Would it be better to write a HAL addon, and
do all this work in user-space, or would it be more useful to have
directly in the kernel?

Obviously, if the latter, I'd appreciate a bit of guidance on where I
should add the code.

Cheers


[1]: http://www.amazon.com/Logitech-Cordless-Desktop-Laser-967558-0403/dp/B000AY5ZIS
[2]: http://home.gna.org/mx5000tools/

