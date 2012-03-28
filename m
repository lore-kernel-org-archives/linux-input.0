From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 2/2] HID: wacom: Add module description
Date: Wed, 28 Mar 2012 22:13:37 +0100
Message-ID: <1332969217-10727-3-git-send-email-przemo@firszt.eu>
References: <1332969217-10727-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:44969 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932894Ab2C1VOP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 17:14:15 -0400
In-Reply-To: <1332969217-10727-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

Add description for hid-wacom module: "Driver for Wacom Graphire Bluetooth
and Wacom Intuos4 WL"

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index f130f40..fb0fe16 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -687,5 +687,5 @@ static void __exit wacom_exit(void)
 
 module_init(wacom_init);
 module_exit(wacom_exit);
+MODULE_DESCRIPTION("Driver for Wacom Graphire Bluetooth and Wacom Intuos4 WL");
 MODULE_LICENSE("GPL");
-
-- 
1.7.9.1

