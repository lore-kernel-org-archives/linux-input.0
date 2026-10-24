Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812647;
	b=vaHPb0ky4ooLo+Yslv3YDYUT4y8SvNuyGQsyRXltpNAwEN3sUz4KdvDYFL9jO4V6Hick
	 iMiiyBbW1FECM015kj0KmYlb52yVFSiXUaBlYCXFkwGOhy5YMbPJQPqFjye4h2AIebnPz
	 AABLQsOPRc8FBgl3Y0VEiN3/qUuIeyOkf+jDXn7z/dpTE8KmIK+9FI9p/07QVCVfoG9pZ
	 hwVI+lrxXhObe+l/zWQ6Y1Nh+Cgu7c8dfg5o25nIqATQ1E2F2Qb/6AZPh4sn/teWBfyWO
	 ukbv8mhIV6T0o+24mvNgX2steRUo8G8sNjX4baYc1SjDwJBOpjFU6ewWUrI73S2d9fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OZMDdE1sz75D6sUxXlzqCF8BQygc6BjWQNC85XiMV0U=;
	b=N705m44uZ8gHS7JYizGQpNsgNrXByrH2ocxgTE37dgAGoM+SadXMcYY2gFk/msASeHJv
	 DsNxH+kJpU2q9DzlV3U+V7tpE7f4eVOC0BZSUPmT7R9zfvxrmQDWsfaMsh4/rGIuJwvn3
	 53LQFyYk/XvYM46yGt64mma14nyPeO/3xBL9p40RoNX5596hbyMuqgrdn/UNSXQ1kONAJ
	 //0lADSIG3skF56UkGzAdQwfuQUMSavp0w/t5jilAnyWv9Q4Pbv+7rzTAPY030UbKqvGK
	 HZOS0uBrXHE02srheSivldr/X+Jj7F5RpaAwS/Lkwy7dBSQ0SXh/xU+JCtsL0xjH3OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Gtu0Vp/H";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F55606A31A
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 03:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gtu0Vp/H
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35c76e9614aso2249169eec.0
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812646; x=1793417446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZMDdE1sz75D6sUxXlzqCF8BQygc6BjWQNC85XiMV0U=;
        b=Gtu0Vp/H5EfWSIIaFdMd9y7DYtDlr38BhaEIteYiOBAlHVJ895c6jCEOTfnuMjRiDr
         gb9Bnui5eMkyisoYaH8xLFFDx1KWNMq9FMgEjUkXHXht+ZenwbpFIoJCDHT8zLEmVelp
         AJZ2lODAamK/P9ypcWuohJNCyhbwdRCIJnWBArEhgDYadnYESPOXuRxSMVIh3g21bIZN
         wzB9IqC9grdxl4hXkY/fM+Qjju5xqt55WHV5MBEl32CEyqNPY5FjVJGzCDAwfRj1NHcg
         buY0NPqeRxJLAeI858zPtQa9ceBlv4o2CUJmA6XhlcWWxOEvVxLy+UcIDBRwVixMS6hx
         gz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812646; x=1793417446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZMDdE1sz75D6sUxXlzqCF8BQygc6BjWQNC85XiMV0U=;
        b=sYCG3D56vNvms6OEP5ftCcP0soMC4x54UIOFcrcuZ/VzLFWVlpyuz1AaXduUgumEEs
         pb0EWtfk/Dti4i3kBnB0sIr61q90b+IXHrHXBdAtaC3ieG7VnDG+orkmhIHOlETI10JV
         6ntEwldF/3F5EtJmDQpVxbtbuB3ceqSfU0B0cC4GuKiBE8dg/0EDnuT9jwC/OliZAID9
         oP3yOZkmBEPRze1u+Zq+jnAwFH8P6dE7keYyd2x/NG8QI+uEnuDmf+Q3ol+VREpUtf8F
         omqAXMJWsMqA9m0PXtfS2II/SHxU9iFxPDucgAC2L1wP+JWkghxY6tgoYwUJsMo8ezuJ
         Wotw==
X-Forwarded-Encrypted: i=1; AKwUvBwlUJrOr7Z5seoCiur99vqrHekcQHEIG9etV8W3PSE++lhm6GWKw8+OlUf6Q3z3wFMmmfWR4HriwvpVwQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJTl987aEoHgxl9QsxwO01xR/dwm2wISoTTGDzWZLcKdkTksKJJ
	uz5B4XpCf6cdRyUh7SpvJ/u1PNLlwB+vaNgG2y3KPrG1ell+L9yN4Png
