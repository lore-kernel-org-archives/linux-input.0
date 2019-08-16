From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 49/63] Input: Atmel: Improve error handling in mxt_initialize_input_device()
Date: Fri, 16 Aug 2019 17:37:10 +0900
Message-ID: <20190816083724.19341-5-jiada_wang@mentor.com>
References: <20190816083724.19341-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083724.19341-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Deepak Das <deepak_das@mentor.com>

Currently Driver probe continues with a warning message when it fails to
get the proper multitouch object configurations like TouchScreen resolution.
But Driver probe should fail in case of above scneario because it will not behave
as expected without the proper touchscreen configurations.

This commit modifies mxt_initialize_input_device() to return error when it fails
to get the proper touch screen configurations.

Signed-off-by: Deepak Das <deepak_das@mentor.com>
Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 27b908a50b66..b17af89a4711 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2749,15 +2749,19 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	case MXT_TOUCH_MULTI_T9:
 		num_mt_slots = data->T9_reportid_max - data->T9_reportid_min + 1;
 		error = mxt_read_t9_resolution(data);
-		if (error)
-			dev_warn(dev, "Failed to initialize T9 resolution\n");
+		if (error) {
+			dev_err(dev, "Failed to initialize T9 resolution\n");
+			return error;
+		}
 		break;
 
 	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
 		num_mt_slots = data->num_touchids;
 		error = mxt_read_t100_config(data);
-		if (error)
-			dev_warn(dev, "Failed to read T100 config\n");
+		if (error) {
+			dev_err(dev, "Failed to read T100 config\n");
+			return error;
+		}
 		break;
 
 	default:
-- 
2.19.2
