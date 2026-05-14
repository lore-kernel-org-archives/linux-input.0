Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB322083
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787199; cv=none; b=JQaeDPC31pcHpHMYVpmAQq8a+kXIRr24/twzm1yCRhZ5zsJHtjgk4FNrASI0rgGBiGS2vXEpJwiYRsuIUu8HKS99gAtlg9ccKdOrtACzf30+WNDMlG9+osVSB8VRY4lhFXIl5UL3TrRkKx5sBcD7SdQMTclUQfgyinZBft6HniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787199; c=relaxed/simple;
	bh=GyeCB+F5S1ltXOB4E/AB6IAEsOzAtFqglRNDrUrXYZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOdLoIhl/D00IvSi4V0cJMzcdSykmSi7xLvHWMNSt/s0OgC/CVYR2J6EJscsOTTdRYTSdGXPcXwODEaPhLK294SUgEE1hs6zpiYgi9OmsmIzOXEAUZg1Otk0dB/rObutPrbAFdAtVeUy2pnXgSHY9zgUzAcX3WTYKYT8No0mxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnhln89U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnhln89U"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48fde648a71so1432875e9.0
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778787197; x=1779391997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uS/vBXvCRYkbRefNnmmA7qiAQL8I0yoScXFkZuVO7v8=;
        b=Nnhln89UMpdLfi/gsjbjAVRRxJktwlCVTod3Wrp1IXw+GQNtbljJMlR3ukudOL2Uuy
         2nAwJmXAoMLpCeWbTXVLfY1eZqSt+lz7ZPn+2Cl6Seo5yoDtJaSNf0s+pnsxuDTBpscg
         QVZTCBdnSOcI+px/EaCDPCgT/fDl4QZTNEYMb+ctlgAhJ5UkeF7kf4qZ8DTuSXF5U4Cs
         xg8+6xj9pmyF/AYek3YnJr/6KM8vgK7MDMEVPrzb+ykmboHut2nMnEfvlQcY2gU++VEI
         bCB9ek/QQWc3MQ2CSv8eSa7zp7lDhIsP7rU1YKes/MjefwcEzgX0dQVCuKUtBQ0sh/9y
         VFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778787197; x=1779391997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS/vBXvCRYkbRefNnmmA7qiAQL8I0yoScXFkZuVO7v8=;
        b=hujrqgNK91n6jMWJyOXkot4MB50TFoyJ3WzBsxWebwGSGbXqmz2fTUffoaUlkw+hG3
         dLeNgmqDnl0neKJDhCi4tfpNME8+GDFVHp6vYNZarewGNHBdqSq00a1e6AwQFvxJYHdW
         1Lgp2yTwy6UmfILad3zADuaUCazyxqQcYTadYBwvHSPURkfSs20ZdhqHTMbcFAKa1sEE
         I5gWKPW553MK8Tli2QbBMGo6W5Sr8BME3A/CAFeF6/ZL0Um9T1/3POMqO/1BfbQwt4AB
         x8a7NdNfHMsSPDc4DYuH37GWtIETuoS6qBgnqTSn3vSt5eYeCOYQ0lpmq6V13ZaUqXlS
         4ldA==
X-Gm-Message-State: AOJu0Yw84DTGwLPYnVLs7IqsaQg8Bi6MIRu8zvZct2zgqXJXRGingihz
	oh9ewhFq9pOwJC4+uRTK4mM3oHbnduWLez41gXM6DCewY5YjBq6SZ84N
X-Gm-Gg: Acq92OHb2xYiBcwBEovUl3Ue6McQKvNt6L8TSoo+c91MXF+ZrKVs1xIlP3+AjHVj0xv
	lbDBAsvyDQ1u2Gm/pwsLDrXxnjaEICqRAYkbEmlJ9huouUj961XulUmLQRG8dL729KU0TitY3hK
	4nCIgvOKcfTHR6cP8xJT34uz4iDeYOeJllpjtMR1aVew1B5m/5E0Lq/8dC1x1E4IxHBGbj2sxM/
	XwDsC5F+516UYYvDV6UaHMOdPim9wukrscBp4+IY9trwUGYuR0Y3IFG4zCjC2Cj3VDGZdwUWRrg
	n9UCFkanSzxy8k1KQkmnyNyoVRl3JTCZpZnWGnSNwXH1Misb3WA43eXjHB48pz0wRFtR1rQnWU1
	8ghYRxFyQ5oTZfoxssGc0OY8BeLlwdD0WrblMn0bzA7EWv/c9omMqaonVzlRvgnoyzdK2Zemgke
	AWzZNtAsWu82r0CIbrN4Jnihi4J3HAWQ5O+bB2eTolXU2kTt5orHKsLm5sxjUdq303SnwJz/+O4
	A==
