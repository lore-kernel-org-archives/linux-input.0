Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803114;
	b=TYFtm7yJ5BY60PBbC5Rp9jUXXKrCJrMPqbdKfpn82fCt8LoJqAjX3x9i9fgo5ogEsxSZ
	 jSAI69v9xhix7srQAIwF3Dwoobl1JkaMJHveftcEJr7TzZ9xuIe9ObmjqtFYmXXsWcOSH
	 foltr8kIOH65BZOFoGqMZoXBdTbSojhCk0PeNuFEHy6EBSEHZNgrdIBdNpRC6SfFHmGPF
	 ddS6SdB+113NSCvwkQamc+ATM09xtwYfqDjAFrDmqXkkwykxKBXj4+bbilUrlmkeV58Z7
	 tvFQ+hiZH+W1eAKCohcCZHQ1y5gvtT97bl2rjlinoaFVJQfwtPC8sluSeoOZ8dSYvlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
	b=OFPZuxJJ+4qlo+AcnO0P716DgWDaoDqwR6BvSlqm5cTW1tabY+rzNubQKreyyYGVyCZV
	 1V+meN2Lqwd8JrQRba9BdtxNyP5iAy62XOlLLpHfSuFsJ5Ng+3quKAYXfiLQN8WqlYCvO
	 2IF9vJMrjQtZ488hXYaTUepf2xiYJH3qyZAkj2E+BxXy7KPZui0pV0OIvG1TNwntmd4op
	 Uc+TGCUlYYiwK7ZG5kph9bQnu5WC3IZlpLtTjiV3qMcPS5HugWZHqz6Ib8kLbBiLposAc
	 iBV6w4QNVB7hmWNUyLIO3by9inVITR6SisIn/wkZt9wGKTXLMmcw49YJOGfk3KA23gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F71mQzNN;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000A606A331
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A000A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F71mQzNN
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2dd76b1361dso7696915ad.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803113; x=1793407913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
        b=F71mQzNN9Df6I/It3i/2orNrHXqbcP1PQC4xWxfUZUv03/GeKMX0+yP6pW/QSoi4Ii
         ptvSZ1Z31lTqIvQT+c2UUZ4XLuqeRYPIgHONPoesz2XCjoScHRojFWbuVAMtryozroII
         lptbybUDhb+BfNrIIQ8CLpLhFa5OgZPmiEOrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803113; x=1793407913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
        b=heW9df16SmLfI33rI1n9oQr7AqWQZF1h/NiIjF+brV4zdX0mj7G2v2A8eJFzahjF4f
         aJPDtm9tM178e1bz2XRL3k06t7TIh+DkUc/2m6ZzLpCNLgIFofTIPylKlhYdJO7ZLJpH
         CwLsXfLvOiAsB1HmZDnrWmunwCu9ZRDDk8Kx+gbfIRjLY5m5tsjpJL+eaiDps8vRv+nl
         HRnbrIHtYMfJFv3Ao6hcMqRYnhguXIWMB93yePKbWzJdcf1W0vtQg04Ni1UD2a/Qqllr
         ZaMfpuqiL7m30P2hOwZaFTeUPdlPsEhY8u9NNziu00oqDlIImVsvrr5B1qAlQwmPYRWn
         DjOw==
X-Gm-Message-State: AFq9FYJNfKaJ85ief4KlHCTaYjv8UmtL5n4/N6XxmbC19s52E4THB2O6
	oexqO/J0emF84dkXGBtrcxZ45YRC0fNwxXRC4dIsM41XvGHXeYebBOlBFiQg9bS6kdfdAcbAUOY
	wJgU=
X-Gm-Gg: AYBFou3V+R45MkOkZcgQ/Yc88uFA4+p14q0/4n4CWo/hNTFnCP7M3k+vUmM2M8de9H6
	7jZ0WKDLnQ30Gl78Dwl+F+71Y7eCjxyoveCgXqACth+l/lpteSElqSm87wyoclyV0sEB4uAbOc2
	19QBeU8Sds3AMOi2I8OqM1e/TsMX0LCKHlK6BGsUxcM7eY0BRAiOyyXY4lOG1tOPot04gX1tyk1
	0y9c0/p+0WXCU7V7zocKfXOlkK/rbt2cMHMfOfhTtLo3quLBzH7RPa8yl0uk6Mm12tJwLU3+3zQ
	3deRuw8J1/rCaOtHzxlRFYNSyCAyIn7E+59ezLoXRP6mC1o9RlSunswaZzXhDYsKfFUIJKiG9RW
	/NfZVTUGQotekC0vETxYsWWABeo3y3s/wg22MgnOfyd/PKkxsgYwkDFacjOLYA0GSrEBMu7RDQ4
	dCsQW+756g4eb5OPd+W+jlt8gF0pXlJuVHNXzVy7Lyco31UIR0hOPBeQ/mfbfMuRKrGNMO1PAmN
	DSORb9/fikdaToww7tfhO6b45lCUJkkSTpX44ynm2DEcA2pBuupydRidew6UBMGq8c9P7H1xKB/
	+9wPP+xZczbPqc13VRKP0qprx+sX/gDCPtAt2+1Nd97zz1UZ3KpqhGHqJtr1hJc/Nh0eomFskR5
	qN3lXAXJE
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3ade9b2cff5mr812341a91.1.1792803113127;
        Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:36 +0000
Subject: [PATCH v7 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-send-upstream-v7-2-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=yw607yxfhlGqzMQvUei0spNkHE3rjdhJJTsFkZ74pk4=;
 b=KYERMVr2ZOi6iWqsiLz616NCWFhyAhngzW+obBzlRREHTXw7r+si9gzT5hauuQa2QoLoisRF4
 r+kaho6ZY6bB466JTmNpULLdgLk/5/3ojuz9VXHF+5kjPJhrFfcp5yo
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cd..1b9dbb7515ad 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2373,6 +2373,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
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
index 8d17b741638c..45f713fe9982 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -821,6 +821,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.56.0.257.gf7497c7d27-goog

