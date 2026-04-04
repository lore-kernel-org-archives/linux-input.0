Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB44C92
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775309879; cv=none; b=iy5bpetw4Ha1GYMmXTnOywJAhEopd4Uy12HrzE4aTBAeSRvIP8TkdHtcRlmo8oz7OugGdo93rZWA+9HH+a5TT3EK3yM2cijQZcuNDbQU5vl53scPnoO0IpiNuZdLfKfhkqH6nfUeEr8/yykqOyUZcSMOcm2aAFjtmuReU8cZomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775309879; c=relaxed/simple;
	bh=zPBgSdFmJzxodButczK1sWPzU+PemhkhYTagS+9CElk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFCV4QQBCmB+zAk5z7TcmGkFEnTbB7uYri+kf+8TLia3peOnqW+0hrJN9f2mS+v6lzmo8VdSN5vqC3vi+K2VNWjEtBPLfr1XTnZWyalf0RZDhjU0J1j1Ur00xQUPbUO4eCORgcwdm84mWHDgvG86DKg61I7XxD1CTbsOCMP2qYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4G0CNEE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4G0CNEE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so35483215e9.3
        for <linux-input@vger.kernel.org>; Sat, 04 Apr 2026 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775309876; x=1775914676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPBgSdFmJzxodButczK1sWPzU+PemhkhYTagS+9CElk=;
        b=c4G0CNEEW15SQJ8jNgu6/8umDOUZB+1if/2/WMtheHKH71R4/yGXKAB23KU7pRHh4O
         gXNlMGJSWRUo+bpXQHskjyKusDRioC4+gHohjSD1I/MsHYlEumNHFPZMf8AEJp3Uaorx
         gvQUEGwK+hZU/h108IuKF60FiELMt6REjgu0rgCgHdqeWLdEyTyVXH6Qm2tx+KeMhzKK
         9fIu87V371Aj/Yn5m5WR2ERGsI8TMSkLHgmqmBX3qCPnlG7CB2diWDM0tvLSO8NSfqsa
         EiWkIVMhU39s01ppXpbeI1w8SlESGOZ7sxMW9L9AmBmVtIdFok5iDPTSAM/5xn9rk+6s
         RcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775309876; x=1775914676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPBgSdFmJzxodButczK1sWPzU+PemhkhYTagS+9CElk=;
        b=p+f/j5dIB2LoHKm0pYolAKvCnxQzoSuK8BQhgYMwb3yQ+nOxyBUKBSScB6TYKBmefQ
         ZlHKgSGhR71/M0UvuwLt0ScQQK+j5BrFJlaBKHPKNc033VJyGVUA223gEVjNEtHkQHK2
         m9N2IhOAve8TokXeo8LtkzGiOVgfCMnigZHU2KoK0kxyyLWs78kP4hpZ7wsOxpD9oR/Z
         swr1AsWbvUFAHCVf3AYUx6FcijtvUsW3voZTj6xeETN+YwIoeB9j3CeqSlcNc/LnOQNj
         ptFv/ZU0Av+DQvCodVbgnxa6SuOpDmpapLB0MH2hfHvNHZkvmfx5ptmo0SgJWXHteO6x
         msew==
X-Forwarded-Encrypted: i=1; AJvYcCW0VOg2o4dWsBzap8Pbjumy9hHv48BLYzbVWrtROGJs0Sq+O6RSMF/z8E1cBsjFZAARq8XlB4MvMxfKtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sU8lfBUKH+4MKM+BW6rWKZk2gMooaKg7pYo1rLIQlpAFpi5+
	gwQt1du09xWuIVKLL8sPE+VhXyKi2WDcGex80RJvllVnSltB6YZMIAQb
X-Gm-Gg: AeBDieswn86f/4xbB5yg+1B6eDVL0JrMm5nuq7ZwmLM3T/DG71DsCAqdoNa/p37jDr6
	VD97Ame+5LuDKrYlzw4c/urx6Uj26RCQTc9p7Nu+JwwssfaXGh4aSjdZFheywUhCIH1df1RLfbI
	nYU9CsZ1A4IYC2WpG5zQA3ptT5L0FgTHInOVKpqigNgao1iGSAnIDphEMtOfs1vZ/xtQEtyBZM2
	klMB2x/1eBCw493yQlICooAgs7t9mU/zI9jPV6OZumVoLXj7SOrbTzy7fVW+OW3g9vj3dp+tO30
	uXRWxA2KRiVSdl3DtwrRZixJcBUINOugMDnACBNcOhGN3R0S7R5SQob71qHaWZk54TB2gNYITEA
	0jw3mpz3V3nmYmoxqVRJ/ndFgJdRoKCLwigrcm4zihuCT1xWvzUnrecnwla45Pt4isklklfnuET
	rSzhz89cqWzSeiw25vjw0kqQ==
X-Received: by 2002:a05:600c:628e:b0:485:9a50:3384 with SMTP id 5b1f17b1804b1-488997da325mr93797135e9.25.1775309875418;
        Sat, 04 Apr 2026 06:37:55 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c7:268c::3d7:32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a706062sm239655955e9.9.2026.04.04.06.37.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Apr 2026 06:37:55 -0700 (PDT)
From: Zubeyr Almaho <zybo1000@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Zubeyr Almaho <zybo1000@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH v2 0/1] HID: add malicious HID device detection driver
Date: Sat,  4 Apr 2026 16:37:44 +0300
Message-ID: <20260404133746.80914-1-zybo1000@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri, Benjamin,

This series introduces hid-omg-detect, a passive HID monitor that scores
potentially malicious keyboard-like USB devices (BadUSB / O.MG style)
using:

- keystroke timing entropy,
- plug-and-type latency,
- USB descriptor fingerprinting.

When the configurable threshold is crossed, the module emits a warning
with a userspace mitigation hint (usbguard).

The driver does not block, delay, or modify HID input events.

Changes since v1:
- Replaced global list + mutex with per-device drvdata.
- Removed logging inside spinlock-held regions.
- Moved VID/PID lookup to probe() to avoid hot-path overhead.
- Switched logging to hid_{info,warn,err} helpers.
- Capped timing sample counter at MAX_TIMING_SAMPLES.
- Renamed file to hid-omg-detect.c for kernel naming conventions.

Thanks,
Zubeyr Almaho

---
 drivers/hid/hid-omg-detect.c | 435 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 435 insertions(+)
