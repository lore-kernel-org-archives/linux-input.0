Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193968;
	b=d4Xm3OZEfRERLqHwsOvvXbTJSGspIo8LCBOe6c8/HzTI/o7ZT6g6/opawOH/y09iX3Cf
	 lURNCUJxdr47Z/WpAHbxHPl4+O/34HJDje4L6JAPCskXCTG0oVMdMwGelrnWZvQto/NQO
	 oCydRtbs9N31Erys5I9BnlQlDtFtYYSQDdnWNRKMPa1WmfZ8BEFef6Pgug+to59cc/wJZ
	 uq7XUvIJv+sxhZFW6b5s0AEzU94Y/NV4J6nEOXn7B756mJA1CPAjfFs1Lbn0ztBaVSVfn
	 9eO3MYRDvPom1kMN5fkSUsz2P68NtNKOVCMDLNA+cp8dOuVs0T3aZjsmv/YleTvSy2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DOaHU7ZgVC+P0bPSjaN43IEeRLa3GiPBavjQ4gEWVdI=;
	b=l7HiAaIlpRqLZfC7iLs+TsCgM5rO2CN6dDHbCyuGLOy3pPOXDYQyTUzC1kVSZFhthHKT
	 fdEPFbXs2U4V6ZEoL0X2v24MDT51Af7uQ4FB1T3zDlaw7422uKPXLqrY/slt+GnVsrTRF
	 MvQhn1SLl1B1zNk7OiF+KzkGLuesIqRk4cVBYyKbz4LtavEAZ8+4YnW1NeRYQ7wuXx/oM
	 WVht54DPFvvMKTccaZGwgrh3+qIgQR2q2tHxCn9+jFm62LbQZFQTuiV/4RrRh3R4fKQjL
	 Dsjnx+/TlBFBsWwXCiPlYgGTZz4Tw+zLpM9DMjhX24A1TSj6tbTky8wKfb/LAHC53/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1vNilsD;
	arc=none smtp.remote-ip=74.125.229.136
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB9606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1vNilsD
Received: by mail-dl2-f8.google.com with SMTP id a92af1059eb24-1379d236149so335188c88.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793193967; x=1793798767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOaHU7ZgVC+P0bPSjaN43IEeRLa3GiPBavjQ4gEWVdI=;
        b=S1vNilsDMh8D8VkeSGojf83TefvqMa+Cwa4mAc5rV8rzmAoGcedPNhm1R+ViVYyNcN
         fPBtLd0g0WO8nTDPUzJztFB4LwDnD7j4TQaGEEMnRRKrXcYFx/1bK9i1V/BOKaLOkSR/
         uFar4HI3i2DzISfBZ4xryYw0bSBFlAIwKXmPJue205kxnjjeQtrReI6MnKQUK5nouI4Q
         H6S3k3+2T/Lw5XxW1z4GU2wrgZZjG1KH0Q9Onem4fIAatf//n1upPzW9hK2Rz/qwdZ88
         IfOsnverutSqNn7O2JesprIPb8exQexAj/QzjLHmuGLhgzSVcBTpoaXh6fsbJ/iUo7Ni
         1R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193967; x=1793798767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOaHU7ZgVC+P0bPSjaN43IEeRLa3GiPBavjQ4gEWVdI=;
        b=nx8mfGBkngBZdqD/WdFyjclEcX79h8lvSsHWyVqgMmDgGlUhpSpJsKxv6uKnUfQMEF
         bz5URQ3pUTQfMy4DQVd1u1sQ3DL/Ok7qN0oudKyw2fcZzIWHD35w/oZXUp6lbzW4BSc1
         tgGsNygVqMb/CYiR+xMOSeeOriXBDGbd55qdKW35FeV98CVQgM0KVDCzYBHkY1GHUxXG
         Qx6fM1dprHlESmZFRd808nHUzNezrr01So9M0mkFtFwr5T6cdeqs5PcKfyxqmkBPt1nj
         qZRbQIjaOn05vO4PRpu065/cWUGuFfnsV8ublGMdNUUonuagD6xhUC/icUJSimAR0lS5
         I0Ug==
X-Forwarded-Encrypted: i=1; AKwUvBy7p0D84HXOX4taVnrhZe4Wo3AS+UTFuI+cO3/PfuN3im4KAy3+4vtTgfcqeTG6fB2MIwu5IIk+D0LuGg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYzSajcqwTK5i9p5SqHSNIC2hiMZKozmND/bHkqixBqzUMZzO5
	BOrZws2UcqIaAhLjqJgYl7dMZsumoT3KXL9KDFr+otw7mR7wHGyOGGTh
