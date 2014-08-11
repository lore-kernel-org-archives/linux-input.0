From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCHES] HID: huion: Fix "doing dma on the stack"
Date: Mon, 11 Aug 2014 20:45:30 +0300
Message-ID: <1407779132-26749-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:36606 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHKRpw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 13:45:52 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so8891526wes.29
        for <linux-input@vger.kernel.org>; Mon, 11 Aug 2014 10:45:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

Hi everyone,

These two patches work towards fixing the "doing dma on the stack" reported by
a static analyzer (I'm not sure which one) for my recent changes to hid-huion
driver.

The first one is easier to read with whitespace changes ingored (-w).

Both patches were tested by me with a Huion H610N tablet.

Nick

 drivers/hid/hid-huion.c | 128 +++++++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 50 deletions(-)
