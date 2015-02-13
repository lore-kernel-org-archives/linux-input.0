From: Martin Herkt <9@cirno.systems>
Subject: elantech: Support for ElanTech touchpad, fw 0x480f0a
Date: Fri, 13 Feb 2015 22:19:08 +0100
Message-ID: <3635013.z7hF9RsVDZ@sakuya>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from srsfckn.biz ([148.251.137.227]:35941 "EHLO srsfckn.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbbBMV01 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Feb 2015 16:26:27 -0500
Received: from cirno.systems (dslb-088-068-183-166.088.068.pools.vodafone-ip.de [88.68.183.166])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by srsfckn.biz (Postfix) with ESMTPSA id 7D2591876000
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2015 22:19:09 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello. First time posting to a Linux ML, new to drivers in general.

So I got an ASUS PU551LD laptop and quickly found out Linux 3.18.3 wasn't 
detecting the touchpad correctly. After some digging, I figured out that it is 
an ElanTech touchpad which reports firmware version 0x480f0a, then poked 
around in drivers/input/mouse/elantech.c and tried changing 
'elantech_is_signature_valid' to always return true. This made the device work 
properly with all the expected features, and it shows up in dmesg like this:

psmouse serio4: elantech: assuming hardware version 4 (with firmware version 
0x480f0a)
psmouse serio4: elantech: Synaptics capabilities query result 0x40, 0x17, 
0x0c.
input: ETPS/2 Elantech Touchpad as /devices/platform/i8042/serio4/input/input8

Now of course I want to help getting support for this particular model into 
the kernel, but I would feel bad about posting a patch that just adds more 
magic numbers to the function in question. Any suggestions?
