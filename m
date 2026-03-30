Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0D3B4EBC;
	Mon, 30 Mar 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864807; cv=none; b=UnW1+C/+QUtvLn44kxvIq4bmCh9d0AAVRxKPIjt83UeLql+MVAZalNWX/CeUTsxWuYt4z467djFOi3kj2h6Nhhq7I2NSQb9zOkYSpkQZUs/L2Lp7vwJUqS5pCqjgGLnVFsUZUuAxEmvMyu/uP95bbhaPqKZXkFrUr4LqwckKXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864807; c=relaxed/simple;
	bh=7+VHVjKGCdQxEWhptBkDrSh/FHonAepi3RRSoWJrvv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG+OWx3BJ4BrErsQQpmEPbiCQ8lI3O9XGe8AnN8oDAaEKCTlMl10ISYRwzPqdiFpolgNJikLWC8WAdUKwiSaq7q102vRfujQsIqr2JoVM5JDaSrqeerkVaPVMT6D2Unq8NyugvyCzQvh4cYRT78hPP3ZBtXxhOYOoqn+es4xJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5WKOkQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5WKOkQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB88AC2BCB1;
	Mon, 30 Mar 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864806;
	bh=7+VHVjKGCdQxEWhptBkDrSh/FHonAepi3RRSoWJrvv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5WKOkQV9FqxA/nWu3LWmiJRCj9TT//ki6/Rv3vABcEg6g4kw6E+FTUrDRHlfunSy
	 H1boIIyBhpszKOEMbGHMKFk+UJI2WhRyGin1X5FIPmUfnka9egUI9KY7wpnbq0Waxs
	 X5ZFE7NZKpM2iuwnggTXMJQi//Fr1CeoVen9yXN57GJTtsojOObXX/iGfY+zclsFSx
	 /FDvJ5xuFLXr1O+Dkap2xyZZ1AoJ9nlYkUWbiZaFu0uPW1QqxokP6a7xmkNBdAa2MN
	 iBnj1YqmXGyBfafe9/tV9a4lbwT0JY80WvpMh/9rcrzjsmMOUDuH2v9BZb6qUi5cmt
	 ykjj/CC6gQVWA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79Pg-00000006yfZ-3Q9p;
	Mon, 30 Mar 2026 12:00:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] Input: usbtouchscreen - refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:59:48 +0200
Message-ID: <20260330095948.1663141-5-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330095948.1663141-1-johan@kernel.org>
References: <20260330095948.1663141-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helpers for looking up bulk and interrupt endpoints
(and determining endpoint numbers) instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 38 +++++++---------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 657555c8796c..edc809d0f773 100644
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
@@ -1447,17 +1432,18 @@ static int usbtouch_probe(struct usb_interface *intf,
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
+	err = usb_find_int_in_endpoint(intf->cur_altsetting, &endpoint);
+	if (err)
 		return -ENXIO;
 
+	err = -ENOMEM;
 	usbtouch = kzalloc_obj(*usbtouch);
 	input_dev = input_allocate_device();
 	if (!usbtouch || !input_dev)
-- 
2.52.0

