From: Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH] Input: touchscreen: ad7879: Fix ERROR: foo* bar should be "foo *bar"
Date: Mon, 10 Dec 2018 21:14:33 +0530
Message-ID: <20181210154433.28319-1-hardiksingh.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: michael.hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hardik Singh Rathore <hardiksingh.k@gmail.com>
List-Id: linux-input@vger.kernel.org

Fix the coding style problem reported by checkpatch.pl.

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
 drivers/input/touchscreen/ad7879.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6bad23ee47a1..b68902c17f2e 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -290,7 +290,7 @@ static int ad7879_open(struct input_dev *input)
 	return 0;
 }
 
-static void ad7879_close(struct input_dev* input)
+static void ad7879_close(struct input_dev *input)
 {
 	struct ad7879 *ts = input_get_drvdata(input);
 
-- 
2.17.1
