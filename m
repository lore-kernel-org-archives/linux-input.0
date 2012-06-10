From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 16/16] MAINTAINERS: add UHID entry
Date: Sun, 10 Jun 2012 15:16:28 +0200
Message-ID: <1339334188-21766-17-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60560 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab2FJNQx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:53 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj8so1970186wib.1
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:52 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add an UHID entry to the MAINTAINERS file.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa067a9..4997519 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6886,6 +6886,13 @@ S:	Maintained
 F:	Documentation/filesystems/ufs.txt
 F:	fs/ufs/
 
+UHID USERSPACE HID IO DRIVER:
+M:	David Herrmann <dh.herrmann@googlemail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/hid/uhid.c
+F:	include/linux/uhid.h
+
 ULTRA-WIDEBAND (UWB) SUBSYSTEM:
 L:	linux-usb@vger.kernel.org
 S:	Orphan
-- 
1.7.10.4

