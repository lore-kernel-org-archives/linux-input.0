Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A9D36402A
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659438; cv=none; b=DEjaWpKQZmdfaiDUuaeYG1o0J0eeUBFLSVYSISUq9Np+Xu8vG3V6emg3YMt96nqzTE7rjqksyMFqDg34AB5pNMOTO6Md0ItKB+xE+5n1diK+NZ4lidUaCw0h0vetcFFugm+FVe0g/u29WfREOrr/Np9tzVZbgli6j9bf1egO+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659438; c=relaxed/simple;
	bh=awjdtHzdvRtnEfgvFMsm8k9DOKmErrjpCal2ijjHmWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Di/lrmAs//HHtwGsI8Eic2CXa8MOK/Xb0+TtslHgiDizNdEcTlyuEFpUPfexMghlneAfVMovwjuY2NyHmakeChyfYEu3XR9k6+Fn0H6EleWyhpUhyb/5pnAJJDV+S3eHPKeCU8mFvnBpgx9D5Y49xhKK0y9gOG9TEklYhsWdJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=bAAgH/Rt; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="bAAgH/Rt"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-917c04630c2so11559246d6.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791659435; x=1792264235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sePYJd1IcAwgM9NvQ3Wm/mXj27dl2KtQ+o9Z69cf6Y0=;
        b=bAAgH/RtUa/jmSbzD+WrInwMpF+6yGUvKk26GHHL7EJhEEAHNPDo8mVAM28kggOmKI
         JTe1DjCpX+BBsf/ZZrIscZXq+y3P3Fpay7Er94WfEgJImVgoPUmRbAOhZaZNTYOjJhyJ
         /Gn/LQ3K+sTdH94+tMwXW1L9I1CNdD57KGkSbgtVvMWfqy9BSYFCaKRrnTV2swpmDbwc
         LJOjtseKxAssoPjDyOUKqQLZVdcNfaATXPnwQ7+nUJgVe79vwqoKe6NGNvcC740PgMct
         zQeEzG5MZFD2cJXVA/3Z+HgvDejWM74jXc5GM6FEc7bWo2RmWWRaNpFVeuP9M84POBEZ
         1b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791659435; x=1792264235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sePYJd1IcAwgM9NvQ3Wm/mXj27dl2KtQ+o9Z69cf6Y0=;
        b=fDUY4Ns4GnCSh/lDfSSzG0RWR9tCrXCN/gOMvsGDUq2/ywkrzGxNL9e/kBRF+gZclW
         IWDgl15kH1z+XOXTEnS0UbKfrD0NJbgREtSwahwoZ2MQZuocqx7rSRiQsnjdtkGSF/Xc
         IstICBt3cz8y6kKhtujZwteYyJdXDX2AI35/oynHyTbNJzZNnOAh0Qe2Dn+E3Ia6W+fX
         nrvOvkeQ6zje56331p/H3lzZJcSKfOymFJ2x697cWU/DqlOSYBCD9xk0xJ8YggWI79Yh
         D6g9gyvZ45TwXD1SZcBwjDs9ENV9Rk9WyPTcQxDMBjKN4AmzKtCB6L9huUple/8AZdBJ
         UWFA==
X-Gm-Message-State: AFq9FYKM4IgO6sueB+J7jA92ONp/CA1n3qI8cBaw/kBWKBhA9nofcQGC
	/yD3QJlrmhEvKmFTPCh60M5SvZLjNMaC/Kff43uab0X+oBVhmrmuppJ7nlLmxHfZqvdcKvBmTd9
	7Ai2zsKU=
X-Gm-Gg: AYBFou17T/yxn1mgXmx10fUu7j3hsYuLJjCbK+j7O3Wvr7bZj6ogHp/mWOE2CpRvy/e
	zMG7RqoF+BzDlL7oqi0Rs8JiCEskVlx6acKWwXj1Cz1C+1coy6GAhXe/UqukR3USfknEPlyI9DN
	t1mjihX88cIMNm+ozYtaa/+4LgKmHI6ybX1OL6Xg7ixMJWZFH/UgoXtWmPbZ2gU+liO3FyH098p
	Meyr/u8yW6LPJiwj3epm8ygFBLXmP8nUsIZp2XhehorHojgZcUQtdPjBKhNB9qzZCngpwUhM+/N
	G6csl01ci6ui/aEEUclOu2Z/u/Xo61dAledU3R3qm8GH+3XaM63X85u1ZrnNjYnlYTnlcveq1/B
	69VU7J3PFJvCfnyT6r4L/dvMZthptcIydKBjKP1el8AuOgGJpKNsk3EEE8/uR40ne7LKrQWDYJc
	MyyR3fhWX3GbMQU6VT2u1tdBkYIphwFwv+bU2alHAJsnPlV8O7KbW6wzAC0KYdG0GSyB8TfSTaz
	BJaniNQBC9GCFH/e4BdXDvl6vqfvS0BfNXcfzCD+Q==
X-Received: by 2002:a05:620a:618c:b0:93c:8544:6adb with SMTP id af79cd13be357-93ebd228f75mr909689285a.22.1791659434752;
        Sat, 10 Oct 2026 12:10:34 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0cfsm489355685a.19.2026.10.10.12.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 12:10:34 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v2 0/2] Input: discard pre-registration events and test state seeding
Date: Sat, 10 Oct 2026 15:10:31 -0400
Message-ID: <20261010191033.23577-1-kabel@voidship.net>
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

Patch 1 contains the six-line runtime fix. Patch 2 adds KUnit coverage for
registration with and without event-buffer resizing. The test uses a
virtual SW_DOCK device and performs no real radio operations.

Tested on mainline 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0 (7.3.0-rc6):
 - Tests alone on the unmodified input core: four pass, two fail.
   The non-resizing case replays one stale switch event; both cases
   retain the initialization timestamp.
 - Patch 1 alone: all four existing input-core tests pass.
 - Both patches: all six input-core tests pass.
Both source commits were built and tested under UML without compiler
warnings. The revised tests repeat the same failing/passing comparison.

The same runtime fix was also tested with QEMU/KVM on Arch 7.2.7 and on
the ThinkPad.

AI assistance: OpenAI Codex assisted source analysis, the fix, regression
tests and this text. The submitter performed the physical hardware
comparisons.

Previous version:
 Message-ID: <20261010180031.7-1-kabel@voidship.net>
Review addressed:
 Message-ID: <sashiko-outbox-166792@kernel.org>

Changes in v2:
 - Patch 1 is unchanged.
 - Patch 2 checks absinfo allocation before event seeding and unregisters
   its handler before its device, addressing Sashiko's review of v1.
 - Forced allocation failure now reaches the explicit check and cleanup.
   A forced teardown interleaving reproduced unintended binding after
   actual allocator address reuse; handler-first cleanup prevents it.

Karlos Abel (2):
  Input: discard pre-registration events before attaching handlers
  Input: test state seeding across device registration

 drivers/input/input.c            |   6 ++
 drivers/input/tests/input_test.c | 171 +++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)


base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
