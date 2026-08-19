Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4403D954E
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178536; cv=none; b=A14tSdihjqmHmyTB/dtsReW2GwIMSkqFmtAPHqYunhJRSKQ8Nh9Ozr4HCfgbQusMmU79V5II0p8Pqt25MT254pAlSQ/O4I6uFXafiGpeD/hooEk9vNpNNGeIDOzsD1OSnGEwkJkMvQC222VdykvowxyVvS7Y5eZM/O6ELHAPYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178536; c=relaxed/simple;
	bh=w04FCCwpJDIBg2u2Ugiop1PhPjDYLMaKHY0WwXweRK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i9JRdk5H4TSWIXI5J6hAvjB+quSbFuvFBZsPPyrzF+FXODUQ4mwUZb0vkyrKu+PTkY7MHE2fJ1+DPSg/Gj5R7C2vXny5YUdshCTZ66GAKTpC1fOJgtJQqU/a0a0uMZt+4p7Tdk1NARtnBFqsfKwWFhmr1xhGSBz+zidNA6/WVXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh9z2WWa; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh9z2WWa"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so244669a12.0
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 15:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787178535; x=1787783335; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qUV4xoTyLUSRv2FhGM0sk0uIprDCdmyirtr1g03/2pE=;
        b=Rh9z2WWaEWewFJj4XnoZOhzqXSPwIPMGEiVFIMdzyIJh/j2TbSiidmQyZMp8a+fgQk
         ED60Wdn7NbA+7r4Sekf3JLUFyXS9FhlbEKxDA5fe8MCcgSa58ODL2VoZyn577Dv4BIOd
         WLa0Nu5Ei1aBMCyXR7XmVfMz3wrcoLxygLmOv8y0mR015B2HZgYstd9CW5aepaB3enHM
         nwkmEee7SJLCubqxpF7cm/GD5DzYetplxSFKWfJaMo2meg8mrnhlnvsq41zrdvo5Pe0G
         0ssAs8HOffLARfwJOOn3dO/YV4l6NN/dQTyh2hWrR+bGSNCHkM7/w7OqAwI9i6LoKUZp
         6aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178535; x=1787783335;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qUV4xoTyLUSRv2FhGM0sk0uIprDCdmyirtr1g03/2pE=;
        b=G6K6ebVtaEn1KwVRe6HZ+elPzTzDloCOK0+U7mMx8c8Y4QHBfjaUQ/ijrZSf5W6Jne
         C8xjs21CigqhkV98y7TPmweqXSbNNc2JpSbFpdAODap9gm3DaYaeronF5DJsuovv5Oez
         znBw//hnVnCQ4UFJlFIleJyhQ6RWiCwdi14jU+GppQREGbg01qv4V3Yfv9K5Lupd6+GI
         opqIX4Snx2njuS4+NewpIySsyLS6IpAo3/3oS/2zMu6gBtrJ3rzZnCNdZ2DCaCplL35k
         teCaIZbhNn7S3PlxIgRdedeAZ/jbLkjqMIOXOonFRstOwlypil4k9bl+1m8Fec5O/1MQ
         WkNw==
X-Forwarded-Encrypted: i=1; AHgh+RqbgI5SUIVxT57FII81QiVUDEiq6z2415gIPofSMk0FIMZ3OlTwV//AREtj3xczDB7wP0UtqvHwo724QQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nqpbWSS1ky5XzBqC6ycD84lhrcZSDwB2cde7nY/R6W1R3oFLuC
	92Do0ysEECvweoBWUyyyW1Z94j23QQlEycFNa5RM6YhvJMo80y/Pi7geR0RLGA==
