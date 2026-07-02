Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0E31F99B;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009084; cv=none; b=K2JIz2pHIa9F6owxZt7RrXhfhprCYCriRZXtc6O4Bds9cvUrAb/xZWHYTuRAjcKpUlo6qkFwW7iW5NjZpFa91V8qQbc8z3jStEM2Rx+bYPXFK/gtJShnU/P114GVtH/G9OqKei2b9qbgfQAq6nrGRettY6+hvBbbdKBrZZUCHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009084; c=relaxed/simple;
	bh=+m9IEtEWDNFKYYvXHkWmrrpEv+UUXIOMqRTwsT6wCoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fa9PFOt+L9HholVgMvlrbqIBbg+BuhHlF3O1aQra6BhnqVOpx7s8/Zw2duyADgaLzo8+QewkJ/JdL/SimlSL5EldS+BAYErwmuZDoRMtLw7b8ZwPobsvQv5PhdGFcDGTd/0OwtmgegP1zwnEvkI106vliLT54dEnfpeTKt+la88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiPAJQDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiPAJQDH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5227DC2BCFC;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783009084;
	bh=+m9IEtEWDNFKYYvXHkWmrrpEv+UUXIOMqRTwsT6wCoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KiPAJQDH1/Gmx1qNJEXOEJ2FPFh6H/7fXEM/AE5symKzQHcM2FWOWTbS/MuTBJ1aR
	 Di/3kG2XNijFZifkC8a+y5tKc91eUhEhplqJtfb01ECS2uX2qJAmWt+HzhwimW75gU
	 Fri099g+RTXL6dennCuLGG+on9njX/bBvPH10IB9pKnCPwNGdMvJgmBe64kMHEfDIe
	 jlpRsm7TbpMZmL1/B6temSrxlJCdQCO788C2Rh64dNxUaVNk3Sd+YSNqPCVxpI2vxu
	 bqAKPvG+sc431zMxVshu9mhVynrd1XBcHVksnRU2BdWWbBUyW3IRHkuYZFYVSdtNR0
	 MSSQGpOazZzeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B86AC44502;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 02 Jul 2026 21:48:01 +0530
Subject: [PATCH v2 4/6] iio: humidity: hid-sensor-humidity: use common
 device for devres
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-15-jun-hid-iio-alignment-v2-4-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Zhang Lixu <lixu.zhang@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783009082; l=1483;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=oaBY7n/KDzBWzhQdsO0RXXpR2otX0e7lfUNOgkg7U5A=;
 b=xmaFoeaDGTl9vgXSxZD2RFBJ66BEmeJvvodXxnVq2wVgFD4xFye1iSzbdavo6KdGpCE2cD/w7
 5nnhBYCFUs4CJ/aq4W1N3pF6+yurSiR5gGpRIkhZIcxg67e3zNeXyiV
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kmemdup() is used for memory that is logically tied to the HID
platform device, even though the driver binds into the IIO framework.

Using &indio_dev->dev for devres allocations works functionally, but it
results in two separate devres ownership trees—one for the HID
platform device (pdev) and another for the IIO device (indio_dev).

The devres framework is intended to have a single, well-defined parent
device. Since the memory originates from HID sensor probing and is not
IIO-specific, &pdev->dev is the correct and logical owner.

Switch to using the platform device for devm_kmemdup() so that all
resources are released deterministically and consistently.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Tested-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 8dd8bc0b3ba1..b7130eac0394 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -216,7 +216,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	humid_chans = devm_kmemdup(&indio_dev->dev, humidity_channels,
+	humid_chans = devm_kmemdup(&pdev->dev, humidity_channels,
 				   sizeof(humidity_channels), GFP_KERNEL);
 	if (!humid_chans)
 		return -ENOMEM;

-- 
2.34.1


