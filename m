From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 09/11] Input: sur40: fix error return code
Date: Sun, 23 Aug 2015 02:11:20 +0200
Message-ID: <1440288682-12732-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Propagate error code on failure.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier ret; expression e1,e2;
@@
(
if (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/input/touchscreen/sur40.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 8be7b9b..3f11763 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -581,6 +581,7 @@ static int sur40_probe(struct usb_interface *interface,
 	sur40->alloc_ctx = vb2_dma_sg_init_ctx(sur40->dev);
 	if (IS_ERR(sur40->alloc_ctx)) {
 		dev_err(sur40->dev, "Can't allocate buffer context");
+		error = PTR_ERR(sur40->alloc_ctx);
 		goto err_unreg_v4l2;
 	}
 