X-Gm-Gg: AYBFou3ZUC5hKBhJnZPBfJPAMRdzyfQ0/S1dHj+3ORitHOISLBZ+sN45xN5yhDobFQu
	hpDa+LmtXtt0DJsjrPbKZSqD+xR+U6mGTFrpdAOk+iFtc5VqHVJiD6J7xM1dQuLYNI/ADwsSVd+
	JyUl+K0C5yFEeaiHj/hXQmgY7ZVVG8yyLXy+rOb3Lw024LZZQE15LAddsCqJykw7g8NzZOviGG6
	N15+o1jixWSdOZYJ2AieIv+OqTD4ZgJrl7mVcbknZghwW5aEy3JPHktOapDEnjVwFLJeP0zDUBK
	t9ys7+5tJplUsw2ZkSfqlgGwcj8RhDEUvv0+Rp2cRSqhTF1quRTfd+GoDvueQTQGsQR0fQAf8Q6
	DhN2kaaGD2WConSf/lk9FQc+vGMlSJ4CmBSlM4yaBKOgqEQyNwsvwIR3G4KV5G4MbmQ1Bj0wdej
	pI/+Hb5CoKJNx0iJpe33/JS+gkfH2qrgSiAmmtmQqkjJRwUfnJoUQruYU9FC06e1Jh+XJXiVqoq
	zTc2WNZLUAEMcXt4e6VAmPYTGxwTw9A1Vuy0l3vKCd1QreLWipH3pCv7UmyLNIoUHsrPZA58A8/
	sVBAB1fB3D8DmgByVhv+DaOpCGapOc0fpjNHaJS+TgKBzgEP2Q==
X-Received: by 2002:a05:7300:8816:b0:369:e930:6bc4 with SMTP id 5a478bee46e88-369e9306c7emr1047457eec.30.1792812645741;
        Fri, 23 Oct 2026 20:30:45 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:44 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 0/6] HID: wacom: guard against NULL input devices on successful probe
Date: Sat, 24 Oct 2026 12:30:34 +0900
Message-ID: <20261024033040.316652-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
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

When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
the corresponding input pointer is set to NULL but probe still succeeds.
Subsequent irq handlers dereference those pointers unconditionally,
causing NULL-pointer dereferences reachable from a spoofed HID device.

This series adds per-function NULL guards across all affected handlers.

Changes in v4:
  - wacom_intuos_pad() now returns 2 for the normal path, 1 for the
    NULL-guard path; wacom_intuos_irq() applies "result - 1" uniformly,
    suppressing the spurious input_sync() the old "return 1" would
    trigger (Jason).
  - Added pen_input NULL guard at the top of wacom_intuos_irq() to
    protect its helpers wacom_intuos_inout() and
    wacom_intuos_general() (Jason).
  - Added pen_input NULL guard to wacom_bpt_pen() (Jason).

Changes in v3:
  - Fixed wacom_dtus_irq(): DTUSX is pen-only, so do not require
    pad_input for it (sashiko-bot).
  - Added patch 6: touch_input guards for wacom_intuos_pro2_bt_touch(),
    wacom_24hdt_irq(), and wacom_bamboo_pad_touch_event().

Changes in v2:
  - Restructured per Jason's review: per-function checks for dtus_irq,
    graphire_irq, and the Bamboo handlers.
  - wacom_intuos_pad() returns non-zero when pad_input is NULL so the
    report does not fall through to wacom_intuos_inout() (sashiko-bot).
  - wacom_intuos_bt_irq() guards both pen_input and pad_input (Jason).
  - Added dev_warn_once at every guard (Jason).
  - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).

Jinmo Yang (6):
  HID: wacom: check the input device in the shared report helpers
  HID: wacom: check the input devices in the legacy irq handlers
  HID: wacom: add NULL input guards to wacom_intuos_irq() and its
    helpers
  HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
  HID: wacom: add NULL input guards to Bamboo handlers
  HID: wacom: add NULL touch_input guards to remaining touch handlers

 drivers/hid/wacom_wac.c | 127 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 122 insertions(+), 5 deletions(-)

--
2.53.0

