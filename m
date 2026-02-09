Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F72DCC13
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652292; cv=none; b=CaXjN4wrbD8GPccu9Yxqk+N+Sj0X8jkI8C7j1dZmsBMlRS+5CcnZBtpqX9Spg80ECBF581dpNhAoDsPcDO5UKPuDu/BnlyVvTVJexzyEMp+VH1GUoYOJ5eSE0Sg8Gf6eNl7lMPF86Jx++XhwfYZS64LkJRC3DB6EpHsevRZ6zKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652292; c=relaxed/simple;
	bh=Nuidy4VcouerookqpJUzkL+AcBPLi7r0bsVBDY2jq9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOqVaUV7wzdXf3RMPUj82b83DfDGO4vaq1masLlIJgLxbaEGXMnPL3KZY06JPOab25WGhY61WmrXZ1ZEpM0C5TUPBdN8i1KBPjmtKfiyoKc2Eyo2hBn6KNRqScyGQ4D+4N8JLj/F9wvZBWKIQ0j49lGLRs4IPeGs7UG4/oSG4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mDtE9FvJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mDtE9FvJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4807068eacbso41698675e9.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770652290; x=1771257090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+gUdmUa3DqKK9a1+H8JL/5YG5QXo3Jj2RgucNl4lfE=;
        b=mDtE9FvJnoCSrslemNG/JUV8FpBwJRZVxtPzSSxkOwYtmDPvO8S35YX6yFYoxwjNPp
         FKQ5MP7km33VXP1nQr2nz8i4+IZPvcMdfR5LwCGEKNgyIutyxf7P4XztMDFPRWNwu1fM
         1mXOK9Qa+mzmfM7n1ZnaJGmuuw92TcwA/7QCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652290; x=1771257090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+gUdmUa3DqKK9a1+H8JL/5YG5QXo3Jj2RgucNl4lfE=;
        b=tLTAUO1pmS6TNlJ3G5c2SkBawUvjDqIBPyX0AiBW08chfnREeRE1PFmzZBXJJsvmEI
         e1gv1dIdxw6gbTSkb0hkYCHtqCgdbNDAQXFDRFzBOIVmZd8RJjAyCQ5TfRGBS/Lr94fU
         Z51SRSHdCx8lUUC8V4XBh/BsuhhGnIigDmvc7QL1CvKAuPGM0xpdssnVktpsyBLUO+FT
         DKQRKgmIsq3C9WKr1bsYSQJbzprG7i98g/2TriMazeZiiDCtLfOyR1S7GjrhYH7XlAes
         f10JP1faU76FXWDu6qnMjIHvzMOn4eHG85O1SGcTZweAxlJeHOui1+wySyr2j80/B+ff
         nNNw==
X-Forwarded-Encrypted: i=1; AJvYcCUXfaafpMYSi/n0hUbYlYErdo3h33FtVkTJqR7mTGMIafrDiUuTQA1IBVdASenqdYNmsHnlpwl6RdFoZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzBGHZD9zHa3OkF2QS6cpim7jV2wIAXSjXndGeUlM2qVakdSL
	cX/XSrdEaxNUPjnqUo8UIHgoY9ioPe2fchn8zpNWJ2Gya49wj9bI5ks+qadefNAJLQ==
X-Gm-Gg: AZuq6aKEe86/OefP0KFKrEisUxw55A8FRvJxvRndxmxpxU7+Il/M15EFlKugBoQwKvr
	fBLXHJRtbb44bZjQeykkzchdVIRiA2dxSI/zkUG11PHL2HrDjDixqme9817O0wYZK/Ljb6H6px+
	AzFwm01fufZq/vaWwSogjgVfMPzdNI2PbZbwFh11/fUHagS7qk9SyN6pSQapXnzhs1QyeQ9wIfz
	BlWgeNE2Vfuuz+8fsSRuvt3XextTKc96qjJQS1RqKIt7CbSD0xN//FsNL8w+c/ffKp27e3LoBJ3
	hSoGE7iyGVXfGE3Gc/qtKwB20wgljFPhQBKcxKxe1RMFIma5I9KYz3kkoa8u3O6tc4OY7zz4iND
	TF7+K+QNf4RghD++nHv19uChWdqbaXcCAWrncFT3a9ZLDB2Zv1zF+AiII2wvgEZZrSmc+N4nqUr
	1e2gD6gPsXMryukknrUVCOzMExuw==
X-Received: by 2002:a05:600c:6209:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-483201ee840mr162312885e9.14.1770652290202;
        Mon, 09 Feb 2026 07:51:30 -0800 (PST)
Received: from balto-ws ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm501929835e9.10.2026.02.09.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:51:29 -0800 (PST)
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] Input: cros_ec_keyb - add function key support
Date: Mon,  9 Feb 2026 15:51:26 +0000
Message-ID: <20260209155127.158813-1-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v5:
  - minor renames/cosmetic changes
  - dropped the *_key_status array, tracking using the idev->key bitmask

Changes from v4:
  - just a comment tweak

Changes from v3:
  - implemented fn layer runtime detection
  - tweaked cros_ec_keyb_fn_code to return back the correct position
    code

Changes from v2:
  - renamed the dt property to use-fn-map, dropped the example
  - added few function comments
  - added a helper for obtaining the fn code
  - reordered, dt patch first

Changes from v1:
  - change struct to short types
  - refactored the fn key handling in its own function
  - changed props to use the google, prefix
  - reworked the properties to use an overlay map rather than a
    dedicated one

Fabio Baltieri (1):
  Input: cros_ec_keyb - add function key support

 drivers/input/keyboard/cros_ec_keyb.c | 167 +++++++++++++++++++++++---
 1 file changed, 151 insertions(+), 16 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

