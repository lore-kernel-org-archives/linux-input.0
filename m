From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 9/16] HID: logitech-hidpp: fix error return code
Date: Sun,  5 Apr 2015 14:06:29 +0200
Message-ID: <1428235596-4757-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1428235596-4757-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428235596-4757-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Return a negative error code on failure.

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
 drivers/hid/hid-logitech-hidpp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e77658c..ce9819f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1210,6 +1210,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	connected = hidpp_is_connected(hidpp);
 	if (id->group != HID_GROUP_LOGITECH_DJ_DEVICE) {
 		if (!connected) {
+			ret = -ENODEV;
 			hid_err(hdev, "Device not connected");
 			hid_device_io_stop(hdev);
 			goto hid_parse_fail;
