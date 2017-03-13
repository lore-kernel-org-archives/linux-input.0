From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/7] Input: ims-pcu - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:35 +0100
Message-ID: <20170313123539.28103-4-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170313123539.28103-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack control-interface endpoints.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable <stable@vger.kernel.org>	# 3.10
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/misc/ims-pcu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 9c0ea36913b4..f4e8fbec6a94 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1667,6 +1667,10 @@ static int ims_pcu_parse_cdc_data(struct usb_interface *intf, struct ims_pcu *pc
 		return -EINVAL;
 
 	alt = pcu->ctrl_intf->cur_altsetting;
+
+	if (alt->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	pcu->ep_ctrl = &alt->endpoint[0].desc;
 	pcu->max_ctrl_size = usb_endpoint_maxp(pcu->ep_ctrl);
 
-- 
2.12.0
