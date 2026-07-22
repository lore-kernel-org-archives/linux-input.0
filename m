Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385574DA52F;
	Wed, 22 Jul 2026 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740758; cv=none; b=oBe78UnVx/qELjzUtOJZKaqB1OKUw9/9KZguu5BWvP7g3XR9ytMp+AfH4ArHPloJnqRh0euaI9A57mft4doeuMkTRFifXevtOBCkLaYI6i0tflCHFTxWpSfHkAPuE4+De4Hjx0HtpiA3EzBtOzWSHKn6JnofsjRxOeaNYAeG76w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740758; c=relaxed/simple;
	bh=qwJlCn9D8PGLNGgshW3nUPIpMVOkRUj0pGRSDgWuSc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L0fFqSzu1R6JmdYlhPKAoEZUanl5Q09/OTJTyJwz3F/3vVmfGtsaYAS+EO0aYzaOJP/7MmLhHauS4XzX8uxKM6y6SxWkEdw3jLlNhn0gxbu+HWtDG0tgjidyG2FcW+U6SQ6SAatPgaei7jHuuD9YCNM4krKtqv9/pnPZR/+QVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5gOXOuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5gOXOuO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2CF4C19425;
	Wed, 22 Jul 2026 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784740757;
	bh=qwJlCn9D8PGLNGgshW3nUPIpMVOkRUj0pGRSDgWuSc0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=g5gOXOuOdiluXXGXQZDVG4lCWCCixfrckoPBuQr2TWHNxELz/KnvNOYY1Eqo+vlrS
	 /5R0nONic9SBa34qcSfBdROTzf/AtOUlQ18oxVTqLqfLLOKod8o9VaBHgC8eFHuqBX
	 AK6PLf7nouQmFk3Vh77AlhtVTdoVev3XYqPhc3BZJPhC1+nWHhh/B6e6L4MZR+SmCI
	 R3/LmjuhvAFuBD3ULVp/aN/jVmk0ryPUDa+MozwY55mboFBlZfhj3EqVWjEAHIv2Tg
	 uWFuLrgDdjii1EcNZT87N2hzr8pj7WvFunHUY395zF2Ad3mPwvUo4rbNuzt1H+q/cn
	 FTJB/vSVm0oew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B8C44536;
	Wed, 22 Jul 2026 17:19:17 +0000 (UTC)
From: Daniel Schaefer via B4 Relay <devnull+dhs.frame.work@kernel.org>
Date: Thu, 23 Jul 2026 01:18:58 +0800
Subject: [PATCH] iio: hid-sensor: als: scale each channel individually
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNj3eSMovzcxJLM5MySSl0Li7TUZBND8zQDg2QloJaCotS0zAqwcdG
 xtbUAJL9cU14AAAA=
X-Change-ID: 20260723-chromaticity-88fec417f00c
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Schaefer <dhs@frame.work>, 
 =?utf-8?q?Sven_Vaink=C3=BCla?= <sven@xn--vainkla-r2a.ee>, linux@frame.work
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784740756; l=2857;
 i=dhs@frame.work; s=20260705; h=from:subject:message-id;
 bh=/XNacu+WH59c4GNRh+63P9svsVbz6GJ/iheaNgZoQTM=;
 b=JgydhQAJU0UdE5wRL5rLNQx39GksdInXROQsM6J4R5XfQGDUGZ4tGJYGLK2BXzt1zwaqQX0Wi
 HPbh0QVzf2nDLi5pGoYO8TZR5AdRWmKHAIWBnoKS7zQl1xmu8SZqtT2
X-Developer-Key: i=dhs@frame.work; a=ed25519;
 pk=O1zF7VDnmz6EZNc7sEiawR+KK650uRg1XteQ8jHwScw=
X-Endpoint-Received: by B4 Relay for dhs@frame.work/20260705 with
 auth_id=852
X-Original-From: Daniel Schaefer <dhs@frame.work>
Reply-To: dhs@frame.work

From: Daniel Schaefer <dhs@frame.work>

Some sensors have multiple channels (not just brightness but color ALS
sensors) with different scaling factors.

Tested on Asus ProArt PX13 laptop by Sven.

Signed-off-by: Daniel Schaefer <dhs@frame.work>
Link: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/413
Cc: Sven Vainküla <sven@xn--vainkla-r2a.ee>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux@frame.work
---
 drivers/iio/light/hid-sensor-als.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..232cb58e0a9f 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -33,9 +33,9 @@ struct als_state {
 		u32 illum[CHANNEL_SCAN_INDEX_MAX];
 		aligned_s64 timestamp;
 	} scan;
-	int scale_pre_decml;
-	int scale_post_decml;
-	int scale_precision;
+	int scale_pre_decml[CHANNEL_SCAN_INDEX_MAX];
+	int scale_post_decml[CHANNEL_SCAN_INDEX_MAX];
+	int scale_precision[CHANNEL_SCAN_INDEX_MAX];
 	int value_offset;
 	int num_channels;
 	s64 timestamp;
@@ -186,9 +186,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		*val = als_state->scale_pre_decml;
-		*val2 = als_state->scale_post_decml;
-		ret_type = als_state->scale_precision;
+		if (chan->scan_index >= CHANNEL_SCAN_INDEX_MAX)
+			return -EINVAL;
+		*val = als_state->scale_pre_decml[chan->scan_index];
+		*val2 = als_state->scale_post_decml[chan->scan_index];
+		ret_type = als_state->scale_precision[chan->scan_index];
 		break;
 	case IIO_CHAN_INFO_OFFSET:
 		*val = als_state->value_offset;
@@ -338,6 +340,10 @@ static int als_parse_report(struct platform_device *pdev,
 		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
 		++index;
 
+		st->scale_precision[i] = hid_sensor_format_scale(usage_id,
+					&st->als[i], &st->scale_pre_decml[i],
+					&st->scale_post_decml[i]);
+
 		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
 			st->als[i].report_id);
 	}
@@ -347,10 +353,6 @@ static int als_parse_report(struct platform_device *pdev,
 	if (index)
 		ret = 0;
 
-	st->scale_precision = hid_sensor_format_scale(usage_id,
-				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
-				&st->scale_pre_decml, &st->scale_post_decml);
-
 	return ret;
 }
 

---
base-commit: 194a48576843858afcd9c00ed4f105ec2b398e6c
change-id: 20260723-chromaticity-88fec417f00c

Best regards,
-- 
Daniel Schaefer <dhs@frame.work>


