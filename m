Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580583CDBD3
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865882; cv=none; b=ICkFlMDX4BJZlNCT0tr58v3JR0AMU3u6BRt7HFPT7zfHbD6NbTe9TLfyBIlyUINdb+tZsMhzA9ivII3wxQOJmik4EMW7lXfjED3TzV9VgxWsCYs+f2GEkq2TVgXeZNmfNWMPBNpNTOHthpVConfBxtmsKQ7IgUptr1ilUttkec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865882; c=relaxed/simple;
	bh=bVh9SbGXj1SLk90mueC/PWZz0v/47/SCQrbVWAuM7rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZesjkQl1Ch1Tj81SyJISBtFL7EmLmUvnOPM448NOPccFydkzFRI+B3qDvbCHaJYSJD2t/BMBo7apFpcpAnd4bAB4s/n54B77xiE6b24Q++pg9sEwDbPKWRR7OPRMe6NjsX050Un0v/RO0ZivB5umykd7bDemBHuyPWdKYrrMBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEKsPtAs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEKsPtAs"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38f620399a0so2083691a91.2
        for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786865880; x=1787470680; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uxz6osYBu3ceFE4gxCZtzflAq35fYKkM5G9k3p/A1ig=;
        b=AEKsPtAsonZsMSS79Cw2P23wYfxiBsG9W8xb2Rpazht0LX6uQ+aEOKI97o6P0rJF/m
         jtPi5d4Lk1lSiDe3vLRDPc2lOPfxcgN4Qv/DS40jCYKZiEc6IOw3fzqNZpJFi3jX11/A
         mvfw91gL1o/BGeSdaWRADx1IwOrISAARCk26gDRK7C+qwRJJC4h7WOnWyUQi3n6kD8dA
         2Qx1WYGEWNTocbPOswHAVJFbJj9OiZnzIIiSjoJpAxnYzEaVAxn2AiCoaM0wE4f4tYbb
         tLudSESpoVckW4WBWyS9vQPAJje7kVdXRfqcfibdSO9zywLnOt3orL8+4h8ECv4gSOg6
         4sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865880; x=1787470680;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxz6osYBu3ceFE4gxCZtzflAq35fYKkM5G9k3p/A1ig=;
        b=YEcr+yJIDMDEuv8RFM+PUttLtKqSJ26r1TVYAAnVhtjdF+xTrg0SvBMTVkQjwkmF+L
         zM8UUV4YhfqIg7qETOKsG1JCcHGbQlrzP7+WAaCv4z5BNwYe6AcquPj31q3RvAnZblK1
         GgZIiqyIsMxoyCKEYAMAWUCyPA6Y1YqOW5oIsWuJPIDpJHG6elTYV8+wT+hfdHk9UGi2
         XOglZv32C29CL7VI+CuV4NnRKyn3lzOFFID3ny4yBcXL7x8Sk0IUzebR2/cl2mrDkWs5
         aHYj0+Xee2wyLrQwJn/a966JOktCUXCmVz45dYMXbDa53KxMpyPGuQmCzLSkbgwNgTUR
         E6og==
X-Forwarded-Encrypted: i=1; AHgh+RoFEKsQFszHrr6wBJYYzxGvb0Po73/azSi5UVN3eFS0nNmV1dh/kq46uFrAfZMmPQJVaPUMuH01uoKhEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyakT9iK4vstvZc2POTZ5v4SUbaWUqIuloy1+NyndsouQ2cRG7n
	o+b5d69przcKJCTVOt9YlRNhGvZuT9rLRg4ipZgzg8apRYliSs7jmnzj2ghpQA==
X-Gm-Gg: AR+sD12N5Oz+BvAbCO8WtVnLguPLwWm0wXpoMq5v/eUxvcUWE8Tw/r5XvNLos837uwW
	DneoODfXELEpDAaj8GEJ3S0P7Ilx/vLC/+y5wKFhZVrX+zPmOHNiJmzx0G3N6H+M/zfIKhBtUkB
	oHR1F2G70O/aUfIERjZyge2kwyYOfYDrlblruec1aG+V3hyHggYjN4U/QY2UOyivfdmiz5ZPG7+
	qNq31mmkxTxKWLJbSDEYrDKTX0dz2aqvV+dgxm8c0hBru3MqvUADdrtXz773COBxaCirpa6rPTv
	UYom1QEJiyUKdAKqrHpa5S+XnEEGA3jEsYuzMmP5eLP19CsVANSw+1Mw6wdzcZ4xmffYHtD1TMH
	y4IJuHcedJJKPXm48IWscfzY1f0VpjnTnyCCUSvNjqx4Oz3TIMvSIppc3thcJvApN+RbUw0lsWA
	WZw+no2HADUI4A0ICPf4LQTVsh8HW5TKCeaNsStjxs7y3IKEliUfsU1BeZ24VqljnOVh69BPkKY
	QMnsU4BI7si6ilaJAo3eUylgv6ufaZL0GBu3T7IMVgb8xNOFevX8g==
X-Received: by 2002:a17:90b:4c:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-3933b8fc6c3mr19239894a91.11.1786865880442;
        Sun, 16 Aug 2026 00:38:00 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-170-159-fibre.sparkbb.co.nz. [222.152.170.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e9a6ebsm834166a91.9.2026.08.16.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:37:59 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 67778360445; Sun, 16 Aug 2026 19:37:56 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Miro Kropacek <miro.kropacek@gmail.com>,
	linux-input <linux-input@vger.kernel.org>
Subject: [PATCH v2 1/5] m68k: Fix atari mouse movement
Date: Sun, 16 Aug 2026 19:37:48 +1200
Message-Id: <20260816073752.16656-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260816073752.16656-1-schmitzmic@gmail.com>
References: <20260816073752.16656-1-schmitzmic@gmail.com>
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
Changes in  v2:

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

