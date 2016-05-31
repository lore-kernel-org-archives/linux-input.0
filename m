From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH v2 3/3] sur40: fix occasional oopses on device close
Date: Tue, 31 May 2016 22:15:33 +0200
Message-ID: <1464725733-22119-3-git-send-email-floe@butterbrot.org>
References: <1464725733-22119-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1464725733-22119-1-git-send-email-floe@butterbrot.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org, hverkuil@xs4all.nl
Cc: linux-input@vger.kernel.org, Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>
List-Id: linux-input@vger.kernel.org

Closing the V4L2 device sometimes triggers a kernel oops.
Present patch fixes this.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 64e588c..85dedc1 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -448,7 +448,7 @@ static void sur40_process_video(struct sur40_state *sur40)
 
 	/* return error if streaming was stopped in the meantime */
 	if (sur40->sequence == -1)
-		goto err_poll;
+		return;
 
 	/* mark as finished */
 	new_buf->vb.vb2_buf.timestamp = ktime_get_ns();
@@ -736,6 +736,7 @@ static int sur40_start_streaming(struct vb2_queue *vq, unsigned int count)
 static void sur40_stop_streaming(struct vb2_queue *vq)
 {
 	struct sur40_state *sur40 = vb2_get_drv_priv(vq);
+	vb2_wait_for_all_buffers(vq);
 	sur40->sequence = -1;
 
 	/* Release all active buffers */
-- 
1.9.1
