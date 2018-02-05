From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] HID: logitech-dj: Fix a typo in a comment line
Date: Mon, 5 Feb 2018 22:30:22 +0100
Message-ID: <0d17da5f-00ad-259f-932e-dc54eb45696c@users.sourceforge.net>
References: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <12e9f2fd-5e85-fe8b-5eec-cd1712b07166@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2018 22:14:49 +0100

Adjust a word in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index f1496c6303ce..de1859fade5c 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -318,7 +318,7 @@ static const char hidpp_descriptor[] = {
  *
  * Right now, RF report types have the same report types (or report id's)
  * than the hid report created from those RF reports. In the future
- * this doesnt have to be true.
+ * this doesn't have to be true.
  *
  * For instance, RF report type 0x01 which has a size of 8 bytes, corresponds
  * to hid report id 0x01, this is standard keyboard. Same thing applies to mice
-- 
2.16.1

