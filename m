Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E13E866C
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920898; cv=none; b=rMt0+FrXv20bJr2sSVeHWEb9pHFPch++n8CJX/HzRqgOXqdV4yC3VbzIX60SNpVCqEJ8jQux0p0MmtjnKaa4nakhKzdG23o2P/v18I0oKtNwCArX/+3Ms7t6t/zkDx8PkTjO1aiEy/T4qiCFLdC3MOdSDmvnMNp8RUDxX5PD3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920898; c=relaxed/simple;
	bh=X55ehTcHXaCqT0xJ22vOal7zcjBzPSQpKGIGy6t63ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpGu3MQLEbUx5vegdMoQS9sk2+qiX0G5+15gfxzKB69fr+t5FokQEnsAjZyqKH2Cl8JGwtxN59ZbSDJB4oEZs3Q7AZuNcd1PfAkdI8QKgRYKEMXEm8nijfApQLiTGuNOarzV6crFUwbIs941Q6/9CQaf5y+I9YRWkyeIVYON3bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oca6NDNy; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oca6NDNy"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso2410573eec.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920896; x=1778525696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYObmHZvceBxCd+lbo9bHNlphgzvjFOiFABepwHq0Xw=;
        b=Oca6NDNyU2J+lcUqGgcCel8FmGp1SeOelWw6UPmlHd8VSuCWlH/JC05prZ734Y49l8
         yCXhIsGnL7Z0PqTspg/L/0aLHf4lZCbpeQqfGf2zJHlJScqBUtd3CP+k+f30LuicGeTY
         OsbliHqd7Qf5TOfiwr64g+hykSNvGZ0p7vWHCYjugdFGGbUV2R1LBh3pFp/7x5GTnI1M
         GU0iSpwM7y/Xn4REotZoTBN4Ty1wvMBCH4OX8EdS2aEg/TRRjxqBYkOChZLp0tEvcrvW
         RoV+aDHsFGfSP5gr0pkOpb2t05SmEvCWWn9yRRs1iHXrf6NW9qmxpyy7YGzbGjKgwx0h
         JEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920896; x=1778525696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYObmHZvceBxCd+lbo9bHNlphgzvjFOiFABepwHq0Xw=;
        b=V9a3MV3GrPYm/GD88t1CKqfNHF+6HVSCNOtVE9j0uH8zmYOvgpXVnSvY5vy4HQlfQy
         QSMOO18rMU2WrrNHFfrAyQkkyX+nJUyBE86EkIm1rw/bCz1gZWhCgmv80fFe1BbNhZAV
         mOC8T7aRmFM4ygU+e+VrhkCKjJ17Bzt7exdQyP+RxE+uS0TznKalC7j8ymr4qpHQnW7T
         rx4sKz4Eq1NtjTj+5fHFiXJ4z7KrNV827JTvKpHkbT6viiVzZxdlRdT9NKjVOf4q2SPx
         Wqf0JeixakrgNUi28h6zDPurjLWGak8f5Ft7BbAFtDOj72BMvG4Y2XuuLlebFpIq+GTg
         E9Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/6R0D81zukeOJMA84H0gvS7zfEfyKxq2fJI7Vq7PAabPF9a/cChGT9NweOxCBszkl4SMsslTieRvlDiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6PqMesvp2T51zaRqI0bylDS3OY87aXJhWT+XG2JmM54H2HYO
	nyMeSOh7oNjtmnXxFQKz/CBeM4nWFAxKHm4acMnCFhAN1ul8irknfM0L
X-Gm-Gg: AeBDietGbLsQ2Ou5OBsiPSpWV8qpyno6RZwSd9cBjaZBCrLRU8mj5/KG/0Yg3kaC3FE
	xnix3Xot1Tcw85OxRsEjKzcJNWgeZw2sI0qypbbHIeFsrOrV3dw6c8bc/E399QLBp6ex2VoWmuX
	BmHT4lBNOcgm4O5cb2S5Ww3GObznvZa1GdqFbjdm5Kwy5UKlzN/Ow5Xj7aR+sazO2hipRic8kj+
	Dgv+eyrUm5UBEyzNWrJSaIAeRYYDDshJ3ME9lVJMpzEvt10eeHHZqZUhHPAXdyTW5Slu/ihQ3dK
	8it9CbMH5AFKW+4H26EgmS01KSBiYxFigfUL2sqxNYyH2Ldrqv5fxCiA/dob+zl5e7iN0LZrwoj
	hkiKSCE/8R5+81cd1fIVkHwXVnoBaQn5nYU7YY18QqdEWu5m3KctuxFStDdwBT54Hyv1Z1sn2sv
	64jZyE6hWGDe1ygYmEjUldCu5fnCH0khR/GM7F19jt3ixVUy4uExTg67DPLaWi/Ag34T8estHfL
	C85ov+9NZ2m545wUKxeHL89Lg==
X-Received: by 2002:a05:7300:fb96:b0:2ed:2942:34ab with SMTP id 5a478bee46e88-2efb8aa1fa1mr5602385eec.3.1777920895874;
        Mon, 04 May 2026 11:54:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6812asm16830718eec.28.2026.05.04.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:54:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>,
	linux-input@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: atmel_mxt_ts - use __free() for obuf in mxt_object_show
Date: Mon,  4 May 2026 11:54:47 -0700
Message-ID: <20260504185448.4055973-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the __free(kfree) macro for the obuf allocation in mxt_object_show()
to simplify the code.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d660cc5b5fe3..6af4db5ed117 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2870,14 +2870,12 @@ static ssize_t mxt_object_show(struct device *dev,
 	int count = 0;
 	int i, j;
 	int error;
-	u8 *obuf;
 
 	/* Pre-allocate buffer large enough to hold max sized object. */
-	obuf = kmalloc(256, GFP_KERNEL);
+	u8 *obuf __free(kfree) = kmalloc(256, GFP_KERNEL);
 	if (!obuf)
 		return -ENOMEM;
 
-	error = 0;
 	for (i = 0; i < data->info->object_num; i++) {
 		object = data->object_table + i;
 
@@ -2892,15 +2890,13 @@ static ssize_t mxt_object_show(struct device *dev,
 
 			error = __mxt_read_reg(data->client, addr, size, obuf);
 			if (error)
-				goto done;
+				return error;
 
 			count = mxt_show_instance(buf, count, object, j, obuf);
 		}
 	}
 
-done:
-	kfree(obuf);
-	return error ?: count;
+	return count;
 }
 
 static int mxt_check_firmware_format(struct device *dev,
-- 
2.54.0.545.g6539524ca2-goog

