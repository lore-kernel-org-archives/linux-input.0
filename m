Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797EA310784;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009084; cv=none; b=hRZkXuZTKNezWWQ0h/Yu0FUimH8+q6BCnuiA3LCT801wjeCGsuy92ivpw26r2sGshbQ5zz1bF8FksIhdE33HjgCkBMpJeu+8ZmUwKix4PUbyY6DarDITyAxPq08owNi1nnZ8lRIhZ1On1b/g4YmVsN7Q9De1EyMNgbnX6+YDnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009084; c=relaxed/simple;
	bh=cDhQ1jHdI9f2Cp+7HNNJfRrVqNckYCVWcbk9jRv1TiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gI6b3S13foOWR2UFBgRbHFGLL8dzbjDAT2XfJz8PJlm2VfO0hbLWtdfDrakjfvqZj28B3C/tgb/OushiLY9PYfPztT68mBWFMIf7ifuP/7guXMdf6jZUakk18mHn3JKb5zw+THNnfElob3TK+PrpuEW1d9O8v/mQBmRNH3YDZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Duk1YiqW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Duk1YiqW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A1B2C2BCF7;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783009084;
	bh=cDhQ1jHdI9f2Cp+7HNNJfRrVqNckYCVWcbk9jRv1TiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Duk1YiqW+iGlz2/O5Jw3SI1vw69nSm9HRZRFLOHbNTWHooqmjbWYgE6ut5szyIaJd
	 Fhzy2LlwS34wkYBf7t9lSiMZtFW/+GIpzvyNuvjceUs8pYA+JQe9DzjZ92ErfXlk3D
	 Ch1EO++/mRp2dNwXQ6qxf50FnAaDrG77S4dpopczzfxgRfpV94n1ndTnsFNKkfpmBe
	 taLzPBGFl6ujuo2Z5XK4KOPsYzssRnF6ZdFG/O65zfloqi1QrHYJKnTgJoXgfHyNcs
	 WMxVxIqJYxjEu/Ne0sZq/d+U5uUP++xjP9HRQZE1zYyF/rktRdKANW+5krWUyKgcJy
	 dxcFzrrSi2nwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D413C43327;
	Thu,  2 Jul 2026 16:18:04 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 02 Jul 2026 21:48:00 +0530
Subject: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer checks
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
In-Reply-To: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783009082; l=2751;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=owJksSx1dj5lBGugetx8eR38mlNEZXWL0V9RnRI1bTA=;
 b=J2Re/LF0jpUXJ/f0vGjv0UIgfPjwNTHsnp1woLJC6yNvcSxKFWkzAuZZdr9qo1EAbksq+zVU9
 DvDZqgZimZfBbJ0KYhCO5On+F3cBDSI1e3UBA+XSdok/jW6cy8z0zIJ
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace explicit NULL pointer comparisons with implicit checks across
HID sensor IIO drivers to follow the preferred kernel coding style.

Convert 'if (indio_dev == NULL)' -> 'if (!indio_dev)'.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 2 +-
 drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 9197f3424c0c..225f8dd65ab1 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -325,7 +325,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct accel_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index ad10fa20fae0..738bad65d74d 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -463,7 +463,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct magn_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 870c8929491e..c8efb0dab8b6 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -302,7 +302,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct incl_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 2dad0453fc67..6db253c1635d 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -274,7 +274,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct dev_rot_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1


