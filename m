Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348A26FA60
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934302; cv=none; b=jyDk7VKfDFWgUMPtKbTHMpI9Bd+LzoMbt5RKL/uRgjYbfgRWleJ0TG33NNfQwUSnDIuZFLO0Nr4Ycvq4tqP5XtUwfljSUFYQfvmDUFvlfw9vyAdIzDgX4Yqk8bqADFALPddoJQhZ3e7pgdtViYEAn8Y/phtdr1uC+KQavMzh5sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934302; c=relaxed/simple;
	bh=U6FHGWdz2Bvdzm9NUMGnmiRLKvyra1JEcjIxN8ogkEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZKBD1UFIJEZ4dx8AJXfSzYAnGPOnM/y+VJT8jAbf7ECvSVSj5qUAg7bB4DDRoTbUW4R7LomCDbVHNToeeNhgWoV76D30m7cAyOWO4Iu6wHPxIeJRLdHfx2E2ugaxEg5QfW4E+x2IRqLGBAG89bMDZje5yJOnigt3GwTHnzCX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rIm6ojcx; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rIm6ojcx"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40429b1d8baso2209478fac.0
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934300; x=1773539100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fX8dp/t2b2t4ZLjEsHFbwzNcx+4POL6FqcGVJe++/XY=;
        b=rIm6ojcx1FPYNAu7olc43GfUWeynLXqyzZetOkMApqKBhl8zM6Hml+bXEjbCy9bC7a
         5Yp2p7RKd1STA6ZaVR01cBgr2pTxXfif4BsbslvDhr/FGJtKLmoWYCN5CtaQaxA8/MPb
         zVl773MmMsKccLeEukmOJhmlEcyyuUjjoLSPeILcSWE4vn4SQJNIIsE6qmRoF3ulc9ak
         uDw8hbxV7+toXFR/UzUB+yupS9b6a/ODxxauL6RIgqCsshW6SHD7z+pWWeCiTNOYLOGS
         3XSxpXxIkal/EjG97pKR4tTHOveiF6AeXBIUrQnyi1YHZ6hK7Qm5V8wJB0uCTi58sPQY
         0V4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934300; x=1773539100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fX8dp/t2b2t4ZLjEsHFbwzNcx+4POL6FqcGVJe++/XY=;
        b=CwQO1JJEjHv6DpLs4nuFLpX1PzricPSqUw+dznntb49mWvQt/VPetYqnpjArgVqyvq
         3QuM2b0OrlrU1zwk/w5bPSKSgrK4xrPps7D2ujawoaR9ea5ORnY83PJNlFy69nMKwweB
         ZwkJeps+la5YSnWT+OmfOHnMdFUsSEi+N2XrOLF62QVu+l8BFKul0vrE3AwM3Xb4auAP
         QeEZW8Qt4dUwYDDsYYvK2t17AwDk13PFDMDIrZ01AI6ky9dIB9l0nt7X8+XoHtaDBma/
         QoABm7+/8Usoe5DzWgSu6TSXZc233CqtmtT60EO+BGsqeR8Txnps4R6GNQ6u6xTqAa4i
         xcZg==
X-Forwarded-Encrypted: i=1; AJvYcCUURr6zvkls8VxrGU1b7JF6HxaLyEpP2rBqpiFKsCwuiZGMys4xaTPhV4+pArBNRFk99TppvQ53z3jyYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywed7Anz1w0z/ERN8/Wfd0kmSY85HLALFPX1UNv/iOJA2T1oNpN
	/uRbwMqLHNqP9e2Tfyi8DErXQOy84VIHO64ng70h7P6r2kMIYVMErYihFnMG99IJ9lI=
X-Gm-Gg: ATEYQzzd3DcE8+HtIkU0i2saCLaLpyBrmamg1VUkm9/5yXGe2mk8skyVcnIeL8/q68e
	jJ/C6/GHrsJz7H1AODlf0Ov97ML3ORuBHquJED6cuRtpStC9pUPQ3LexJXFmFifZ7u5Ri2BaTM9
	+sMxFjgKwjV5n0h1C5uTCd+IE6b8z9TioLVKud9c3q4SZo9CSs/vLcNd6bLD1RGms+s/z+NydJs
	7Q9TxAkrkAkeEuj/aFaM6mJ1WSGbP+b8QP0+9eOr44tvhUQSDE9kyx+PD2HvhSJMBxRnJ78xFBn
	P7SAJHWQ5wUB73BUBy/Oj7bzzpZHahsHsxKcBmjS8lnSAIAUTkHddNkZu8OXQJsoPtL1YT5iZPt
	xVo8xN05Gp/sCJ3MVsowDNLbYr91YZI77pYWBnXZ8iMVsKnBjBqQX+JQ0J6SAGcm9nI/DYIrmKp
	j4tx9OVae3cwK50DLSzWjihFgTXGvZ
X-Received: by 2002:a05:6808:4f1e:b0:466:fd2c:9570 with SMTP id 5614622812f47-466fd2cb1c4mr819176b6e.18.1772934300244;
        Sat, 07 Mar 2026 17:45:00 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:44:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 19:44:09 -0600
