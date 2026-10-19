Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436492;
	b=NwE5Ux0M6SFSvikScHEy7o1XknV3wdu9HnlgEYYyMiN5BExKJcdQvcqR8ISFWLrS3Ywd
	 axxXVUoWI/tGSMb4UYt9cBLHFrgaPZRxVxroPdZubis4UdHeg0zebUnYq1OKWuuDrNi4g
	 Zjy6bmG8oyzqlJh802ukQYnOw0uf6Nqbacg2TgEzO0F8YF/6zTnVYNshfOWGYNnKLpbHp
	 6tSxiv0nrFmmPejPqDoyCqU1TSpM5IloknAfZ7cNf8oClo0rGyVrYlT3f2aQWXiN28GjT
	 dISo4eBFJ62PgRRUKGnUvxShdWQ72Xizrs+k7I+EwpCCXLIHGVRjVPD2CbCpycRA3Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
	b=psJDO50iMNmlPH97Tf5lOf+drpSqlcpKbYskTVnwCuxf6xZM6EpegwCmuFoFVr7wJjKm
	 6ZY49BCKSgkuWapoRaUSNuEFce4hD5iffyJgD7oJh5a03SAr0rhEdlScnno8qsIaZvfaQ
	 ORnKyhMi4tMKoJMv2kFluL+TLiMnqs65anvsFGEwpAy5bJIRZgsY36b6tsBc12pYsBw2s
	 LPYh5dTFqsWRp8UWwWyeKi6vYby1WahkH9+htvVmFEVItK+7JHTFjaWZH/QvzDfxNxPly
	 H8reGC7IXXEvWRQKMm5HVrHc226QvtTeMEtjOeD+sSdSk/+K8a+MaicePL/UZtFfGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cRYpaBTM;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF93606A32F
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 19:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF93606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cRYpaBTM
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e8246b13cbso18671375ad.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436491; x=1793041291; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
        b=cRYpaBTMVC7XVXSau9iQnNb982otn5J294NaNijuz0X4dHP9n0KRgvYCrOplTS5aBb
         QNtAHSxHVdqETcgFENkX00iuJS60yVQO36lr6lyNUs5Ej+Qd7WqPb8JUoXieKTCCu/1R
         qJufzAwS5wu0jOzMVbtHU+oqZexlZf/2UYxKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436491; x=1793041291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssNnql6T4QoOjXfpwZ5XX0q7jJl54eqkrFJ3D8Kx+tc=;
        b=HuLjS+HH2M5XmGeUAWok3SjCDjX27fXZp5My9IAcUspP6CjwahtAbhENkGcRoEUFr7
         +H6IsX1Jgq0+w6xqY80Kgv3pPBeCvtngJxVmlTOTPGSp67mEpQpjF7WXnqF7T5pP5q5O
         m7+d6QT7/wO2zE+dkkYvZmvRZW97YaX1WVi+nzV1nfSYIR2EzYa3sbCKl/6wVtnj2zec
         9qg+ZeEWjY7OIeaEzRzy9ybPMrkZ5bVmnW9S6QwPzTfZ5M2vmWQ0HJw6B9H/vHnBIRLS
         wnWiQeDG9v5fLTeqMROhs2HJ3cmGh1JkSCT2py9lHPM0nfZ3tb/smL6Vnwdcs5x64uIK
         tNnQ==
X-Gm-Message-State: AFq9FYJgQk2IQiCnrPwlODcG2hp8iMYJ6sg9X/H0igHqoojYvaHZYEb0
	piDQkD6FGaneBGxVHGLm8eIt/Pcs0pbnaYHt6COH8IyMy7gVqXBqNZYnPWfz+Q+TfQ==
X-Gm-Gg: AYBFou3wEMb4i2L2glIxgSeopazhqcWcN1+7JufJbsf9yqNAgWpvcniybp5+RW/DoCY
	9OzhUWe3MkGTgiPXS9ujJeaWmPdNJDZynlVGDtirbP6oCnkwBq1XU/vhW6r4FaIjcSaWTGdtdxm
	1r0u4Rm0QMlutoMRRIQ6vVqNRtUl/VCwds2viVuQQuLB4abScQf/t3Lkcle/5y4OcaM+u7z3j/W
	evDvnrNEwyPAlTgIT4RwGXSJTkK3+lENoRX0Jm26VtUhi+jjE61yxatMkdRXRSBmqMLd3vjKyWi
	gT/hFViOvulz1VrG85qwosJ5ofHVsr/fdE1LUW36cK8KQmDizgFIb/KiSQOzokot5nAkof9Tcvs
	Ig8ic7XjajCCeeatHApioQuTAOeAf4Jwx/4/E9AVj/URtpoZGnRqee9G4iqIJF8wMXzNUOyPN8F
	Al0rDtZOeEMlVo3eJi5AvJU1wcDQYhCBYnHRKdJvj7f6g6hks3lSqaAgHC01ZFUSpdsSJnlKDob
	fwRwqd7aYXZdkOkh2OPVidvzZKNWhNPagRiGjOvJUEPurokPDs/Wns7ZaWIb0InbeRbCIiCJXXB
	Dk/A0A==
X-Received: by 2002:a17:903:22c6:b0:2e4:b37a:d583 with SMTP id d9443c01a7336-2e9a6d367b9mr71528345ad.61.1792436491064;
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:30 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:13 +0000
Subject: [PATCH v6 01/11] Documentation: Correction in HID output_report
 callback description.
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
Message-Id: <20261019-send-upstream-v6-1-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=1212;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=3F0PUGRvwtvEKibOIad7sMQuPUN5v644d10H48NGstE=;
 b=oNrr9I9JcmB+rovcLexc52aW/JcbxtVxrpwrTYSTNrVT9zSgQ72OmH3qacvYoupyivVC/2ZPi
 FOYyp9GlaJNCdYZ/PxNSjL5MCAqvSVv1uPmyoBi0jqFRO7HCzmMYTCH
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
2.56.0.212.g129ede20d9-goog

