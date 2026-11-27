Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795775670;
	b=x/mnIybgWx2YrJ2d+uaOQCrEEbmKc407rsNYNYVvacdoMBh2q17Gzliq/YgSJ9vwHhtT
	 qdFKLKJ6IEsSlrQOdU1tAPYQrIIroak5C2Ka7UCLhZ5sx+D86cB6BezTSdxgMUqGMfXxY
	 bbsOHgTH+SmbizOHmvQdAocGgQzrxxRrHiF9DuFvwIzs7WlU6wQrLpm57pPNiLLH3Yt7t
	 VZNEIpYd6cQ7+HSYNb5jcnP3eVGM/QYKpzqC1SPChoiLwj6boFg8eoQPhqOxYGDeeX+Rj
	 9pBvCCg1mo1X82DaPqSgUOKBc4ygSTmocnobxQAOLeEHu14Qpi4GrD/Lnk+/8GJMiiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775670;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z1e/VCW5oZKKzLUH0EadYkbC3hnbO+DYJJn9zI+5GTA=;
	b=LXQxzIcw2bGrptl0hHRxddf0OkzjMVbEozt+j35o9mwxy7j8pjOOX6drQCQ5AQ0dVHyf
	 Yx/W+6QPKOnO02aNRqYfnCTkf2r6betnC1wKprrU00No3zT405sLd74dao+gy49ulIfnI
	 FFWujkowQIA7ButH8JayJ0PaOHjw2YGh6lROOmhI/xC3LMHia+Qr2K7l5Rqzuh3Jzp6nJ
	 wPOvGEttaB63JcCoc1GSdxn7nPbC+T4T0HQoA0ZoYbexE2lfHpCEYG2km8f3v3PL3efgO
	 R9LgQ2dMbngdRpCzah+waoHn7XMwHkXfz7hkLnJ2eeUacXW8A4HLJIqvfZlZyyxznEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvC923EC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2180606A32C;
	Fri, 27 Nov 2026 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvC923EC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795775670;
	b=l9k8vCE5UUsrGKRqQRC/IO8CwOjOGiVPOchMEw5N8q6B1jkQn0dcFMAkTNLXiDrSGkfD
	 R/iIwPLViHFZdfXWCzTLaSwBHDDA4xwcvMKREgDhb/YkcXXEa8q3uOmnJVgbGEowpFJOM
	 RaUWEt6LIxhLXP5VunG6lYs03vNzL/2muoDTFlWom//oGe1eRjL2Sn0MmmBf+LI+ikmiA
	 GLGJehSMQxx/0k3Qo38v7r09zUAMYgfi595WyBARdcVHpJBdLh0Is1oCOwJxJdWbaf8Cn
	 sXGF1pP0U6fW1aoXrzm2lCGjC2aacPTFrllzjNEefs24AXf7DhVjQsb9BxIM3n1xVsw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775670;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=z1e/VCW5oZKKzLUH0EadYkbC3hnbO+DYJJn9zI+5GTA=;
	b=fK4u+MqLorYbQbBDO4aMb2yiDNxL8LpNWNW7yyNT8RyI76IeaLL2b/pWU44D4NjJZVVj
	 IPbVXqTF1D0wjDecoQpncxmCJJ0pEPFj0tEFp0XWnp4f0d4PzymUM4MvY/ctG5qo74Sgo
	 Dd7JobBYgyup0cixxj9HcogbSfbnfKxBbWIGaCwwD7uKjH5eyx0zDBw4BFbOMywtHCO08
	 pm2TsGRI8g4Tg2FO+9DBFCqBLSduCJ7OBGmTdQWe7MffvGx1d+3X+OpKyjZp7rGWWYV2o
	 owVWq5vdhP8uHDphAfWeCb0At5YWv71flrVxXyeVjbYkDpBpLBfLo5vz7fdifS71JUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A88331F00893;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775670;
	bh=z1e/VCW5oZKKzLUH0EadYkbC3hnbO+DYJJn9zI+5GTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PvC923ECbu90ViDLdLvGOoAn3+VYn564473Ms+1VToEeJ/N/vn2pfCXEwtPLBz6WT
	 nuUIrY1Xz8hOf9wSB/Kif22Op4fvmr8bRS9sjp7a/7XZRE7Q0aUb6IbxpJEeElAuXt
	 qfAhemdyQJZ21i4DXouWpwOm3eBDbrVnPgtGFi9c3esF0KC7Kp7vNIsv9kdshnk5c4
	 EQUOVmYG7Pcz8HA72HCmQ7KByal+JcVkKRZAUZ+LY5Gva6pku39w+ErU2CrDDOUt0+
	 XKfDE4Hu3B4tkiwWKuZa7tWwehTEKT1h+9QzHiy9oWbFmnW0iGRtgLqxJECupXw+DG
	 GspHK8D17e+eQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3B67E4B733;
	Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 16:03:58 +0530
Subject: [PATCH v2 3/7] iio: magnetometer: hid-sensor-magn-3d: drop
 redundant probe error messages
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
Message-Id: <20261127-19-oct-hid-iio-unified-print-framework-v2-3-3f476fe1a940@gmail.com>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
In-Reply-To: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795775655; l=2280;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=El48voEBnfgib51qLeTAjfSBpWFdJf3qwG7hOZtaFtk=;
 b=xD2nk7BDs1A3niyi6NtpqHyofScXb7w2FjUfKtp1rB+jZ/iTmIFIdW0NiE+spVkZwGlMwdgal
 JTD2LZuIbxqBJFQs73v1Wgb2pqs5mlx/TeXjVxZ8d9AQ55PERTiabDG
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
index 5dd36cfd0ca7..04e2569d7ea8 100644
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
@@ -372,20 +369,14 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	/* Setup IIO channel array */
 	_channels = devm_kzalloc_objs(&pdev->dev, struct iio_chan_spec,
 				      attr_count);
-	if (!_channels) {
-		dev_err(&pdev->dev,
-			"failed to allocate space for iio channels\n");
+	if (!_channels)
 		return -ENOMEM;
-	}
 
 	/* attr_count include timestamp channel, and the iio_vals should be aligned to 8byte */
 	st->iio_vals = devm_kzalloc_objs(&pdev->dev, u32,
 					 ((attr_count + 1) % 2 + (attr_count + 1) / 2) * 2);
-	if (!st->iio_vals) {
-		dev_err(&pdev->dev,
-			"failed to allocate space for iio values array\n");
+	if (!st->iio_vals)
 		return -ENOMEM;
-	}
 
 	for (i = 0, *chan_count = 0;
 	i < MAGN_3D_CHANNEL_MAX && *chan_count < attr_count;
@@ -409,11 +400,8 @@ static int magn_3d_parse_report(struct platform_device *pdev,
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


