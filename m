From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 06/12] HID: hid-lg: Check return values from lg[N]ff_init()
Date: Sat, 21 Mar 2015 12:47:36 +0100
Message-ID: <1426938462-884-7-git-send-email-madcatxster@devoid-pointer.net>
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

hid-lg did not check return values from the lg[N]_init() functions,
possibly trying to work with a device whose initialization has failed.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/hid-lg.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index b86c18e..c797781 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -712,13 +712,16 @@ static int lg_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
 	}
=20
 	if (drv_data->quirks & LG_FF)
-		lgff_init(hdev);
+		ret =3D lgff_init(hdev);
 	if (drv_data->quirks & LG_FF2)
-		lg2ff_init(hdev);
+		ret =3D lg2ff_init(hdev);
 	if (drv_data->quirks & LG_FF3)
-		lg3ff_init(hdev);
+		ret =3D lg3ff_init(hdev);
 	if (drv_data->quirks & LG_FF4)
-		lg4ff_init(hdev);
+		ret =3D lg4ff_init(hdev);
+
+	if (ret)
+		goto err_free;
=20
 	return 0;
 err_free:
--=20
2.3.3
