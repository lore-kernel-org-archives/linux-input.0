Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711496;
	b=sqYKiJkCokN9LsJ9G2hhKiHQdNEUd0S5b/ONKhljablFktQ7fO4hu9W4O13no5V6BCBQ
	 mfOJZCYNh/FL3T5taZ6Nh0Bw3NeE8UnmpwTLFTb4aNazMKmLS7n9nQNN/5Szkcsh9ovrg
	 GeqbuxEFxHNgfyzPduwiNnfPepbkE3c5dTQViuJJKEvL5C3Z+Xll5fMVTpJGGamtRuudr
	 ctAHt7BGOpk0Yz5KnKZZqXYbKlfheq+rT0xi28RUPZuktWKpjL9DQhHZKqkOZAPXdAP1t
	 731vg1k1csuKvAb1Db2WYeznsE6m3UaNMkI2OL/KeBWGn3Db3auSxHRlYUMgDTgGoVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711496;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Nlu/CW67iHg0bzlP2EMITpBeYel7A1QcubAf52CIYcY=;
	b=Y6GjVfQldMhnkQrRV7MONBlYftIEnn0ICxoqX1vVnog90y9PWMcwXQQV8RP3Je8k4lkG
	 Gi8rmyrW0DJw4XcjI7U6uj6EiPxSiDvM+oKio7luHE9Lx7HhMlWJHDJtAyl9XP6BnHHhw
	 OC2BxLCpRPNpI2cA8zkhfNOy91a24Q/y2FUJLXXE6Rg30j5Z74ZGvyaJWSubM68H9xR+D
	 aK1A3xDwjATR5h13jI/wpT6MjVUfx1yVwNZ7ZeIuXbXTHDE/TQzHQ6s2igUcsjDjQCU4U
	 uZ7P0ZlP0RUxiWSk7KOPjnJdWklXlc98eh19pThtDvCy3r/IsG5E7IYE8vicEN7xQjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmbHhHN2;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67455606A32C
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 13:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67455606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XmbHhHN2
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3646e6de3e8so299080eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711495; x=1794316295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nlu/CW67iHg0bzlP2EMITpBeYel7A1QcubAf52CIYcY=;
        b=XmbHhHN2D+hG9YFnPC1ru/pSxK2+z0aoYfMVGmRnzKPQSMpYqtfjDA1s44rhvD4uCo
         w+hUeBaBq3RJUIawkc8wb33xWtXXdhOXTMtIEzhPJyaSA39Ue3ZhLYGJIXSz79Qq1xIa
         kVNy1AErV8tR8VEHf3qCbBLenZcU2SGpu8qJRF3gGA+hr0agi/+HKM8uWANMINfdTyTJ
         Rj/P1DkEgZRdfqkDBKYWaRM2ZzZFTYZZJ5sbB8/BnygvRIpv8GH6Gx65jVSc+eYzjNce
         Fq97BbXYESxDduK1nhdjeLi6QhrYdUNdMBgp/PQ/W6RGcRV4yw1wmgJIwguTmk9bsFfT
         49Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711495; x=1794316295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nlu/CW67iHg0bzlP2EMITpBeYel7A1QcubAf52CIYcY=;
        b=o3aN0LT8KgUlPrJWe7JXY6gzgaJYWlf/UMc1xd1+mNa8M4bRpsaTDcVbeKU8NwGU5x
         gUTve9SKk92CEvuoMuk3bq7Ryt45fYbhJMJozwlsHCGuMWlHvezLNHdbXS/kh3uCHJeE
         EcIFjel9+b3laikoKPmNnGDdYvqhQR5tHwPm78Qpzj3kDNMZBR/ogQJdjSuywJRbbF1X
         Cy0OsMzetpRYuWP77HAVIABpwberKI4jd+3sq2jnu4njcsM70WxajyD4TYorQ1mNi4/g
         Z2kkMYJtvs3CbpsrNgPqULhFx609rICKxlTQ77zzvYZpyJyl/UFZlDE33a4i5J1dmPkv
         ZI5w==
X-Gm-Message-State: APuU4Z+GkHua1ZFjYqwptG7i2r089DOwJE8UmUiUwZiQAW7SsY7G0Z5q
	FGstiGd9nNgm7Ftnq189cCKJPjMJVe0PSUjngEssqd0oRkFCDnhoQelm1IKFur/TnJQ=
X-Gm-Gg: AYBFou23yMXDzcmm19HyoHgN+mX++kuwedTfcmvuwVst2VvV8nEWexaNGx5SyuDny1i
	O+Tf2RWwEzAjEcQ+oqD1VbMRmnXd/dgG4K11UIFqCIs8w9KUz+ZVVTXyVY2Nv2Fa2HIqUNdSKJI
	aHWuFzsu7qsypgvHpuAN/Rp4Preukzi8tZ3Joymkaa1h4CYYXplx57Ax3BNT+FqJABuPfhxagcW
	t4HISh3EhoeI85EWo9wegl4jwf+VVF3EkKW8CUupJwPTL2A9WZ4KsJKoIO2FmDN5bZ3TriZ+kB7
	DjqhOgIHSZ9vGhihdY+kwmm5TGEPZNcX/a/xCdSmZYYlf9HXK7ua9zc7feUBXDC680/6BZ/KJmy
	OyXWTUADDn2qjRtUrqZ9GSpdZdlwjbdN4M5TMVuRivl/GiBifGJTCFaUeL2ZbwpXSx8Tkzvo7+M
	RjhOrf+5jEqDQg9wiwBeKC9N6sQWMjMGwQs3/xs9RNkAvCmZaIY3XMi6Sk+Z/vU04+oMT5xNfgE
	T1CvmdGg2L16x54Z1uNiFBddZVn2UmruxMS7aRltbYaCBitqVrIX/gTY3H2uyzyqBiKoc4OMCcE
	gZ/JVlW7lLkb7IHHtuHiCFmRECa8PgxUDWpx7hLLmQ==
X-Received: by 2002:a05:693c:8099:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-36a42236aa1mr29674331eec.2.1793711495269;
        Tue, 03 Nov 2026 05:11:35 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm40133125eec.4.2026.11.03.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:11:34 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH 0/2] Input: clamp SMBus block reads to the caller's buffer
Date: Tue,  3 Nov 2026 21:11:25 +0800
Message-Id: <20261103131127.1585884-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

i2c_smbus_read_block_data() has no length parameter: it copies the
device-reported byte count (clamped to I2C_SMBUS_BLOCK_MAX by the
core) into the caller's buffer, so callers must pass a full-size
buffer.  An audit of all call sites found two input drivers passing
smaller stack buffers:

 - rmi4: rmi_read_pdt_entry() reads PDT entries into a 6-byte stack
   buffer during PDT scanning at probe time; a device reporting a
   count of 32 overruns it by 26 bytes.

 - cyapa: cyapa_gen3_irq_handler() reads into a 27-byte struct
   cyapa_reg_data on every touch interrupt; a count of 32 overruns it
   by 5 bytes, in interrupt context.

In both cases the contents are controlled by the device.  Bounce the
reads through a full-size buffer and clamp the copy to the requested
length.

Found by static analysis (audit of i2c_smbus_read_block_data()
callers).

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Chengyu Liu (2):
  Input: rmi4 - clamp SMBus block reads to the requested length
  Input: cyapa - clamp SMBus block reads to the caller's buffer

 drivers/input/mouse/cyapa_gen3.c | 14 ++++++++++++--
 drivers/input/rmi4/rmi_smbus.c   | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.25.1
