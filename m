Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336341;
	b=Ix2mWMJ/v8UcR8u+kiVTqm885Sbld60QYgjqCK7gzRFrmqzwbyIaKlpnMSLQEpyCB7mj
	 GuMhj37YreWOO91xJQLnfnLQKU1QsL0n7jNEoTWpn/DeMEmPFw+ierJjCQLJfK9owLvYe
	 Oi4DVLnQ4ZatCnwJYiiz6TRTHuAK3T7ZPM8V5cJDkBGDAjRmPusUBChWofnY2YOjvAOog
	 fzM3TEiE6bnawSVyKJtPsLzAMwSR9hDPk/Hd74f+sbged2pmhoDZ9wLVPeC6aEuIs0yRf
	 YoPzqt2tR552Rmg3aAicCbTc4kQhbYHQzhSMgQYpSuzlhWf6cm11qvo2HYuX3WbqzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNwpVqDjROJGkszbWCt3hcbKnoADzVRF7vj0i9CDHdk=;
	b=KXh4dIgHWEsC/QjcZ2Wa8XjQwLDtgh16ijdwTJbpi+d8zpQ2RafQsA7tjtPEE8CgQ9oy
	 6pW5z2qj+swLETE3xJrcuXe0F6y+WVFKDyDjPQ+QH6T+Pd96t/7VkN7yj2WPaZ1FadDnW
	 bzVNcyE3nNBlm8Ns6Y6kv2eDwOiSGeRE2Px5YH26OVyeEZsIlSPkTWRraDVWnEZ/I66D2
	 OsmLHDQE4RTCo66jm7nCEYHSmA5ufjQcKBOiEmh6Gf7n21G6QXY1Me0ff9x7Py8tD5rjS
	 5p7GJfgDsVp9MNQYuda1keO4g1qEDfJQrOHYw9TfCSgmOQ7NQs+0CytrH++EqlZXh2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvQmqhyj;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A8606A31D
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 04:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C56A8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvQmqhyj
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14394530ec6so378601c88.1
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 21:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336340; x=1793941140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNwpVqDjROJGkszbWCt3hcbKnoADzVRF7vj0i9CDHdk=;
        b=VvQmqhyjoEfPElLInA0okpFRj8JJVpHzoDW7YpvlerOqYiY38kQKJgoIhcWf02E3vl
         +gmwDB7w2YZ+mUDUNLSYg6IlRdw+WxDPyiX6Y0EtxHtQeblklMDsnBl0mM/b9qH7cZfq
         X5qD+dgjfhZhWOil8lhpKmBCt9G/+qd9JIzKUY1YulKatrn3nQnJwIeqH8GFAq9b2ERy
         G0R7cvaldz3pSckXRcQYYWu/ww6vGToCTb/rVG67QkL/TohkYGUSkenl1VvTzmsn+lWg
         Fq2wx2T6Cl6hOdgHfC4M5sjrvHxK9+SFE0wPTF2pIO2FlURVj9m3GQVDWlv1Vxyp4/hU
         NmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336340; x=1793941140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNwpVqDjROJGkszbWCt3hcbKnoADzVRF7vj0i9CDHdk=;
        b=ezbbwo9FFe6DPZj1UF+faIiVpPvyQOQyRzX+AK3JXePVm0RsNz/OcFGCRu+PwBt16+
         gEoLXVqtI5QGUHhJHQo2hWy6yZbDZimdMFBs4KJXuoEns1BpmtmwP4nGWVov/q+1uEDw
         cfThU1eSDNoKPtsi0mCDg9d3yTzYVUBl8P2h4FwN1dt9WlwSdHF/fXN6dhJVGKUOSB8Y
         Qzm2bX5wsTkAhVSKpbIpVQ7AgjXxeJ3kTk06rEPOEVbZXxJIxJRkceCuRMK3lKmHZyVC
         +/ibDCnzi4zmhB5c0TRNUDsGEQFWO7ea6pAup29I0lPdlNgwByK/3dckL3aUUtUDKIlI
         UYLw==
X-Forwarded-Encrypted: i=1; AKwUvBzgwHTMKF3/y1Fm6FiF1nXJ/PEAMKsFUpRiGrfqZPwVJ7NHaCTEOtfRZAwrzYgK2uHI4qMButY23e3iWA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3whjWGOOewVLoY4msByah4UlVz8BUxPpUJ+iZ101KHnkdFq/u
	F1Z0fgYokkqMRCZ7/9X/8F5QMjBAYJA5WeJyl0VV9XQJ6w/Z7JG8lUjX
