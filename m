From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial 1/4] HID: picoLCD: Spelling s/REPORT_WRTIE_MEMORY/REPORT_WRITE_MEMORY/
Date: Fri, 17 Feb 2017 16:36:36 +0100
Message-ID: <1487345799-1638-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bruno Prémont <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/hid-picolcd_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 3c13af6844108f97..3e0feb4bb5380978 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -736,7 +736,7 @@ void picolcd_debug_raw_event(struct picolcd_data *data,
 		}
 		break;
 	case REPORT_MEMORY:
-		/* Data buffer in response to REPORT_READ_MEMORY or REPORT_WRTIE_MEMORY */
+		/* Data buffer in response to REPORT_READ_MEMORY or REPORT_WRITE_MEMORY */
 		snprintf(buff, BUFF_SZ, "report %s (%d, size=%d)\n",
 			"REPORT_MEMORY", report->id, size-1);
 		hid_debug_event(hdev, buff);
-- 
1.9.1
