Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9487E3C5550
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334408; cv=none; b=qZSnCy5C99ccCkDRWGo4QDXCUCoiV70y3htFKm1QAi0ldVuJjLxaCLE2vInEpAzzRd4Xx6DN7RH/kfZ0YZjh4pW5VygcDZazvspPXleFWW6mDhpT3a/biu6CTo6qiWmyTIHlbJS+8ddbeXxjXEVdqUULUhC7IaEjbJOtW8z58cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334408; c=relaxed/simple;
	bh=qznTTsH95JMiWz2KpE1aJItnwW6ycamhHq8hzhCMPB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/VH/sD7JuNzd6ta4KqQ0ZslxXCK3OFRQEZUt7GKJwyfYjjvKEozae/2dWSKfnLTrFbk4UIssHNzh11foEXczv9xbGnQWGRgwtEZCHYdIJChoaFHOGVdTrDUcAwfXQhnYlzHmBYbnTATe95tUta5/6tc6BceUgFm3qyBaigQ54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f9aYIaU5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9aYIaU5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso4618635ad.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334404; x=1774939204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws1XJhm562F8Eqr4Gpp6hR2Els0noubs7wtAB+jE3IQ=;
        b=f9aYIaU5D8+n175pz0sVt1dDRcFNP3LrPfin9laH7FEGhusp3Jum5kWNRAryiFQSA2
         ASiCLsCmAb7iuq404pHLcbvo4pcOuGVJJFXChFM8+VOONN16R6/8feAvlAiqj1d/doT3
         q2K3lltJ27gylknDg9m+qxUjhX10d7KONwdtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334404; x=1774939204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ws1XJhm562F8Eqr4Gpp6hR2Els0noubs7wtAB+jE3IQ=;
        b=Y8cKdAmRn2acml8peWAPNQ8py9sCSwjYx9U1LGZofzL60NTr4H6znLePpR4SsAl8LR
         oP6ZCQs2XrdVDg/bca1RTnv5/RTAnCH/THuPM9mefP0u185nM9pU27LC0GOIh1php5p7
         82IStwqTkpYe9DGFLTn3osLZT8AOfgpLzjv2yF+Jg4uDdkWQNrUTGi/PqVtJypNiemD7
         wv1BBA6Ihx7l53zCiX+V4debd6Aq4yfAxCniqvuWdGqJH6chycPwaqyrcG3evDz5+Tx5
         cqU+h1QdK58sh9rpCUzIh8Np/0v7yzWLNZepGSM9odjAXv9Zi+/X7fcoRX90DYIjH0F7
         341Q==
X-Gm-Message-State: AOJu0YyjVgY1lldcc4IulZc6KwbX4Fhx+TjF+swFqNxpYnjjrF1rh3lv
	u8IFRhc2ySjKCBs7oowIrxKFVl4NlA6u735BhNx1dJGdtHYmgYibUjYpCgH4Cxgx8Q==
X-Gm-Gg: ATEYQzyUroroYOwuiNDAQm1PWz94qbxjXazS+Z+p1jX8qres8iMQVL24ymR4JxX2x6J
	V55xr1gfRjnfZgDHbsJq7D7O6UEBdxk6Ev2nTJ/ZZ3fTBxtSh2JMO+/QhevupGeVahQaRigWQEw
	6MOs8sMEddRl5r4BJyr/aa3+HNi9cMClYGhamvxRWq1vlcMpHV19eaIXyYV+MbEu/odd2b8fHyO
	qs0TpLuDUQRyF1aekTnkfvzTqUZ0i5akAW/5ZhK2IlbIkTbfzxW+FSLjdbDZR1sJzx2bs5TZH3E
	bBOd8EHU9JASAuFYqgLlyWbbkH3oSYcEVStI/i6dvADcJKMpzocEFHBXGxcJzQXP13ghLve6zSQ
	J24DIVYH3M/EXjON52vlXnceYsaIz3GGAR9FKmH9osp+PkOp4b0nYLwxfTg86fVCJ+hT3fyl6jJ
	aEqd9lWgMs0wzwUsbTHqi6ey/sR9SQDGRF6lCnYJmkfj4uHrQi/0wzv3HcquWmrQGj9JKn7QzNQ
	cNWvMdksJF6RuvDTAea9qEdiifOO7nemQ==
X-Received: by 2002:a17:903:94e:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b0826e2f0emr127644455ad.12.1774334403691;
        Mon, 23 Mar 2026 23:40:03 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:02 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:35 +0000
Subject: [PATCH v2 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-2-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=1401;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=uFPHOo5tVahmnQsO+3HulhbmLaF0uQlDRKXTc/zQ45Y=;
 b=FzRz6hRBlzD7ymlf0UgsS6IIaaR2bkVOGVToLSaLqiBXlBFUdjUt7+8GdOcAKeSszYW95MDk7
 /3ijkLg5nuzBKxgO95bX3yQFQEwML0ujPgq48j85CrKspcQ4tbxqT5x
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..813c9c743ccd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2316,6 +2316,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_SPI:
+		bus = "SPI";
+		break;
 	case BUS_SDW:
 		bus = "SOUNDWIRE";
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dce862cafbbd..957f322a0ebd 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -786,6 +786,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.53.0.983.g0bb29b3bc5-goog

