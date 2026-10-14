Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C337A826
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 05:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954813; cv=none; b=HRVIgvCiJk6kCNIopX9FTADEN8l7qRLNJcNyeAp03o3fnt+tX2Om2JwNNVN+xrwdTiKJo7EVWc+84qS5GNpaJWEUBkR8ciLgwGQR00ve7ongmwMO8kAJMLNNomzGUs5aOq8RsWhZ6VTItx/MDEL7t8M27OjAwGDgRAxUB8a76Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954813; c=relaxed/simple;
	bh=9L5+pPNFxNcJItTifh5cuhYQBN+IPdNZ/AlJN1nZVIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbPx/lS3+uYYT6aB0xTu8lQ8Wv2id/qk6hsJRfhXeCczqTjNRo6WF5jXmZ0zaHoEfCnv9B84gxhclYJN0Mi8Vk6pifOY51wAvnpvy/vQID0n/6nFf8oPqHE7uqQzKsasLPH6ncOaUelSy9OmPcaDcYjVhRBOKGB38z0l50alY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8lRRtCc; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8lRRtCc"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so848980c88.0
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791954812; x=1792559612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o96Wr4ulgCtQjy9azqIV/+wX469kS4vlmKygYY/jVsM=;
        b=p8lRRtCcTSh1zh+t2rD3UabIvxVvyl5BxSq+vzZsYOywAW4lJ3z8fjt42MQzxCx4kF
         n98YcG0mgnnmdJ1hMN1rEwE2AcSShG0xQgvzWoVJvmu/J1gbgEt64+emHisupx1Wa/Px
         XK3CFAQzw9ywEjriPH8BbgMJKf93iCME2GRAfiP6OM2SwKDWGsNbfxrbT2yPLJhXZTYU
         NhXiAxXpS6QR3IAKaAVjU7k79Mdw3fZMMnvn6D29d0/YqmYDRGAH7Ekm4CcEmspbVLvw
         RTjA1nF87fByfeXPb9l5m5jDpDLCaMPKsyEc3CNBZ/yLQ/+tDOk2eaQL6DLiovPZQoNJ
         CVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791954812; x=1792559612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o96Wr4ulgCtQjy9azqIV/+wX469kS4vlmKygYY/jVsM=;
        b=N4nI8QYozoIF7VOKkD8BF2TiN0a+IchaBZTeMWAXBF7n9itaGaxo81iTJhXMbon3dJ
         mXLJFxUQpxJRk8AoLPrpVld2yxy+rnEZ27SVs4sucBsS/gh4ysAt2v8Sb3NYTvKLbbwp
         gnyoxQucwzZ/drshK01M44BV82RcRJSIAZR6DCxlayhqty4fHhF2zet/N4s0+0s6YMAG
         1P4xhauhWpc3KWUU4y91d9eOkwu7i5O2/7msOc4bWQXy2y56/IM5VAWGRNNwxqyqr6Sc
         CqJ03MTL4YlyjH8dTOuBfUGnYRYyi6SwCXAp5xyfGwheQr3U6dtDFHT3dL8rn9HPMK1t
         nDnA==
X-Forwarded-Encrypted: i=1; AKwUvBx2OlWi3vY+4o4xrvZbQIJ4f+ym8w6GRgKsilf20EPbwSGprD8MbaWgctb2NW6vEB2xlPy5qD4QnXplcg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKzmeLZgWrA4TaJrLzQD3pUBD7tEidZHD/92gE9hLZt93LknRfl
	2uvwhpvjQeIShwn+PP7nvmm/McYZ3I1fe4Fo30F3gJhQOoVcedKLhaZe