Subject: [PATCH v2 1/5] iio: orientation: hid-sensor-rotation: add
 timestamp hack to not break userspace
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-1-d1d48fbadbbf@baylibre.com>
References: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
In-Reply-To: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4892; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=U6FHGWdz2Bvdzm9NUMGnmiRLKvyra1JEcjIxN8ogkEw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprNR1OsLLAxolA8HVS3rzGa+qNh/BN81hlw9zP
 3RG6J2viwGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaazUdQAKCRDCzCAB/wGP
 wHWkCAChcCxM7jrEnq62LcdCVUnk/uqRO9FKZ8KZHVclomQbcbUgZdTF8mqI1O3NA6ougHz4Uiz
 Crmb4OAVYxcTmirKu+BwKmGC+9NNEWZfHw14eNDvTW0LUXRMdcv/eLU0+QYIaMw++XAFkQwoJMv
 CVFeIj30yLXhdh0M24IgAFeHuXoCIyWL487LKhxj9BuJ71htmE/JM2Npkh9+vr7Rj7E+dpWBPqg
 5fJgEFKbqOZz1G6thR4aM7ZbzvtMYYKF7qyGrU8AyEuZ3G2xxvJ4ENP1u28hfFhew1RDCd7rT9o
 JJqGpnsWviC9acvQy9ntW4BDWnfJvaGeFckEaGrgsrc4f+CS
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a hack to push two timestamps in the hid-sensor-rotation scan data
to avoid breaking userspace applications that depend on the timestamp
being at the incorrect location in the scan data due to unintentional
misalignment in older kernels.

When this driver was written, the timestamp was in the correct location
because of the way iio_compute_scan_bytes() was implemented at the time.
(Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
align the size of scan bytes to size of the largest element") changed
the computed scan_bytes to be a different size (32 bytes), which caused
iio_push_to_buffers_with_timestamp() to place the timestamp at an
incorrect offset.

There have been long periods of time (6 years each) where the timestamp
was in either location, so to not break either case, we open-code the
timestamps to be pushed to both locations in the scan data.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huawei/
Fixes: 883f61653069 ("iio: buffer: align the size of scan bytes to size of the largest element")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
- Rebased on fix that also touches the scan struct.
- Improved comments.

I found that I could emulate this thanks to /dev/uhid. And thanks to AI
code generators, I was able to reasonably quickly make a script that
worked for emulating "HID-SENSOR-20008a". See v1 message for test script
source code.

[v1]: https://lore.kernel.org/linux-iio/20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com/

I set up the buffer like this:

cd /sys/bus/iio/devices/iio:device1/buffer0
echo 1 > in_rot_quaternion_en
echo 1 > in_timestamp_en
echo 1 > enable

Before this series is applied, we can see that the timestamp (group of 8
ending in "98 18") is at offset of 24 in the 32-byte data.

hd /dev/iio\:device1

00000000  6a 18 00 00 ac f3 ff ff  83 2d 00 00 02 d3 ff ff  |j........-......|
00000010  00 00 00 00 00 00 00 00  5a 17 a0 2a 73 cb 98 18  |........Z..*s...|

00000020  ad 17 00 00 6a f4 ff ff  35 2b 00 00 ca d0 ff ff  |....j...5+......|
00000030  00 00 00 00 00 00 00 00  2a a6 bb 30 73 cb 98 18  |........*..0s...|

00000040  92 1e 00 00 50 ec ff ff  ea c1 ff ff 78 f0 ff ff  |....P.......x...|
00000050  00 00 00 00 00 00 00 00  8f 3b a7 39 77 cb 98 18  |.........;.9w...|

After the first patch, we can see that the timestamp is now repeated at
both the correct and previous incorrect offsets (24 and 32). (Normally,
the last 8 bytes would be all 00 for padding.)

00000000  dd e0 ff ff 0e e0 ff ff  75 07 00 00 90 3f 00 00  |........u....?..|
00000010  f4 38 82 d0 3a cc 98 18  f4 38 82 d0 3a cc 98 18  |.8..:....8..:...|

00000020  a0 e0 ff ff 1d e0 ff ff  a0 0a 00 00 1c 3f 00 00  |.............?..|
00000030  3a 29 9f d6 3a cc 98 18  3a 29 9f d6 3a cc 98 18  |:)..:...:)..:...|

00000040  a9 e1 ff ff 1e 14 00 00  6c c1 ff ff 98 f2 ff ff  |........l.......|
00000050  39 21 77 11 55 cc 98 18  39 21 77 11 55 cc 98 18  |9!w.U...9!w.U...|
---
 drivers/iio/orientation/hid-sensor-rotation.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 6806481873be..5a5e6e4fbe34 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -20,7 +20,12 @@ struct dev_rot_state {
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
 		IIO_DECLARE_QUATERNION(s32, sampled_vals);
-		aligned_s64 timestamp;
+		/*
+		 * ABI regression avoidance: There are two copies of the same
+		 * timestamp in case of userspace depending on broken alignment
+		 * from older kernels.
+		 */
+		aligned_s64 timestamp[2];
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
@@ -154,8 +159,19 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!rot_state->timestamp)
 			rot_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &rot_state->scan,
-						   rot_state->timestamp);
+		/*
+		 * ABI regression avoidance: IIO previously had an incorrect
+		 * implementation of iio_push_to_buffers_with_timestamp() that
+		 * put the timestamp in the last 8 bytes of the buffer, which
+		 * was incorrect according to the IIO ABI. To avoid breaking
+		 * userspace that may be depending on this broken behavior, we
+		 * put the timestamp in both the correct place [0] and the old
+		 * incorrect place [1].
+		 */
+		rot_state->scan.timestamp[0] = rot_state->timestamp;
+		rot_state->scan.timestamp[1] = rot_state->timestamp;
+
+		iio_push_to_buffers(indio_dev, &rot_state->scan);
 
 		rot_state->timestamp = 0;
 	}

-- 
2.43.0

