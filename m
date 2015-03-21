From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 12/12] HID: hid-lg: Only one of LG_FF flags can be set for a given device.
Date: Sat, 21 Mar 2015 12:47:42 +0100
Message-ID: <1426938462-884-13-git-send-email-madcatxster@devoid-pointer.net>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.devoid-pointer.net ([31.31.77.140]:59578 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbbCULsZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 07:48:25 -0400
In-Reply-To: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Reflect the mutual exclusivity of the LG_FF flags in the code.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c3981da..f1e92bf 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -713,11 +713,11 @@ static int lg_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
=20
 	if (drv_data->quirks & LG_FF)
 		ret =3D lgff_init(hdev);
-	if (drv_data->quirks & LG_FF2)
+	else if (drv_data->quirks & LG_FF2)
 		ret =3D lg2ff_init(hdev);
-	if (drv_data->quirks & LG_FF3)
+	else if (drv_data->quirks & LG_FF3)
 		ret =3D lg3ff_init(hdev);
-	if (drv_data->quirks & LG_FF4)
+	else if (drv_data->quirks & LG_FF4)
 		ret =3D lg4ff_init(hdev);
=20
 	if (ret)
--=20
2.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
