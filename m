Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107863;
	b=LSmYvmGIb3pOYP4hssOFXE6uKW9f/aoGa+t5kKQFE/XwUbLBzHa8xhCFxpwYDiZP7M3P
	 VpX+/lHPHi/DJ8IcHrzivtttsLWzk8E/DdNT96puPUa8Qj7xWrn81mfqyNJKge7LkRuEy
	 rws8+RSMc71pZdxOdGcQa01S7yOvc1LUJQaJA5xUSyIQ34ipgMrrJZN1701WjVkIVuM9j
	 7/uNxC8w3ZQtoe5LB8IKB5Dfi/dVlwbWH2GUUOFeLijtnFoht3EfzV3zExb5Nk9CO/DrL
	 DQu7ta0E5ptCh5+pPfUtMvzGfA9DLFb/Z1bqvy4TU7nxs6XuksDGmAdifrmFQmM5R0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=tbGvL9tZ+BYgVAO5FMDS+XSwp11ngMpDyW2424LSejU=;
	b=bAXldSJoTGWVSVGB8iVetn9wMUViX53Q7zD9zFEh1tUJdOekJnCIas5J8JoDCPdgjgky
	 r5ne3lv9BWu+xwGJXzjwuSPdgwnvI8S12cYJHhDJK96C7YeI9o/IgAWSL5eb1dBA8sz45
	 w3x3cwhriNBWaokXH9IqeqGs489Y4imWTJCLp4NR1xx2HUOpgwQmlqf0JDh4vo1yNm0QC
	 mMQmVfKQEnDZlLdasHq31my8bBKRpbGBs9BYv5CQD+uJMcz6tMacIbWukioIbQMjYcTHF
	 dDgXJux65hiOczyFuNEcxEKYyvykEUFTV81ajKS78BcmxpwJNh+BD43CFkiOM9T91PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dgJ0q2jo;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63360A2624
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 17:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A63360A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dgJ0q2jo
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a5005fd0f8so4485904c88.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 09:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795107862; x=1795712662; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tbGvL9tZ+BYgVAO5FMDS+XSwp11ngMpDyW2424LSejU=;
        b=dgJ0q2jo/7wmzCjkkBaQyktbr2kyJVnbgxUwAktZwmw3Ka2wu9lGhG6P1FqTtQ0ROs
         pMzla42cpi1FNEKPJ9MzBc9xSTm1ay5J8+ZJrlQyQmgclzfthu5ClafSzRZEQ2IaD8J0
         hxDXgJdNmrzxORHr2U4KYB0QzakSmhaIu8Jv+PbEOpMVKjTepSM0y6NLnqrSPFvQWoSc
         su6WGlcmG28la08WzqkbwHXea3htNo7xqKMbluhMVWLk1Vu2v2lP2MFEXaQ2bC+mk/Yj
         X0ejA/gcH461W5Q2Xd7+BessAZX+frl3/D3DYZEq+HDhJEAcAzovXC1S0rhJjRbpi+YA
         yXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107862; x=1795712662;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbGvL9tZ+BYgVAO5FMDS+XSwp11ngMpDyW2424LSejU=;
        b=pRdGs4+E+CYTGICPa36zfuq3fCeUiMHl66trTAUsfM7YMBBzeS0/v7PklBvL2rRtiS
         IVQNrM+yzqTj5tvL7UH29P3wfOgYSQsnKQWXwEX3+qxTcIgToF+YlK+n+2KOP/sL5WqS
         xVrVehWvLf7SRU4YvwvkcaJh8EeW07OWr9Ar7e3TiBhHSVm2ytocd1iONDmHOsr9IkuX
         b6CmaOya784V9EHcqah8/wqGfOir0SaB2NteRwcaHtBPETTrZ0PDFqAsGZAc0sDe+4VJ
         9juWPB1yZ5PYFYWLvcBWgAZ191OPRRnYQoilzlUIXCse9E8J+YujPR2FhvncEVMui2Fc
         0+yw==
X-Gm-Message-State: APuU4Z9cRoqXRk2UyQsAVNIPTV4MEpVImTxuzWvv93Llc5sZ5RcXCcpK
	PRlu8JdiY1uBEiGqANivI+G+PdJIQ8g+CsKyuGlg7/esrcvax7CrHA/uhXJWHPmWMMmTDEkah26
	uysgs/bx8LQ==
X-Received: from dlev7.prod.google.com ([2002:a05:701b:4647:b0:1b5:330f:621d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4584:b0:1ac:9da7:e86e
 with SMTP id a92af1059eb24-1b556908c17mr230062c88.30.1795107861814; Thu, 19
 Nov 2026 09:04:21 -0800 (PST)
Date: Thu, 19 Nov 2026 09:04:18 -0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170418.1511770-1-irogers@google.com>
Subject: [PATCH] HID: lenovo-go: Fix reset_tx_dongle sysfs attribute to be write-only
From: Ian Rogers <irogers@google.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

reset_tx_dongle is defined with LEGO_DEVICE_ATTR_RO(), whereas all other
FEATURE_RESET_GAMEPAD attributes in hid-lenovo-go.c (reset_mcu,
reset_left, and reset_right) use LEGO_DEVICE_ATTR_WO().

Because feature_status_show() has no case for FEATURE_RESET_GAMEPAD
(which is only handled in feature_status_store()), exposing tx_dongle's
reset attribute as read-only makes reading it always fail with -EINVAL
while preventing userspace from writing to it to reset the TX dongle.

Change reset_tx_dongle to LEGO_DEVICE_ATTR_WO().

Found by enabling Clang's -Wswitch-enum on an x86_64 allyesconfig build,
with AI coding assistant help to audit the warning and prepare the fix.
Build-tested with Clang; not runtime-tested on Lenovo Legion Go hardware.

Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/hid/hid-lenovo-go.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 318b1152ff8b..8a2aa2b4825d 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -1848,7 +1848,7 @@ static struct go_cfg_attr version_gen_tx_dongle = { HARDWARE_GENERATION };
 LEGO_DEVICE_ATTR_RO(version_gen_tx_dongle, "hardware_generation", TX_DONGLE, version);
 
 static struct go_cfg_attr reset_tx_dongle = { FEATURE_RESET_GAMEPAD };
-LEGO_DEVICE_ATTR_RO(reset_tx_dongle, "reset", TX_DONGLE, feature_status);
+LEGO_DEVICE_ATTR_WO(reset_tx_dongle, "reset", TX_DONGLE, feature_status);
 
 static struct attribute *tx_dongle_attrs[] = {
 	&dev_attr_reset_tx_dongle.attr,
-- 
2.56.1.708.g77570a6a1d-goog

