From: Igor Murzov <intergalactic.anonymous@gmail.com>
Subject: [RFH] Lenovo Ideapad U455 touchpad not always works
Date: Mon, 30 Jan 2012 04:51:43 +0400
Message-ID: <20120130045143.5d1be121@garik>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47051 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab2A3Avx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 19:51:53 -0500
Received: by bkas6 with SMTP id s6so2749333bka.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 16:51:51 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi, list.

I have a problem with my touchpad. It works fine, but not at every boot.
More specifically, AUX port not always initialized properly:
-----------------------------------------
i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12   # <-- this line is not always appear in dmesg output
-----------------------------------------
Here are two dmesg outputs:
http://paste.pro/5141560  <-- this time touchpad worked fine
http://paste.pro/5141561  <-- and this time touchpad was not working

I saw in the git logs that many laptops require some workaround to make
their touchpad work. I've tried i8042.notimeout, i8042.nomux and
i8042.noloop, but this didn't solve the issue. I wonder is there any way
to detect which options should I use to make touchpad work, other than
rebooting system countless number of times?

Output of lshw: http://paste.pro/5141562


-- Igor
