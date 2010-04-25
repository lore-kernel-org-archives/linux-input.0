From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH] hid: fix picolcd's version parsing
Date: Sun, 25 Apr 2010 21:31:40 +0200
Message-ID: <20100425213140.371194b0@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

During grouping of version checking code bootloader mode's version
bytes got swapped. Fix their order.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 0fbc7d3..6f71c60 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -1196,16 +1196,14 @@ static int picolcd_check_version(struct hid_dev=
ice *hdev)
 	}
=20
 	if (verinfo->raw_size =3D=3D 2) {
+		data->version[0] =3D verinfo->raw_data[1];
+		data->version[1] =3D verinfo->raw_data[0];
 		if (data->status & PICOLCD_BOOTLOADER) {
 			dev_info(&hdev->dev, "PicoLCD, bootloader version %d.%d\n",
-					verinfo->raw_data[0], verinfo->raw_data[1]);
-			data->version[0] =3D verinfo->raw_data[0];
-			data->version[1] =3D verinfo->raw_data[1];
+					verinfo->raw_data[1], verinfo->raw_data[0]);
 		} else {
 			dev_info(&hdev->dev, "PicoLCD, firmware version %d.%d\n",
 					verinfo->raw_data[1], verinfo->raw_data[0]);
-			data->version[0] =3D verinfo->raw_data[1];
-			data->version[1] =3D verinfo->raw_data[0];
 		}
 	} else {
 		dev_err(&hdev->dev, "confused, got unexpected version response from =
PicoLCD\n");
--=20
1.6.4.4
