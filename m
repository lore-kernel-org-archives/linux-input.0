From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/6] HID: Add the client_addr member to the hid_device struct
Date: Fri, 31 Jan 2014 12:32:48 -0500
Message-ID: <1391189573-2591-2-git-send-email-frank.praznik@oh.rr.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:52176 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515AbaAaRdC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 12:33:02 -0500
In-Reply-To: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add the client_addr member to the hid_device struct for storing the client
address of a connected device.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 include/linux/hid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 31b9d29..283fc6e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -495,6 +495,7 @@ struct hid_device {							/* device report descriptor */
 	char name[128];							/* Device name */
 	char phys[64];							/* Device physical location */
 	char uniq[64];							/* Device unique identifier (serial #) */
+	__u8 client_addr[6];						/* Device client address (if wireless) */
 
 	void *driver_data;
 
-- 
1.8.5.3

