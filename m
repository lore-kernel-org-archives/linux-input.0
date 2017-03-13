From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/7] Input: yealink - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:36 +0100
Message-ID: <20170313123539.28103-5-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170313123539.28103-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Henk <Henk.Vergonet@gmail.com>
List-Id: linux-input@vger.kernel.org

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack endpoints.

Fixes: aca951a22a1d ("[PATCH] input-driver-yealink-P1K-usb-phone")
Cc: stable <stable@vger.kernel.org>	# 2.6.14
Cc: Henk <Henk.Vergonet@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/misc/yealink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 79c964c075f1..6e7ff9561d92 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -875,6 +875,10 @@ static int usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	int ret, pipe, i;
 
 	interface = intf->cur_altsetting;
+
+	if (interface->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	endpoint = &interface->endpoint[0].desc;
 	if (!usb_endpoint_is_int_in(endpoint))
 		return -ENODEV;
-- 
2.12.0
