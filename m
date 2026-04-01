Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754C3AC0EA;
	Wed,  1 Apr 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031792; cv=none; b=PF5ZNv3gCyqkeEo1GSMwums9ccJXnHo6AYFj0qoj9uLhlDn9c6usW8P1bVWFkmsfhnliR6JeKTVnLKHS7i+BSVkQetn4D1lSkmoNQMwZQlUdnEhNYc6P444vA3yGLn3y57GszzsYdo28NiJod6jhxMeOSABDGOtqGpIk1O+q5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031792; c=relaxed/simple;
	bh=Nq/ZgQQEPtF88L8sfmyqs0B57W0/6SQan2r/zelBRiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCtIeiBKDrEKzF8+15vpxdlXy+W7VxvFa8WnX+gllJVtZUQUzorHV0MejKGGaHPBE2dBCi0EfhwmOdSeNe1FaJJRUpy/WLztPFXF/kA5KqdVhyBY6/by0xr7655pqolf6p1J4a3j2mlFkNWt4NgXwSNfK76naF2wgRF3+6ze18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMOUu2Sx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMOUu2Sx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3115C2BC9E;
	Wed,  1 Apr 2026 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775031791;
	bh=Nq/ZgQQEPtF88L8sfmyqs0B57W0/6SQan2r/zelBRiA=;
	h=From:To:Cc:Subject:Date:From;
	b=mMOUu2Sx/Hsx3vVsrMZJCbXODBjJdPj6MFQ2tFA0foNbYaELw7Bhe7S/TxxRGcEv1
	 8wVQGkJSRceG12fP4+1gOYkdfHhHmVBm1eo2jOZ9oFgCR+4bmvje9Ql8rmZN7rwWJ/
	 JpSlI+kYN82H9z6RUtPeqtW6wIgyIObgY6P7W2LhkkWf8luGYTBX6Vl/edOBb6pUJk
	 oUKTPgepiU+UCAL1IxDjUNJ7uOPCOd2czynlimUMrYSG+HOJdAfw+43G27QTCEmT0a
	 kbhsaWjfSLJTuuTvPYKsmCcNTwXbgVRENGyGO/sCyy6xt0q4ZU1YPePexXvZP1vWMF
	 bTdS6uUnDetTw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7qqz-000000099FN-2hAw;
	Wed, 01 Apr 2026 10:23:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2] Input: usbtouchscreen - refactor endpoint lookup
Date: Wed,  1 Apr 2026 10:22:12 +0200
Message-ID: <20260401082212.2180434-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining endpoint numbers) instead of open coding.

Note that the NEXIO data interface has two bulk endpoints (see commit
5197424cdccc ("Input: usbtouchscreen - add NEXIO (or iNexio) support")
for the descriptors).

The lookup in probe handles both bulk-in and interrupt-in endpoints and
was added to handle NEXIO devices. Replace the open coded lookup with a
lookup for the common interrupt endpoint and an explicit fallback
accepting a bulk endpoint.

This iterates over the (two) endpoints twice for NEXIO devices but makes
it more clear what is going on.

Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2
 - add the missing fallback to handle bulk endpoints to probe
 - amend commit message


 drivers/input/touchscreen/usbtouchscreen.c | 43 ++++++++--------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 657555c8796c..daa28135f887 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -969,24 +969,21 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 {
 	struct usb_device *dev = interface_to_usbdev(usbtouch->interface);
 	struct usb_host_interface *interface = usbtouch->interface->cur_altsetting;
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct nexio_priv *priv = usbtouch->priv;
-	int ret = -ENOMEM;
 	int actual_len, i;
 	char *firmware_ver = NULL, *device_name = NULL;
-	int input_ep = 0, output_ep = 0;
+	int input_ep, output_ep;
+	int ret;
 
 	/* find first input and output endpoint */
-	for (i = 0; i < interface->desc.bNumEndpoints; i++) {
-		if (!input_ep &&
-		    usb_endpoint_dir_in(&interface->endpoint[i].desc))
-			input_ep = interface->endpoint[i].desc.bEndpointAddress;
-		if (!output_ep &&
-		    usb_endpoint_dir_out(&interface->endpoint[i].desc))
-			output_ep = interface->endpoint[i].desc.bEndpointAddress;
-	}
-	if (!input_ep || !output_ep)
+	ret = usb_find_common_endpoints(interface, &ep_in, &ep_out, NULL, NULL);
+	if (ret)
 		return -ENXIO;
 
+	input_ep = usb_endpoint_num(ep_in);
+	output_ep = usb_endpoint_num(ep_out);
+
 	u8 *buf __free(kfree) = kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
 		return -ENOMEM;
@@ -1427,18 +1424,6 @@ static void usbtouch_free_buffers(struct usb_device *udev,
 	kfree(usbtouch->buffer);
 }
 
-static struct usb_endpoint_descriptor *
-usbtouch_get_input_endpoint(struct usb_host_interface *interface)
-{
-	int i;
-
-	for (i = 0; i < interface->desc.bNumEndpoints; i++)
-		if (usb_endpoint_dir_in(&interface->endpoint[i].desc))
-			return &interface->endpoint[i].desc;
-
-	return NULL;
-}
-
 static int usbtouch_probe(struct usb_interface *intf,
 			  const struct usb_device_id *id)
 {
@@ -1447,17 +1432,21 @@ static int usbtouch_probe(struct usb_interface *intf,
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *udev = interface_to_usbdev(intf);
 	const struct usbtouch_device_info *type;
-	int err = -ENOMEM;
+	int err;
 
 	/* some devices are ignored */
 	type = (const struct usbtouch_device_info *)id->driver_info;
 	if (!type)
 		return -ENODEV;
 
-	endpoint = usbtouch_get_input_endpoint(intf->cur_altsetting);
-	if (!endpoint)
-		return -ENXIO;
+	err = usb_find_int_in_endpoint(intf->cur_altsetting, &endpoint);
+	if (err) {
+		err = usb_find_bulk_in_endpoint(intf->cur_altsetting, &endpoint);
+		if (err)
+			return -ENXIO;
+	}
 
+	err = -ENOMEM;
 	usbtouch = kzalloc_obj(*usbtouch);
 	input_dev = input_allocate_device();
 	if (!usbtouch || !input_dev)
-- 
2.52.0

