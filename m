Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6743A1695
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234513; cv=none; b=MX+OMAdnIMUSzaUsUyV+a8T5qg+BRebeKVv8PFKlqt9uZD3YdXTx7Q3CP+DiT0oSw5VK2kRzHVZ9yW5RtzUbNeSROqMT1/PlClNDvtwg+eYovLMQFpppzLfMjQ3Mip7kp2fIMSVbuXe8XzlxDUxhwaJV7Ohs5Fwp0XjDLkHdFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234513; c=relaxed/simple;
	bh=Dnn1CGS+4OZOJShrWTbuyQ6nfUqx5TGkH6Z+F5fnlXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSEv8HwF0L1ZLC9AV7/hYvxA6+pFNsffPrj1dTcBpjgvvk7vVKrbibcON7ZT4l1Ua+Iy5c2+es+xN5ZJDHeD/eQWUTisY5I/1SJ58iQ/UeAEXbAzoVnEZFNsEwKGNxBwqV9lKSnadlaxPTX05pIpkJHCl7HwZD3PXUBkSVGcV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=qF5lczHg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="qF5lczHg"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8be236ce888so43128076d6.3
        for <linux-input@vger.kernel.org>; Tue, 19 May 2026 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234511; x=1779839311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erGMYs6yW3leYyCJ6nURYYZoDVNiP3/mQp9l8F6DAlI=;
        b=qF5lczHggrAaA4so7bhbzZ2i6Fs1gueZ7edaRB03NjIeoqrNC2tJ9qLm6I7TyXiUuD
         LTqB+FP88fea9WVIVE4PUmjFI8Hy+JikFojbtd6KM7GgtUveqWhLvtWZP5JY2XbNam+s
         7mSXF5GvOKVAj1XovAeBwL4CS5fhvwUuYWi2BPhtJZMVJ7tctNN5bBRywccbgCU5s6lC
         45tNKQFxDr8rqMvimWNL2mpI7uzs4nnCnY4G7NtLiBUKQ1oK81xN4wDiANmAxzO9jBIu
         Eno71l+lneMf6BBOL8LSZeRJ4UejugQCjUCAo/3FEv+F1qyAlzyiqo2vf/Yfwa7cOI9B
         Qa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234511; x=1779839311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erGMYs6yW3leYyCJ6nURYYZoDVNiP3/mQp9l8F6DAlI=;
        b=RJrOfJI+qWiVM1QQ+q0E0IUEepmMTrDzZWRmlAgpf9WoF0go9areTVG5Yby8hLLFzF
         mWlbpftQJpf9kEoAenRbvef5pMo5634rUO41NtGC1FT9p4SA2rCfyjm+doHfws2Xi1zj
         XMQY0k0ppw3YyG0iPW/zLh81zOGBePZr5LBqwKrJbSvQ95+qoDnmd7LFDwU/eqUMVeqs
         RFrwrS6/VAmEcJ5x8/xm6fzwzFJvvLt6lZ6HqJjcYai4o+iIAlQI5QYOH1uapwlIWrc8
         /Gi4xXVMxhjMwrs1pktm5czkYGmvsjSuDMPZ11ZCWjY8TrazvLQdFOicV56lkQzxH+pi
         GXlw==
X-Forwarded-Encrypted: i=1; AFNElJ+W6bChxbXzbJLu7eS00hK6/hgtMPBjoxzWzfIVYosieBchulw/DKHdbx5p3h6m92PeD9mZmhg14QiZsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLfGemrFUwszOaiMhyJBWTT6x6B+Asb0S5VzzH1PBwo37oDvoW
	Xj61YbgbIrmOpvgARgv1PCJ+uT8F/Wa+2pYlq+FUX+I8PFi+hNlrkHrYjJhXqxKBM2Y=
X-Gm-Gg: Acq92OEXoxNXAOEpTW+DIJUWQgkxuvfTmgKuWTOJYIVX+r1UIVxG2dq0pjIKzEwMHtM
	oyUsbJg74sTPccUuTRBEpnq4CmvwD56lRk0/6jHRE9btFebQYpNEUbyZQdr8YRsTikBvKLZxBXe
	E0b3peRjcMmNkfTpq9VNptFQO0sd+KnrkOzt8AiK0yqj0/aNsYUIFGlGA0LeOmaMhCXq49MrJM4
	BIY0tqim5evau9xhX74KpCmAsJGOehP01FjAh07Us+NKWlSBvmYbVRDG+8DfW3XY+7rciivv962
	2+U7FN6pCDBaHCcryetcq2t2emxoNkCUQjJuD0gAGybCAGg70YYuRdRP6Em5CGZ9OPEo0CczxE9
	iakr/hziESbxGDipa8soqLlE2XarrZkzz0d7nuR+wnKUXsueI51JDuXObARKvDvWaQe16+lagke
	/tvy7tj7ou41MVGvy6vMA3oB9ni5BCgoQ4CyZuQOI=
X-Received: by 2002:a05:6214:33c8:b0:89c:d808:c255 with SMTP id 6a1803df08f44-8ca0f697396mr374299376d6.37.1779234511542;
        Tue, 19 May 2026 16:48:31 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:31 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 5/6] iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel initialization
Date: Tue, 19 May 2026 20:40:47 -0300
Message-ID: <20260519234752.23911-6-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the local magn_3d_adjust_channel_bit_mask() function with a
compound literal for scan_type initialization to improve code
readability.

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..3b26dc41dd4c 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -3,6 +3,7 @@
  * HID Sensors Driver
  * Copyright (c) 2012, Intel Corporation.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
@@ -132,17 +133,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,9 +408,11 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
-								*chan_count,
-								st->magn[i].size);
+				_channels[*chan_count].scan_type = (struct iio_scan_type) {
+					.format = 's',
+					.realbits = BYTES_TO_BITS(st->magn[i].size),
+					.storagebits = BITS_PER_TYPE(u32),
+				};
 			}
 			(*chan_count)++;
 		}
-- 
2.51.0

