Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007084;
	b=KX77jDKdhttOReFUB+AIxHZXROzwlGsM52hNTMkAqrMGdgvlQVsbLx54xAFK5zE7Fhzs
	 RY6R5WEr96xNE7HMSPOfe1tRJs4RDoNKagZtnOvagQaSX3HcjK8oYodMHu+gcPVTofmDs
	 bikyozzL904PkX82ry5hff3OAwTDvULmwiuEbjMdmy0Ph7ezHWhD4dE8bR2Wt4PgR3sBO
	 fhM1Il5i/cz4Y+20wFbyyjZJ6tdNQiCZng31eiyLK/kAHUv+adD8IZ8P5AiEBma1tb6ND
	 KO9SdBoNQ36yNUU8WygHduem7Uu8BfYTdayr/UuF+LVcETJJ4ciKJKA6kryNSkug/9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mDjO7YbeUJVzk6R/ZfeWCN2X4jglFANlJF1XQmpMEOc=;
	b=ZvfR3bBV3ZqfWhHsY5ARAFQoip8DjNDPQb9bpo5IVellt+8NV+AhHaf8m/afHq0oHsRF
	 b3S+wMEAXBlDgvHj15YyOica59blElmeSI98/N05LiHX2hJn57r3Yd1lND9tpNI4DfL7H
	 oc9GczMusPLgL2QFsZfRNpnjT0D4VEhDxrg2pH2zLS9T9L6yzWQRTfX10Bx6qxQtBz6ZL
	 hkurbO8HrStxOXoA6N8dR2UW6OnqB/9njFdgXO/SzxVhZRJ40z9zAr3kD7wk5ad/KY/LQ
	 xQYBE/pqG4GunnVpnmtlXVe/qfFeHgTEt54SwRy2sAMoqrXcD8hn0W9ejzGYsz5H9Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernelgen.org;
	spf=none smtp.mailfrom=kernelgen.org;
	dkim=pass header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mSycVN5D;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFA606A322
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 09:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDFA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelgen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelgen-org.20251104.gappssmtp.com header.i=@kernelgen-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mSycVN5D
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48dfbf48b92so218728f8f.0
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelgen-org.20251104.gappssmtp.com; s=20251104; t=1793007082; x=1793611882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDjO7YbeUJVzk6R/ZfeWCN2X4jglFANlJF1XQmpMEOc=;
        b=mSycVN5D2ygixJbO5SxRv8V3vV5pL/LEBdKTvWdh2WzJHpT6p6HpmCOv5XfTOALbnc
         updtpLtu7zSKtgs416WzNZK1gSTqmSx5Np/sQqiLtZVYHCZC/j79vsHab2nuGty14mcf
         2yB+hoevCFIqnvfemX5mGo7Vq6Sc1zUJKoIj0m6HgfpRJe5T8dEgWRTgEmfGWDuOWm81
         NyO7bnJHLNGb+Rq61rTRPmf8hT/OIH4bZpKtYmR6BJOThZ7b4AcR4xsMQ0AUMfHrUtY3
         8h/jb5PmTtPeCbXKyNjqKfBj+dJcDfw//lmERufClvNUFn3iNakgnPV6+ynuyhSlQPDp
         ywRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007082; x=1793611882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mDjO7YbeUJVzk6R/ZfeWCN2X4jglFANlJF1XQmpMEOc=;
        b=hGaW9gCvUMXe6wT6xiCYQuKCW2lxh+9wXFDMpXoMZqWjP1BGEnCrjZVeLaEFcK5uH1
         qPwhAb3a2z9S50MIQsNuQyZdGWS7OjkDU030SVmp94Y57TRZhXCdvdcoXr2MckwC242F
         7AoPsukMFAc19lo1mKuF+8Fl+K4uyaTKcXxu0TIGGG6d5kDIuheUyKer9l8OBjZB+f15
         4xE/4FB4rg415uzYdPsYK8n4JZHRGDhH51CrM2VXtMd1vrrrJmVlG/H1Knbfv3kk2Gyz
         NuM+OKtxy8Euf9ztzymef9kwrNRRhzvpbP1pJsQrfDlLYBVO6gqe4Q3/aKzfJUrUCw+x
         ECsQ==
X-Forwarded-Encrypted: i=1; AKwUvBympxsPp6nhG5K2JJJXFZYE77pXF283BYFL5uz7B66JAgoe5nLJ37ANw/QGGO9U0l5zhfQpIvc7RhFewg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLqDK0q435PHll28LobzE1XUaj3kZn2DqqW4Qo9H4iERDpjFULV
	2FO6XYXxp/IENnWmN7dR1JPJMSxCdiLdL69zRx0ER5DOgrqDG1aIvCFrwoKVj3SfQRA=
X-Gm-Gg: AYBFou2V+kgDZa83I9lqWSLC0WK4v+CYn0+DHMXI+Pkwv6KExDFhJGZOLHBtxeBoB6X
	MyX6iuGJx59wLWV1KSlI0lhkvBypwWeD79zAuTfn6l+JK5q4S0rGIQj83lBEvqoQSPU/zhuJ8me
	MtmTK1CyujOPwqKRMKZh7eHyZUAZpBGOZaA0prOWzBFlYlZeNgsftdoHTaJsK2+lPRHsTZUUxi2
	Ot/YeNMzI4ZY0vXI0aLcgzkIsrnjJ1CXuMYiVPYRd0qHTVBDv9zEuwdr8WDj/JNPdGumRnpfEXy
	otQpLeipJrp2nUOXt4EiVI5cmjVtNYN40sOVUuvI19uSAQ4kMKyDABInvQdoBC2I1Gix04WaTjU
	PwIvhtYbvc6ekoFrk+ir7NvD18RByg6/T2E4zPoOnGxFPWe9vl8u3f8+cIcO4Cmq9KM4V2aXzLa
	FTm5AZRMhxazZd9xxqIOxZ40zbCzM6p2LJ3cpQWE3VCXyniGxI1mJsk+SjJZzG2GWtPMEXqBIUw
	4j2gTon0PKj5N0IIrSabN0iLjhlxDHpU3v8usmNPmcvlhKYrDaiujOLyt0bNRdRH16x+OskEZv4
	cR+ukJMuffPHIEMQgecEsEsglTqOa+C8GIwcRuWjap3fq5GFfKbFK8HayRY985OjbMuxZYGc9w=
	=
X-Received: by 2002:adf:e194:0:b0:487:8ba:8b4c with SMTP id ffacd0b85a97d-48e3eb2b66fmr10713419f8f.1.1793007081391;
        Mon, 26 Oct 2026 02:31:21 -0700 (PDT)
Received: from kernelgen.org ([2a04:ee41:83:91ea:29ae:67de:9d1a:d368])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f305sm14217710f8f.3.2026.10.26.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:31:20 -0700 (PDT)
From: Dmitry Mikushin <dmitry@kernelgen.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Mikushin <dmitry@kernelgen.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Input: synaptics-rmi4 - f12: read only the object data on attention
Date: Mon, 26 Oct 2026 10:31:17 +0100
Message-ID: <20261026093118.2312302-2-dmitry@kernelgen.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026093118.2312302-1-dmitry@kernelgen.org>
References: <20261026093118.2312302-1-dmitry@kernelgen.org>
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
index 841884d967..ad210464b2 100644
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

