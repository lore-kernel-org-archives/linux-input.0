From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH 6/6] HID: picoLCD: use proper device as input_dev parent
Date: Sun, 19 Aug 2012 19:33:56 +0200
Message-ID: <20120819193356.3f853c78@neptune.home>
References: <20120819192859.74136bb0@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:38364 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab2HSRek convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Aug 2012 13:34:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_c=
ore.c
index 580269b..86df26e 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -446,7 +446,7 @@ static int picolcd_init_keys(struct picolcd_data *d=
ata,
 	idev->id.vendor  =3D hdev->vendor;
 	idev->id.product =3D hdev->product;
 	idev->id.version =3D hdev->version;
-	idev->dev.parent =3D hdev->dev.parent;
+	idev->dev.parent =3D &hdev->dev;
 	idev->keycode     =3D &data->keycode;
 	idev->keycodemax  =3D PICOLCD_KEYS;
 	idev->keycodesize =3D sizeof(data->keycode[0]);
--=20
1.7.8.6

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
