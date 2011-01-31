From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH v2 3/4] hid-multitouch: add Benjamin Tissoires as module_author
Date: Mon, 31 Jan 2011 11:28:21 +0100
Message-ID: <1296469702-3710-4-git-send-email-benjamin.tissoires@enac.fr>
References: <1296469702-3710-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:33275 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab1AaK2h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Jan 2011 05:28:37 -0500
In-Reply-To: <1296469702-3710-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <ch>

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-multitouch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b976d10..4f63409 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -24,6 +24,7 @@
 
 
 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
+MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
 MODULE_DESCRIPTION("HID multitouch panels");
 MODULE_LICENSE("GPL");
 
-- 
1.7.3.4

