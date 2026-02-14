Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17382BEC30
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771102853; cv=none; b=f9lBczju407pI4aRroiFRf3N9YgMo0+TgBqW+NRyDvRLZ6LQa18o+N7vnN5lYCAb3GeJRUNoHZUWQ8TgxUb+lpTfQkcLL9+Sa8lOCdl0tJScQ19NJ2m4jX2bk+2NgJ6KSwmPv/oAXz2mDbYXeon0UfAyA32Cy8hBRGmaJSv99/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771102853; c=relaxed/simple;
	bh=jNjN7gD3JF9jQQ5s2IgcCsLWPxaJVNTVrn2kWorSt6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8OXZ3tsEGfltryFp4qabw88y5LJ143lwwxo5R09h1z98/yPzYgHkdm/xJUJcZU2smzY4Va/qvqN6F9B9Jl6KQnwsNo47V0DpEw2q6syYjLm/ke7DXtdsOJj3ZkRD5kKqCc0P+d7hfa2T2ODiW7HGfKgGq0eEML221PssVtecVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vzK8yPtf; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vzK8yPtf"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4cb7e10efso1433792a34.0
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 13:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771102851; x=1771707651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KssbkPb1gHaJEaz+zWwlaEszLsE5KF10Og3GBOyj4o=;
        b=vzK8yPtfEKbUSKNY/rOj8/Weem9BsWSqg/he3CsZjWPttBFKwqRbrT4KK969QSh9FE
         ZXlg/Fs5DlKgPHcJRqA47ThYl1WzjJyk39Oa10IjWZTDAla7V/LPo118YxJCdcH47PsE
         2GfVWPhzXOee5YrVq6qdAJgcel4hFwcCQtxbA4x2JWbOPeh2XksgJu0lhHjNQUY/IxK/
         pEbZ78PVyjGKuQnZmaB9Hpcbj35cgE2nSHwOMZemAaLDJUQq5ucwOg/wHioNQj80iJCx
         1edKBQDH2Wr4poze6GXJgIb9j9aiff/4ngwxoGh3oiVl62z0LbE3BNLlKw0b+CZ7kdra
         4naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771102851; x=1771707651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3KssbkPb1gHaJEaz+zWwlaEszLsE5KF10Og3GBOyj4o=;
        b=G1C1dd8lx32RJfeFqVKT+bFK/sz0KayY5+eHoxH/QGs5FmNoYgDUHsL86K6XDpjArW
         v+y7fMB7hCqiJkz55VocfrQYRKSEVq9VilT0vr99hwb/nO8LiAoWTL1OImGcm5t1nALS
         0u4lm4gDtPrYQc4+qXgYTCTQwvMyRrzzg166hhq/kOeJKKmi1zhX1CR2UCkjT4mFgxJZ
         mr++x8GNqpUSg26I3RhGKazUNM5HN0MSay5GRdhlD/RmROMcHbR6oChioJneGzKFELDn
         15QmjMJB6u5j/a/7F68LOFtLshwdvzdwepMG84fYaSZP5l3LZ0WGDg+VaLZ89DlOAKbg
         SkRw==
X-Forwarded-Encrypted: i=1; AJvYcCUV3yhr7ysjTeLF9C9b2oAuCZrVXm0cOXad1jxyCWn3RKR/wqQm9zMX7Y1+9bPgr+RLRLa4xAeN5dEr/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJQe6qRP8oxScwoMplCWLSuqHAfHTT9jnc4iCH8iXjDlAhw5b
	RMBP0ruoFnjIo1vdPl9bqUfyoOc43LUATJumRtnFhA05MujJTxmyqjTmdAHUnfJb6xs=
X-Gm-Gg: AZuq6aLR5kfFPmJFeSdHiz0EekLz9uoGYxatvHhY1xMP6UG8RFypwuti6Xiy2XI73vo
	z45wi285gmgbyTCtPPhGydirwiMl4rSgTmE6W1Lt+dQHQbQQbyR44xL++A1buVgf/pnfICN6a91
	f/BhV3RAKVqy+MdClx6fjcow0KRoNxi6GGcwC/anLHx9/sc+r3iskQbShhTLF4ajQBacmdylQVG
	rn025xyYEb4z021YWPYsg2/ooiLy7fCMthcNtjOMvoa3HzFCIbIxQZSJSPkuybTmgS5Rx2hPgxE
	uFvBub1riWwWAO0ypRfBerqzqF4W5/3MGypI5BQrH5zPytPhbC0VQ6gv1PohavAMelGckNx6kNf
	EDnJtXpRT3MdMJp8xs60m5xYI2iVOB9Mf7hD9EOYeeyTOx9+poEZ2M4Mm5cvYcrk6KHSIbfbCH8
	5lBg1+ml/TeOuq3prIgLZM7FU77g==
X-Received: by 2002:a05:6830:2e07:b0:7d4:bcd0:db07 with SMTP id 46e09a7af769-7d4d0c7aba5mr2222848a34.37.1771102851474;
        Sat, 14 Feb 2026 13:00:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4da074c15sm1181680a34.15.2026.02.14.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 13:00:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 14 Feb 2026 15:00:21 -0600
Subject: [PATCH 2/2] iio: orientation: hid-sensor-rotation: fix quaternion
 alignment
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-iio-fix-repeat-alignment-v1-2-47f01288c803@baylibre.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
In-Reply-To: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, Lixu Zhang <lixu.zhang@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=jNjN7gD3JF9jQQ5s2IgcCsLWPxaJVNTVrn2kWorSt6Q=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpkOJ6F/c+o0+u4560tz2ShMNf0GrCyrMUkjWcg
 EqwUCxz7j6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZDiegAKCRDCzCAB/wGP
 wO0aCACNVpVpzq5Z0KzGvMClnuShr68EGfgfW8/MaM0b0blIw6AOuLMd2H8WsUzQ6t8E6jg1Ibd
 PUYL7b5N98E7WTU7ObNs3Ulj/ewdYqxgHl63xDVPFY8NbjxjOwGZo7L9o7wYHpkoQVJ+82C7/Wn
 /Wx+IhxkUhqnFF1+1qu70AeTX5PU5CyvNB+BOLxV0abWA6xEMOjiL+OGJjm95Cs/o/y8hZYj5++
 zOyQAdcRaHo3BWdoHNCRGitXWADDNbrAJ60QknZgBnO6IlaRhTtymRYWOtuaecXvC3aLTfSgis5
 k00n/YwwDJYRYYSxwe3i65WlLEtXzjVOXTNueLaUSKRWkPDN
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Restore the alignment of sampled_vals to 16 bytes by using
IIO_DECLARE_REPEATED_ELEMENT(). This field contains a quaternion value
which scan_type.repeat = 4 and storagebits = 32. So the alignment must
be 16 bytes to match the assumptions of iio_storage_bytes_for_si() and
also to not break userspace.

Reported-by: Lixu Zhang <lixu.zhang@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221077
Fixes: b31a74075cb4 ("iio: orientation: hid-sensor-rotation: remove unnecessary alignment")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e759f91a710a..9df955ecfbac 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -19,7 +19,7 @@ struct dev_rot_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
-		s32 sampled_vals[4];
+		IIO_DECLARE_REPEATED_ELEMENT(s32, sampled_vals, 4);
 		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;

-- 
2.43.0

