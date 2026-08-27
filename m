Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B13F106F
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868412; cv=none; b=nb4ymAER+IyH+rsddZwzsRYSw+hLUPjoSeO0yNYveNUkOhYXRUrlz/dfyIWjXQJfuUS9r4Zz82c+k4wOyFlhgoV14ynyqljea6k0+ELeg3r1LlDxfOf9L+EFR6D3r+kmTAggWL0IsnKTREfk2X5nH2+tgGQBNLZ30QcFUx00R+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868412; c=relaxed/simple;
	bh=iaHuxTL9GgUJZF86l4ALIIzy/p5FmBSH/AsEH222pSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A/NcbvERX0fEEA6sXYYx8fRTtCt1vtTGRruPgXo4E5NZ74XNA/SZZ0N0B/n0H3JWoeYlwbIU2vsqeVeRZZpPS1XA7YAdqkxaXdVwmsUgOx7MQLzgroopa8yuL76Una2BPt5lX5EXNgBGvz7yuHtalpESwHfCst+eZDaVycqeNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e0W+xDS/; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e0W+xDS/"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso834120a91.3
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787868410; x=1788473210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GW+2Hhc2UcSsdCGhPp7Ouw0/2a2zcXh23hCHwGyqeA=;
        b=e0W+xDS/Np2tDy3zyJm9EVlLo58KFOT3yPU64sTUc2NOq+MudOuwy4dsnyIdTGNVQY
         XWNSmplb2pFe9xbyfV8tC2/f3tZTY10+zmf/dHr5VwI1VGdv5aIG1mK3Sa0kcfXfQMtI
         co3bn+b8swGeXelDpK1bUoBNY+0HjZmRkdUH6wBiO08aN4GcyEEucEKctq2RltyK5hie
         jHpzkG9xpvKdYCze1II93U/Fbc91GgsJ50Kt01YM/odZpMC5Oa1LtT+iywYiWYMNkWto
         +fjjJFUecNHiagp1gf5Q0LPsFkYSRpISSlZR0CSdXfBT3imQ6BAFzQqwJk1b/PDi09Rd
         RGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787868410; x=1788473210;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GW+2Hhc2UcSsdCGhPp7Ouw0/2a2zcXh23hCHwGyqeA=;
        b=VDDO7mfK+hy/3mM8shAxX6d9Xm1dSNEdEuh4N7VXTrjnyKbekoCnofDqeF/WKdXtl7
         QmvaHigAOJzGX+8kozcnz3lUbsp4rGcIiBgDvt8KCNo+4CMj8BsVOPArBLFhYYrKb4X1
         FTRDbeZxnJIkbWXmSai67i1CjES6yR5diJTiYRFwiPN/i8G77BqSzO7yECVkH2kC9V2+
         R1xijS57tKy1S9JBiPo3uSHemnYNsR+nuVdNclS/j8DE9NULWDf6j1BTyMS/2Pw0Ajxb
         BAakw28tlBNHKGzBen/YocrBqHN5tUQTdO6RQk6wtZQY+xkv1hUfT1plJqAi1+fiPz/I
         TACw==
X-Forwarded-Encrypted: i=1; AHgh+RqZnmD2sv5PxFl3QY5mZ4BQd2iyhABZMkgARCHccSsFY7q3f/SbDsssSbG2xtUzIn+95CsNqk0eaO8PEA==@vger.kernel.org
X-Gm-Message-State: AFuF++mrcMTQGJyroQ3Io3izn/pwvoPh8er4v+4/g2L1PX0gO8gH+LRi
	h81eDEroOVXXYFhFDb6L5whEp1oO8CNNvctTZ8ENNT39y0FX3xlrDR5YJnSrWbVA0ojlx4CuCsU
	6cUusDJ6DuTz6rA==
X-Received: from dybgj36.prod.google.com ([2002:a05:7301:124:b0:328:6c15:25c1])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d44d:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-396d0c15f3cmr4689966a91.0.1787868409462;
 Thu, 27 Aug 2026 15:06:49 -0700 (PDT)
Date: Thu, 27 Aug 2026 22:04:27 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827220428.2988999-1-cmllamas@google.com>
Subject: [PATCH 6.12.y] HID: uhid: convert to hid_safe_input_report()
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Carlos Llamas <cmllamas@google.com>, 
	Lee Jones <lee@kernel.org>, Jiri Kosina <jkosina@suse.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	"open list:UHID USERSPACE HID IO DRIVER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

commit 63a694c51bf120a37550890b8e7736b4888985e9 upstream.

Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()"), added a check in hid_report_raw_event() to reject
reports if the received data size is smaller than expected. This was
intended to prevent OOB errors by no longer allowing zeroing-out of
shorter reports due to the lack of buffer size information.

However, this leads to regressions in hid_report_raw_event(), where
shorter than expected reports are rejected, even though their buffers
are sufficiently large to be zero-padded.

To solve this issue, Benjamin introduced a safer alternative in commit
206342541fc8 ("HID: core: introduce hid_safe_input_report()"), which
forwards the buffer size and allows hid_report_raw_event() to safely
zero-pad the data.

Convert uhid to use hid_safe_input_report() and pass UHID_DATA_MAX as
the buffer size. This prevents the reported regressions [1], allowing
hid core to zero-pad the shorter reports safely as expected.

Cc: stable@vger.kernel.org
Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Closes: https://lore.kernel.org/all/ahsh0UtTX6e0ZeHa@google.com/
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/hid/uhid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 21a70420151e..d16667207b9f 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -595,8 +595,8 @@ static int uhid_dev_input(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data,
-			 min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
@@ -606,8 +606,8 @@ static int uhid_dev_input2(struct uhid_device *uhid, struct uhid_event *ev)
 	if (!READ_ONCE(uhid->running))
 		return -EINVAL;
 
-	hid_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data,
-			 min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
+	hid_safe_input_report(uhid->hid, HID_INPUT_REPORT, ev->u.input2.data, UHID_DATA_MAX,
+			      min_t(size_t, ev->u.input2.size, UHID_DATA_MAX), 0);
 
 	return 0;
 }
-- 
2.55.0.897.gb25b4bd76c-goog

