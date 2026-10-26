Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024814;
	b=H7bqR5rBCv44jw4LVOiGkXx/9OLGuf9U16dGgXep5TG73iCsJRaMewTX1+xIRAkxoqMw
	 K0sNz3y9EKNE4tDICRnZs1MkqmxnzMVpW1FdXTCnmTLuB7Q9q2jHuk7qG+vUECQkms4gQ
	 H9v1anGYgoCsqy+kSyeRFj3JEVQrLGFq/p/4MxGAp6G+U7jwmEPF0vbTI86uIG22M1RM2
	 qW3K6VCmeaOhwhpTzZT8u3jIjdLp453NrfbX5Zwe54FNW5l4zwbwAlWl9uCXQTQnHGevJ
	 dG2aomjmFQZxsUT7rHJgVEnd6h5fjf03zRBNdyOxbl01dwQHZMmKuNxdtZJH1K6uFQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=G4D3rT/T+qzopMN1XAOQ4SvTyE4fnFXWOdSQPWPqPa0=;
	b=zlvlog9qDNylw6Zz95GKY5VTB3QsH6HqRDXZH3jlCglIusI5wYySlzEp0MjV79jCK/DU
	 f08NPMtOD9gyz5kdYqddsfBz2dyz5somnqRQXq7NNAN1WwmJnOZ32DRYdtwYHAC7mg3PG
	 scALcUPPK/4Nig1eadFiak49LQy/ws+htiJIGWIHl7Aac2I7s4kx3tiW/zDg3Dj6QChHb
	 1XDVRnmSLUf+JxNleG50HmEltlCp5VP+0UsF4jsAQ8mHGA9lVubbHeYfbQkbQBJttVFVS
	 En4HEj2oJ5xgwjodefBchvi183NhiC6/jfBAEd1HejonZ6H8gOi6GnZrrzMiAIgdxPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=A7BnZUwK;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0C606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B0C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=A7BnZUwK
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48bbb06f29bso396182f8f.3
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793024812; x=1793629612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4D3rT/T+qzopMN1XAOQ4SvTyE4fnFXWOdSQPWPqPa0=;
        b=A7BnZUwKxyRprulsg1KtU7nGkXFRByK4bxUuee+HfAnh6WZYuR7WGZfbVG6RyDhZoy
         ysC9qoEvlOejjFDbKr1CJe4yZVgSq26bJ8ttQzJWkWeNl6ozMluxeJ3n3J5VGj9Exx6t
         yK5Plw8GMHa+WszIPyLFWQDEWUgQ1JLc2shcddQ2fGXIW+2eJ9Zss2gbnagw7iphk0tF
         7IABmokVHjlw9Qssh70TsxHbGyKh0m3W0XyAS8Wzh/DTJYTbrn6ok8lYJYuie97Q45U+
         nurfjyr5CnPD6LrhSvQuufmGIN18O3bQOnCqPI/k3wYQpdBVTe9MabPXZle7k1Qo3m6h
         BXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793024812; x=1793629612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4D3rT/T+qzopMN1XAOQ4SvTyE4fnFXWOdSQPWPqPa0=;
        b=vdyBMgeuoem04/6ZarhZ5OqXBn3xFBvaSEQVHdmYlfEXTFsfcR6ARh9mvQDkW9Io14
         x4ADSvrBoTIEKWRBuhM7zmlQ/F49mZnIsQ8liWnLxh14TLzuI/l7eqbgK/rHj0nasOSF
         pGNq7NrqGn4UAVwXIRyepNDiFEQTzIRlsc9yJd1qq1P95ox0Wma7vLj3hxfs6O+x6D6f
         iEHrLhtPL3zUQnWlX1mmvyFBKvlp8w+mw5UgXRqHEYSriw5n/9XzyOIMxNYkZUxFazCG
         dSOsrk21SUKijCoRklE5jMYT9wK9Zj4ni9L9g9IRHL9QgnNM4HNrXhg5ot7ZIKp08QK0
         1DHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDuxCklX1OzkOAWdv+qiBwCtoBR0dkF2IfwDJ0fZk+u/Dv5ASuU9cOxnogNa/JpBaYvqmxQD/Zollorg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJOemFEbta7gsznkxLf0ILlB8K32x3qXAHwF8vY9Y7LghjB9cM0
	eTndMa+Z53XXR6rWxPY5Ss/Q81aT+quOePBBQfXdnonTlXPUbeRZy+dXfq/o8IG0zcHUNws93KT
	mq6UL+ZGasw==
