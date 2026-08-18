Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA93033D6
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025884; cv=none; b=Ba2kw7jycIMVeiqTi133LClB6FJ+t4wo6jvfmtp/tl3T9oh3FGqj/hX3jdAfjssnpOJduIvi8+q9hEDeDxj/4CQCVUaEYiv3VnVcb2lLAU2pAfIG6WS0dB3+NOC+4YMvJPKvDHqvWZIQeOvj82RxEG2lrK9mMR5jC6W9PXZM6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025884; c=relaxed/simple;
	bh=lwzenrEmvFq6Ms+TlrhhSnfYi9JXU6L7/Vuwgf6D3Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usWzaICjM+yoRxTgoSKlTTAto1rw3QpC1jECzRDupEBcRFydm/GEt7pNoJJgAELjMR2xeJPuAY+cru1QX3lmY1OKeggjmCvDJplhh/D7aIFMWsPupYkxqsFoGVjJEd3aE6pXEGVI6PHAbyrBlrd5kOhObIO0IjXzqvphYnBnyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sLPpCkoa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLPpCkoa"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f84023916so3931911f8f.3
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025881; x=1787630681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HoGu1OAypKCl2TYpCNd8T62EqWCSWGfh3kJlxm+m1qo=;
        b=sLPpCkoa2EdfoSHgNKttholBTA6V9jqjobTTaI8OlMLdVlvWI1d9N4xwbqNA70rJXO
         RoZnymPWA7TfnsAAmRgWfy6nMRMosWKPB3O2sof6FfF+saVvghpQqB4531I/FvS7T5HM
         K1a2o/fWA5byy8xlWxVug4c9nT1XpVDekd5kMF5MCONhHbctJcNkHF6qIrZSj7QzObBf
         T3yhe4gHSbSDSFk056SubO4yd3vbw95HCUEgwjWRQQD/GTGBQu+fXJ+rGIJWEjyVaMf9
         LeH2e033sFQAqk23KFmeq/7Dau2bqXFlTvWQZHkfpm48CREjm+7e/n4j30nDRi2hCxMz
         ur7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025881; x=1787630681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HoGu1OAypKCl2TYpCNd8T62EqWCSWGfh3kJlxm+m1qo=;
        b=jEb6UI10QrSKl15RdBsYhofs+PLmHUz1mJXpMpxR4k6wjBBlBP8G5Er9xUFUBAOgRr
         b6e4uF0QB6i7JxcvjA/aFSOryAd9c3jcZ9EzM0O/3+kvo2msrtfljIq9bqutmASnO23u
         BOITyKn3aT/jF737bawxI7gNoGMh0M2qdabHgWsMS9i2pXjfF63tg4zleOnio4wpo20T
         yRSSFmNJaQ9h5QSNf11i7Kz2ZnBcQl1mmkX6IMJahSi4j0DpgI3+It7eRUlPoWk9AvL7
         1ghZcrm2rXAKl4dEhSxstHHF/btJBPUrHOV7FoO3QTZ5yfWzfu1jy1H1CLcvjAQ0NnEw
         /T5Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro9AwVIDqkfLE5y8XKrdI+aFRP6fMx4BFSoxw96zShhdFg2aqXqYm0ZfyqaEEyn7Wp26GP8Q1ogEp/SOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaq/3pOhooM8vrl/pyCmLm1dNLalet/7CgVmCWosmc96foEf9
	9dotuW+EVr19MDt2kLXxO3+LzXjJmkIkzmgX0822CiIX/hFv4VgTbsEO
X-Gm-Gg: AR+sD13USTN3/LMDwTd42vTsvk5r1Y1wBzWmZS1IZlmUTau+mJnQEcY9zKALJP715Og
	cC5guP4G0lmfgf5TfwG21Ck/2UI5V9U5+oQeL2zRBsCRBbCI3ch8cbFCZ39/GL+2nriHss9pao3
	SAUy92ynouC/TZxrpi6FZAsmu5oWet5l4zgojERIUs28TYcvHRygNR0HkYNzMqW29GidE5fRpDC
	tzRwpApBkVm/SjWyGj1V8ijZu2tWudXOHEoNK6IcpJcT8z/m8E9LiuiDBkweUbuedYZmNyeR3pr
	IJOXH6CklBAzCUQgcs/gk1GuTAfCf/oGvoO8pEnffzF5sXvehZFNqkRm4uPCoTE+oMPRCliMryK
	u3dh+3PaRrzVEQsAKaaI2ZO8gN5yNlgqyDzHWXpxmq1u3upFgn/AuhMbpvVj125pRZKhyiCzIqo
	2e/Y5AaG8p4NKCraNKzSDnVcrQrK4TpiUFAlXyKvGuTscWrOHNzMDxGj7dZb92J9yH1TDsbKEYB
	CytuvzqFg7xwRp7XjfPJb/0YgwPhhvLQDHjsRmLGdFNjrHq/Cf2Fuf5TpuAKwB25QaxPzds7mdw
	eWOqwR4+qxbOVbuOF/tM3/dxiNaDCwZ/iqJ3EHSTyVACOVbfjRohaE1Lu3SYv47nqqbgts39NDx
	YYoXH1Qs=
X-Received: by 2002:a05:6000:25fe:b0:482:a9d7:7ced with SMTP id ffacd0b85a97d-482a9d77d37mr6882286f8f.14.1787025880688;
        Mon, 17 Aug 2026 21:04:40 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a88f-5701-94a8-6746-801e-fa61.310.pool.telefonica.de. [2a02:3100:a88f:5701:94a8:6746:801e:fa61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm9030108f8f.32.2026.08.17.21.04.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 21:04:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] virtio: synchronize callbacks during device reset
Date: Tue, 18 Aug 2026 06:04:31 +0200
Message-Id: <20260818040433.66986-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_reset_device() documents that vq callbacks are not in progress
once it returns. virtio-pci delivers that by ending vp_reset() with
vp_synchronize_vectors(), virtio-mmio does not, and a driver that frees
state its callback uses then hits a use after free.

Patch 1 brings virtio-mmio in line with virtio-pci.

Patch 2 makes virtio_input reset before unregistering its input device
and stop its callback once teardown has begun.

Together these patches fix the use after free on virtio-pci and
virtio-mmio. Classic virtio-ccw and other transports still
do not provide the documented guarantee.

The use-after-free was reproduced under KASAN with the race window
artificially widened.

Callback synchronization was tested in an arm64 QEMU guest with a
virtio-input device over virtio-mmio and four vCPUs. The event callback
used a busy delay, not a sleep, and an in-progress counter tracked
overlap with unbind.

The driver was unbound and rebound 120 times under continuous input.
With patch 2 alone, virtio_reset_device() returned before the callback
finished in all 109 races, each in under 1 ms. With both patches,
vm_reset() waited for the callback in all 111 races, taking 24 to 86 ms.

Karl Mehltretter (2):
  virtio-mmio: synchronize callbacks during device reset
  virtio_input: stop callbacks before unregistering input device

 drivers/virtio/virtio_input.c | 8 ++++++--
 drivers/virtio/virtio_mmio.c  | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)


base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
-- 
2.53.0
