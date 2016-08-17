From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 3/3] input: pixcir_i2c: Remove a useless blank line
Date: Wed, 17 Aug 2016 15:22:14 +0200
Message-ID: <1471440134-23896-3-git-send-email-clabbe.montjoie@gmail.com>
References: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch fix the following checkpatch report:
Blank lines aren't necessary after an open brace

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index d8b8889..3bb0637 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -400,7 +400,6 @@ static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
 	mutex_lock(&input->mutex);
 
 	if (device_may_wakeup(&client->dev)) {
-
 		if (!input->users) {
 			ret = pixcir_stop(ts);
 			if (ret) {
-- 
2.7.3
