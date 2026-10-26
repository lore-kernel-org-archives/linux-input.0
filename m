Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024813;
	b=1YldyFrSZFxcYLtImR18QdclK9AM1F8B2fvq+XRtaYx1zzYc2AtnDOymFlYnK4w4mmCT
	 yCki2uFa+iw5PxXahq+pZdvjRVip6PvDuT5Z0fd8enIvegEQB4G7t6ElHKq2tzu3kYvlR
	 0nZLQLgI1O/LCIYp7sC1LRxrzlQ7CymCRWwRwhf+qEyS6xt35oxdLsr2CO/mRc423attu
	 iWobNsyBW6zvk0YvlKZSaR6HNaVMm1eKWWKtcRG+OV36Qs+kUfrzHBfQVMkCx5EJrSiF5
	 bYRsHCVb20L4NSuA4KlQt64k+TdgxLc4dm7UBqtcGwNxMQ9VYL4cY6naMjM69GlrDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kPxtDvfkw7gzZMJAYGqqIUZcM0lgL/y+Nw/mPWUHCmE=;
	b=dbjWu+RDflNDnwR8Xx3DWeVmnoEroXlD5fn4radCoZIYxud7Z8tb7x7eOrJsFAx1Rfls
	 md9IGrDWB0XTIiEVMwPWm//hlI+F8z0SZeTM6KezcfVdtzv3/CxcZ5icdP+EbugP3rcPc
	 UHFB2ZX/6TSRyyCo+vPyLsQG8ghKnz6ktRzHKC+56zWyfp5ClhrtDiYcKZiAWEuNTBshZ
	 cyz+1ZyuEl8T18/551n39hZw8ToXLjR+9obSqyhaOyK/LcVLyZ3KPP35gDRskiPQc6Ggb
	 F7LJm1D6y/XtHt7svnF2CdgVX0BUAHOYnoaQx4cQVF3b15+54YsMPMbQaSdtfpheQRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bGAy0Muu;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BA606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 14:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bGAy0Muu
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48b0d20cc81so115808f8f.1
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793024810; x=1793629610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kPxtDvfkw7gzZMJAYGqqIUZcM0lgL/y+Nw/mPWUHCmE=;
        b=bGAy0MuuMLpX3wD9gYnGXXtWKNJc1pSI9tTxcKuH2vKd069FO90Sy8OjEn3ukfvmX5
         G5gYFhQBJ2OSrPJAE05TbNNDoEDdKYs9kqxIbDdMPZ4kEpia1tmqbZQa3qnGeC8puJvs
         N3q/bVNR2w2Cw3pIBJE9q7HM40+4MRJ3lHS05dDYx/Ri4nKX88YhI46H5UdCuRRK3YFE
         5TfRPhvbetLdEq5pPsGltVt1j/5C44BWN8XvJq4IX+0r25NLSFw87HpPIZMf1EBY54Z6
         wqdXrGRKeI3z4L6mwaqKbjESDFJCgmYVHJqu3QPn3J9+sjn6fLlpAGhwTNaEketwkonh
         7bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024810; x=1793629610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPxtDvfkw7gzZMJAYGqqIUZcM0lgL/y+Nw/mPWUHCmE=;
        b=08IzOMnPMtA1pbhUgGcNahO8q8IqL0v50YGLd0M3s4j5dcYGwPD5xv2dh/2lH6L9Na
         RRncjwObLoD0BPiv+Vogrl9AD640YilKjhtnB04MIK8CcpFGaA2QGp8JaFhiyGh9ixsT
         VnWYk/qz+zqHYDNedgui9JXIuQxArwrFXPe8d5dO309Hhkg51xb8CkB4yPzPxwCrJSKg
         hwUTnHezvldEMkxFzQjdBuFdcTGuUN9Mk/PgosYUvP+Pvm5oBaB2XVUTJ8XGU8sWykLU
         MqrtsRGDqfMQdbTZXvCdUy07Jd3emqE5KmRGj/exLGhwDoQZKGvLqo2wsbN5z/vdZYDS
         3OUw==
X-Forwarded-Encrypted: i=1; AKwUvByJtlDGT+RRQTZQSs/dQe8BRZKetiCW8BBydn/9Iy5yIe3lD7M7tM3PBvc4s+GcIFyYCY9DdWgg7jGCIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL06mmiPXU89c6g2auqTcuIAn5+mvCSp5VKfxQIuafkekW3bv29
	ZlDD3N/o3VPH/uSgGanwmVQZ6hGtXgO6NCCNGOxT/I8muanJDyi862F8Dm/ChImVW1LZVn31P6f
	VkEq/MLw9Ackr
