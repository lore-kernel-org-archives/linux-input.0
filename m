From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] HID: logitech-dj: fix spelling mistake "Unexpect" -> "Unexpected"
Date: Fri, 26 Apr 2019 14:16:31 +0100
Message-ID: <20190426131631.26692-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a hid_err error message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 64e68ac871cb..b1e894618eed 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1064,7 +1064,7 @@ static void logi_dj_recv_forward_input_report(struct hid_device *hdev,
 	int i;
 
 	if (report > REPORT_TYPE_RFREPORT_LAST) {
-		hid_err(hdev, "Unexpect input report number %d\n", report);
+		hid_err(hdev, "Unexpected input report number %d\n", report);
 		return;
 	}
 
-- 
2.20.1
