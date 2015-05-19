From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 2/2] input/vmmouse: Fix Kconfig help text
Date: Tue, 19 May 2015 04:37:05 -0700
Message-ID: <1432035425-45514-3-git-send-email-thellstrom@vmware.com>
References: <1432035425-45514-1-git-send-email-thellstrom@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:38333 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754203AbbESLhU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 07:37:20 -0400
In-Reply-To: <1432035425-45514-1-git-send-email-thellstrom@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>

The vmmouse Kconfig help text was referring to an incorrect user-space
driver version. Fix this.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 drivers/input/mouse/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 7462d2f..d7820d1 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -156,7 +156,7 @@ config MOUSE_PS2_VMMOUSE
 	  Say Y here if you are running under control of VMware hypervisor
 	  (ESXi, Workstation or Fusion). Also make sure that when you enable
 	  this option, you remove the xf86-input-vmmouse user-space driver
-	  or upgrade it to at least xf86-input-vmmouse 13.0.1, which doesn't
+	  or upgrade it to at least xf86-input-vmmouse 13.1.0, which doesn't
 	  load in the presence of an in-kernel vmmouse driver.
 
 	  If unsure, say N.
-- 
2.1.0

