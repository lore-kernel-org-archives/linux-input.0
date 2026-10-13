Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F147F782
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862955; cv=none; b=AFCU73X5jhMHzWvLkKvdzTAqCdssZwGRZ/RfpStqHSqAsJ2/zSXTKfTjPj9itYVPlqRWkjGOQNFEGcF6hJXODAvZrwIV+oo8poF8o5fOC28UHCRl8bdb8803PpmJTHHVJXrSW/i2MBqrz7YDoOaQsG13iWyxA2lJ5M7mnRE5HY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862955; c=relaxed/simple;
	bh=qQtZc/LYpwS1Pn0Pbj2cy59uoKqv6Ln5ZHOMP+Ij/ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tRK9ddf67+K0IyiD03VqGr1msy1Lv2A0WbXzeL3CLUpK5QPVfpaq8FJQ3EPQdztCGWKu2tzzp13pmppTj73SR5dfKBUqTQ63LR0EaHrK0dKxh25/gqgmlPOTglwPCz+qrkL3A4OBsYwrptLJGhnV+Bjg3dKjR9pfo5wpxHdh63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2kRnEGy; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2kRnEGy"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1494361eec.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862952; x=1792467752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6SSHz5Dk/JWNOpPlT4rfoa6eqVGLCdKSUBhsVYqgGQ=;
        b=Q2kRnEGyDFWcdS2ZxPmW7s+rq35ZtEfMcFORDFvjaZ/ulG2vHAL2pnYOHYLoA5/Evy
         DnIFiNOW+Jkb+zBFi6w7pKNnSUD6p+5KT4k4F/1pR0bGOOdOlxO+oA7f9S0e3GAMJ1zY
         wKO6ySobGjUrH6JS8J3py10QmYVf81OxBtH4Jd25Fv/0QLVrQIthjYqKwbCwUgUBiR3n
         DNX5g9Io0eUPU4Imqh+VLJmKaEMLYxU/r1QjAZh1xxBp4QrL7iZlbIW2QiVBUAlISHr1
         qSZoq9GEIMW4j4CLMplpcPw+c7HxvH283M2qRGVTZG9lxmnc/QvTncx9T0j6Q2YwrEnK
         +WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862952; x=1792467752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6SSHz5Dk/JWNOpPlT4rfoa6eqVGLCdKSUBhsVYqgGQ=;
        b=ZBAO0ao88r0yE9FpzFk94+sdFICtIo5Gh2Wk740viUrQRSrigFiLgJYNnfArWORQRU
         4O9wQL/Fv03YAx7n5UQTyaBLXtNm74cmRHI0i5WRxzyO3IUzMo7TJeTIRnXh02h3QDTl
         fpEj79y0HPe39ZHxHDkY1O6L/5DLGdxJPLFw6n8qC0vPpqBeg/mCbI+VcbOaMHMfrMio
         oCyv+D+AsjD4mL3cKbryFJTrPY62KKWDC+LAVYQSRlP1jG4nKVrth9dpip44wvoXfWrb
         JGnAAaAwFDd0Dh0RgnnYwG+7UaaU6+4BzvMLHdebvRFgxjwK6Y4+aq3BfQbgggrW1XE5
         w7Yw==
X-Forwarded-Encrypted: i=1; AKwUvByI8JT4mmpKOwJIymbmgsaKJhhyQ6BY3mJXjF2utVywSQ2iQC6JLnY4P73bIysh0+itI6HpA4142Q/PlQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJCbQvX34PbPhvunGmHjfUfOmLQebnqReDyHBJbUMCOwN7XIvPU
	NXTH8YP/XkmwGbzQRuhbuOSVtOKkbLQm6LqdZHf6fkpxZLvD9CoG69Vh
X-Gm-Gg: AYBFou2hz+tw3lfTjY1hwoRXDikk68Fa/Wr4xsCiXVrsExh8R3Wlf7LJMwutnVNahxI
	hjUEadJbNoVj9x/wuCj85Fg++YQbKWWrRwYUie5G8Tr+oWSko3AvgvcRYgN8bSMaAY/siZEws1s
	JxNI4oHBql+k9NAmhNrcEPXYjlP16A6A4FSmOVj8wjgoYJgyYoAauqhW0ooAI5nn9WVneyBHfuC
	81smHXuQsz+z5tpXqa18cPoH1IisV7Dgk7GyLLK7s/em+PMOcZvYFziEyIT/ZtaWygMNDoDn7yS
	twd1OIXM5wHfrM6IBx4lxdWeFIe+is48AHUxfkIDxJXEtDKOJRRP9oMEfiSd4I7q5sUIR1co1+c
	ZKLTINKHuiofV5RglwvagbpbzeH15MiTCqHboTnhY/OMs3kTxYAuUARLZtKs2swu1bwClTJ5PCI
	zQ9ObJaFkjo7p6Pv5kNJhZKB4v6/odC6g+0k0NqSMebBKfIvwfdJ3vqxBz6nlqv1eP++zUaekqh
	0UXcGvrM+7rbYEM0cP7MHWs3jCy8HOMngKEXhZntYhzYgxpcpY64J94SkhI3A0=
X-Received: by 2002:a05:7300:e9c6:10b0:35a:c54:f446 with SMTP id 5a478bee46e88-35a0c54fcadmr8535188eec.40.1791862952303;
        Mon, 12 Oct 2026 20:42:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:31 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:21 -0700
Subject: [PATCH 5/9] HID: i2c-hid: Drop redundant report ID validation
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-5-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

Now that the core HID request handling validates returned report IDs
for report retrieval requests centrally, the report ID mismatch check
in the I2C-HID transport driver is redundant. Drop it.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a8a9854854f5..d8ed7bb8e80c 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -311,13 +311,6 @@ static int i2c_hid_get_report(struct i2c_hid *ihid,
 	recv_len = min(recv_len, ret_count - sizeof(__le16));
 	memcpy(recv_buf, ihid->rawbuf + sizeof(__le16), recv_len);
 
-	if (report_id && recv_len != 0 && recv_buf[0] != report_id) {
-		dev_err(&ihid->client->dev,
-			"device returned incorrect report (%d vs %d expected)\n",
-			recv_buf[0], report_id);
-		return -EINVAL;
-	}
-
 	return recv_len;
 }
 

-- 
2.56.0.385.gd3acb90ef8-goog

