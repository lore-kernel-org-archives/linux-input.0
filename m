Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DF1DED4C
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095184; cv=none; b=n7vMBGUL3SUGQXqVmoDtppITJReZSZTVsPKUM6YoY1j+yjGwRpS/lX1UYpqEk3v4RTILI6ZlCkmAFr0j2kn3lViTiE5bYflSTXvKIYSJjIzCpgsZJParzgyeBs1ABqPoajOObcl5KUbQXiULHUK+qzkgwW6AQvAIksw/e0ndtag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095184; c=relaxed/simple;
	bh=BDcoGzUEgpCGDfndnWpejoVBe/vKuqQ4SnpVtpHMd0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uW6pfCf346VviUDiW6PZsptCjUDkWcEGFH1MoR3zFq3q/76O7jw7w9Sx4MUilIwwxGDt7u+i3CBaGzz9XGeh0VazbEIxP6tVJPIUhbbv2e/GhJIMAHB2+AAsB8d241nTtjI7uxnEBfsyNRjjASXuCYcTZ2YDWgJ8/RwlF4gYESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JyUMCfsE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JyUMCfsE"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76c067bc51so125609a12.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095182; x=1775699982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHrAn4/x3CwheBfg3e0ZTKZNKx+9iUkLN9KNaFrA10=;
        b=JyUMCfsEzJUvnAMUaH8pFk7JOJz5S6j4yc2RPRMEDvcR7+AHkR2RcjSaIaWqcS1bk1
         pYXgyC2RR8ANzfyWQI2dZu03PBe2k9eQDah7UHIYUoXK+HKo+CrxeS0+HybIbbmEtud1
         M3Tr2cQDeNwYp6bFGqBDUUyAFrSsM5AQoXgXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095182; x=1775699982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fzHrAn4/x3CwheBfg3e0ZTKZNKx+9iUkLN9KNaFrA10=;
        b=R+wwV4Gah/M/4i1acyL+qK1MHLAJ+2p88o+y4xhK4hrHlQZQ6tfprACGVmiPgl2XTa
         P8LzBse+S/fIr/pidKW126av/EGQqBq/ST+4ntXsnKOfvxmJRC5/GP+idRslY1C0oR0Y
         Yz18Bvzv3mevI71q1wIzMJc9V4lHH6n89QbfUuIUoCIdUxx6d2SFm8/dFp9YiSl59egI
         S6GsdAs8gJAM5QCRgLe/zx3ZqeQp0IJUVg19CGaU+2U3ycafcIYeHgjrjTXj+j02/uPo
         eGZmZ1tCAu+cJZqSFMt71Xp1gVpXKm+i76OgOFJHc6DgPl7F9wdEfECGdytYvH5WFbRn
         Xc4w==
X-Gm-Message-State: AOJu0Ywm+29yWZX7Ot8MKR8eW9Y71KHXPKa2xbxPKF22FSdD5VOaLSjB
	+C9HGUn4HQDyY6aY4XrP1h7O3P+5XQ34eESwOk2b91YlMwFiz/nwWqq0MmXY5gbml0Di++SCGnp
	K3lo=
X-Gm-Gg: ATEYQzwO5AxXi4+5dsjl3HEjAWDN/C+E3ZTQwaok+WT6nEIpzeD/Jf4nbFo6Jxrzo/8
	bAympcbaJdg9bQjw0XHk6TNI0IFQPTLMdLZzYhGpCAn5ikzX7UWO3vTj3LmPwCmcd64/cOWFrbQ
	peYJMCS//fWIDvtUkuPJjg3yYIE+8CIVc1wQVhs4MhJLt0LxaHGHmzUrEpbKvm7NwLVg0HkRiE5
	6iOJUpVYOPAb/2/5pPyaXz6jOjvIETal06ekpmoXCzcca98becfidoLPHq0Sg0194h81nv5Yz36
	LPS/eUWf6MD7g76lD54g6/i2A8oPiK8Dio8qeyX2UOGqrQPKBIn1SPJZ4hCIH5dpULsf44V+Ph7
	XWY+iTFKTuZynRv+rQL33ao0Y2fhnOCIHg84Y0SRRlKI2I37f69K+2zvXEwKnMWSutb+FCqRNbA
	MPtkoXKhxboPJrMhT600PGDOZZwVhRZbSrltXVAUN8A//il9C4O/kTX6aym4y3HAzBKg/r7dDCr
	CCvdcBiML7boZDeUFdcsrKX0z/y7l7fsA==
X-Received: by 2002:a17:903:b8d:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b269c9b80fmr50932815ad.27.1775095181703;
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:38 +0000
Subject: [PATCH v3 01/11] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-1-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=1213;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=sHkk34xkCVNuYNvgvLM4yfgwiPvB0kDmMlwDb9gzQSI=;
 b=sWAbum2KtSMvIZHpotQFRl3qPX0w5lDPo0wVXGjdcQZ4Iy/Q1lBj1M1z1kObb2Say/DR3abDE
 qMXRcGAYSZjCwmC4SoKf0troiioLGh8ZBZYI6TTyyS5zWbVHFTQHQ7k
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 Documentation/hid/hid-transport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-transport.rst
index 6f1692da296c..2008cf432af1 100644
--- a/Documentation/hid/hid-transport.rst
+++ b/Documentation/hid/hid-transport.rst
@@ -327,8 +327,8 @@ The available HID callbacks are:
 
    Send raw output report via intr channel. Used by some HID device drivers
    which require high throughput for outgoing requests on the intr channel. This
-   must not cause SET_REPORT calls! This must be implemented as asynchronous
-   output report on the intr channel!
+   must not cause SET_REPORT calls! This call might be asynchronous, so the
+   caller should not expect an immediate response!
 
    ::
 

-- 
2.53.0.1185.g05d4b7b318-goog

