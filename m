Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D02F3621
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125437; cv=none; b=LXhEzFFwHsceP5lBYxWsZkVYAstBHZBeGVw7aZUe3udc0kWWuBXv+JvZJzyYT+tPWBdeT5p0a+oa1jgR1BIpzpDy8Q2cbveM/BEcf0GGrQTBrdKLXTtzufgTn+NyhT9CNVGqAVHkCei2dNHUEFHXPNB7ERu9z5t/95lxe/1Vqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125437; c=relaxed/simple;
	bh=p/A+hyd8Czmzv+d6bee7JEW5kyJdrX0FwFb3c+j1AQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tan8f/+Qc1EKHB463M3veCw9sHU+jDsx3NwEb8LSz/GkPUpdGv9jpacP49l4NS2CyQqP2RPDNCcH+cqE/VTJF3phMk3VSVzhIm++LbzEt/G40jSc9DdhN4x4cXl9Y10WGP8pSm0Q7iOiombgojeZAoF58XKjLeZFWDG+QwNfQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwqwjfgC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwqwjfgC"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c12614b81c9so1022576966b.3
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125430; x=1784730230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3M40eRQW8Z0pMjSw8FZJIlwcW2HMM9RvErrQLP04DY=;
        b=SwqwjfgCEslbuijNYESdaBK7NoufURfPYcTjbE4T/OjQyYATATQZTStoennxlnpu/9
         NEhpZuxqun84aEpeYVohYv2wjELeIsSFDG4Lyi2ROipBHnh2EH10zUx+sIUjlicx373R
         jF1pgN855yRVW9FSh49u+SfaoWgaK62n/OqKKjxshCdV1DtYk/nWWzdVSXtQ90PAObYn
         Mstc5Hx8fhI9BQ4aF37Hj55jNYW5Zouz9ru/EVPJElEMqsZbONui8qQB4Wm9Dp1PymRM
         iS61BQP8tV5COrkfwbiCMvGoFMvcmYVFg2Li7R0KIQVX2LOiowwAi9YcfgU3WqlRXukI
         jrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125430; x=1784730230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3M40eRQW8Z0pMjSw8FZJIlwcW2HMM9RvErrQLP04DY=;
        b=KRuGqEIRC6pTDl7c8PFTrYAxNsc6bAXCMPrXJBxR56gy4vooD24Jx/WG3+NgydnFcY
         62l0rzmj5XTf6JhWOMZlW/4KGud0j2mFgm51Q/+tx6V5men+qLpFIo7Bw74DodIUKJaf
         5U4g4L4vsztWd+LExCX0hBswu6GkwC1dGUKup2aJxL8rKM3bJnp83xc9ETGfytGyW4iZ
         vwYyZ7FhsAA1coF+tQaavWcBWlgVNxFeAPor4t313JLwU0BI9Fo/A1h1+0mqYV04iKlU
         OPBYf+67R85lgPTL3hX3txfrqr+AYIjglbXToSNd/MAN3foLgf6SVnaojygvEEOv5ABI
         HpCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1+kg0K3vq5ThKikCIMivrHxYknvk8USkRVYszvCkTfBcEohB2xuY3B5rCGRaMEaoIeXdJAvl0Zw8V1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE0eEwomZtbrJKnoAX+UayEnPZjJU9m0vL9a4EB7lJyr9HDIY
	q2oHRbPvMGcraXiwTdo6iUCmurMYvQbIGXNYClT1L8pGmMgGGJ4+1N1t
X-Gm-Gg: AfdE7clTij3lxyTr5V+9IGGVVgFU47dH3APM/wnA/zocxa1A4xbRycyDSPwxNMaOBD5
	svBFAIprpHCdcU4DFPmN25q25Is0P8ecJQzHbnfJlIvZRshO54B8YWgU6YyHdKDPPQmygNHRTN0
	Rb5Q2xf05T/4dw9tqP28v6TDD6vQedx/rWh3GD7Y8r+78Hp+Mik3KHVM3XMHn53nD9firZkWx7w
	d3cOVLk5nMYc9+YbOA8FWaDyCrJwNxjkqbRaeQ3DHLtTuRYukYFzZgBykSqHHN3d5lsEUCcFJ+i
	ihJZ65xcw15gbxuuDeGH/a9s8Q5EecBEysBdteJD2M8pbrMw+yu+DM8ngMWmtBpf15DsTAbyhTY
	Io88HJr1BX/5UU6zkuY+6uTe1NhkEMttHH7ehWWIhizJpgjX9rsOs8izt7kd8kRQSOkkam1dZEK
	130k86fN1E9l7EK55qt3KJGnI3BqI4mfEefgjnssjaJHlYA2wNVD1cVZPTh64su5gSpjKuyo8jJ
	Gl9
X-Received: by 2002:a17:907:d16:b0:c15:bc2d:e938 with SMTP id a640c23a62f3a-c16792a5887mr227159666b.32.1784125429946;
        Wed, 15 Jul 2026 07:23:49 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:49 -0700 (PDT)
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
Subject: [PATCH 2/4] virtio_input: validate device-reported multitouch slot count
Date: Wed, 15 Jul 2026 16:22:41 +0200
Message-ID: <20260715142337.22811-3-harimishal1@gmail.com>
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

nslots is derived from the ABS_MT_SLOT maximum reported by the
virtio device. A device could report a bogus maximum (e.g. -1)
making nslots = 0, which input_mt_init_slots() does not reject;
it returns success without allocating any slot storage, silently
leaving the device registered as multitouch capable with no
backing state. Reject non-positive slot counts before calling
input_mt_init_slots().

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..2cc19782cdd3 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -312,6 +312,10 @@ static int virtinput_probe(struct virtio_device *vdev)
 
 		if (test_bit(ABS_MT_SLOT, vi->idev->absbit)) {
 			nslots = input_abs_get_max(vi->idev, ABS_MT_SLOT) + 1;
+			if (nslots <= 0) {
+				err = -EINVAL;
+				goto err_mt_init_slots;
+			}
 			err = input_mt_init_slots(vi->idev, nslots, 0);
 			if (err)
 				goto err_mt_init_slots;
-- 
2.43.0

