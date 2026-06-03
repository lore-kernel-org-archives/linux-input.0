Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB063FCB15
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519445; cv=none; b=URi3AD0fPX33ZIC7OGRyAqRcTIcKMr8r/IoeLTMH9lbNHkkafJs2B23loourTSFD8U6T6Qb67utXRIjyAe3sXLDStXT79AK2ijsuvZXpVwQIzvH9+QoLjz6XCRekeIrNnuvdBJRVJfZkMKWQs+RZGvxp7sMmfG0GuJh9pLePZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519445; c=relaxed/simple;
	bh=+JosnbZhQUF/MOBUAyqR6d/lHKYmP/5jY0EEF59+azs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oIM1ZUg62pe+pQwqWj4C3apXJzo1SLxDyiRBybt0rAYC9UDn5JAPFZeNYrl8SvtgZwbxMjCVpQvf4ZhJ65MgBYw2stU5M0J2VNVQEcipAB7T8h0gHNzHMMUAi1xbMtUCoxBfEMadV6hD6+RUbRScSAxkheVu/1hmw3tVNE+/ES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBhHX/bj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBhHX/bj"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-48657fc84a3so1241755b6e.3
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519443; x=1781124243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IEf6hXj7f37DFxPYxn9sI96qJysjet+fYfxXFRG2SM=;
        b=eBhHX/bjUqK/bQgWs32lKFc+cdIrlG6bjDtdscaOc4jE8J3fMP6N6xa4MHb+aanQ4r
         vjdbiFEKLGRZgWx8jdRAt2PzEL0vjWQoxbnsouDIXQtzrul6Gxuu5eRXWMVcz+5n/Rhe
         jig4upRzejUnzDzQlUALFqK+JmJAoR8lz7Uw3U3SwruM1FGl3106LcTKsn/3yDD8FH/B
         3MSbKgu1iwmv1uz4BAc1vZBJ0hfRZTGZvVUyaUtoFLczTJCWd14PC4Nsc9C6lHppBbNh
         4pe3UUvDR5qWghr81ltPt45/kVmIgiN1XGrcWJ5QGk7LUk2PvpJL01qWrTkj+rolK28m
         xPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519443; x=1781124243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IEf6hXj7f37DFxPYxn9sI96qJysjet+fYfxXFRG2SM=;
        b=E3IGhd0qaUVuZiS3uKI3MwU6cx2FNsfepQ2QOwV1A7JOIl5WOG8oy+Vt4SlmHOhDID
         I59MDX7JIExA1vnysE50rAC/WJ/VNQXDwPtdny/OCbFXJ8DBtgPY2vE5v2Kt3y6ZH2/7
         Q0Y6f9fHUxS9S6Bax/9d2Tbf0ga/TRPqWzRrhVH6SH8qufmNM981kg7KB33EAMCM1M3X
         3QMxfFnWg5JCy7RiGFRsfRiOxNEOh+PmS0yDOGvoaET2Csq4Uv0f8nS8o83dxc8HiAIp
         XDP9pPvs92M+cUCA4+qi3+OPARa9Ra/h9pMpm41lBb4Bzg/QTZm7il1qYiWD0XdI9hWP
         XVeA==
X-Forwarded-Encrypted: i=1; AFNElJ9qcoQJw1pxYjZ7py5tTvrq5vlaR98V76zh3UtX1z6A/8HnbVnbzSqeMwxQ/AoNXL93iyVgoh+sQpP/7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUqH462ggWLq7u53gLfq5MZuSTHDhGTouJi5r7CLRQWsNifM3
	txxGycte6F8XZ1KG+PHHiqmRJfj0Yi9qYl2R0q2IFI0ldcfzDvQXleq9
X-Gm-Gg: Acq92OHgRoARk5UobLJEGqgIYKLJg1+ipi4CwjYR63b0Dey7mtYCsIowFS0AElRFB3d
	z6dhSMksSsW2WVWo35axSaqQd3bxJ4SwUqMBDvaSImCLg9sBb+GKzeCT2OJHhoPS1OMFtJABSlu
	uzK23NrEeb//ZerfQVcJiCD+nylouTOCdTBTO7z8PomIiKWfbovgJoTCggzsThpi54/J05OJZ3j
	Uwz/cV6zlhA7SJVlXTpXnTUD98KPhkMepfPIzb6Z+FXFuxNwBycQxGbD9NdI8JqDDWjo9O9AP2n
	zVglFNydIUCkeaixvLTUbta1g0aPG16CCk1UQQ5PrWk7Glm8gQiA36qDs+IzWECZoWngXP7Lvn1
	3f2FiQTIlhnDvP7X/Omm+7FwU9BUnnxa/a3CqLpRQIw1AfH74wTn9nSeEt8jbfmrfw15iMTrTot
	Uq0wqxDXeq3R0bZBciM0FWxoki4gq3RBGrpEZ5dn9kCKMtIf/axw==
