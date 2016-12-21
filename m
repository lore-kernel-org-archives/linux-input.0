From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: synaptics-rmi4: remove redundant null check on rmi_dev
Date: Wed, 21 Dec 2016 14:41:04 +0000
Message-ID: <20161221144104.25794-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

rmi_dev is currently being dereferenced before it null checked,
however, after deeper inspecting, rmi_dev can never be null,
so just remove this redundant check. Thanks to Dmitry Torokhov for
noticing that we can remove the null check.

Fixes CoverityScan CID 1391218 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/rmi4/rmi_f03.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 8a7ca3e..9a1b099 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -175,9 +175,6 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	int i;
 	int error;
 
-	if (!rmi_dev)
-		return -ENODEV;
-
 	if (drvdata->attn_data.data) {
 		/* First grab the data passed by the transport device */
 		if (drvdata->attn_data.size < ob_len) {
-- 
2.10.2
