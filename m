Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860FB430B9D
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309046; cv=none; b=VLsB3qtp7MPyovl6JWlhgKOuLudxTPgheNww5f2Ong580yXtcwVmVfCXcc/XvoQbpeZJwjaj6htdB274+LG5FJpTuCi2s8xULo5QwFP7ZaJCVBYfnaQyI+BRj/VtorSpneVWs5fAm7gfRAwekV37yyfS/jBzyxxQaDrrBXVVtPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309046; c=relaxed/simple;
	bh=hvun0/ynWDWaMzowPDTzCwJIAGYy+Qld1aVhTnL0qWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kdq3i7dcNH8HiPlxenk+R5mbdnljwyVkPuBEcmel+Sb4uPdFurdQy37ZZi5TXvQOeNP4hWIDdwWMqsMNg0xX3B8Ae8olBHrnlzXTUqZz/biSyYZhFOI5+uFoYmLsJ0dYe6YVghm3GX97euTq2NRBOyqgYP6yD9r/Tq/p8bu2ueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MX6S+Yil; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MX6S+Yil"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d18f80b5c2so1631796a34.3
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772309043; x=1772913843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GT0smzTAfpvCV5w+JzL5GF01/TVTvbNjJtXgCgPsKkg=;
        b=MX6S+Yiltnqm9TRx9QCQ2uiz4MakpE3U1Nyx/Q0fgZtwq0Wrtyb7MSiC4drNZiUjf5
         yx6Uyia8jDAVyIpHnjwS8bux5aJIak/+4HM8rGRaEXIdV9LYXMchMEKswppcsefu52Wy
         IzCUkkCU3qOG7rDw0y/q5zhGxQl2yqJx9WiA9rkQk4RdQkcw3sXYx734ToHNNdM7jBLY
         1IpaOJzTEKrh+zrrMCSZSvdjhgwfxNulAo+3m7Ju2PusA4+Syk+A99oQWvVJxcGc5TNA
         lOoReOVhNTt1NxO0C6tUsLq/YkrHZk+MKM2ckKQ385Uj9y6n5yqrcVuVMFCiYCuiIqtc
         BtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772309043; x=1772913843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GT0smzTAfpvCV5w+JzL5GF01/TVTvbNjJtXgCgPsKkg=;
        b=onD+i6HAc3MpEZQIyGqZKSJPeeBLKgRP06R+Uc+or11G3G83a2T8J5ApP3ssTR/QXs
         I4TkluTZTIdDvEPO4Jmtx8WrWr1E4EcvKPvCEpqVywIQGOnH/rCxtNI9nZR6521TLES2
         lEdzgBTbHzdWB6WbAs052opDkVwyAvqSxZvjO0+GJ9enQEI9+Ui+f0XTNdpXMFfhzqfp
         fq7Pyv3Pflhwl1rRRW9NwND1uNyP9erfoOPIKGwYNRlrI8VPNPw2kLFPUNBMTkge4BDU
         bAiqTqUcc3f7I63OULN1kuxP9eJMOH5vBfLlYrqnZR2mVCbf4FsLiSu/TYNOtTZGVkmV
         Zfug==
X-Forwarded-Encrypted: i=1; AJvYcCXpjzvxBsu0Lh0QnymwEn/tAVYikGGkI34L5KD/0YrvPDIQaEtJ/hzuI/TP9HLRlhL6dwwPLJV6l2WXmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHHNnjJH2tAchptfmnuKB6FJtDP3eaBz+tnEBuHNzPCY8Pn00
	PMHF9m9fCFRrDSVMSotoPdglLcW2ITflizmvIfwFrabrZ8TTzNAMuqEOLOOViKg2AAg=
X-Gm-Gg: ATEYQzx7wGPkAQJ9/CzRaZX+peJz7s4I+WagLg15L1QdsUWpG2JI5lC5Agc9zRAwvWT
	3e6On3LSPWFvdZURQMHMcfqCTJdA1lKBltQ17YDCRMlWzuQ6RjIiZgt/GMbCS+lTSDQL1ICi71x
	9mD4/VgFjN0UWDTv9C1DpFSXmaoXC4IvU3RR2HjmzX0jPVFA9RNpeR0+m6rwx5lTxkupSLVaWPo
	1XtUbGdeSDQdVlS/d62HhoEUuY2BWgP++LbdFhj2xN/CnQJQcOES3PMz/FDIV9LP4y6myRtokwm
	QIvWm9YqmfF2EUpUngniF2cy3zTyi/IW9baisrjVl5hcL1xeTpC0WikkEUmqUKHpI7apUpDOq0a
	n/lDRVeNqTCGeKgCnqA3pS6eUuWb3E07QhJYCBKWX1idUYvg+uafqpFadfYiyprMZbiUsQmBb4u
	gg8xcGYbH8FmOVcdAbcmvhsqpWhxOkb0VUnjji5oo=
X-Received: by 2002:a05:6871:a86a:b0:3ec:321c:b2ac with SMTP id 586e51a60fabf-416270c77e3mr4847845fac.37.1772309043510;
        Sat, 28 Feb 2026 12:04:03 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm7579785fac.20.2026.02.28.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:04:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Feb 2026 14:02:23 -0600
Subject: [PATCH v2 2/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-iio-fix-repeat-alignment-v2-2-d58bfaa2920d@baylibre.com>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
In-Reply-To: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lixu Zhang <lixu.zhang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=hvun0/ynWDWaMzowPDTzCwJIAGYy+Qld1aVhTnL0qWM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpo0opGwtMAMyKN8kl6Ic0I2p6gJBg3VoYfY//c
 UlxpftaNIiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaNKKQAKCRDCzCAB/wGP
 wK8xB/9dHEQD0c8C8Rg61xc47xQOsLaBUDA7ANfx/2in3iGZ/IZzyS6Dk+Ty6fzkwPUDdjv0etU
 sdCgDo3KAa9ie7O6mA0UKKea2eSadkiv1Xhek3wCm+kavT8DutVlKkUfSeVz+3PSd/119powJgj
 IZtkXE/x1Vk0+CyqmKYfF417RySl/shHBXUvNi3FYwLxbPiTN8BZDzryjIVgVe7LRejTsBa6zZ6
 Xh5NgEf9V4zApmel7B1nZ08hm1Io3qAAV5vTeQSWDS4EForyIZfbiVzor1mJ6LLO3dDrWXp6zvN
 nnn0QALmvqo4OfQb5xkyeIlP8Psf4/OYk9fTYKRhGgBidZvG
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Restore the alignment of sampled_vals to 16 bytes by using
IIO_DECLARE_QUATERNION(). This field contains a quaternion value which
has scan_type.repeat = 4 and storagebits = 32. So the alignment must
be 16 bytes to match the assumptions of iio_storage_bytes_for_si() and
also to not break userspace.

Reported-by: Lixu Zhang <lixu.zhang@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221077
Fixes: b31a74075cb4 ("iio: orientation: hid-sensor-rotation: remove unnecessary alignment")
Tested-by: Lixu Zhang <lixu.zhang@intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e759f91a710a..6806481873be 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -19,7 +19,7 @@ struct dev_rot_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
-		s32 sampled_vals[4];
+		IIO_DECLARE_QUATERNION(s32, sampled_vals);
 		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;

-- 
2.43.0

