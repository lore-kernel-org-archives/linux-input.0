From: Jiri Slaby <jslaby@suse.cz>
Subject: [-next regression] USB keyboard stops working occasionally
Date: Sun, 20 May 2012 00:17:29 +0200
Message-ID: <4FB81BF9.7040705@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:32781 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2ESWRc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 May 2012 18:17:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi,

sometimes, in the middle of writing, my USB HID keyboard stops sending
interrupts (no changes in /proc/interrupts). I have to hit a key on
another USB interface of that keyboard to resurrect the other. It
happens once or twice a day. It happens with -next since around Friday 4th.

I tried to bisect it a bit (three or four times because of fuzz) in the
past 3 weeks and my suspect number one is currently:
commit 3d9545cc375d117554a9b35dfddadf9189c62775
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Mon Apr 23 13:54:36 2012 -0400

    EHCI: maintain the ehci->command value properly

===

I'm currently running on -next 20120518 with that commit reverted for
one whole day and the issue seems to be gone.

Could you take a look and double-check that commit? (Or do you have any
other ideas where to take a look?)

thanks,
-- 
js
suse labs

