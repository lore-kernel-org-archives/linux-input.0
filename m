From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 04/12] HID: hid-lg4ff: (Cleanup) Remove unused variable from the "lg4ff_device_entry" struct.
Date: Sat, 21 Mar 2015 12:47:34 +0100
Message-ID: <1426938462-884-5-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

This is a leftover from times where hid_get|set_drvdata() was not
available to hid-lg4ff so it had to keep track of the devices it manage=
d
by itself.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg4ff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index cec84a5..d1d5d45 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -84,7 +84,6 @@ struct lg4ff_device_entry {
 	const char *real_tag;
 	const char *real_name;
 	u16 real_product_id;
-	struct list_head list;
 	void (*set_range)(struct hid_device *hid, u16 range);
 };
=20
--=20
2.3.3
