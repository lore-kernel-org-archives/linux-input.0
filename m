Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB983803C5
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673094; cv=none; b=JEJnH6iDYVsEUo5UL/Udg5yEKN30mRSFGhveKLFnuxEZjQY0X+vFZAfEuDRvvA/gZkdYPEfB99EkQy4vjlf6bN7ew3psRcmbhEWbKAA27b9f9L5MT2fGqV+7hzl1Sq7KaTwj1Isj3n24Hi4l7vupG4/7b4aBY5Lc0Bklo1hlxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673094; c=relaxed/simple;
	bh=WFPbXKjO6TLw12mAP6vLlTcCrT1MH/2+rxFy3tIZpkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hPIEVovJShe/pvyDWqJAruUJvthvsu8tL1vmb1PFOz9Je7bz6TWOXqEDrGV02Bpu0IIVzj3D8psoCQovQPNjAF0I5Bt4dEcLlw777hPzFjXStDCIRaojeIm2/OGypP8uxpV5vRezitQlECKA7q6HxX9th3yllUx08vR5qtlMKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=wv+b3+xN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="wv+b3+xN"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9144e8021d3so13144056d6.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791673090; x=1792277890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ai5X7JtaQUacTHU9H9PAvi537MjNeFiGt6V5Xj0ZZcU=;
        b=wv+b3+xNJKlrQ+8x9nmS74tCCVBXCCHJH368Tq0P2Y+MT84a8snSg8hdM2ofaFhju4
         qHcsuxMlst3gN6ucGocB6G5CufMRL3BnGbBn95Usuo6291zDV9UxACPcbuHezi3f+0We
         bTheggQxM3Aiq+nmuaidL9x7VlOD066oKAd1ALLVzXUv15i1NgaVS8r8bCeLLRhvFkDu
         dd+vMYRETBS/KbONsFr6PDuijIdt9F/4jeUvDad/C56Z9hmFvxKEqlBBzweyf9n9STYA
         QCowlnmo9MHDgJOjDs2vdnre+VxtsNQBvVakdXfiIGU1IR5HfkOenFQFa/sWCHePYqwM
         4B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673090; x=1792277890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ai5X7JtaQUacTHU9H9PAvi537MjNeFiGt6V5Xj0ZZcU=;
        b=rO/+/ecSG3q+aeh9xTUF+guGQn1vrRK2pY99Ogoel01w5V4enn8UCkAs3p6dt7mgT7
         SHEGqyc4wCInTqTMdO8qaVO2sYAfPDsYZIDCPvleRIcmB5TvKYPNmRLP9MfEYsPugRlK
         Nv5aBvbuMwFeZv30cQQWlTV9A0BGMAO4bVhxRk0GIs73eAqilo+TWC6UzGaYTDxQh55V
         v2mS66RPIS4Cy9GtebQ67PIr8+QSdGZmI8h0i+GGRvVpK0koFEkxqIkSteolvnTyM2yg
         8g5ziiyf2o5R5pdHg+/VCN+BwxnNVTAqlksJIBCkFn3ghVHpRjnglN0J6Fa2v5GnOr/q
         0guQ==
X-Gm-Message-State: AFq9FYL6bjBVJuKKTvrPNeEMLCw49bpO5mrXxsPiPApKQoHIcLnxp2Qf
	nPzzJAmq8AmFN3Jr75ut9ciihFK58e4hzX6K6BfjqlaoKXpSCsn79Epk06tkHQ30/jw=
X-Gm-Gg: AYBFou3v99gU623jkCX8OEOZRq95jQ9sgC2z0d7W1LUzUErUBBa8U7I1C9DHaFnuDS6
	h0Ly7bI5EPrjSmMXDfnq2HTAeNkNEaoH71UmFfXEUeh2S5J0ysUAK35eHH1jhkqujAU9fGi/oX4
	AO7AavN+UFxEja2SUncOdT63Y6TIkpgW0kbQAX41a8piHt5AEWRGJj4hH2WXNDoMrfb19lJd0p9
	/GtxVlvyMwKQ+J0pLdwmeFATWtWfmsUVARrYxYVMeQSUQJv0xekG+02hk+L1T+6pJLaJiAtuR53
	tc0VQnHhWsH0sTtUh1KZEFcB/Gf1v07qZdd01lE2eyP/EXv6TEdxi9XGwJAMKJPa12hxsKsrtpn
	KLMSijDWhwSYlNZABUYvToyjZWJfGdVCGpzGoReNmqZiT8ScnIvy8jn8hSF+qG+4LMojXKn24NS
	YFdCpOzbQmq+sAbWnFGy6obmmyz6QovhGoMHjU895VdsUUrwE/jDpucpY/og9MmE8AMyBDysbiP
	91OOrRaYawgQDp0sihLdm+YzHUrD7MqnkX49QNO8g==
X-Received: by 2002:a05:6214:4906:b0:917:8b9f:d62 with SMTP id 6a1803df08f44-91b554f1babmr117225666d6.18.1791673090373;
        Sat, 10 Oct 2026 15:58:10 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55092ca8sm55498256d6.37.2026.10.10.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:58:09 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v3 0/2] Input: discard pre-registration events and test state seeding
Date: Sat, 10 Oct 2026 18:58:06 -0400
Message-ID: <20261010225808.36404-1-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series prevents input handlers from receiving buffered initialization
events after device registration. On a ThinkPad T14 Gen 6, a later LED
update flushed a stale SW_RFKILL_ALL event seeded by thinkpad_acpi.
The fix drops the pending events and their timestamp before handlers
attach, while retaining the seeded switch and absolute-axis state.

Patch 1 contains the runtime fix. Patch 2 adds KUnit coverage for
registration with and without event-buffer resizing. The test uses a
virtual SW_DOCK device and performs no real radio operations.

Tested on mainline 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0:
 - V3 with both patches: all six input-core KUnit tests pass under UML,
   with CONFIG_PROVE_LOCKING and CONFIG_DEBUG_SPINLOCK enabled. No
   compiler warnings or lockdep diagnostics were reported.
 - The unchanged tests previously failed against the unmodified input
   core: four passed and two failed. The non-resizing case replayed one
   stale switch event; both cases retained the initialization timestamp.

Earlier versions using a scoped spinlock guard were also tested with
QEMU/KVM on Arch 7.2.7 and on the ThinkPad. V3 uses the same underlying
lock/unlock operations but has not been rerun on physical hardware.

AI assistance: OpenAI Codex assisted source analysis, the fix, regression
tests and this text. The submitter performed the physical hardware
comparisons.

Previous version:
 Message-ID: <20261010191033.23577-1-kabel@voidship.net>
Review addressed:
 Message-ID: <sashiko-outbox-166847@kernel.org>

Changes in v3:
 - Use an explicit spin_lock_irq()/spin_unlock_irq() pair instead of
   adding scoped cleanup to the goto-based registration path.
 - Include the spinlock declarations directly.
 - Patch 2 is unchanged from v2.

Changes in v2:
 - Check absinfo allocation before test event seeding.
 - Unregister the test handler before unregistering its device.

Karlos Abel (2):
  Input: discard pre-registration events before attaching handlers
  Input: test state seeding across device registration

 drivers/input/input.c            |   7 ++
 drivers/input/tests/input_test.c | 171 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+)

base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
