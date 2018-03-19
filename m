From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/4] HID: alps: Fix some style in 't4_read_write_register()'
Date: Mon, 19 Mar 2018 21:53:29 +0100
Message-ID: <50b54e595830cc86edfb977e045f5a7b2b1b726a.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: masaki.ota@jp.alps.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-input@vger.kernel.org

Better indent the code to improve readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-alps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 137b963779c6..60d3950692d9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -223,20 +223,20 @@ static int t4_read_write_register(struct hid_device *hdev, u32 address,
 
 		if (*(u32 *)&readbuf[6] != address) {
 			dev_err(&hdev->dev, "read register address error (%x,%x)\n",
-			*(u32 *)&readbuf[6], address);
+				*(u32 *)&readbuf[6], address);
 			goto exit_readbuf;
 		}
 
 		if (*(u16 *)&readbuf[10] != 1) {
 			dev_err(&hdev->dev, "read register size error (%x)\n",
-			*(u16 *)&readbuf[10]);
+				*(u16 *)&readbuf[10]);
 			goto exit_readbuf;
 		}
 
 		check_sum = t4_calc_check_sum(readbuf, 6, 7);
 		if (*(u16 *)&readbuf[13] != check_sum) {
 			dev_err(&hdev->dev, "read register checksum error (%x,%x)\n",
-			*(u16 *)&readbuf[13], check_sum);
+				*(u16 *)&readbuf[13], check_sum);
 			goto exit_readbuf;
 		}
 
-- 
2.14.1
