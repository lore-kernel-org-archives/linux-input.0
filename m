Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A335E1A6
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125432; cv=none; b=Fp6aPjTYv4SMDal1cseF6A/h+bGSD0msji2azcEvrIc7uS8CdZ5M3DeOS3TbtrQs9xEE0fXT2xrBVxQwyPhzhRALbFF1EMyxDDMd4YF9CJFo5u5Thpf1HxMIvrnz0IcSB2+9iRTd/sIrtWZf2bCyolTOm/xGG/LVPbhTTBEWido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125432; c=relaxed/simple;
	bh=OXRFGV3ZEKm5uHkzNSyrA0yPgKg3XtU9cJdegrnuOko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU97vgDhz+gQgYPHNWAf8/78nWM2zf7X53WivZIcVRThZEXBWHArx2gV1tkbvvezt21Jv51KdtDcMRrLE6EQB0Yp9ooQy9uG0Y9+Btjpg25LFRNpQTz7dwJwwyf1OnQPWyBVbVTv82ViuyOBVvCHz2zsUzRJT38mL41PK2bcwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7h7iLFx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7h7iLFx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so9202939a12.2
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125428; x=1784730228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vcxZytprafatkbtEcF/4Rnu8N7mYkaazUCNyoFvFkKA=;
        b=K7h7iLFxWL23NgpQRhElT22pkI/EKeeqbM/9+vlJvPqorXegAtsxwzA9nSnjlDAtWH
         3+aJ0zHG2I38Aj4RX8Jz/HUf0JOyEEgVFLhQgE+akMSeLexN+60QH05TGxTLQr7L+xAP
         WwxslroKZxYDL+7ygpRihrjXrSsG61dXK2enr7RNUZDee9mlSGN4NRcyBid6R71qGHRN
         P8gNhJ4JCxcc1NQCdkLj0pW/lrPCJGYpBbCCS+5MQAkYhqfbnNE3wP1F/QgspoMgnvdw
         il71wr7mDZytyy8qfs/c2sFdthvjn39e5k7hA3EBFIqfJmxzxDnJGqN8dJnfIgkbp8jj
         seVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125428; x=1784730228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcxZytprafatkbtEcF/4Rnu8N7mYkaazUCNyoFvFkKA=;
        b=hQhqQGINGbcfFdPDg0A4/0PWDhc0uEDq4AR55k/BR/0jaFr0ELt+tUAJHnD2ciCd7n
         fCK1gzDEy4M6rE9HVG6OtNACZex0XPwUaFRSZ89VJIs0lC3qgJtJz3E5c+asIjUPVdsQ
         0N2Qh5eXlVnKPqWFQogLlfjtVu1rf74me45wLJyV18qbI7F3v7QhOZ+1iYe3+3k7i8MI
         wTUgjz+EXYyrHKX1zdK5zVluIAB6wosC4geC5IQcDCVsXXD9alnGkKN0ZVjxpKrKvByV
         YC2DyT+9G8zRJFxOvog4E+dq69BWBOjCsILjo1eVqd16N6duILH2/F4fxZxbt12zNIxN
         LVpg==
X-Forwarded-Encrypted: i=1; AHgh+RqzyqvN8tu/Ga1PU/NMN/OL/1XdvAJVtE61ykLKnhw7MkpVzDQpQWuf2nSfFIVwos0s1y0E7CVyzFVRJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6hs1asP2+MtiFtPxvN9OFFyD1xR+tGwyNx+HgARW9rV8oSLD
	9kvRfODtbl/nBgYL7xT29dIPQVw5L/5uFRkd0WYjyiCWvx2XfrEVXC4a
X-Gm-Gg: AfdE7cmuPJzk9FXHGhiNxHsK2rqyaFwKHjsxJVzoF1S4bkZTeTAiLpR427wSdH3XqPh
	6akL0pP9Vxgw1fBsLm3SOl4Wmu4whQhoVDxseq+/lQ6Y8Fq+MgITo008FMiMwz9PVT+uCRqIpgR
	SSZAOyXyWSXL6JO+VWw7b13t95jllRsAWHjEmVNMmkEbUotOElZJyM1V3HrpT5oVqWN50NvC2HP
	Ta6ZAwG6oBHbc15nglVWeNpfdNXcRMLElpyF1RsObWl+vR30gMoi73pGoM04SiQZuq42Z2lhQVv
	e2Kep5XiYhOWgtzhfbvVjYo8wWYCxre5OZK440g+KW3fKOVG9Ogj75b6gJ0lAVh5IAtvy+V12IA
	3cRt3SisPEa5i83i+I0sB6A//gay+Ga+Az0UuTggGxPRo2O+dXPhycZ+dzDRcanQopVn2ed848+
	mwPAs3AYOEu6r9hXOb8Pzv8OyITjYdz66eV5xmRYypOk5KNbg1QXXCgTiyPP4MweX8wB0ITyqXe
	uls
X-Received: by 2002:a17:907:f815:b0:c12:2946:ffc4 with SMTP id a640c23a62f3a-c167940e68emr197974766b.40.1784125427700;
        Wed, 15 Jul 2026 07:23:47 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:47 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH 0/4] virtio: validate device-reported values across drivers
Date: Wed, 15 Jul 2026 16:22:39 +0200
Message-ID: <20260715142337.22811-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These four patches harden virtio-mem, virtio_input, and virtio_console 
against untrusted values coming from the device/backend side of the virtio
interface. The fourth fixes a use-after-free in virtio_console caused by a
missing refcount.

Hari Mishal (4):
  virtio-mem: validate device-reported block size
  virtio_input: validate device-reported multitouch slot count
  virtio_console: avoid NULL portdev dereference in in_intr()
  virtio_console: take a kref in find_port_by_vq() to fix port UAF

 drivers/char/virtio_console.c | 18 +++++++++++++++++-
 drivers/virtio/virtio_input.c |  4 ++++
 drivers/virtio/virtio_mem.c   |  7 +++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.43.0

