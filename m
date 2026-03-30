Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAF3B7B87;
	Mon, 30 Mar 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864807; cv=none; b=Y2sufzU1y4SKq9Hw6JFmaILUhYNIPulPYFHjPCFNjYcMJOnZXJPEau3KsYK17ue5EPRrhujt3nc+NEzlrB0BFYsui0PnRKKdRRDlQ8zt+tyGwvt1cbw3cYAuKTjvdLvt9s+wIu9+iFIPrVkIS65AQ5e6yjyyYbrqhqZAxj4lhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864807; c=relaxed/simple;
	bh=uLZrGbmKmSUeJlzGFVn4O15k5z9DbQQi8RH35eZ3DJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpgwvAc8IOp4zSBrlCGEj2ZepEgIgrM79wvn55aQexVfYvyoBqv74sSQoHz7YM4ovTc0/BlCDmnsALFbRZTOx21pdOLjRtku1igbO7NkCmspzk4Lk2wYIW+5XG5ZvMTIe00BfEib/MJXICMoGwdACYsor02PEwAoYPiOZX9uVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leqPetKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leqPetKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E121FC4CEF7;
	Mon, 30 Mar 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864806;
	bh=uLZrGbmKmSUeJlzGFVn4O15k5z9DbQQi8RH35eZ3DJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=leqPetKN4g2Vj+8f8D/IYx2DJs2XzZUT+lLh+xnvgEfhpPc7jh1w6b+GPxo28dj4r
	 WKKmUL21u63kh8fSAR5bdSwa79VUhkRYGstP+TML9PA0vTybVHqZyNljfwNrpET220
	 8z2Vc93Vo/msD6aXmMFB6dAuvs3SbOhDkkpx+SVDnGiiDhNgGcna4BlhlUjbDhfFDy
	 y31X9DohKSpSdHv9eHY9aYrdToIhZznRS1RbHeArcwBbRHcehLqh/Sr/PEDXDvZUKY
	 M+YJNEcZETUrsRrFVIsWnqHaL2P9YitjZJqm4Bz0HjRGijXMAR7bI4Dhcv9MMcfVa+
	 N7MOtgq5lTEEg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79Pg-00000006yfV-3LSW;
	Mon, 30 Mar 2026 12:00:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/4] Input: appletouch - refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:59:46 +0200
Message-ID: <20260330095948.1663141-3-johan@kernel.org>
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

Use the common USB helpers for looking up interrupt-in endpoints (and
determining endpoint numbers) instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/mouse/appletouch.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 87d8f5afdfd9..eebeb57515e1 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -829,29 +829,20 @@ static int atp_probe(struct usb_interface *iface,
 	struct atp *dev;
 	struct input_dev *input_dev;
 	struct usb_device *udev = interface_to_usbdev(iface);
-	struct usb_host_interface *iface_desc;
-	struct usb_endpoint_descriptor *endpoint;
-	int int_in_endpointAddr = 0;
-	int i, error = -ENOMEM;
+	struct usb_endpoint_descriptor *ep;
+	int error;
 	const struct atp_info *info = (const struct atp_info *)id->driver_info;
 
 	/* set up the endpoint information */
 	/* use only the first interrupt-in endpoint */
-	iface_desc = iface->cur_altsetting;
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
-		endpoint = &iface_desc->endpoint[i].desc;
-		if (!int_in_endpointAddr && usb_endpoint_is_int_in(endpoint)) {
-			/* we found an interrupt in endpoint */
-			int_in_endpointAddr = endpoint->bEndpointAddress;
-			break;
-		}
-	}
-	if (!int_in_endpointAddr) {
+	error = usb_find_int_in_endpoint(iface->cur_altsetting, &ep);
+	if (error) {
 		dev_err(&iface->dev, "Could not find int-in endpoint\n");
 		return -EIO;
 	}
 
 	/* allocate memory for our device state and initialize it */
+	error = -ENOMEM;
 	dev = kzalloc_obj(*dev);
 	input_dev = input_allocate_device();
 	if (!dev || !input_dev) {
@@ -875,7 +866,7 @@ static int atp_probe(struct usb_interface *iface,
 		goto err_free_urb;
 
 	usb_fill_int_urb(dev->urb, udev,
-			 usb_rcvintpipe(udev, int_in_endpointAddr),
+			 usb_rcvintpipe(udev, usb_endpoint_num(ep)),
 			 dev->data, dev->info->datalen,
 			 dev->info->callback, dev, 1);
 
-- 
2.52.0