X-Gm-Gg: AYBFou2haFKbVlSd9LUUFviYTdrhUmxospqr0RMNGEx8hw5tVP4WG26seuxwnh3KzQR
	/CS8o/crT9zLuN+rnRLSk1iN8tgp63m7MWmFG8zG6VkLv6xmTz656w+Rnqnw0epoVWXSLU5/wNw
	NicTjKMRDUOmn1OIqvUo+kM8VAWHk5A/zccIcEi6gSDWgJQmo+DtWPvePBdtcoQkgFao2fQ3X4Y
	XFYvVTPOxhwz9cZHUBH4zTFgc3lXZEWAJfMn/UhxD3MzkAXll5OfTiykEXbvwJk27bJDdX62KdG
	Nkms7OCO5Ho2X616v7qWpuVMPd/QNOL9kbUMDv4UmoTn7zv3gbUg65DFLD4uGXBvhoWiU6M4yuA
	KsfEBsVWT5JyzudRHYhswrFxoXZuX2jbdicabHliqYXKozKwthk0CkusRsUhu9h682WZZyK7xW2
	anyZs0BsuejZ0Kv7wK6He64l+oQFBhCYfJa7xPnTRVQOM2A/yf/cfAMSuwri7VIeqrOXEZyU/+8
	eyvQfc40AQRVWc+SzeB+I/Gv+Ma2o6g2Td/1wnKya0mMkqiSgpaJtLVrOYs3rhcPtCTtxOiFNRB
	PwKoTMbCvLweBGHcSoVceaOcx1yOWqoMw2oZ61N2btP1kZNrNy/uLMnIOuZHC/hgSqnv
X-Received: by 2002:a05:701b:2803:b0:1a7:a79e:224c with SMTP id a92af1059eb24-1a7a7bca75bmr1729249c88.34.1793193966766;
        Wed, 28 Oct 2026 06:26:06 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com. [2607:8700:5500:3d9a::3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c814aa1sm10708639c88.7.2026.10.28.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:26:06 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH 0/3] Add support for Valkyrie USB LCD displays
Date: Wed, 28 Oct 2026 21:25:33 +0800
Message-ID: <20261028132536.375927-1-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds a DRM/KMS driver for Valkyrie USB LCD displays.

Vendor website here:
https://www.my-valkyrie.com

This driver is devloped from scratch via black-box analysis on
vendor software. Currently only supports two variants, I'm sure
there are more variants, but I don't have them.

The devices use a vendor-specific USB protocol. The driver exposes
them as standard DRM outputs and converts XRGB8888 framebuffer data
to UYVY, the only format device accepts.

Patch 1 was authored by Ho Jie Feng and provides the XRGB8888-to-UYVY
conversion helper used by the driver. It was previously posted but
was not merged because it lacked an in-tree user. It is included
here without changes to the original code, with my Signed-off-by
added as the submitter. Ho Jie Feng is CC'd on this series.

Original posting:
https://lore.kernel.org/lkml/20261019154820.68659-2-hjf3108@gmail.com/

Patch 2 prevents the HID subsystem from claiming the display control
interface. Patch 3 adds the Valkyrie DRM driver.

I wish merging this series through the DRM tree, with an Ack
from the HID maintainers for patch 2.

I tested both supported variants on physical hardware using the
Sway compositor and verified that rendering, suspend, and reset
work correctly on all of them.

Thanks,
ZiAo Wang

Ho Jie Feng (1):
  drm/format-helper: Add XRGB8888 to UYVY conversion

ZiAo Wang (2):
  HID: quirks: Ignore Valkyrie USB LCD devices
  drm/tiny: add driver for Valkyrie USB LCD displays

 MAINTAINERS                           |    7 +
 drivers/gpu/drm/drm_format_helper.c   |   73 ++
 drivers/gpu/drm/drm_format_internal.h |   21 +
 drivers/gpu/drm/tiny/Kconfig          |   15 +
 drivers/gpu/drm/tiny/Makefile         |    1 +
 drivers/gpu/drm/tiny/valkyrie-lcd.c   | 1413 +++++++++++++++++++++++++
 drivers/hid/hid-ids.h                 |    3 +
 drivers/hid/hid-quirks.c              |    1 +
 include/drm/drm_format_helper.h       |    4 +
 9 files changed, 1538 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/valkyrie-lcd.c


base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
-- 
2.56.0

