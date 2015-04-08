From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 09/15] HID: hid-lg4ff: Stop the hid device from lg4ff.
Date: Wed,  8 Apr 2015 22:56:47 +0200
Message-ID: <1428526613-24239-10-git-send-email-madcatxster@devoid-pointer.net>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from transparentnimenzy.cz ([31.31.77.140]:33014 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbbDHU52 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 16:57:28 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Stop the hid device from lg4ff. Originally hid-lg was responsible for
stopping of the device.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg.c    | 4 ++--
 drivers/hid/hid-lg4ff.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c797781..c3981da 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -734,8 +734,8 @@ static void lg_remove(struct hid_device *hdev)
 	struct lg_drv_data *drv_data =3D hid_get_drvdata(hdev);
 	if (drv_data->quirks & LG_FF4)
 		lg4ff_deinit(hdev);
-
-	hid_hw_stop(hdev);
+	else
+		hid_hw_stop(hdev);
 	kfree(drv_data);
 }
=20
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 0f8d726..031b8ab 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1213,6 +1213,8 @@ int lg4ff_deinit(struct hid_device *hid)
 		}
 	}
 #endif
+	hid_hw_stop(hid);
+	drv_data->device_props =3D NULL;
=20
 	kfree(entry);
 out:
--=20
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
