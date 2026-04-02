Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8C3328FD
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095185; cv=none; b=mVtiRW6q8WZ0XkO8tusoSpxuLC01ppd+ips22qdeWnByFsjzofGKnCyR+lV/zzt1kOC4sdlI0RM86gLddYcTSRCd1NI4srctbJYs5aUr0IMmdllsYroAOuciO+7VXbPq/lHhsMEc4ngVFO7OAxl2lokO3UuQ8f1JkLrKXIIeW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095185; c=relaxed/simple;
	bh=Tpi0yK/iaLtS44lW6KsA/vacKkKe39WvD034jzj5Q1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyWOAAHK46v+pnsO88S3G774fF7h2F/Zrw7X4PdJS6oSf+S5QsvOKjAPepG/0NcxyMaQAYAxHzYYzglKAGLr8f+anf8/4UM1jTvk2+vIZESghXnZiMbC/192cK+crwOlZ19CwtEy6L9Xf2/WeigqM88E8xOJZ567MpRbVT6ENy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l9wyNuW/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9wyNuW/"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab46931cf1so10497555ad.0
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095182; x=1775699982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaSym8CXCOjXII696jSRn6vHWWlOmeUfwp714NDMznM=;
        b=l9wyNuW/X8GoaB8VBjCO8tdBYvh9Vd24nXum3SRwu6fQJxDlm/CtMGE4ey/u9w4gC2
         lyhdGhqTpfrcZDtYcsz0v2C/zRcmt+KuCg3lOlEuMN+KSh1jnbq9M/JTPr89FuhnHFvP
         +ndaRXJ/LQIDNlyR1IsjvnKRHp8RLbNI1ahoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095182; x=1775699982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uaSym8CXCOjXII696jSRn6vHWWlOmeUfwp714NDMznM=;
        b=KcdNR5gH2HJ2BiUSTIqw+cbqIU+rN+ueOpLiXDTcjXV0cbD8xxEwQTmvmeZVfRbvSW
         Nc7CuvW6PR8dkuz/uLmfQRniNA3ibuTDDRsSlzjuDUCTEvqSxMaZfsRfGQoC3yTMsEK2
         iALCHRd2VAKjM5HYf19uDqnGhHjOHwSgSy102Bg939HKUUR6jQg/yzj0vFRcM8gVcKJS
         ZB+UPRzSyWfbNTnT8mWdAjecLEkAxzfK/vwdR4y5/PV1xdqWHWrNYtIp8ywtwQFVIso8
         DnotNQKd3DinPSt60wNTmU3QPUu4SP/kpJuDW+zJBwiIxWd8OnFuWg0/y5le6cBzC/V/
         hyQA==
X-Gm-Message-State: AOJu0YxkTOieJfT59MoIdXaJZ1rXXMCL1aLU+USPepsA4R6tisfcLtBk
	7IY0UmdwItGaQ1CB7rg9lz4F3wYyx/1/CYQFGFamEB2uumQcAvFAtuKObUP5had0l1iRyowXSqT
	WYh4=
X-Gm-Gg: ATEYQzy8CuxBw1mq/kf2C2mre5c2fLs8O1Pkd45cgz+CxgdL6TYnXqLUsSSyf7cOuQO
	euEUwwmMQutTVx986NvOxkuCmAJQLcSTDh83Pip5JrDSlQb9IGWS4Lp+68lpBL6QO48Flv1ma0M
	Q63McoYiXOKWGPFwd9w3Hu4Rovz+90wTtBG26EObhBl5LC2dbsTEyXWaKF4uIkM2SnRJ9Nfr/WP
	TsK1rFwrqQj+FhphMXjppd7NiJQQysykKUQWLESYV2zA5gWlV4JYI00jSY5NmSJIgC2TznWteik
	SRi5wwVIb8lUEjuLzk4rTxAFFWYBQAFEKQ48UTruoGQtBBci8QcUJ84ofHS1jDmtpWQswWbV4dU
	1SDdHDt7zoVUdgTs5LDxzxMjjksgrp7Wi94FPLKmqjNXVZC0Q5SW4r6M1ExjsDRuyUKP0nPjoAm
	clwOao+JSfIA4g+x6YU92dFXJbOAObdHTGk0ESDYwmB4lA+ga+j/lSAuzL6Mw8lmgUFsQlKZ14W
	yD0P1Lo/bQRfTyO0id5A6g8T7WGYQ6p7w==
X-Received: by 2002:a17:903:946:b0:2b2:5293:f415 with SMTP id d9443c01a7336-2b277d8ba21mr5711705ad.7.1775095182367;
        Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:39 +0000
Subject: [PATCH v3 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-2-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=1402;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=FjzRhH7/ErE4TnsMI+7AvjihWBkT/xpCI98HMGNLH6s=;
 b=u4Lc+txBMvZJgNMm1YnjIU7DFBygkIoEJquBuEPB6zFCxqo5mXw0HAIQJAzTByC+gO06+zlwJ
 t0bqPyaLh0nD1I0sai05bo1y2ot0KK93bqPfmYAxaNKepG3FQdXBoLt
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
2.53.0.1185.g05d4b7b318-goog

