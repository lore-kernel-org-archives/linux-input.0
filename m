From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to
 debug?
Date: Sun, 27 Mar 2016 20:53:54 +0200
Message-ID: <56F82C42.6020002@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52480 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbcC0Sx7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2016 14:53:59 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id 6FEE643535
	for <linux-input@vger.kernel.org>; Sun, 27 Mar 2016 20:53:56 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id 28DNrwjsxAVP for <linux-input@vger.kernel.org>;
	Sun, 27 Mar 2016 20:53:55 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm writing on an usermode input driver.

Currently my force feedback support just consists of some printf's as a 
first try.

My problem is, that it seems like as soon as I first sent something to 
my open uinput device (some buttons that were pressed on the device) the 
uinput backend seems to get into some bad state.

My "force feedback thread" gets the "EV_UINPUT" event trigger, but if I 
try to call

ioctl(args->fduinput, UI_BEGIN_FF_UPLOAD, &upload);

in this case, then the return value is "-1"...

The same code works without any problem if no buttons are pressed and 
"fftest" is called directly after startup of the driver application.

Can someone help me with debugging this problem? My understanding is, 
that this call shouldn't return -1 if the "EV_UINPUT" event was 
successfully received, right?

My system:

$ uname -a
Linux manuelspc 4.4.5-1-ARCH #1 SMP PREEMPT Thu Mar 10 07:38:19 CET 2016 
x86_64 GNU/Linux

Thank you very much in advance.

Manuel
