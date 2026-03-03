Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9B373BF4
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518428; cv=none; b=cMXWgo2CxHj46Jo1XOiwoUGOm4RumjTlFtsBtdkJBrqnFZAsIZ9fa2d7czogVjHJBVyBYwwNohZeED/bfan1GZ34tPRe6KWa0c0NDzmp2izzqopaPnb21unbgU7JJAPoWHLXZ7Bltbbxw4HwWayOCMIu2+BBEQOQ2wqkpQwYK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518428; c=relaxed/simple;
	bh=G66u8aauHLh3hv8Ltv8yWkfXW+pytZrpTmIScPLSZyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Znihp1VNkq03a0j+W/cxHlZY8TCK8ww9r510Y8ryfU9nZyrp3VNoELM8q4fC23QcedCZhnmZTnutarbaKF5k2/K6HZfRrILl0SsHNJVVFT37ApoEyva8dqmSFTPXNu+VeFsCT+EUdToPeswwFKEk9VlenrWL8eRcE23dT29xoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YB5gyq+9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YB5gyq+9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9516a653so22126715ad.0
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 22:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518426; x=1773123226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBLRd0VVPT6JgeA/gmRFgTBh/C6/jiLo21KLSX9AmXs=;
        b=YB5gyq+9Jx/lm59QV8g/z0+2iozkEQnGdc/kAIsB9JpJTq7as0CQs9EhfBvcGCpD+f
         kTsyDpnRDmBrpTZ2uNx4PYMfFz4jLPCFTlgIe22H0kFOhIaoMzn8fS7Yht3rXY+Km7Ow
         uI8hKu6C18NFhyzz69Q88leyNI4L9GPnKdSUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518426; x=1773123226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBLRd0VVPT6JgeA/gmRFgTBh/C6/jiLo21KLSX9AmXs=;
        b=dyJvujziEMSdn7mNYyoyWj5Td6fEUXpcpzs1Ij79+B8hMbCB591Qufope0/SVXZBM6
         94XKuy9Qut/OtEj2wph1krc8Dtbt2IvAq78G6EwfvVAGJc7PMH8VMFKtKjXWICt563wZ
         P0o3qII4LIMgJdIR7cXg/VCXbpPg8zbLqqSUPKQzXPZCxBizwnH+HF9aD3GkUsoOLOIM
         NvHapHbcVNlZoSr5N0XM6XxidXsxDh/KAPbi9DqMY0h/jtsGybT6vDYQyN6hwnfzasIy
         krbF6RyeBZj0gujw95Q6RtGZ+wSEl29jPBq+hnBbqUdQ2QUbtNW5pRji7vvozjdTzsxd
         o61w==
X-Gm-Message-State: AOJu0YzRQkaljcbW3ZSoWPWuoGyi5M707/nFKpu2VHeH8knQ8kHjVCyW
	/4p8d5W4VMk6/a4iomuiaB8rLhIqDTJVX+ugNu94EpAySRyKLlcPs6a4o7D9Wi62nw==
X-Gm-Gg: ATEYQzw1AzhUm4YW+BhoUGMrviMT7+THkEZoTT2kOOCpNAjH03sQdvz3DdHmVyAqNX1
	IYseMYphjHrFrMUn0dAYtHlXkiX4UYaaj0Ra/gLrIEZz9hDzmEtvr/+rgBGZaAxRFA2OhcCxwmS
	1espCr2NqL3qHlTk87ZsEEuCJakAHzL1Fwoo7H91eK6EFg9FX1e77O4wa81w9N36UgJddhguukL
	Lxciu8Mf8T5M3dqJzPpo8iGRuM1ro07H5Jnt909me5cQVMZzL7MtcSKetj9N0ZI6hi4O3JEfJch
	pbLE8fA4O3t/gubD5e8VFVXpg+7D3Rd6arrhZaq3zVOYiM0FIJcLtYsBZLRhurlGVsF4qKu09qX
	NwatC0Bc/oaCmkoWjPhZl2UbuCuAj//cXPzA1udREUf/7DGTuwaNr+IkXebkj7WhZ30fsNzjCwZ
	7R0I3bcv9lmlIuN+EpDLluk8I8fm0G+j0HSi954RhAwkr9ILcLv7I/abp0DQnwGqq2YnNX2qekq
	RQQqIxGUIFsGNGVT3+e7Ski3PXpKwutVA==
X-Received: by 2002:a17:902:f70f:b0:2ae:506e:4711 with SMTP id d9443c01a7336-2ae506e4abcmr61194795ad.31.1772518426248;
        Mon, 02 Mar 2026 22:13:46 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:45 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:12:53 +0000
Subject: [PATCH 01/12] Documentation: Correction in HID output_report
 callback description.
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-1-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=1154;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Ko4HAge31pJ3y5sK3I4VHU62kcrFbomkgScSw+0vFnc=;
 b=i1wJDOCOTKohS8sUVAT9KTdbS7usX9DiYzDm8pdpDiH1LnyATV9bgGB6dBKN6tIy1Yav+kyUU
 1E/czgHhZrsC9IXUbBdK9LOimEy3qzdp6R0G3SqQS+y4oZSRJt3mGxQ
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Originally output_report callback was described as must-be asynchronous,
but that is not the case in some implementations, namely i2c-hid.
Correct the documentation to say that it may be asynchronous.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
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
2.53.0.473.g4a7958ca14-goog

