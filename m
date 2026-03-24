Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D034A3C4
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383546; cv=none; b=b5Rw6C7NHdOiiB22sDdTf6Ig/dU7cHZlFOvy39sQ7eroZ618H/QJq5qNSjrGBBnvxgff9HgZyeUhjQ9RYSQvGoF026FAu7El+BGo9f0OgpHQv3l7Rvdm4wQhBCbdiCPDH/an23s69Xwm4P20hsU7tHkRBqHZmHWI23NFp5Zswd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383546; c=relaxed/simple;
	bh=Dyg46i6NCc1WhVwi8ovx5dhpXtlJuvYJqgKq6QPv0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdVKeDgk2iJLfDn0hL4RP5K2b82MWIxbfFZOG/VbFTydduUspVviyjZuDcPoqO5H3Fv1O9Q2ieL493G2njiE3SQzyds0oubl2CbTXWXPNWOxZYNWrvI64LRs6vQVpBNRSyq4BH2LZWRDSsnk5KM8BBTOrPf78dsyqwqA9xfoYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6vCoVf1; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6vCoVf1"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-602947681e2so995998137.0
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774383544; x=1774988344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=e6vCoVf12gK9VWthRMn61bBa/NccVDO0jp6+PjF+1gUG5lfxCW6Lloo3qiTgcbzK7o
         UWAtpQ9YKK28PesKG0rLIAedXyI/0nD1swFFk6XPzyl2mBdcb3seQOz3nEhdf4bZq9uB
         EGmF2C+5lfuGxGxTL3WIZq5wH0V092DYfTyuaYnC6oL5iXbypLgE305y0Y4m6mHrcc6f
         3nzxCMRssTptHAgaolWDwMolk+l6XgqgJFCabVIgG0i24QbVuC/oWc5Ke/tpCLlxPW3K
         24OArcrdEiHivf4LCu7yZG6D0xrVagMIRTvdogvgB6wtzFA6XroaH2xmI70oJZAU5RQC
         yaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774383544; x=1774988344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/LwkGsCAcMgkIjG5Z0vM08NnZ6ybKA3EObcdXRbB+Q=;
        b=AbGiRPDwe303wvNvgRv3QpKaebc7oh2mHXdCzWcrCE/ZjyYoSdncA/PQFVnKGpDrPD
         o7VempsFeuPt48+iAsCQsyjgiHRJF/rALqd3QJ2Rlmd4KIz2alLwDqIWIE+BrU/FxQop
         HS9vfx7RY4GiBj5pxULQeVqP1TMxggCsLBcsM4LJdUKH9+gLLYCCv7Mi5mvOSF5RM+0/
         psTD6ZSp4Mgm7jD2Z/Qa99aYDINGNQQD9qm0oHCi/wGEPMoiOpu8OyOLbfyEs3PFsVdF
         20XH/41kv2zUeUmj0Cct47qDMmdWS7rpjVxKR0QvFc3bWIKIcIdoRZvqCzS2LL5aMshp
         ZimA==
X-Forwarded-Encrypted: i=1; AJvYcCUM2td86Y2r0Uwjmq65k/Qi2WWrZB8a6b0zpGDnLpwrYx9Kv0+0Do5OddUh7kTRdFFcg6JbdgJVpJ+83g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2j5idq/eGN+z8EIaUlg5uR0NOhEugtkHed4p9GAL8Trg3Q6tq
	pNkXIb1+Abdgz3vS47RYCwC7wtHKXjtyWppqbCuOSl+fX+oPAwAw9RoJ
X-Gm-Gg: ATEYQzyQF58iA0BcYh2OkdjVmdvmXEYQD3aSMFG9/RIlLA5KEtiV1XUHDKDhXHIZRn5
	6qvdt0cmU2BiXou/MMm5FrxoQUzKeREgdwwTUM5FqGTpp3NV4y5+pig8REgknVPyIErY+q2OJYQ
	KLS972B3Tsr5+HZy64ngx3DruP/dhU5MT73iNYq7TV7GMcll0fj0wSHpZ11XYyeoWlqn+Vr5fN1
	/g9/f8qwABgqB72WdfEiP9NXIvbKDqwgOF9VpJ96g0WAweWJoCxIzYW+dh291/+KycljlSrdiHA
	RMaCcwBhSigUle8i2gYdTZ6FuD/gAnYwdFu3sc4JUImXXTYM8j72VYStMGGNLdNaL3glZkUVZwN
	a1JgJuE4jwUKL5AP+Wbiq5O7aDRBTuV4w0QN72d0vcTe1lc4weHnKNXWZmcWwuMW0lqpDG8wtw4
	NAzcVcjLUqN+kXIUygsDKufVtKFwuEe3hBHg==
X-Received: by 2002:a05:6102:4425:b0:602:a4af:5fe with SMTP id ada2fe7eead31-603870b6353mr706587137.9.1774383543988;
        Tue, 24 Mar 2026 13:19:03 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6dd:aa::11:17b])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-602b549fff7sm11665211137.7.2026.03.24.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:19:03 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: michael.zaidman@gmail.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
Date: Tue, 24 Mar 2026 14:18:58 -0600
Message-ID: <20260324201858.46591-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324173527.11321-1-sebasjosue84@gmail.com>
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ft260_raw_event() casts the raw data buffer to a
ft260_i2c_input_report struct and accesses its fields without
validating the size parameter. Since __hid_input_report() invokes
the driver's raw_event callback before hid_report_raw_event()
performs its own report-size validation, a device sending a
truncated HID report can cause out-of-bounds heap reads.

Additionally, even with a full-sized report, a corrupted
xfer->length field can cause memcpy to read beyond the report
buffer. The existing check only validates against the destination
buffer size, not the source data available in the report.

Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
and verify that xfer->length does not exceed the actual data
available in the report. Log warnings to aid debugging.

Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
---
 drivers/hid/hid-ft260.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80..68008a423 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
 
+	if (size < FT260_REPORT_MAX_LENGTH) {
+		hid_warn(hdev, "short report: %d\n", size);
+		return 0;
+	}
+
+	if (xfer->length > size - offsetof(struct ft260_i2c_input_report, data)) {
+		hid_warn(hdev, "payload %d exceeds report size %d\n",
+			 xfer->length, size);
+		return 0;
+	}
+
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
 		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-- 
2.43.0

