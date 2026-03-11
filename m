Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF72D97B9
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264709; cv=none; b=kZqcxwpuwcKbLXZh0D3xx6X9hO2XKhZJzrIWD2U2RRWm9AcGpH5E8FjvWvVscuQhxme5ZDfO9agzV1S/CbCQw1AzAvmasBZJvLTB5DhM79mwu22QMRWdSNDkQZ/kYVvW/lvNoF1T3AaLdacjLkXmSWMlHIM7iTPFYwj+GdWbHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264709; c=relaxed/simple;
	bh=IRq8bUEHznQN9zqCMwpaqY7QqfisFyvKy1SMien43QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1e1Cno4N3Xg4+qtDjKEbjdkESbB3zSrcJYFQbNYhtVLSFoZUG1erUEgZR0D3h67D1CEWhxAC4Eb6gdNMNHVxffzw8CleOdhEnkVNyV7MCKhRvTYR51BpD9N4E2pWilRdiHMHHJ8GTJ7A9HYuXg3e7IyAMfPN5XygAuryGlG5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV97MpgC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV97MpgC"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so243138b3a.1
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773264708; x=1773869508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuih9ShESdPKdWFjHzmIkdBNsXsUSWpB4coqIVUXx/s=;
        b=TV97MpgC5vAbV4k9Ff2pMgrpcbTZ5guFxGJNBYSYmIrPQ1Qe+dw+wW7rJHthnartis
         1JF5n0NuNw5fS/MmIxxaAwJ55h0Ow1dwAFjnpxZiedMBML1x5GDRfotrYm3iF20Sycfl
         Mu8ruC1+il3EkkWrOtZuOAmMGX2LrZ9RqN2CaVmgtCxPI/0ergZiKd0rmF1WzRjEtVnN
         WmT/bn99zLvYebI6DuvvpNxPyEnxhodu3iHajD/BhGDM8mJtXuP0/Xg0OPnsMUG/gCZ8
         qVG14EqIexFtjoyFdZMesIj/qxoEdNjRgM7Lir+B8lilyAnq2j6gZctQD4vEWX2l1+7l
         a8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264708; x=1773869508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuih9ShESdPKdWFjHzmIkdBNsXsUSWpB4coqIVUXx/s=;
        b=Iq+LsogEd2uiSYwvX6UoPxQazwFk5i2FEMVY1bL82Legtv6WQOj1bdRwjD4vNz10/c
         K/Ggdt7xUFhLa9sUKUoN7F7yj5PVleAJuVx/sUReG8nDeUoCn2zBeB3xvZZCaAcbcOM5
         gsfdcvOCFkM+PYKZVKxcbskkjSxgrMKZskkSzxO1loKZohZt707NwV0ayUCgI0S1YZse
         pXqrULCqkBbw7ac0xxdpho9xrrlcYiHw/ieUR4bX/iwh9rwLd1bMy8639tuHYEOq9fZ8
         FTkOFNuqXt8+iXzLUZPj+xh7eSNLfduC/cvK7XvU/QE/RcXGHO3mdh6cGGiHxh7xsMSl
         MALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQAS7iiFNA3JpkiX3w49BGtFaMuzMfKpjZ1wSx3VfZk+geiY3s7rLpc0QNir7z7/clkUFduqOVUi6/SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHthzULctIkRwRkLdC6WqvHcYkbTvt+xhRQ67kmic6stgLlgg
	OJPi/HDQPREAle6wfoGczYCWcB9cteeoSorm8sPEUC5gVXkPRf9oEH7s
X-Gm-Gg: ATEYQzx2jE7Pom6ILyK77Oo1ug0xI2JfYLuhkzv4Zkk/y3JplJbMAI3AazHC1bfFuXE
	Ul86bzkUJMV6mfZL668MCHjkHvv13Gj8XR3RTwmpwpEFXendwWaaB6DRshSaYxzFFjXNAD2YGbx
	D8kWSWqvwuv5Hm+9nqDRTNz7OIdcsK5bZo2X45HKgrIcSilZCjWku0Uy/6TOI5onEiWuBBXX/Is
	BOkfXTidqM+ODu5fhAkatRX8GzyNluMQEJqQZHSdelS112Tv0Ryd/jr+2l3rW9SG6oWOhMoqoxa
	LADiAVvcrWqLm9QEKxspDoT5Qt4vpZZS/pqANs9IOZwG8QNcCKPNyuFLC23Pamu+mHXB67gc7Pd
	o3/WXvd7x1WePU13ipXCZW0/pDwRBicmimNtWGKiLMmMM2t76+CVujgR0hhLC1vPp+xSTo/OZ7S
	mucawFNY40tZkoeQc+7rh/pUc0yfHnx3ZfZfXa6GTvpND0Kpiye36r7wEQ2moQyz6702cJYpZqB
	BpiyJxtXKZA+HEaZO2S92i7xsZWxTZ+FU4KL2nPQqnjs3rnT35R2Q97/fcdH1hGtNg=
X-Received: by 2002:a05:6a00:3687:b0:829:8015:1637 with SMTP id d2e1a72fcca58-829f7072a12mr3448629b3a.12.1773264707581;
        Wed, 11 Mar 2026 14:31:47 -0700 (PDT)
Received: from sanjays-pc.govzhome.govindz.co.nz ([116.251.152.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07244ab3sm696384b3a.7.2026.03.11.14.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:31:46 -0700 (PDT)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Nilton Perim Neto <niltonperimneto@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Lode Willems <me@lodewillems.com>
Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xpad: Add RedOctane Games vendor id
Date: Thu, 12 Mar 2026 10:31:04 +1300
Message-ID: <20260311213106.271577-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor ID for RedOctane Games to xpad

Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f581..e97ff270d978 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -585,6 +585,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x3651),		/* CRKD Controllers */
 	XPAD_XBOXONE_VENDOR(0x366c),		/* ByoWave controllers */
 	XPAD_XBOX360_VENDOR(0x37d7),		/* Flydigi Controllers */
+	XPAD_XBOX360_VENDOR(0x3958),		/* RedOctane Games Controllers */
 	XPAD_XBOX360_VENDOR(0x413d),		/* Black Shark Green Ghost Controller */
 	{ }
 };
-- 
2.53.0