X-Gm-Gg: AYBFou1ZCEiFmnmKmFH+rrU9WbIM2uDnhYPQwJnxRAzjPtWTx5nE6H5Hz1DFjOnTSeG
	4e3MgjT1WUzVzxcX79a3vkq0TSVziHK+WS9UYVTIstv/fNAyaT0XIOY4fmgscQ+Pv1pLAk17qvO
	BEbHnewCVFxVIPOVoodOyHMhq4rgkVom5hMvdnQTfoIa8SrsA7mczvI7nbSJ05ucm6JaeYF25mq
	1SnD16YvziPW9d1gCyLDQ74835L0hWq+xNnADksOiJLHdf/jSgbEyLMk4xen4KGepvrNKVNR4g1
	jjctdF3ZSHcnXGZF9CaQhAImFEX8VBPYMvC648MciJyTMAuTmm4DwIco2NjOCvJRUOujhOw9TFI
	hVc7j/C1ZJFlLMNSxer1N1EHPXEal+SkyUyUwBpfRI7+zOERT9iUapwStPk7s3cRmxfFyg+vkcP
	bkF9W+qWYwI2cQtZ0DQ2f8Dpn6Biep6ec0dM6ioLnXYnnWXTtUnnMsVKYP1YZwgK/dvZjHrEFqG
	TMlhssRayHrKDz35Om3ZXxamxiTr0tmPxWo09ijp/YQqFM8YzvODHowPOuDzyyz/Nj2umjo7g==
X-Received: by 2002:a05:7022:295:20b0:151:6e80:baa9 with SMTP id a92af1059eb24-16a5e49fdaemr18617461c88.12.1791954811647;
        Tue, 13 Oct 2026 22:13:31 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm51629125eec.21.2026.10.13.22.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 22:13:30 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Rishi Gupta <gupt21@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Andrej Shadura <andrew@shadura.me>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	linux-input@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
Date: Tue, 13 Oct 2026 22:13:20 -0700
Message-ID: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up internal HID core and hidraw header boundaries.

First, internal HID core declarations and unused symbol exports are
moved out of include/linux/hid.h into a private drivers/hid/hid-core.h
header. Next, a hidraw_instance() accessor is introduced in
include/linux/hidraw.h so HID drivers that only need the hidraw minor
number for naming or debug logging no longer dereference struct hidraw
directly. After converting the drivers and dropping unused
linux/hidraw.h includes, hidraw.h is moved to drivers/hid/hidraw.h and
struct hidraw along with its internal buffer and list structures are
made private to drivers/hid/hidraw.c.

Dmitry Torokhov (5):
  HID: core: Move internal declarations and drop unused exports
  HID: hidraw: Introduce hidraw_instance() helper
  HID: Use hidraw_instance() in drivers
  HID: Drop unused linux/hidraw.h includes
  HID: hidraw: Make hidraw.h private to HID subsystem

 drivers/hid/Kconfig                     |  3 ++
 drivers/hid/hid-core.c                  |  7 ++--
 drivers/hid/hid-core.h                  | 20 +++++++++++
 drivers/hid/hid-cp2112.c                | 15 ++++----
 drivers/hid/hid-ft260.c                 |  2 +-
 drivers/hid/hid-input.c                 |  4 +--
 drivers/hid/hid-led.c                   | 10 ++++--
 drivers/hid/hid-mcp2200.c               |  1 -
 drivers/hid/hid-mcp2221.c               |  1 -
 drivers/hid/hid-quirks.c                |  1 +
 drivers/hid/hid-u2fzero.c               | 10 ++++--
 drivers/hid/hid-winwing.c               |  1 -
 drivers/hid/hidraw.c                    | 48 ++++++++++++++++++++++---
 {include/linux => drivers/hid}/hidraw.h | 32 +++--------------
 drivers/hid/usbhid/hid-core.c           |  1 -
 include/linux/hid.h                     |  8 -----
 net/bluetooth/hidp/core.c               |  1 -
 17 files changed, 100 insertions(+), 65 deletions(-)
 create mode 100644 drivers/hid/hid-core.h
 rename {include/linux => drivers/hid}/hidraw.h (58%)

-- 
2.56.0.385.gd3acb90ef8-goog
