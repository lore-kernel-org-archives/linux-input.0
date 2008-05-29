From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Version 2: [PATCH 1/3] Input: Add switch for dock events
Date: Thu, 29 May 2008 09:20:30 +0100
Message-ID: <20080529082030.GC16444@srcf.ucam.org>
References: <20080523160955.GA19674@srcf.ucam.org> <20080528130621.GA32646@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58806 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbYE2IUn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2008 04:20:43 -0400
Content-Disposition: inline
In-Reply-To: <20080528130621.GA32646@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Add a SW_DOCK switch to input.h. ACPI docks currently send their docking 
status as a uevent, but not all docks are ACPI or correspond to a 
device. In that case, it makes more sense to simply generate an input 
event on docking or undocking.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

No changes to this one.

diff --git a/include/linux/input.h b/include/linux/input.h
index 28a094f..0bc55ee 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -638,6 +638,7 @@ struct input_absinfo {
 #define SW_TABLET_MODE		0x01  /* set = tablet mode */
 #define SW_HEADPHONE_INSERT	0x02  /* set = inserted */
 #define SW_RADIO		0x03  /* set = radio enabled */
+#define SW_DOCK			0x04  /* set = plugged into dock */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
