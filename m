From: "Phil Endecott" <spam_from_linux_input@chezphil.org>
Subject: Apple bluetooth keyboard
Date: Wed, 21 May 2008 20:56:41 +0100
Message-ID: <1211399801133@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="flowed"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:3458 "EHLO japan.chezphil.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbYEUU0l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2008 16:26:41 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
	by japan.chezphil.org with esmtp (Exim 4.67)
	(envelope-from <spam_from_linux_input@chezphil.org>)
	id 1JyuQT-0002Kw-Vu
	for linux-input@vger.kernel.org; Wed, 21 May 2008 20:56:42 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux-input <linux-input@vger.kernel.org>

Dear Experts,

I have the bluetooth version of the Apple aluminium keyboard and I'm 
having trouble getting it to work right.

I'm running 2.6.25 and I can see that it has some quirks for these 
keyboards that should do some of the things that I want.  
(Specifically, HID_QUIRK_APPLE_ISO_KEYBOARD and 
HID_QUIRK_APPLE_HAS_FN.)  But it looks as if they're keyed on the USB 
vendor/product IDs, which presumably don't match my bluetooth device.

Can someone please explain how input quirks should be applied to 
bluetooth devices?

Thanks,  Phil.




