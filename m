From: Alan Ott <alan@signal11.us>
Subject: [PATCH v4 2/2] HID: Move hiddev.txt to the new Documentation/HID directory
Date: Tue, 15 Feb 2011 23:06:49 -0500
Message-ID: <1297829209-10511-3-git-send-email-alan@signal11.us>
References: <1297829209-10511-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:48129 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757664Ab1BPEGx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 23:06:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id DE7671CCABD7
	for <linux-input@vger.kernel.org>; Tue, 15 Feb 2011 23:06:52 -0500 (EST)
In-Reply-To: <1297829209-10511-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, ospite@studenti.unina.it, linux-input@vger.
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


