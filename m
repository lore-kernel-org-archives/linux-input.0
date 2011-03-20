From: Alan Ott <alan@signal11.us>
Subject: [PATCH v5 2/2] HID: Move hiddev.txt to the new Documentation/HID directory
Date: Sat, 19 Mar 2011 20:29:45 -0400
Message-ID: <1300580985-10726-3-git-send-email-alan__12372.8432962254$1300647297$gmane$org@signal11.us>
References: <1297829209-10511-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:35953 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab1CTSyV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Mar 2011 14:54:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id BEE3F1CCAC27
	for <linux-input@vger.kernel.org>; Sun, 20 Mar 2011 13:54:20 -0500 (EST)
In-Reply-To: <1297829209-10511-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jonathan Corbet <corbet@lwn.net>, Antonio Ospite <ospite@studenti.unina.it>, Jiri Kosina <jkosina@suse.cz>, Jason
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