X-Received: by 2002:a05:6808:144f:b0:479:fa21:adfe with SMTP id 5614622812f47-4865a9264e7mr3070801b6e.6.1780519442890;
        Wed, 03 Jun 2026 13:44:02 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b5a5a64sm2667962b6e.4.2026.06.03.13.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:44:02 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Subject: [PATCH v2 0/4] dt-bindings: remove redundant .txt redirect stubs
Date: Wed, 03 Jun 2026 15:42:17 -0500
Message-Id: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ7diFESWO/Ih5isql7UMuuihD8e
 0NPwxxmCigJk8K7KSB0sfK+VbFtA3EJ24eQU3WwxjrjTIdzj0LrflFFYqF4oB7nrOiHIeToc3g
 lBzX/CmW+/+txep4f7I/bSWoAAAA=
X-Change-ID: 20260603-b4-remove-redirect-stubs-899afc8fa7d6
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3

Several .txt files under Documentation/devicetree/bindings/ contain
only a redirect notice pointing to a .yaml schema with the same base
filename in the same directory. These stubs were useful during the
.txt to .yaml transition but are now redundant, since the .yaml is
discoverable by name. Meanwhile, other documentation still references
some of these stubs, forcing readers through an unnecessary extra hop
to reach the actual schema.

This series removes four such stubs and updates all remaining
cross-references to point directly to the .yaml schemas.

Other redirect stubs in the tree were evaluated and intentionally
kept:

 - Stubs pointing to .yaml files with different names (e.g.,
   spi-bus.txt -> spi-controller.yaml) serve as breadcrumbs for
   the renamed schema.

 - Stubs pointing to multiple .yaml files (e.g., nvmem.txt ->
   nvmem.yaml and nvmem-consumer.yaml) convey that the content
   was split.

 - Stubs pointing to .yaml files in a different directory (e.g.,
   reset/st,stm32-rcc.txt -> clock/st,stm32-rcc.yaml) serve as
   cross-directory pointers.

Two additional same-name, same-directory stubs (leds/common.txt,
regulator/regulator.txt) have significantly more cross references
and will be addressed in a follow-up series.

v2:
- Patch 4/4: corrected commit message (eight references in six files, not
  eight files), Sashiko review.
  https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4

v1: https://lore.kernel.org/all/20260529052246.4934-1-akash.sukhavasi@gmail.com/

Patch 1 supersedes my earlier standalone submission:
https://lore.kernel.org/all/20260523004223.3045-1-akash.sukhavasi@gmail.com/

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Akash Sukhavasi (4):
      dt-bindings: net: remove obsolete mdio.txt
      dt-bindings: media: remove obsolete rc.txt
      dt-bindings: net: dsa: remove obsolete dsa.txt
      dt-bindings: input: remove obsolete matrix-keymap.txt

 Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt    | 2 +-
 Documentation/devicetree/bindings/input/clps711x-keypad.txt    | 2 +-
 Documentation/devicetree/bindings/input/matrix-keymap.txt      | 1 -
 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt | 2 +-
 Documentation/devicetree/bindings/input/pxa27x-keypad.txt      | 2 +-
 Documentation/devicetree/bindings/input/st-keyscan.txt         | 2 +-
 Documentation/devicetree/bindings/media/hix5hd2-ir.txt         | 2 +-
 Documentation/devicetree/bindings/media/rc.txt                 | 1 -
 Documentation/devicetree/bindings/mfd/tc3589x.txt              | 6 +++---
 Documentation/devicetree/bindings/net/dsa/dsa.txt              | 4 ----
 Documentation/devicetree/bindings/net/dsa/lan9303.txt          | 2 +-
 Documentation/devicetree/bindings/net/mdio.txt                 | 1 -
 Documentation/networking/dsa/dsa.rst                           | 2 +-
 13 files changed, 11 insertions(+), 18 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-b4-remove-redirect-stubs-899afc8fa7d6

Best regards,
-- 
Akash Sukhavasi <akash.sukhavasi@gmail.com>

