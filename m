Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A633EAF3
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655235; cv=none; b=Pj7LC4PoYlC0mm3VXkA91n1+gKEsu1zMKUDPPoQHOibc/HB3kwExm8KnbAlMUZKIeEn6dByVUxew2pqpCzSxs8TVCHHpB2Z5LAVBvYkDDJWXSGo6vc/j2ScKFqWYmo+VW626pM5dovVjkcFGtS3EwlVgjx+ULyOPzZhGidQBktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655235; c=relaxed/simple;
	bh=QEE/N6PnwPszZHQB06FbCOKn/XxBs8ay66Sp+xmfqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5bkyAB9Fz4HPn9d5GtM/u9aAheCDFRbXh9W6Uf8wFmXNYpwGepdpYNWZH/S7bZKzeu7jcKepvjjjafm7saBEsV0whipG+sR4FDlCPYHLIPvRP5vqZRM+0UU2GUu1HPuulEdvWKUNFvTZUxQw67gJ52dP93SFdvNcwtqL0ou0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=WoD+fPtV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="WoD+fPtV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53505bc6524so74399881cf.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791655233; x=1792260033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCsenb9Bskg3bCFGqLkiR40EBE50kMlcijLAOuMhnEE=;
        b=WoD+fPtVVsk8glmY0MtOSLbCvFA1NpzTK03e+ePsgmzbL+/V3/iZF8E5Isqst/hZiv
         Dw4r2XizyYpKnWUGjsjEr4XLNNypm2geSXy021YfzC4UyWJoss/6dc3T2uDHTgT66LWy
         goTjXHw0eKg0da3o2Fzsy1OlVUBelYetpVEkiTiV1MlBq1hVN6yo6N8yy/5pgrhD3dwU
         MH4M7JmLLDrhOTov4SE6bEwVDjP9xLsbUwAbw/M/p0VfHcLoJ0Yuj4mmBKheJJKdwlKi
         SffPGBIsW9FG6PJtItcc9XaeFnilsfLmI6URdviRhuKb9S+3FnEGzqE7X8db3kyYnCdb
         pGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655233; x=1792260033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCsenb9Bskg3bCFGqLkiR40EBE50kMlcijLAOuMhnEE=;
        b=23Cvfx0ONT/GCQOinEdjd+5QN7DOYYFgYRcrqhn5oxeBTNXnIQi1x+DncrDJ4NgRAe
         X/Mse599J0GvBuuuD9FQwjc2k51zE/F+3Lz2b0RZHqokp2cO2lscyzjoryyyvYxiP8Rz
         yakVcVWogw1jR9ijTJCEb3hrpJS++Yhr2jCjGTqSPp01Zfape4dy3ClNPimMnn0g/jUt
         CN4fQXpmrA+X7/ptFs4WzKIkXDBq1GwMvDBTLlosH0nnMMbMJWuY8ptJlYNn2M7keigl
         KNP4Dk09qO4a9csjSxiYPtnIf0PAnB8eZv88WgvPcWsvURiHU8cDI4zXT28bgJeiR4aF
         erEQ==
X-Gm-Message-State: AFq9FYK8UC6SCxKKt3GVze7b9v2Qu0RxoQmWfq+yK2iGHtanLUcYA08w
	dLjh23ci9tIoJGdxheZFRsVwXU4Q0h/UGVpPWiAF7rel1gyPqo4c5YlBCcj9KQovW2zaYzLtuJD
	qipaLpZA=
X-Gm-Gg: AYBFou3Z45AnS+tNpxW9yFsXLbNFBG9PvOtwGSNVyk8u0O8qStv3xrzCKba1ArxU+Ht
	vT2oIIgfHgBpQxq09VmjCaVt8SK/pJvoPaGOutfMHL/Kkn4BQr6zhatttc6b/v1pMO5c9SDpWE1
	jH2mHYKjLti/k22dWu/AcNK6lNCZc/QzwEkBmx3BnbMLj6L1zwheMSuMBnjJvZcLKeqUd6v42V6
	12//mSRYzg3WNNxPh/uBp9B015tIE69XVioHIJrZ2OIBpFryNgmPvR+HZQzrhZMUquF8G0RLvXT
	O1+RDp1V9QY8hnzTiZf9d6ZNZ09D8MDLEnevW+2yrzDij1E7a9ugaqCIRpRSWgeP63xNblAJw2P
	uqEuSDrAaYpTplcBh4tZNNYmXsp2kqxF0V7ALSIwFOXxJ48h/u0Fi+729X6qV8nm/CH1DR5/N4Q
	Ml5h3v0veudmIBkqSa1ehP6u36jO6O7RMqBU61QjZ48Yox2T+wII+8owajwCSmvpP5GzlYfQcGa
	ezgGHNIkUR/f+iXLtPkQt2XUEku9dJaJGAWF3l3
X-Received: by 2002:a05:622a:120b:b0:532:8063:4ccc with SMTP id d75a77b69052e-5359d6a6713mr90845801cf.3.1791655233434;
        Sat, 10 Oct 2026 11:00:33 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550175e3sm50339326d6.11.2026.10.10.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 11:00:32 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: discard pre-registration events and test state seeding
Date: Sat, 10 Oct 2026 14:00:29 -0400
Message-ID: <20261010180031.7-1-kabel@voidship.net>
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
warnings. The final files match the earlier failing/passing comparison.

The same runtime fix was also tested with QEMU/KVM on Arch 7.2.7 and on
the ThinkPad.

AI assistance: OpenAI Codex assisted source analysis, the fix, regression
tests and this text. The submitter performed the physical hardware
comparisons.

Karlos Abel (2):
  Input: discard pre-registration events before attaching handlers
  Input: test state seeding across device registration

 drivers/input/input.c            |   6 ++
 drivers/input/tests/input_test.c | 168 +++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)


base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
