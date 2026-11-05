Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793882518;
	b=oPgGLaHlmvVKmNm5btdmsGIPd8m/QQq4Eqz+CmbMNPlsO1YbhZmSxnLaW9tFKptRbJkO
	 jLANB4d/td2tlVRi52HRAjW+fkxxa4kY3p3uLydHAiAs60avwmcI+xZ8rMax7rQp2jvIQ
	 n/xvV7ArH7QTtLQPtKZrALeV2j4DNfeghxmMfxS4dOwUW97kDONiSYidyjkBTqs0MQsqC
	 VqR+lbk9mTAijaSmw5P01XmoN+d5bmLvMPcDat5/L8+KsNs5Ydr5U+0Y73hGm4X6IP+RB
	 /SpV6jRE/UkqAPOs9Y4w3IJ0UAOC7aJNiCjWE2aYCdE3hR3VTa6huivwahGaHuGB07Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882518;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jrCXnQ3aZGIK+NBppR3g9GDockAX6IFgurYVDQ31mT0=;
	b=V2xz20OSvAv32z7I6bM18zp4GoQFDPSRWV6IlO6tD1pdzU26TFhKogkwXzh40RlbJGS5
	 1kRPtdI0ZZcKA9vySuRFSzFdn1KyWdVdpDgbS4JqakjH3dDJKIjglUWtrXu5dGRMUYfyV
	 I3T+0p6mrVMBWSqNhluwOrPXu2YUpfx7BPjLKY9Si1jqT5gDUfSvsgguB74R/IK4cwrAU
	 t0zAUrySd9l06Cmi+PFhoRPNchUgDCpFIOB25G6Db9i2B1/v+yHGEjSmncCoNQXndZltP
	 9M+AbV/Mp6TCcOGX1k2Wnd9fxeNkVxDt15k/jqrBLoWMVzPquX68gMMwbzmnNPu45dQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFLJM4p7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7BF606A33A;
	Thu,  5 Nov 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BFLJM4p7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793882518;
	b=kxFdqpB40DrFNlD+esh7A+wpquHR6rjgcvPsfokK5G/cfCyl4CtMZ2LQJRdQyTaD87fk
	 8Bt0puZor1Ub9KiF4BRVGwsETYDksdmEXaVcF8sMVQ1fgSuoHIzprT4zfK0plowgNh7Ve
	 YMYudJheXfJmeGdPKkE5Qq/m4ZPicHS8tAsvOpO08K9YoP/0bxEW6LXfpqyaToefMY/gk
	 qtR/qbZxA7XsISGLBFVJslgd7ulNHwAAc+F9xNgq+5UUUfWeO786/fhl2RDU125bgghTZ
	 P2L3OjXqlQw356b3qy1P/tLgDOMlkLY4HGcTJjjDqI2s74d/uqCvZ4ZeAt9JDWtB6bA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793882518;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jrCXnQ3aZGIK+NBppR3g9GDockAX6IFgurYVDQ31mT0=;
	b=k3whpTArxmf7KvLcEXd1eOTVGVsgPdQI9rQ0qvKzEb/nGpIT5PVtxs2ihbNd3hyrg7XI
	 U/JsV254K5rHEeYQvI6Vvuxe8kqMl6W5Etvn62oTaWDY8a3IFFKYPa2Ypassy7dtzHTMx
	 /LdzI6lrAoZiMz6o/OdURfVrWNJlwtRhHkXh9mYHpx7RKN7ekxoUm7rAnqGnVDQcoH9Wr
	 waCheHOJ/Dq8E+Ls8VoPYYMn8VqRubCiH6tscxKHu6dO+K3YlzV91CwtTBsVYAs3ytiRG
	 2sY9NfnEP5iO5wPd2TMJB1kdseojpkVJ/6DO3ukrHtm9OSCEIiLC1FiLKcpas6dk9dw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2BC001F00A02;
	Thu,  5 Nov 2026 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793882518;
	bh=jrCXnQ3aZGIK+NBppR3g9GDockAX6IFgurYVDQ31mT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BFLJM4p7iFSZzZuYnW/9p85OUdXSxnf62EARSCPUhHdf7ahmMrslc/7k9rQDbX7Ob
	 Su9yBwbleTMx5Xq2+ZpYxM5H5VyVXV2+1rjispl0jorOkBDza0hwrLKkrJ0N2Q2I4e
	 Avgu1hb6VZuuLPIkiqVJxFx7ZWWbuM0a+XWGX8qyFRr9bsrihjlG5tO1v/9TuKhBfG
	 O2Vf7xKWlfiDR3FtirFN3LQxkGW4BKehO+eZD/VUnxH7NcHK0mY3Ggf9OlqmClbgZ4
	 9szKEzHA3uM3BKz4i6Fmg7HbV/5nVHGXmgveoVt62YOZUPlRxdep1IMx/tB4QiqS3T
	 kjritzv5kWNdw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A86D747252;
	Thu,  5 Nov 2026 12:41:55 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 18:11:45 +0530
