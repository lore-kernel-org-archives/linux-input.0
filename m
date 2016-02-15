From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Simple approach to write PS3/PS4 usermode driver?
Date: Mon, 15 Feb 2016 20:29:18 +0100
Message-ID: <56C2270E.9080603@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:52985 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbcBOTgo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2016 14:36:44 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 0431C404A5
	for <linux-input@vger.kernel.org>; Mon, 15 Feb 2016 20:29:19 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id 2IBHWjz4W1o7 for <linux-input@vger.kernel.org>;
	Mon, 15 Feb 2016 20:29:19 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

now I've been trying several things, but maybe I missed something.

- If I just blacklist "hid-sony", then everything is dead. No bluetooth 
binding, no "/dev/hidrawX".
- After some searching, I found out that the core reason for this is a 
"hid_have_special_driver" list in hid-core.c which contains the PS3/PS4 
controller.
- So I thought: Maybe I can keep "hid-sony" to keep "/dev/hidrawX" and 
somehow detach the generated eventX and jsX devices. I've been searching 
/sys for about half an hour but I didn't find any way to do this. Maybe 
impossible?

I know that libusb may be an option, but this way I also give up easy 
bluetooth binding. Especially the PS4 gamepad is easy to bind. If the 
resulting bluetooth device wouldn't be blacklisted in hid-core.c.

Maybe someone can give me a hint. Is there any easy way to get the HID 
to input device translation process ported into usermode without giving 
up all the things that work automatically if hid-sony is active?

Thank you very much for any information.

Best regards,

Manuel