X-Gm-Gg: AYBFou3nw9joG/DUShqghHpEQV76xv5u+L73EhU0Ns9Vg4T21nNGEZBIv1xx6Q0w+At
	1o+Par7fnwjxnSxX1Jv5vsjfnvL6sVUbgeEf1uG26DnvgCc3ft9aWLNO7CO5Ot5sMouGqDtis3U
	8yrmwurZCbN1P8o7mUNGGelPDNByyZQeDKacBJgI88k/0i1Avsi7iF2Z/DE13fETGHKK1QpqJ+x
	bQeQ11w8AvLZtsIQcEyKZdPFKGmBmui2uwG7fS6jX6ZREwizm6V8hPaNxgJKLTnS+bfQIioEv9I
	mHzqug6RlTFLyOx/Koej8ppL+xM+Zx2Y3jmNZ8XdYrs7TmT9KVcgcPdWyIAhsN6MfSXTvwQz3IO
	oKnTgJPpiUz5YIGaG2Apjfo9jxsQS6zyZhBD19x8TDwSJXuhp2NimWlsTKHv3LguuCZb+2Q2k7x
	C2VXhfvd0iUAEz0UtguUH64mQIeVP3nV9uiuxcnDNXC3enu1OoI1SYrPjfouhO8dUl8HaJrRr/Z
	wp7o/BdwNaSkIHXOQa7N7M1z7rK+UxNC2S9PRhkWOR+UqXDxzheW8NHgVYnS5rRzAvr6yPQBE0n
	1bd1mikES387nTMnF/TuQWP1mkk0a2W1/hb7QCa7KxLZp7A/pB3LF5U6Faf5/zuNdB50VSV2Hg=
	=
X-Received: by 2002:a05:6000:104b:b0:48d:fb3d:bf28 with SMTP id ffacd0b85a97d-48e3eb6f93emr9742954f8f.3.1793024810341;
        Mon, 26 Oct 2026 07:26:50 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm16400703f8f.4.2026.10.26.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:26:49 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Input: synaptics - enable SMBus for ThinkPad P14s Gen 2i (LEN2072)
Date: Mon, 26 Oct 2026 15:26:45 +0100
Message-ID: <20261026142648.2567233-1-dmitry@kernelgen.org>
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

The ThinkPad P14s Gen 2i touchpad (Synaptics TM3471-030, LEN2072) is
not on the SMBus passlist and runs in PS/2 mode. Forcing RMI4 alone
does not help: the F12 attention handler reads the whole 79-byte data
packet over SMBus on every frame, which caps the report rate at about
43 Hz and loses fast swipes.

Patch 1 fixes the size passed to rmi_f12_process_objects(), which
counted from the start of the data packet instead of from Data1.
Patch 2 makes F12 read only the registers up to and including Data1,
raising the report rate to about 65 Hz on this machine. Patch 3 then
adds LEN2072 to smbus_pnp_ids and should not be applied without
patch 2.

Tested on a ThinkPad P14s Gen 2i (20VX) on 7.2.9, including s2idle
suspend/resume and the TrackPoint on the RMI4 pass-through port. On
this device Data1 is the first data register, so patch 1 does not
change its behavior.

Changes in v2:
- New patch 1. Sashiko pointed out that with patch 2 alone, on devices
  where Data1 is not at offset 0, rmi_f12_process_objects() could parse
  bytes past the end of what was read. The underlying off-by-
  data1_offset bound predates this series, so it is fixed separately
  with a Fixes: tag.
- No changes to patches 2 and 3.

v1: https://lore.kernel.org/all/20261026093118.2312302-1-dmitry@kernelgen.org/

Dmitry Mikushin (3):
  Input: synaptics-rmi4 - f12: pass Data1-relative size to
    process_objects
  Input: synaptics-rmi4 - f12: read only the object data on attention
  Input: synaptics - add LEN2072 to smbus_pnp_ids for ThinkPad P14s Gen
    2i

 drivers/input/mouse/synaptics.c |  1 +
 drivers/input/rmi4/rmi_f12.c    | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.56.0