X-Received: by 2002:a05:600d:8:b0:48f:e044:927d with SMTP id 5b1f17b1804b1-48fe537fa84mr11317005e9.10.1778787196903;
        Thu, 14 May 2026 12:33:16 -0700 (PDT)
Received: from localhost.localdomain (i59F7ABEB.versanet.de. [89.247.171.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53804aesm10968765e9.15.2026.05.14.12.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:33:16 -0700 (PDT)
From: Elliot Tester <elliotctester1@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Elliot Tester <elliotctester1@gmail.com>
Subject: [PATCH] input: remove changelogs, tracked in git
Date: Thu, 14 May 2026 21:33:02 +0200
Message-ID: <20260514193302.117488-1-elliotctester1@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Elliot Tester <elliotctester1@gmail.com>
---
 drivers/input/misc/yealink.c  |  9 ---------
 drivers/input/tablet/aiptek.c | 31 -------------------------------
 2 files changed, 40 deletions(-)

diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
index 8786ed8b3..560f895a0 100644
--- a/drivers/input/misc/yealink.c
+++ b/drivers/input/misc/yealink.c
@@ -22,15 +22,6 @@
  *   - Olivier Vandorpe, for providing the usbb2k-api.
  *   - Martin Diehl, for spotting my memory allocation bug.
  *
- * History:
- *   20050527 henk	First version, functional keyboard. Keyboard events
- *			will pop-up on the ../input/eventX bus.
- *   20050531 henk	Added led, LCD, dialtone and sysfs interface.
- *   20050610 henk	Cleanups, make it ready for public consumption.
- *   20050630 henk	Cleanups, fixes in response to comments.
- *   20050701 henk	sysfs write serialisation, fix potential unload races
- *   20050801 henk	Added ringtone, restructure USB
- *   20050816 henk	Merge 2.6.13-rc6
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 6df24cee3..ba8109322 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -16,37 +16,6 @@
  *
  *  Many thanks to Oliver Kuechemann for his support.
  *
- *  ChangeLog:
- *      v0.1 - Initial release
- *      v0.2 - Hack to get around fake event 28's. (Bryan W. Headley)
- *      v0.3 - Make URB dynamic (Bryan W. Headley, Jun-8-2002)
- *             Released to Linux 2.4.19 and 2.5.x
- *      v0.4 - Rewrote substantial portions of the code to deal with
- *             corrected control sequences, timing, dynamic configuration,
- *             support of 6000U - 12000U, procfs, and macro key support
- *             (Jan-1-2003 - Feb-5-2003, Bryan W. Headley)
- *      v1.0 - Added support for diagnostic messages, count of messages
- *             received from URB - Mar-8-2003, Bryan W. Headley
- *      v1.1 - added support for tablet resolution, changed DV and proximity
- *             some corrections - Jun-22-2003, martin schneebacher
- *           - Added support for the sysfs interface, deprecating the
- *             procfs interface for 2.5.x kernel. Also added support for
- *             Wheel command. Bryan W. Headley July-15-2003.
- *      v1.2 - Reworked jitter timer as a kernel thread.
- *             Bryan W. Headley November-28-2003/Jan-10-2004.
- *      v1.3 - Repaired issue of kernel thread going nuts on single-processor
- *             machines, introduced programmableDelay as a command line
- *             parameter. Feb 7 2004, Bryan W. Headley.
- *      v1.4 - Re-wire jitter so it does not require a thread. Courtesy of
- *             Rene van Paassen. Added reporting of physical pointer device
- *             (e.g., stylus, mouse in reports 2, 3, 4, 5. We don't know
- *             for reports 1, 6.)
- *             what physical device reports for reports 1, 6.) Also enabled
- *             MOUSE and LENS tool button modes. Renamed "rubber" to "eraser".
- *             Feb 20, 2004, Bryan W. Headley.
- *      v1.5 - Added previousJitterable, so we don't do jitter delay when the
- *             user is holding a button down for periods of time.
- *
  * NOTE:
  *      This kernel driver is augmented by the "Aiptek" XFree86 input
  *      driver for your X server, as well as the Gaiptek GUI Front-end
-- 
2.54.0

