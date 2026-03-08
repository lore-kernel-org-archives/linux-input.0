Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80177284B26
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934310; cv=none; b=qYoqzR15aPTvkIRJFbnUbqhkovjHrKdCBRObxcp7Rln36GARdsmpUjKLJbbcZVhLU0ObMgpBWH0qCmBC6gBnylNFRYSumHE9RZXUZ/IzU/ipuuVZhmw+7Ou5cnIA1TkbzF3ZRB33EfvItPPNMmmwPcj4Bd/ExIHEnCsCg9DTX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934310; c=relaxed/simple;
	bh=w0Og34GEi1Pn7pz/AH2AqV6Spqskx9CZxx/s0UZTH+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hC4p/ncYomNFQcWm7WHyVce3KgppO0972WN/8xbE6xN6p0ch3ca7EeBjNx21YOazOVIkJeVQ3fE1trhBKEeKTY+86heae9LHRLojXuWKxTs5jl1jGYqo1ljQ3I6BFyi9cwXSfrFxfd2sSf6VZCx6Hb0cz6AuL2g7nHU63DT+oH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QvchBrTQ; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QvchBrTQ"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-464bba3a9easo7035584b6e.0
        for <linux-input@vger.kernel.org>; Sat, 07 Mar 2026 17:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934308; x=1773539108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CGaHrjCmbnPLyL4ZyvnQXb7Y/JQNhM/tEkjcoUuxPI=;
        b=QvchBrTQnquNbz8bDuvk3Wy/bC3PW/J7Ocl4e5DGvthIKN7y4wgaVHjfh8s56+zuPO
         sTLIrLQJ/gGv0SdJiam87TUs57Uhtct6x6yI4Y82JxJsMgqs6sVyLgsvRjDOwst+SBEc
         VcNKpf8/FaK6qTl0JIU7lrT3rLiE0c+mRQ5mg+7vM0/AKRWbeo62GGTLlqmmmWekO8Rp
         CM0HBaVOaUrgMmkxQgAK8jnDIkJo5vzA2OHcOwsODlrKENf8mgiYl9Bqyq5bFe/3PONj
         pcWmvTDs0Rlq60Wm4E3yImnmBZSrGn0syn6vgwijZhEaC4U3dCWkkhwj44wFoKyB9WbO
         ml+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934308; x=1773539108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2CGaHrjCmbnPLyL4ZyvnQXb7Y/JQNhM/tEkjcoUuxPI=;
        b=JU0b/d09J4IDA15mCa5VdUc6m6rP4XxHp+MtvJ610CCjAtpefzZju7Mn67CneW/SMh
         VU1yjXm1rVIynLTCSjYAYtyGXSoQIcZSWGgL6ydNusDSoLBpnnKMoWhVT8RNYoXsRtkN
         ze+34oj4SFHbmilKYaZfqfPSEDqiQ1K8SulYHN+4ooDD9JJNIpkFN6LOpjrpWyYqv34E
         hU4GpDSggZO9C4UbvtvwEtFE7VsHtPzsltu4B6njFn2MZjm+9pQa4jNvvFYEfa0RjBxF
         Ij5TckT6ENQLnFAcQNZPN5ppBfLr9V7005U3z/W34yLraSdkifKeOX7nENWGTAPZ+hH/
         g9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCU61GRdCoOk2jPM0wFMtgKJO1f3eTUhCDQ5iM2ZguAPOmRCw1cFBmR1J8ixXE2TxjBOt2a20zlWgT5V7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXFxnKdZH2C3MpYiT16Lk9SX7z9uyuiWJQvv5HNHIfiJVjAoL
	Ix9aBMp0HvsxBm21QdJiGv3EGt3KHm8/m2JItXrGosxllIk1UcDF6uL4jhn2qU8TzGs=
X-Gm-Gg: ATEYQzxSvRtZhpRJbOXlYC1m+3V6zAJXXLRtJawpgLkhqtbAhVdMApuDEhE7FHFQpbo
	n1xRLy/NZS/mAaTCElSY6/erhi5UpxVnHXl5KAmW+TcBjMNfdM7HWytoWip1kOgK4y2UirS86TZ
	wXj4mSyuikwoychmXRjG1d9sQ+lQ1fnkiQQBogHX/x5YvR1KTJdJW7LyoV8u7keNh8xHhec0ASC
	LUFl+cX9pDIhsq3INy+NRjaxwEpvIEvtnJpvbSVG+5tBALDp1FGkIs74JhHy2/2lsnZFiZjFrfu
	/OD8b3ovhl++2FM8yCiqKGEYwzt7j0zvODevfTN1qou95i0SyeoxAV2ytU2P5YlbcGLWzwmOiKp
	qJPmhyI6wjwNMt8P9VuvpDdD0L2kxId5JdXIldPcc3W/HZjQXYzBGGteHAPqEX4o2lVpGOuUyky
	MBc9SeqxXmDvxGNKgWjcIPojY2lkmrSU5QI6tXwbM=
