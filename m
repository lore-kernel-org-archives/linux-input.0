From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Lenovo Yoga 13 touchpad regression
Date: Mon, 06 May 2013 22:25:46 -0700
Message-ID: <5188905A.4020703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:50729 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3EGFZs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 May 2013 01:25:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello,

The touchpad on Lenovo Yoga 13 seems to have broken some time between 
3.4 and the current kernel.  The dmesg is full of spewage:

[  256.246481] atkbd serio0: Use 'setkeycodes e03e <keycode>' to make it 
known.
[  256.251473] atkbd serio0: Unknown key released (translated set 2, 
code 0xbe on isa0060/serio0

... about once per second; I am wondering if the touchpad is spewing 
output onto the keyboard channel or if there is something else wrong.

I have tried i8042.nomux and i8042.noloop to no effect.

Unless someone has a better idea I'll try to do a bisect.

	-hpa
