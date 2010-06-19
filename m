From: Alan Ott <alan@signal11.us>
Subject: [PATCH v2 2/2] HID: Move hiddev.txt to the new Documentation/HID directory
Date: Fri, 18 Jun 2010 22:13:43 -0400
Message-ID: <1276913623-6126-3-git-send-email-alan@signal11.us>
References: <1276832283-12084-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:41851 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab0FSCNx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 22:13:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 91D54104301
	for <linux-input@vger.kernel.org>; Fri, 18 Jun 2010 22:13:52 -0400 (EDT)
In-Reply-To: <1276832283-12084-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Antonio Ospite <ospite@studen>
Cc: Alan Ott <alan@signal11.us>

With the new Documentation/hid directory, it makes sense to have
hiddev.txt here as well.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 Documentation/{usb => hid}/hiddev.txt |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{usb => hid}/hiddev.txt (100%)

diff --git a/Documentation/usb/hiddev.txt b/Documentation/hid/hiddev.txt
similarity index 100%
rename from Documentation/usb/hiddev.txt
rename to Documentation/hid/hiddev.txt
-- 
1.7.0.4