X-Received: by 2002:a05:6808:a54a:20b0:45e:ada4:f2ba with SMTP id 5614622812f47-466dcb1aa0fmr2781061b6e.38.1772934308352;
        Sat, 07 Mar 2026 17:45:08 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:45:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 07 Mar 2026 19:44:13 -0600
Subject: [PATCH v2 5/5] iio: buffer: fix timestamp alignment when
 quaternion in scan
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-5-d1d48fbadbbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=w0Og34GEi1Pn7pz/AH2AqV6Spqskx9CZxx/s0UZTH+c=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprNSPruc5cJFHnS3aL00cqgukj78lxIP6Uxqvq
 YxfRHlWNXiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaazUjwAKCRDCzCAB/wGP
 wHA7CACcsWKER/egQdfZKlLPUp16lhhStL2FvmJ9UEsQmzoM1cI9FSIBa/G9/kJRYeM+fs36Ab+
 imG1igOODLYZZoQfaR/AtT4avUA9JPGG8Xv/UVfRPq9UUS5Br8vxjlJXCuX5zcTVlsPXDmrBjmp
 ryG+2cpQF3cC733JZ3M3Uid5YV7/wr5yCKTpqppTj8A/BVk+4Q+BH60BxpEpxLPMY3UxWCMHnk3
 62hiX7mbBmhfQRkDJzOhCGRy1OB8Pcj0/EDZrRtJG5RisEtoooA2jS7k1cGnUVUrTbuRLXZ0E8S
 v8deHr2r8HastiMcZJviIAiGBghNZD5mHcM0R0Qrv6yGzrQg
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix timestamp alignment when a scan buffer contains an element larger
than sizeof(int64_t). Currently s32 quaternions are the only such
element, and the one driver that has this (hid-sensor-rotation) has a
workaround in place already so this change does not affect it.

Previously, we assumed that the timestamp would always be 8-byte aligned
relative to the end of the scan buffer, but in the case of a scan buffer
a 16-byte quaternion vector, scan_bytes == 32, but the timestamp needs
to be placed at offset 16, not 24.

ts_offset is now a value in bytes so we have to change how the array
access is done.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* Use cached timestamp offset instead of largest scan element size.
* Mention change of ts_offset semantics in commit message.

To test this, I used hid-sensor-rotation minus the first patch in the
series so that we can see that the timestamp actually moved to the
correct location.

Before this patch, the timestamp (8 bytes ending with "98 18") is in the
wrong location.

00000000  6a 18 00 00 ac f3 ff ff  83 2d 00 00 02 d3 ff ff  |j........-......|
00000010  00 00 00 00 00 00 00 00  5a 17 a0 2a 73 cb 98 18  |........Z..*s...|

00000020  ad 17 00 00 6a f4 ff ff  35 2b 00 00 ca d0 ff ff  |....j...5+......|
00000030  00 00 00 00 00 00 00 00  2a a6 bb 30 73 cb 98 18  |........*..0s...|

00000040  92 1e 00 00 50 ec ff ff  ea c1 ff ff 78 f0 ff ff  |....P.......x...|
00000050  00 00 00 00 00 00 00 00  8f 3b a7 39 77 cb 98 18  |.........;.9w...|

After this patch, timestamp is now in the correct location.

00000000  55 0f 00 00 dd 1f 00 00  af 0b 00 00 ec 3e 00 00  |U............>..|
00000010  c7 17 68 42 6d d0 98 18  00 00 00 00 00 00 00 00  |..hBm...........|

00000020  57 0e 00 00 c8 1f 00 00  d1 0e 00 00 42 3e 00 00  |W...........B>..|
00000030  56 a2 87 48 6d d0 98 18  00 00 00 00 00 00 00 00  |V..Hm...........|

00000040  a3 e2 ff ff d3 1b 00 00  0b c9 ff ff cc 20 00 00  |............. ..|
00000050  27 59 4d b3 72 d0 98 18  00 00 00 00 00 00 00 00  |'YM.r...........|

I also tested this with a different driver not affected by this bug to
make sure that the timestamp is still in the correct location for all
other drivers.
---
 include/linux/iio/buffer.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index d37f82678f71..8fd0d57d238f 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -34,8 +34,16 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	void *data, int64_t timestamp)
 {
 	if (ACCESS_PRIVATE(indio_dev, scan_timestamp)) {
-		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
-		((int64_t *)data)[ts_offset] = timestamp;
+		size_t ts_offset = ACCESS_PRIVATE(indio_dev, scan_timestamp_offset);
+
+		/*
+		 * The size of indio_dev->scan_bytes is always aligned to the
+		 * largest scan element's alignment (see iio_compute_scan_bytes()).
+		 * So there may be padding after the timestamp. ts_offset contains
+		 * the offset in bytes that was already computed for correctly
+		 * aligning the timestamp.
+		 */
+		*(int64_t *)(data + ts_offset) = timestamp;
 	}
 
 	return iio_push_to_buffers(indio_dev, data);

-- 
2.43.0

