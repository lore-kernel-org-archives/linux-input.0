From: Wladimir Mutel <mwg@mwg.dp.ua>
Subject: support for some types of Asus+Elantech touchpads
Date: Tue, 1 Dec 2015 21:59:28 +0200
Message-ID: <565DFC20.7070303@mwg.dp.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from volcano.apex.dp.ua ([195.24.128.84]:48490 "EHLO
	volcano.apex.dp.ua" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbbLAUdo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 15:33:44 -0500
Received: from [213.110.121.59] (helo=pie)
	by vesuvio.apex.dp.ua with esmtp (Exim 4.69)
	(envelope-from <mwg@mwg.dp.ua>)
	id 1a3r5N-0008Qr-Tx
	for linux-input@vger.kernel.org; Tue, 01 Dec 2015 21:59:37 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Dear Dmitry & linux-input members,

some new Asus (and probably non-Asus) laptops are shipped with a new 
kind of Elantech (not sure if only Elantech) touchpads which are not 
adequately handled by Linux kernel module (psmouse). First problem is 
that these touchpads are dying off (losing their sensitivity and 
response) when the system is put into pm-suspend and then waken up. 
Another problem is that on reload (modprobe -r ... && modprobe ...) of 
psmouse module they are dying off too, in 'dmesg' coming with some 
weird-numbered indexes (like, input5 on initial load and input292 on 
reload of psmouse).

There are some bugs reported in Ubuntu Launchpad on this topic 
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1519034 is my own, 
also
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1490130 , 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1506363 , 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1504445 and some 
others).
Also there is a proposed patch at
https://marc.info/?l=linux-input&m=144312209020616
and one more report at
http://www.spinics.net/lists/linux-input/msg41634.html

For me, these problems look related. I have Asus X302LA on which I am 
testing Ubuntu Xenial and whose touchpad exhibits this problem. If you 
need I could provide my assistance in testing psmouse module on this 
hardware. Thank you in advance for your response.
