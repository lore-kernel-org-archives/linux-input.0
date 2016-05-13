From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 3/3] fix occasional oopses on device close
Date: Fri, 13 May 2016 11:41:46 -0700
Message-ID: <1463164906-6273-3-git-send-email-floe@butterbrot.org>
References: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:33797 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbcEMSrm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 14:47:42 -0400
In-Reply-To: <1463164906-6273-1-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, hverkuil@xs4all.nl
Cc: Florian Echtler <floe@butterbrot.org>, Martin Kaltenbrunner <modin@yuri.at>

Closing the V4L2 device sometimes triggers a kernel oops.
Present patch fixes this.

Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
Signed-off-by: Florian Echtler <floe@butterbrot.org>
---
 drivers/input/touchscreen/sur40.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 7b1052a1..38ebb24 100644
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