X-Gm-Gg: AYBFou1KTwE6L3TpH4TeQZnA00dyC+XmkTalr5J1DY4xYQ6tQSThYG+wFAdg7SBgMh0
	DQRaPf4EGi6gK9Tlx9WrwCoBGlChTmmC/hZVD5GPCkszacvenCtOo94XK1xdacgvd18MzHahDFB
	b4Dxa6VREu9972VIvf9R/2ZiBiSYMiu2Xt9XmwPpP1EoIgwQEeiqvARFfaVU7V9eVbKJqKHYyuM
	54nvHvgHXTOnEVfKsG9ycLh0OLEbCooNCLWd2VX7LruC7GNS2n5z/OCGIRocjuf5whkkwjxohgP
	4NURsKg3dMinoge7pw14fUGFTBzKvcw5BR5KdtDvNgz7Om4zG+9gt8MkBIkEvPty4sqKBUHNa4q
	87YxPsFFMdjrGIQOYyVVOE8pGv7vCt6lCn8pfxeKx0RSInAiSdXRMLQrz4spbCMmwsp2sa9wZqA
	LKoli3V5WakKXXn42LDJB8hnLJkmglW5gxYEt6tjIfHu43uuKnlTLc7H4A1c/VqzNEMZuEq7aEV
	b9lcZ7kFjmy60DzR+WklF7WIOT7jEw2hS/tWZkHxrFhMpI7S0C+XjUbt5TrvdGESHfVa/6hk5hX
	lKy/QrlmXkn5yj8GHUbUYOL9yl5JEqfrbYUMX00SwVTxGK889eTYLPZnvHdtyfah5pzwAuVdYg=
	=
X-Received: by 2002:a05:6000:2610:b0:48e:412:3825 with SMTP id ffacd0b85a97d-48e3eb4cffcmr12432343f8f.2.1793024812532;
        Mon, 26 Oct 2026 07:26:52 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm16400703f8f.4.2026.10.26.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:26:52 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] Input: synaptics-rmi4 - f12: read only the object data on attention
Date: Mon, 26 Oct 2026 15:26:47 +0100
Message-ID: <20261026142648.2567233-3-dmitry@kernelgen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026142648.2567233-1-dmitry@kernelgen.org>
References: <20261026142648.2567233-1-dmitry@kernelgen.org>
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

When F12 data is not supplied by the transport as attention data, the
attention handler reads the whole F12 data packet on every interrupt,
although only Data1 (the object reports) is consumed. The remaining
data registers are never used.

On SMBus this transfer is the dominant per-frame cost. On a ThinkPad
P14s Gen 2i with a Synaptics TM3471-030 (i801 SMBus) the F12 data
packet is 79 bytes, of which Data1 is the first 32. Reading 79 bytes
takes about 17.4 ms and reading 32 bytes about 7.3 ms. With the full
read the touchpad reports at about 43 Hz (median 23.0 ms between
frames), and fast swipes yield only a handful of frames, so they are
mostly lost to pointer acceleration and smoothing.
Reading only Data1 raises the report rate to about 65 Hz (median
15.3 ms between frames), measured with a finger on the same machine.

Compute the size of the leading registers up to and including Data1 at
probe time and read only that much. The attention data path (hid-rmi)
is unchanged.

Signed-off-by: Dmitry Mikushin <dmitry@kernelgen.org>
---
 drivers/input/rmi4/rmi_f12.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 34f24de34465..b3cd72d5bea6 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -58,6 +58,8 @@ struct f12_data {
 	const struct rmi_register_desc_item *data15;
 	u16 data15_offset;
 
+	u32 read_size;
+
 	unsigned long irq_mask[];
 };
 
@@ -269,8 +271,9 @@ static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 		drvdata->attn_data.data += valid_bytes;
 		drvdata->attn_data.size -= valid_bytes;
 	} else {
+		valid_bytes = f12->read_size;
 		retval = rmi_read_block(rmi_dev, f12->data_addr,
-					sensor->data_pkt, sensor->pkt_size);
+					sensor->data_pkt, valid_bytes);
 		if (retval < 0) {
 			dev_err(&fn->dev, "Failed to read object data. Code: %d.\n",
 				retval);
@@ -529,6 +532,17 @@ static int rmi_f12_probe(struct rmi_function *fn)
 		data_offset += item->reg_size;
 	}
 
+	/*
+	 * Only Data1 (object reports) is consumed when the data registers
+	 * are read from the device, so do not read the remaining registers
+	 * on every attention. On SMBus this transfer dominates the per-frame
+	 * cost and therefore limits the report rate.
+	 */
+	f12->read_size = sensor->pkt_size;
+	if (f12->data1)
+		f12->read_size = min_t(u32, sensor->pkt_size,
+				       f12->data1_offset + f12->data1->reg_size);
+
 	/* allocate the in-kernel tracking buffers */
 	sensor->tracking_pos = devm_kcalloc(&fn->dev, sensor->nbr_fingers,
 					    sizeof(*sensor->tracking_pos),
-- 
2.56.0

