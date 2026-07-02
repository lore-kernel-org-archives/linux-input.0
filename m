Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99A335BB4;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009084; cv=none; b=lfQMZM36wC6z0NNP4OtQwLh/PxDqyeQCUtI+drG0PJ3z90qAcgK9B8jRwv6CXDPHnaYI7JqJUMuaL3R5N0CCMxe4rLczTARWs9fadhro8WlPYB0IJ5U3pyWweHXjIHfgyq4fLtssvhxPLRvtmy6T+gzc5QpICW110oS64YP9bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009084; c=relaxed/simple;
	bh=pv7PI0tXeCcYFPamSAtzGET4g6+CyDXUeIY+gIwGB88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hla8QEXerCPn2S92+4mL2NXYryyHCWfHivtfc+JobXRueKcPPkzKL0TZf3ig8jDoAdTVnFp75HX54ZBZ4E1ztPxmQxf14RpXh3ROQ8RH9RPtPFv+UlWYlBHWZBhS1qtm59ANWdixq3Iaeb4uz9N4OrHLKCZdYM/ZT/3lAtJkEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/GyLuK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/GyLuK5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B2BFC2BCFD;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783009084;
	bh=pv7PI0tXeCcYFPamSAtzGET4g6+CyDXUeIY+gIwGB88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T/GyLuK5NAGNa/GCO8Zyu4DG5TkT+xKJme5uLWkt4foQKNaxLUI0jg+l5MHXMvqV3
	 kDUd5VFQbW156UpwoMtU3fOUz3StD8MYmpSZCV1Tc2CBH4AayfcOBbRiNpAv6uqVyv
	 t2eHHhVp96naXsWHxOYBHDgJDEk4C6rVZFFXoBhnYpy207KGHawQkEHmFdAljSbq1s
	 FkFBUT03dJ87hNTxoWItlk8jSbq5/fGQ3jRO4M7xlwwguKj020V+G/OTs1T7I+YZvE
	 yZXUbtva7nwqEyB4oqADSROQuPxtAL+TqjvFMUfVBoyJ/hkIsuPbt5ozQDPMb5t0iB
	 2p5UU9ycejPeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0CC43602;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 02 Jul 2026 21:48:03 +0530
Subject: [PATCH v2 6/6] iio: temperature: hid-sensor-temperature: use
 common device for devres
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-15-jun-hid-iio-alignment-v2-6-b87f01f5efbc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783009082; l=1531;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=4701Zl6ga9a1z4yj3Yz9gyyh1nnaOn4C8ewcual1JXA=;
 b=jt3v7QdjWsfgAfapZwFm0C9YNA79+MuK2w12LOFbEHrlpVz05FnImDeiSt5LBiqmdG+XpONgq
 fVMLvt/ITxrAXnZwacib1+ey+TtLlS9hway7fYeVnhNzUgud03Pqout
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
 drivers/iio/temperature/hid-sensor-temperature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 18da85e6c60e..6dfb606a53af 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -213,8 +213,8 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	temp_chans = devm_kmemdup(&indio_dev->dev, temperature_channels,
-				sizeof(temperature_channels), GFP_KERNEL);
+	temp_chans = devm_kmemdup(&pdev->dev, temperature_channels,
+				  sizeof(temperature_channels), GFP_KERNEL);
 	if (!temp_chans)
 		return -ENOMEM;
 

-- 
2.34.1


