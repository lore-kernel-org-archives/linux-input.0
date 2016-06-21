From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: elantech - add more IC body types to the list
Date: Tue, 21 Jun 2016 16:15:35 -0700
Message-ID: <20160621231535.GA20091@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, kt.liao@emc.com.tw, Patrick.Lessard@cogeco.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The touchpad in HP Pavilion 14-ab057ca reports it's version as 12 and
according to Elan both 11 and 12 are valid IC types and should be
identified as hw_version 4.

Reported-by: Patrick Lessard <Patrick.Lessard@cogeco.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index e0fbd42..615d23e 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1568,13 +1568,7 @@ static int elantech_set_properties(struct elantech_data *etd)
 		case 5:
 			etd->hw_version = 3;
 			break;
-		case 6:
-		case 7:
-		case 8:
-		case 9:
-		case 10:
-		case 13:
-		case 14:
+		case 6 ... 14:
 			etd->hw_version = 4;
 			break;
 		default:
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
