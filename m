From: John S Gruber <JohnSGruber@gmail.com>
Subject: [PATCH 1/2] HID: redragon: Fix regression in non-Redragon keyboard
 due to this new driver
Date: Sat, 28 Jul 2018 15:53:49 -0400
Message-ID: <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
 <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Robert Munteanu <rombert@apache.org>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, JohnSGruber@gmail.com
List-Id: linux-input@vger.kernel.org

The Redragon keyboard uses the second device being presented, but other
devices with the same vendor_id/device_id pair (0x0c45:760b) use the first.
Don't cause its deletion. Problem introduced in commit 85455dd906d5
("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")

Fixes: 85455dd906d5
Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
---
 drivers/hid/hid-redragon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
index daf5957..85a5fbb 100644
--- a/drivers/hid/hid-redragon.c
+++ b/drivers/hid/hid-redragon.c
@@ -55,10 +55,6 @@ static int redragon_probe(struct hid_device *dev,
 		return ret;
 	}

-	/* do not register unused input device */
-	if (dev->maxapplication == 1)
-		return 0;
-
 	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(dev, "hw start failed\n");
-- 
1.9.1
