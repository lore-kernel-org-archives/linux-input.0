Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045F32ED40;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009084; cv=none; b=q7HXDngBez47Jaa5FSuELaYsjbPB5+yGNnOA9qjPY+MJsENZgZGzibXmhP8LNSnxO3kEnHST14tJy2+ejb0P8UEG9LMYccdTKapIPahFf4popIcxH1ZUf3RoVSZq3dNU+mO0L31yP5/XI78IqCMCWADyf/QtQOwCWQ6RYlIZZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009084; c=relaxed/simple;
	bh=hBPKC+aSvQjJEYw/EAhJnBYevuk2mW+2xc2cn8CvQDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKQ1W0kuwuoymRNkMBi9KvVMQItukgRhNdSiUpdSk3xJfuxGgJwzGeiwgMoIGfkqA8d3+jksNvZhvsHAxPXHqaukmkfKVKX5Rn0DLOLl4JUuIwbP5R4kJjndK8ZOMaDmuVl/JN0BE2u+PK18jYZxPcUnpx93sjnxyVoHC+nD430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBLIasZv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBLIasZv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F451C2BCF5;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783009084;
	bh=hBPKC+aSvQjJEYw/EAhJnBYevuk2mW+2xc2cn8CvQDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hBLIasZvPnpSvr2V8iDdCYerurEJYaouAkFLoBrvIjRMpfqF0c0JPCLUdGlnDjI3u
	 gL7f/sEp8NZX7DEx7bYzVoLkviJdbY0K49qSgQ1UhtPnRFF8YvaQgVLLRqLTkHBfpM
	 CqFlciqoUGB6r10Kt3Fpq4H7nR2taUUfVwnqo3oS8bzObMfvmXE2o57Cy4WAzsMEzY
	 m29xbrsYd0GnGHk+/vFYE28lA603rfEcZhBOGuyE2VU5L+ETQBYwZZ7r7JTmz2meNq
	 /nB5540m3t98zq0Jf/Rsxv8HCJUCb/HNjLRaZJbl2v7/Hyapo/mqZMKWw/ApDkQMMl
	 kq9FK2bnunRzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A22C43458;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 02 Jul 2026 21:48:02 +0530
Subject: [PATCH v2 5/6] iio: position: hid-sensor-custom-intel-hinge: use
 common device for devres
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-15-jun-hid-iio-alignment-v2-5-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783009082; l=1534;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=UVaeg5VQR9vVfKtl4zUrShl4tLPPpTExSxQIrmcvo/0=;
 b=XacZ0TI+yEupbRsc6dfYKJteuYmk5TTUoc0HpoC9Btht8aTWYGuyCeRev2sgQTMRAFIG0UdKm
 kTVHRRVQYjGBHXa1vk3K7QbEJHgWiFHItPQtrgvG/LmKU1qH8Zhhbnt
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
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 1f4a40716c3f..eb6c59f81c3f 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -293,7 +293,7 @@ static int hid_hinge_probe(struct platform_device *pdev)
 	}
 
 	indio_dev->num_channels = ARRAY_SIZE(hinge_channels);
-	indio_dev->channels = devm_kmemdup(&indio_dev->dev, hinge_channels,
+	indio_dev->channels = devm_kmemdup(&pdev->dev, hinge_channels,
 					   sizeof(hinge_channels), GFP_KERNEL);
 	if (!indio_dev->channels)
 		return -ENOMEM;

-- 
2.34.1


