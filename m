Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064D367B77
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125436; cv=none; b=ExiXM0C8LKsICmvAQFabXk4TyUPXBi17/gYxtKv4p/YK4AFgmXQpvLFjeBpR/ZEJVxLxPPMuOB7sDisd2KccHslT0N9MYN2U3+uJl1ATRZbI/B+IDMUzErQBdB/eaxLA7nw88799DPVQxwVDAnWwZ+RHLw9yLzi0iXZipmcqAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125436; c=relaxed/simple;
	bh=8X6+CQq3Hs1h/DFamxBzRSZL9Lbvylt2J3qL223C0to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPwHx71wIXN0tA08NGg/j6DQajddua7v7HV0+ZSaGjYo5NZ8SMns/rf9/cqdYkB9wVcGR8A0ddK9UHPpKJMybU9muii9j3wVkbD4d+nw3gcqq6ObeYVdkmNZJy9N0JhTYo4ROoCUqBbbFE78ZqNY4EI6d4ZbKDQoTegB566+a0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk5fkXmo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk5fkXmo"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so944102666b.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125431; x=1784730231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBjSAX2B0WW1W8im1PxsWC01gxxXxQM2EqUc+55Cths=;
        b=Lk5fkXmoW5LTi8DuEXIOIMDhBM+UcNyJmxCi1OlIITLBkw6uFaLNi+UGvKtMwMg3cM
         +C/HeQuJT1dgkrCZ9+fNuSR5hufGOkmfiMffse7mTPSLNVBRFRO93bP7YP0ty+iiyjMp
         VK04ONa/+Yn8dCW1AOl2TgR4NaCP3ArDOASC178zRmDkapy0ChTZoFJEKGyW0IU3i3SD
         jeEAvQugzlutY+lo/rwJ/XCPZp8TL62QggIXq/6zMIVByB6OlMQQSEjm6kyQtJEZgnk/
         dtrfVmXHzGh2hEmaFs+pqFl98YFmDZIa8EVeJxXT/rHqx2+Xk3qiQtOKvRJV1by5g67x
         WGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125431; x=1784730231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBjSAX2B0WW1W8im1PxsWC01gxxXxQM2EqUc+55Cths=;
        b=Wp9PuwQJBIu97onVryUeraY5F1EoKHv/4HU/n2LtpuI7hQ+TtnBpNeAOhhW763noT8
         2FriNGS/1dEgmqw9ZeYxK98L6zNDg0gTqtwifDxpBDuLZaCWtXn5sZwm5dxQHStJ0KsI
         pii0Siv4EOGCxR4tocLdYTDu9/QjMryhhwt75jiPKRM5BvTt/8LZiQzlNRlxUTWWO9Ce
         mdm+4dKZK6BG3wWpY3nONfXe5BcyDbxS07u3g6VW9JeEbg/nfqLP08rkzszB2Xm9ehhd
         fhW557AwEGC3zTBy/KxPAehZ9ZLfTkfwd2u1yz1z188cPYAIkogrjD2Yt/5pdskYVWgP
         2TtA==
X-Forwarded-Encrypted: i=1; AHgh+RohJrYBfsKVBio0xD7TJDqYr2nJMljNy5aaavrMPpTdlTLbTUZr/3W3zOVaN6kcPDOk3M++4/4jKhHT0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpaYorHta6fzMDPc/KVIgqPIsuh7yZMhG1A/LjTa2GGQyeSVc
	TzhCewZvZTDDmnAf9nZJr+G0ZE1MBr3/L8bXT2MnVyCKUd6vA7x0+JXE
X-Gm-Gg: AfdE7ckzsIb6I+Esg4cZung8V8Wb3ZzILkeToVglnKY/m/DnW+wPup8t94duwOmDQZr
	py7lEDhHuKgXY79PsjStCFtyL0STTxCm2PLpzhWhIQJ9rrpVDjD3daOWYMRUY2hzklZIBenKI9a
	nFV8kQgTgjL4Epue7GSHpJFx1pBzA0HOYvgXbOs/l4HZRGZKmvLOiUo38nY3/UIF3lQ8gcqIygW
	v1uh48UzhawAF3WUSbkaGQ6W2pnb4i8hW20hniVntuIK322+8fNpEPh/HLAgSrMYhE0wYs6Gcvk
	14HlNLakRhzS9S2N65XZr9qxB2BtDPBcUiwp6w2H0t6sNNy83fF+k/BSgWAcUrS0cNwTAACHQMo
	6+jvFYOAxA+ogS6WUev3y37Xo87Avp4I/raApFu4gIuw6C8g+RInQF2GU7+G5bZklxfzM8cZ0zs
	XNsyara81db6EDpg5syNeCHshm4W1bxL4i1TsL4yE3X36Nu++p57JWYKlwovciKzrr5fAk1b2pM
	dTQ
X-Received: by 2002:a17:907:3e9f:b0:c12:7b74:7812 with SMTP id a640c23a62f3a-c1679533edcmr210683766b.59.1784125431131;
        Wed, 15 Jul 2026 07:23:51 -0700 (PDT)
Received: from misharu.home (2a02-a463-a071-0-8f3f-3afb-28f6-19c0.fixed6.kpn.net. [2a02:a463:a071:0:8f3f:3afb:28f6:19c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bd40sm38743766b.43.2026.07.15.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:23:50 -0700 (PDT)
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
Subject: [PATCH 3/4] virtio_console: avoid NULL portdev dereference in in_intr()
Date: Wed, 15 Jul 2026 16:22:42 +0200
Message-ID: <20260715142337.22811-4-harimishal1@gmail.com>
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

A port's virtqueue is not torn down immediately if the port itself is
hot-unplugged (unplug_port() only nulls port->portdev; the vq
callback stays registered until the whole device is removed).
If in_intr() fires for a port in that window it dereferences
port->portdev->vdev via is_rproc_serial(), crashing on the NULL
portdev.

Bail out early when portdev has already been cleared.

Assisted-by: gkh_clanker:t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/char/virtio_console.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 198b97314168..faef362dae85 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1720,6 +1720,11 @@ static void in_intr(struct virtqueue *vq)
 	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
+	if (!port->portdev) {
+		/* Port is being unplugged, ignore further data. */
+		spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		return;
+	}
 	port->inbuf = get_inbuf(port);
 
 	/*
-- 
2.43.0

