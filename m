Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B83DA7F1
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320385; cv=none; b=M462ie1izl2gnUu/9aRcvEOWsc53gM1GXVJpnKEHOWa3inpaaEe/EJv0mnHWFTSvgZfIwZ5EmTtCFWRoqUAzzA1Wn2SJyzJE4RdF5HGyPQc9/d5nvoDOCBpSyZT7M8gEeMbBlpHkFrKfzkMpo1m/8Twx23gcCbfnuZox6r4NCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320385; c=relaxed/simple;
	bh=kEWxDoymA7MHszQKrmZjRfLNtr2Di+jrlgc4xNhUAG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwCKIK8/cfNdCvZxLnrpbh3SDs0tn/Bvg2DDv/7dVm9rhXfhLujWYuRuZI4W4KNk6povdWC3Q+IOqX437r46aJO1hmUvNRGk2FYi+ttUvuVNxibw2KRbPfhFt2JGvF1INf3ayWRQOLHSvn9yxRJJSqOiNKC2ErXRvgswsPpUFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6CnJ+yy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6CnJ+yy"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso721023a12.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792320383; x=1792925183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDzT7tmYvszUfdQMD+ETbxumnaTj0Q1RZIImeY9qlcA=;
        b=T6CnJ+yyrmUBYqj1LyDWTEjptLTfUjoPYPmWrjXrAbLgw8eOGkEmJTbrOh/mvx5f4S
         HWfAsRZgxr1J+IcsGva7CogW570a7Qbj6RrOI4su11YbSY+vCc5S4Qxq1de1YbpqD9Fg
         FVi7UvOJQ+1C2ssz4ZwLxHL/6ENZBWphDDYHRId01zVDZdcT3U8JvU0L4ZJsMz9qX9uA
         B9cULbcJ3qVj5qCpfxD1/JBBkhWf6o61us6l565OC/+MXWekWjz5F0tBObTliBa9+mJN
         +oFsF5Xb98HB9tDdmxzs1kaHqKfSG//WioNgKWw8QW6iU+bHZ5oGpjThooQMQhCMK7LA
         64Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792320383; x=1792925183;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDzT7tmYvszUfdQMD+ETbxumnaTj0Q1RZIImeY9qlcA=;
        b=LCJOwpu9QdEMirselKVH3Sd8KtH6qALCpEmY0ovmpxu86/LCVs6Deb22nts7bngAAV
         GeDP2Y8mRHH9ZOsewLyP/40zuLqCW9fXT3VD7ZfV02yVFfrlYsuG0u/2aU3La5ElE3sq
         lGPII/mw6hcm2s/B+dT0ecdcPIF1YItgnMNS2yx+nAjZhErE9DVllv04V6WVyBSeqmdA
         3iqbkGyBQRGTJ1/3XRgcmp7h1MW4Edpmg0pGW5De16hrq8u7rDY8hLgHlV1sHFRcey1a
         Grc/c5iNFNoqdhpWoWIQNtiQSSfwR3sUCPu/CLtw1Zql9KzMVa3TQjAY5vk3qzg5jZqU
         6/Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxIdzxnTpUfgJGeVzytvG0GyVWMYdsuYAxNOOthDgsphrnKvmIyv/XU/Kuk9r1JpDlwIZ3gDfw+mJcYyw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKliR5lg3q2K9Yw3ub/oxIm+JtitjT48xfbFKVWP+A+abdKszvs
	s/YQui9aR00O2oSYZu9Oes+wyqKcIU2Yh2R6CZFK6tuoK9BU+pV0pAta
X-Gm-Gg: AYBFou2fGJ4x/uOVT3nsrmirwhOB89h97muUK0kgqJEZdMAfQ+KH/yXBawTI7CSmdZn
	nTpS0qxTph09RpX2uEuW3jhRkH6UeIFsG22VRD4NY5jrk8Ar/RLelzv0chCFMW7/DJ3gwwF1FYy
	oeobc96yZ8ZGDd49ex7vTKY5ffSQvF81G1SFA11/BMsXepkoFi6m94nhxNJh1WeIgZjYJzciL8u
	oJY2x6L98OqGptIVcBFo3oDcG4i0uFSTZrlu6kdAEWHD5XxH9uWyMVVUpVrpG9UKKciaGUIsfOM
	WG/4M0nDwSmrzTKy2mjbXnT1Zr6v9o97xDI0hiNCG+1Hs5LFdUSq2dmi13h9nxJgRgDFgwUrN+F
	O9My1y+W28E6BBBS0B397+f+j8VWXRqKo+RS4fLeXJmz5sPhofGFJCitSc+uba64Ziyky+JXQNZ
	iedeZujr8F1xZs5EWR1HjbONVGEmXT/urkZ48fBlEa2I00XNH/3e6i5/cevf1bvgVtzZxR7Z/Tm
	dyZ6a9BLB9iJvPjKoUbxss=
X-Received: by 2002:a05:6a20:3d07:b0:3e2:490d:511b with SMTP id adf61e73a8af0-3e2490d5900mr777312637.20.1792320382944;
        Sun, 18 Oct 2026 03:46:22 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a33681sm2949085a12.29.2026.10.18.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:46:21 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 0/5] HID: wacom: guard against NULL input devices on successful probe
Date: Sun, 18 Oct 2026 19:46:12 +0900
Message-ID: <20261018104617.743771-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
the corresponding input pointer is set to NULL but probe still succeeds.
Subsequent irq handlers dereference those pointers unconditionally,
causing NULL-pointer dereferences reachable from a spoofed HID device.

This series adds per-function NULL guards across all affected handlers.

Changes in v2:
  - Restructured per Jason Gerecke's review: replaced per-branch checks
    with per-function checks for dtus_irq, graphire_irq, and the Bamboo
    handlers — simpler and matches what each function actually requires.
  - wacom_intuos_pad() now returns 1 (not 0) when pad_input is NULL, so
    the report is consumed and does not fall through to
    wacom_intuos_inout() which would misparse a pad packet as a pen
    event (sashiko-bot).
  - wacom_intuos_bt_irq() now guards both pen_input and pad_input, since
    INTUOS4WL always has both on a single interface.
  - Added dev_warn_once at every guard (Jason).
  - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).

Tested with uhid across 27 Wacom device types (spoofed bus):
                   unpatched  patched
  KASAN crashes          17        0
  probe failures          0        0
  hidraw nodes           26       26
  input registrations    25       25

Jinmo Yang (5):
  HID: wacom: check the input device in the shared report helpers
  HID: wacom: check the input devices in the legacy irq handlers
  HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
  HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
  HID: wacom: add NULL input guards to Bamboo touch/button handlers

 drivers/hid/wacom_wac.c | 90 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

-- 
2.53.0

