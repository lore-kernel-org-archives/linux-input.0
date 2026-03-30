Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA03B6BED;
	Mon, 30 Mar 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864807; cv=none; b=iXyAzLfHsQS0UnZi7ZlUkhrC5qgvIphi6KcTH6wVUuX8VPNDfEh1cxdZaduV5fNgbtuVMjHyGdgGK4Bbo1hUPkMPalazajXrxWKOeA76i2iXwgXK11tGnaMIZkC2A289WsbE8+IjgWouHAmfNAwIYMibkkwFMJD6a8CmNqjswT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864807; c=relaxed/simple;
	bh=jPYqfrVJsg+9XnS7AWkksIvDFGqq18Z99brg532ZAp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvmN3snFc3qteQZeUlG6uyqEQm5J3hMddxLub5v2jw/h2ZS4HIx05GSM4+PJcnSwZD4uhMLfWJBWmJ6wbIlcUZpuHtUGFLr24AKk1ib+OzZShb05EnAMdlTcib8l4aawjAn3nXa3uANrSaEeqC9m1Pq7qdotK6si3mCP/YQ9m7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfJvNZp+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfJvNZp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1256C2BCB4;
	Mon, 30 Mar 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864806;
	bh=jPYqfrVJsg+9XnS7AWkksIvDFGqq18Z99brg532ZAp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfJvNZp+3ilWC+e06rWNF5J7hSW6fRrW6te8J0N8k8OkGrZ/EsYzjbKLOHXhpnOT2
	 OZYM1nMD2sNe3uiOqHdV0HgaXNpHgvoLHmP3syZkQy2dCPMHvANrnCGRb2zifzQNXO
	 yJN2xGu11C8YqEk789ckIglyZnKw2Qdu8zGJuA9mGgfcZlbpsJ8wNockjuKOdEVIMA
	 39DsQrQObd1ORbGzK0O4GW7nYCdmVhd5ZBA+Lwwl6V/5XfWQ7cctHf1IABVWaLbtT1
	 vHB7h0ldmpSRRFgqSDdF6TzmR6arL7+yxC0RFqcJDrYTq7T75bZzV0/NdxKSv/a/zx
	 XpPJqAUJxjYvQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79Pg-00000006yfS-3J7O;
	Mon, 30 Mar 2026 12:00:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/4] Input: keyspan-remote - refactor endpoint lookup
Date: Mon, 30 Mar 2026 11:59:45 +0200
Message-ID: <20260330095948.1663141-2-johan@kernel.org>
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
 drivers/input/misc/keyspan_remote.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/keyspan_remote.c
index 152633bd2266..70cd6586459e 100644
--- a/drivers/input/misc/keyspan_remote.c
+++ b/drivers/input/misc/keyspan_remote.c
@@ -420,24 +420,6 @@ static void keyspan_close(struct input_dev *dev)
 	usb_kill_urb(remote->irq_urb);
 }
 
-static struct usb_endpoint_descriptor *keyspan_get_in_endpoint(struct usb_host_interface *iface)
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
 /*
  * Routine that sets up the driver to handle a specific USB device detected on the bus.
  */
@@ -449,8 +431,8 @@ static int keyspan_probe(struct usb_interface *interface, const struct usb_devic
 	struct input_dev *input_dev;
 	int i, error;
 
-	endpoint = keyspan_get_in_endpoint(interface->cur_altsetting);
-	if (!endpoint)
+	error = usb_find_int_in_endpoint(interface->cur_altsetting, &endpoint);
+	if (error)
 		return -ENODEV;
 
 	remote = kzalloc_obj(*remote);
-- 
2.52.0

