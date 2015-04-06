From: Hans de Bruin <jmdebruin@xmsnet.nl>
Subject: 4.0.0-rc mouse/keyboard events get stuck
Date: Mon, 06 Apr 2015 20:39:43 +0200
Message-ID: <5522D2EF.9070505@xmsnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-3.concepts.nl ([213.197.30.127]:52709 "EHLO
	smtp-3.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbDFSyz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Apr 2015 14:54:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>

Since 4.0.0-rc something mu laptop has some mouse /keyboard problems.
When I play KDE kpatience, a card game, card stick to my mousepointer: 
left mouse button down on a card, move mouse pointer and card to another 
place. left mouse button up to drop the card. This should drop the card, 
but often the mouse button up events gets stuck somewhere until I move 
he mouse pointer a little bit.
In web based mail clients something similar happens when I drag mail to 
another folder.
Sometime after I start a xterm and start typing, the letters don't 
appear until move the mouse pointer.

Bisecting is out of the question. This kernel realease was so dramatic I 
was glad to have functioning kde screen when rc4 arrived.

My laptop is a Dell Latitude D430, it has a touchpad and a pointer an 
two sets of buttons.

dmesg
[    0.636492] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input4
[    0.633108] mousedev: PS/2 mouse device common for all mice
[   80.543044] input: PS/2 ALPS Mouse as 
/devices/platform/i8042/serio1/input/input8

-- 
Hans