Subject: [PATCH 3/5] iio: magnetometer: hid-sensor-magn-3d: drop redundant
 probe error messages
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-19-oct-hid-iio-unified-print-framework-v1-3-0b360d9552d9@gmail.com>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
In-Reply-To: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793882514; l=2291;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=qC1Lxu8F4R235soajdiBHvZUF8Jt4qICpTs8qOVi7Kc=;
 b=gGnLOr9gNzaTqu+nS4pU1eTMBNOqk8sucDT3fSqEsyOfisDSBCb80VF69NzBH5M6xqaANdRIp
 vGdxa6uAMMxCoCtg+uoM4byGnbMH9w3ubMNWCMNTfdgr3wa+4ocR8zn
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com
Content-Transfer-Encoding: 7bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The probe path emits error messages for conditions where the failure is
either already conveyed by the returned error code or can be identified
from the existing debug messages in the magn_3d_parse_report().

Remove the redundant error messages to reduce log noise and simplify the
error handling code.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 911b15a5175d..fb9a561706a8 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -356,11 +356,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			attr_count++;
 	}
 
-	if (attr_count <= 0) {
-		dev_err(&pdev->dev,
-			"failed to find any supported usage attributes in report\n");
+	if (attr_count <= 0)
 		return  -EINVAL;
-	}
 
 	dev_dbg(&pdev->dev, "magn_3d Found %d usage attributes\n", attr_count);
 	dev_dbg(&pdev->dev, "magn_3d X: %x:%x Y: %x:%x Z: %x:%x\n",
@@ -373,21 +370,15 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	_channels = devm_kcalloc(&pdev->dev, attr_count,
 				 sizeof(struct iio_chan_spec),
 				 GFP_KERNEL);
-	if (!_channels) {
-		dev_err(&pdev->dev,
-			"failed to allocate space for iio channels\n");
+	if (!_channels)
 		return -ENOMEM;
-	}
 
 	/* attr_count include timestamp channel, and the iio_vals should be aligned to 8byte */
 	st->iio_vals = devm_kcalloc(&pdev->dev,
 				    ((attr_count + 1) % 2 + (attr_count + 1) / 2) * 2,
 				    sizeof(u32), GFP_KERNEL);
-	if (!st->iio_vals) {
-		dev_err(&pdev->dev,
-			"failed to allocate space for iio values array\n");
+	if (!st->iio_vals)
 		return -ENOMEM;
-	}
 
 	for (i = 0, *chan_count = 0;
 	i < MAGN_3D_CHANNEL_MAX && *chan_count < attr_count;
@@ -411,11 +402,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		}
 	}
 
-	if (*chan_count <= 0) {
-		dev_err(&pdev->dev,
-			"failed to find any magnetic channels setup\n");
+	if (*chan_count <= 0)
 		return -EINVAL;
-	}
 
 	*channels = _channels;
 

-- 
2.34.1


