From: Nathan Huckleberry <nhuck@google.com>
Subject: [PATCH] Input: atmel_mxt_ts - fix -Wunused-const-variable
Date: Wed, 12 Jun 2019 16:58:03 -0700
Message-ID: <20190612235803.9290-1-nhuck@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nathan Huckleberry <nhuck@google.com>, clang-built-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org

Clang produces the following warning

drivers/input/touchscreen/atmel_mxt_ts.c:259:42: warning: unused
variable 'mxt_video_fops' [-Wunused-const-variable]
static const struct v4l2_file_operations mxt_video_fops = {

Since mxt_video_fops is only used inside an ifdef. It should
be moved inside the ifdef.

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/527
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 19378f200c63..48411c83320b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -256,6 +256,7 @@ enum v4l_dbg_inputs {
 	MXT_V4L_INPUT_MAX,
 };
 
+#ifdef CONFIG_TOUCHSCREEN_ATMEL_MXT_T37
 static const struct v4l2_file_operations mxt_video_fops = {
 	.owner = THIS_MODULE,
 	.open = v4l2_fh_open,
@@ -265,6 +266,7 @@ static const struct v4l2_file_operations mxt_video_fops = {
 	.mmap = vb2_fop_mmap,
 	.poll = vb2_fop_poll,
 };
+#endif
 
 enum mxt_suspend_mode {
 	MXT_SUSPEND_DEEP_SLEEP	= 0,
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
