From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: add Benjamin Tissoires as designated reviewer /
 co-maintainer
Date: Fri, 20 Nov 2015 10:16:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511201015150.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50970 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934888AbbKTJQI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 04:16:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

From: Jiri Kosina <jkosina@suse.cz>

Benjamin has been helping a lot over time with reviewing patches flowing 
into HID subsystem. Let's make it official.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b16bffa..ca8cff5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4981,6 +4981,7 @@ F:	arch/*/include/asm/suspend*.h
 
 HID CORE LAYER
 M:	Jiri Kosina <jikos@kernel.org>
+R:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-input@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
 S:	Maintained
@@ -11081,6 +11082,7 @@ F:	include/linux/usb/gadget*
 
 USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
 M:	Jiri Kosina <jikos@kernel.org>
+R:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-usb@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
 S:	Maintained

-- 
Jiri Kosina
SUSE Labs