X-Gm-Gg: AR+sD11zaJl0A+A754ltlTrz3a1VXJa5cNfxS4uTYuuKwuxxx2AuPFYtTSAcCPTescC
	PPNAFZKBRstSG+4PSnRDuMYdjt/mNGceQ+kV3qZluB5ixrWiXS/drwUQ5nqyxY52OULp3fQeeat
	RcAkAtHTJ2tfHvph4dBkx5bi+LcSfJMhVkhFL5TMS9DJoxviCnmnlHj8TnVXRHHkiwwg8ty0jOj
	YSsVEU7yYSWS9VX2VJkrhKAJl0k7lfGk5I8pjwzt7xpzx0/XAzJguwohQay6LmGh7ApHTSL7BRh
	DtPm1GJnqk3FkmSZXHTZoRzxsthHgV2kExlALAkP6XEq+Q6M/8YatZyCgXo5OuJqeeqSzjKI5U1
	uqS47beF3+5o7OMgH7/2JxU4GF6IZ0HrnN0gaMjGAID+srl1c591Lfw5Ql8GEntD7F/dy8guuT+
	8U7bH1YaZScNOq3EXyqCvQDOjBOsdKh7R5OVH/wNnk9xaX6CYi8DoLD/JOXAikmBjPIHwDO9dYy
	J+NMXYwKVksWbTtvhNwZ56qzd8MdxrSkPB0Z+TcVGb+BPjuhEubcyN0hrXZ
X-Received: by 2002:a17:90b:3851:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-395a06ac272mr2656779a91.14.1787178534596;
        Wed, 19 Aug 2026 15:28:54 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ac3d1bfsm9539719c88.0.2026.08.19.15.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:28:54 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 44F7B360490; Thu, 20 Aug 2026 10:28:50 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-input <linux-input@vger.kernel.org>
Subject: [PATCH v3 1/5] m68k: Fix atari mouse movement
Date: Thu, 20 Aug 2026 10:28:34 +1200
Message-Id: <20260819222838.21256-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260819222838.21256-1-schmitzmic@gmail.com>
References: <20260819222838.21256-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

From: Miro Kropacek <miro.kropacek@gmail.com>

Kernels are built with -funsigned-char since version 6.2, resulting
in signed mouse position deltas getting misinterpreted as unsigned.

Cast deltas passed in (unsigned) scancode buffer to correctly
interpret sign.

Fixes: 3bc753c06dd02a35 ("kbuild: treat char as always unsigned")
Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

---

Changes in v2:

- change atamouse_interrupt function signature to signed char *,
  drop signed casts (Geert)
---
 arch/m68k/atari/atakeyb.c        | 2 +-
 arch/m68k/include/asm/atarikb.h  | 2 +-
 drivers/input/mouse/atarimouse.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/atari/atakeyb.c b/arch/m68k/atari/atakeyb.c
index 49a9a459bdf4..86ab73a79177 100644
--- a/arch/m68k/atari/atakeyb.c
+++ b/arch/m68k/atari/atakeyb.c
@@ -39,7 +39,7 @@ void (*atari_MIDI_interrupt_hook) (void);
 /* Hook for keyboard inputdev  driver */
 void (*atari_input_keyboard_interrupt_hook) (unsigned char, char);
 /* Hook for mouse inputdev  driver */
-void (*atari_input_mouse_interrupt_hook) (char *);
+void (*atari_input_mouse_interrupt_hook)(signed char *buf);
 EXPORT_SYMBOL(atari_input_keyboard_interrupt_hook);
 EXPORT_SYMBOL(atari_input_mouse_interrupt_hook);
 
diff --git a/arch/m68k/include/asm/atarikb.h b/arch/m68k/include/asm/atarikb.h
index 68f3622bf591..c5a84c7ee85d 100644
--- a/arch/m68k/include/asm/atarikb.h
+++ b/arch/m68k/include/asm/atarikb.h
@@ -37,7 +37,7 @@ extern void (*atari_MIDI_interrupt_hook) (void);
 /* Hook for keyboard inputdev  driver */
 extern void (*atari_input_keyboard_interrupt_hook) (unsigned char, char);
 /* Hook for mouse inputdev  driver */
-extern void (*atari_input_mouse_interrupt_hook) (char *);
+extern void (*atari_input_mouse_interrupt_hook)(signed char *buf);
 
 int atari_keyb_init(void);
 
diff --git a/drivers/input/mouse/atarimouse.c b/drivers/input/mouse/atarimouse.c
index b1219cc4d9a2..6bac2288c494 100644
--- a/drivers/input/mouse/atarimouse.c
+++ b/drivers/input/mouse/atarimouse.c
@@ -60,7 +60,7 @@ extern int atari_mouse_buttons;
 
 static struct input_dev *atamouse_dev;
 
-static void atamouse_interrupt(char *buf)
+static void atamouse_interrupt(signed char *buf)
 {
 	int buttons, dx, dy;
 
-- 
2.17.1

