Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12B3B777E;
	Mon, 30 Mar 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864807; cv=none; b=ChY6Mggk8wjORdberQ1XBjkoEzFcGZTRU0x3DiFKbNJDn7i24xGUsv1fWlalmXtgF1/CFHQHGmpU/m7b4M5NLYDgx8IpO/kb5NaKtxFHy49CoEcR3rSuQuXRnpIhInKx6Ye6aiSdTRNz+ou1zor9xJtwPr1x8RE7q/ePiEIgONo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864807; c=relaxed/simple;
	bh=ETuNAlVttgyljLvGjyhUwi+P1xNTdftDa3UpnFqoZ4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBO+qjK/qllknjxgBDvtrjYOTjsd2naoBOv3a8f5f0a3Hu/1BMQt7vnFtpHtZ8jL/J/azQMgVPUhNWn22gWUgQOQF101UJER7Lac/oqjr+cwGfsvR7kzSAepuKgWWvtZZR9bAFxB5mUKEd4SZxEV7DFoRha4QpOnHbQlyeKanzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFswPFTH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFswPFTH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44B9C4AF09;
	Mon, 30 Mar 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864806;
	bh=ETuNAlVttgyljLvGjyhUwi+P1xNTdftDa3UpnFqoZ4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFswPFTHYi2i15W3KnvhGfMb8XzjtxO2Z6Lk554VKtr47rfFBGRwaWUGN8YUi4dPN
	 E0muKn3NDbKc1K2PKyGuTz9yW1CtDaSUJ40ZvKSBvn8CFocq7YjK1Fud3xs8dkS0G3
	 07Y5u0BqKzKmNx2O3goT/icy7xWRC3KkeFo7F2N9brihDAFc7DNAbIgZ3t6bNa9BH8
	 mxyYWE+gBgkTI+9ByIV78z94n6687yG6koPjapJ9M+U6FGg9hr6HehP9yPALq85GWd
	 EnxyA3nwNYTTaWDwb5gc0Z9nWiH73f0SBJG2LyJ+wIVONfxULSSptRBi5tpIJN22Fn
	 DZ3F5y06Bk3dA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79Pg-00000006yfX-3Nko;
	Mon, 30 Mar 2026 12:00:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] Input: synaptics_usb - refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:59:47 +0200
Message-ID: <20260330095948.1663141-4-johan@kernel.org>
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

Use the common USB helper for looking up interrupt-in endpoints instead
of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/mouse/synaptics_usb.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/input/mouse/synaptics_usb.c b/drivers/input/mouse/synaptics_usb.c
index 5a86f6f387d8..880a0c79148c 100644
--- a/drivers/input/mouse/synaptics_usb.c
+++ b/drivers/input/mouse/synaptics_usb.c
@@ -220,25 +220,6 @@ static void synusb_irq(struct urb *urb)
 			__func__, error);
 }
 
-static struct usb_endpoint_descriptor *
-synusb_get_in_endpoint(struct usb_host_interface *iface)
-{
-
-	struct usb_endpoint_descriptor *endpoint;
-	int i;
-
-	for (i = 0; i < iface->desc.bNumEndpoints; ++i) {
-		endpoint = &iface->endpoint[i].desc;
-
-		if (usb_endpoint_is_int_in(endpoint)) {
-			/* we found our interrupt in endpoint */
-			return endpoint;
-		}
-	}
-
-	return NULL;
-}
-
 static int synusb_open(struct input_dev *dev)
 {
 	struct synusb *synusb = input_get_drvdata(dev);
@@ -307,8 +288,8 @@ static int synusb_probe(struct usb_interface *intf,
 		return error;
 	}
 
-	ep = synusb_get_in_endpoint(intf->cur_altsetting);
-	if (!ep)
+	error = usb_find_int_in_endpoint(intf->cur_altsetting, &ep);
+	if (error)
 		return -ENODEV;
 
 	synusb = kzalloc_obj(*synusb);
-- 
2.52.0