X-Gm-Gg: AYBFou3mD5t3D4x5YUgynpfQ8zxEQMQnKz36zeUdBS0q95+iGUdl6481oBFqmokt04m
	o3qaCRfYJl8n2e/54phEgfongAd3ptVQA0luN4LOQlFIEW/LTNWiCUx4N84G2cCutQ2mjKZyH8J
	sgmhki9oHVD36KMp1hOOkBom9GZqmMcpAAwSzw2GleCV5u5VUT3UU3g6wOuDmvUAsWQx+DIjOIP
	N6JhotXubQ75+jI15NYW/Ch5+mcCI/IizbdpmCPRpH7qSnirj4UfUt9GrUseCyT2AhC0mXDZSwI
	7PZfeRrLdUzoXBLQjm9GeDn4uuVeTHsqGmGnzNGED+IfMrRNPVssQxv+CZ+weUlapoW9zk5RyuF
	fv3QGk6nIZ+R1o/rDq34bPoqI0XJ8fhXXJ6pNA9oaIK7wYc5xb3e2fyy3Q2YCb4rWAoNQo4FU61
	Gi7KNtMkkvhXUln+ygE82EtCK9jx8z9Y7rkkJ7UbGcsJYKRHYyKHtV1zkgUgpvQrjqGgIykcndT
	o67Uk13urboQDvtzacEqu1/AduREJyfI/iYe3nIQY8vtnry8Bzld4fizDLE5D/JY5bOn+LNLQGp
	OnDNT4y2v15ikbo+7ruUh3/FZ9epYItINFq25yhMLMNKlXGUB28pKa/SubUr69ajR88=
X-Received: by 2002:a05:7022:3a03:b0:155:7721:3a4c with SMTP id a92af1059eb24-1ac5f18175fmr1949054c88.35.1793336339593;
        Thu, 29 Oct 2026 21:58:59 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm3433152c88.8.2026.10.29.21.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:58:59 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v4 0/2] tty: sysrq: fix the reset sequence kept per input device
Date: Fri, 30 Oct 2026 12:58:52 +0800
Message-ID: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

v3 1/2 was wrong and is dropped.  It stopped a truncated parse from being
cached, but the parse still reached sysrq_detect_reset_sequence() in the
same call and could complete a reset.  param_array() publishes every
intermediate sequence with a fresh version, so no reader-side check can
tell them from the final one; 1/2 now parses the whole parameter in one
callback and replaces it under a seqlock.  2/2 is the same fix adapted to
the new 1/2, and depends on it.

Both fix bugs from the same 2013 commit and apply to every stable tree,
but 1/2 is over the 100-line limit in stable-kernel-rules.rst, so I left
the stable tags out.  The two have to go together.

Tested in QEMU with a uinput keyboard, one device per scenario so the
per-device state survives the parameter writes:

                                           before       after
  hold the full sequence                   reboots      reboots
  hold one key of two                      no           no
  hold the old sequence after a rewrite    no           no
  0x3b,0x3c                                reboots      reboots
  hold the new sequence after a rewrite    no           reboots
  release a stale key, then hold the new   no           reboots
  press key 1 while the write is mid-way   reboots      no

The last row needs a 500 ms delay to widen the window, in
sysrq_reset_seq_param_set() before the series and inside the seqlock
section after it.  Without 2/2's timer_delete() the armed reset survives
the replacement and fires.  Rejected input is the same apart from the
two cases listed in 1/2, and reset_seq reads back the same.

Changes in v4:
 - Dropped v3 1/2 and replaced it with the seqlock patch (Sashiko flagged
   the window on v3 1/2).
 - Reject KEY_RESERVED in the parameter instead of storing it.
 - Dropped the stable tags.
 - Tested in QEMU rather than by inspection only.

Changes in v3:
 - Added a first patch so that a truncated parse no longer sticks
   (Sashiko).
 - Added Fixes: to both patches.

Changes in v2:
 - Retitled from "Input:" to "tty: sysrq:" (Greg Kroah-Hartman).
 - Delete keyreset_timer, otherwise an already armed reset survives the
   reparse (Sashiko).

v3: https://lore.kernel.org/all/20261021022007.1717207-1-zhanxusheng1024@gmail.com/
v2: https://lore.kernel.org/all/20261016070636.2559899-1-zhanxusheng@xiaomi.com/
v1: https://lore.kernel.org/all/20261016032732.2328852-1-zhanxusheng@xiaomi.com/

Zhan Xusheng (2):
  tty: sysrq: don't expose a partially written reset_seq
  tty: sysrq: reset the per-device key state when reparsing reset_seq

 drivers/tty/sysrq.c | 142 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 35 deletions(-)


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

