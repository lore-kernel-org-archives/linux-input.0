Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21684357D03
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125434; cv=none; b=NXCvt2lf6UppuyBqTzglVYgs8sIU9ivaiCwFZBtjX0Mg4Wni5i5SSuZW+9JQMSb9JNTbUHA/Fx7N1f5Qgempe41M7MlXEBSdc+KU0LR4UTbTHb+AP/LSQY8dbdSefYqy+n9A8ShsFB9Q2b11qVCPfV+aMhv7VJfZ8WhYo16BLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125434; c=relaxed/simple;
	bh=iLWHG7Z9ifkUCPM3I0W59CT2LgsbHMZPMVoaijdCcg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnvkMHGlqFcMkMz7LA/5bjm/6jiwKTtaGbv9lOhPdnigATUvpNYA0k+dZKsNV6IV7E36um4QDGrElgXAgRtHNbyD+7GRIp5aAe7aKiERgX9enIQ8JXH9x5Nn2mY3X+mTChbIyemmfQRvTF3RI7JxKz+LOzTfSv7i6yG6g5cuOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8Cz0cxB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8Cz0cxB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15f020a223so736964366b.1
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125429; x=1784730229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yo/c4CjAVn9rvKKIkMq0mVxy9jNtcNfgzZTIdJ3Ac40=;
        b=G8Cz0cxBtjZI0A9OyzvOVe6WaDTjkAUQo2PQl5As98uHjZvBKeIntteGshxapy31iy
         5ZzjLZJTHP7I6PfqnmNCtT4CHiRiue/ICKfXltfGJirarB+D3diuhWLL9U3IgI0V7a0Q
         S39zWowuqHX9asgmkJR3zT1mIkGMrRqGCr8zfqnVFfHl4UL9R31hue5mewjcVqdXOP5p
         ylwwMF2Ojl9MZ8sO2ju1ItEc+qLoOtClTUYBnOrj5jZcVoA/qc3VY4yJetlC78n6GvCS
         qIPaVsJ7ycejdCn3BUgIdByHVOfdTbY10v0W642S/+s5OyGQh6ZxXC1ebZWLRqQC71QR
         +N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125429; x=1784730229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yo/c4CjAVn9rvKKIkMq0mVxy9jNtcNfgzZTIdJ3Ac40=;
        b=rB6I0ad5VybadMbxIgEeIkYhCu94Kw/HZsZVoe6c8+d/udxfp+AFjJUK1jCMPLnxmB
         OGzFuL3xPwlyOAOT+JXrKybEpNIzaLswsuZVsrvQotgO7c6Cgd6LhmmzKWvvpKi2ytQi
         mRna0xBAciTmJWtWk1pPJu33KbSJ8nHAphP+YNTuOYOaiSRRaco0jWeJbUTKtIboxs8V
         a3in8iQMRuJ0sH98rTrDmvFq01jxzJ2XmJD6zgXnjZ0f1Tg5/scUD0HQpsCJGAf/onw/
         JsXno2EMi+tSVozR1QPIX3AoYfXhSsTtkZNYuS4l/w0yrxieI8wycMpWaEZsatUKLiiu
         GkqQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1jgl1ro6fcjjRZtafgqH9XP0rI0l+WFjTuASMkKS2sA322AmLZX2EPAKnj3vM+G08KRj9PWJjZXQFMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSSmigLBu3Spvo3KIrpx6oGOzRnD1jr6IIqh7xVF+Da+j+BUH
	JO9eTJPTVgEMOE5OS4471TnhnUct78T86ipUXEStFDgHj8ZfJZwkmXXt
X-Gm-Gg: AfdE7ckz31uspPp329orY+CqvxtZtk+vcBnj8zKit1M/RAfNMtuysao3OuQngoy/Frl
	aSiJ/OxdHBTU8l6w6jWN0sbLhsROTf6VAhKxqpUoAxngEg9//UGMmDF1kwNee78i5RaG39BmUBy
	xVXtUBbzJkrgG4ojeXe/WzBp+lsl+G4x+srn8N9eAi+JEiL9P49r6Skgj/wcuPHVH8KSvrnB3uS
	giruyTx/J24h2d9oMflMXG+9/NlEPwrSIY63nP4ueqipb8tvCbI3qNIedkRFqAm/eIGBJHxYdZe
	m48gqtL4ESDZklZhGOGZmJKN6THfcouXSgD13nxjZ3agQC19CSpp6ieOooLWFCCpBoPiSlbrMAm
	0rziOJwlczcuLQjHdTcnXfBbnjozv8PFeYlJvDDEuLH3NrvBPf+7RX3ZE1tqLo4YRpr9By5KB4e
	WWm0Mw1qsO70FzMtNHWUC8UX3jn0/NSCpXwO33j+9MaoQGVA0zBcCrsiUTTHsC7KWwewCFWiTi6
	sRUo9fRcf5XQew=
X-Received: by 2002:a17:907:e1ca:20b0:c16:8933:3501 with SMTP id a640c23a62f3a-c1689334452mr16024566b.42.1784125428901;
        Wed, 15 Jul 2026 07:23:48 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:48 -0700 (PDT)
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
Subject: [PATCH 1/4] virtio-mem: validate device-reported block size
Date: Wed, 15 Jul 2026 16:22:40 +0200
Message-ID: <20260715142337.22811-2-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715142337.22811-1-harimishal1@gmail.com>
References: <20260715142337.22811-1-harimishal1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device_block_size read from the virtio-mem config space is used
as a divisor and also in ALIGN_DOWN() further down the code path in
the driver without further validation. A zero value leads to a division
by zero, and a non-power-of-two value corrupts the ALIGN_DOWN() bitmask
arithmetic leading to a misreporting of guest usable guest ram, post
crash. Reject both at init time instead of trusting the device.

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/virtio/virtio_mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 11c441501582..43d12ec7c323 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2847,6 +2847,13 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			&vm->plugged_size);
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
 			&vm->device_block_size);
+	if (!vm->device_block_size ||
+	    !is_power_of_2(vm->device_block_size)) {
+		dev_err(&vm->vdev->dev,
+			"invalid device block size: 0x%llx\n",
+			(unsigned long long)vm->device_block_size);
+		return -EINVAL;
+	}
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
 			&node_id);
 	vm->nid = virtio_mem_translate_node_id(vm, node_id);
-- 
2.43.0

