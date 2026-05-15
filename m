Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1714481FB6
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853591; cv=none; b=Fxy33ZI0bxjeJoswYmaDONqoC2yIG50NVlUndTKn0+LOh9Uer14KYcRjbCWW3PTNLXyap0Mkr/fEW8OhRbRNB++l3nh3iib+Mmp0xQl/KFLiO0OTxhfGWjPVJCa9GIPZhqPqtyYEmV8hBk9RgtDughOFCABEuDeer6QGkOTcAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853591; c=relaxed/simple;
	bh=sYY7OW7wGR8JvWeAaeVWHuE+lAvepGIPk46p7xEPeuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLN0x655hNUmGDmMNd4uxSSwRw19AOTm8t8mDpRgDTXolco/EW79T7y02840XvqRUButj/wdMMpP3BB+Xz0bg6m57kxL/hidkQDvo+hhqXrPl448RaQ1pHmjP32gLm9cfO/KFtAGqoy5zYU1bsjD54viGVhnz9nfthgn9XmDMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=uIXocQZS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="uIXocQZS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e63771eb0so86050431cf.3
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853586; x=1779458386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/1EYMrQvVHAnnWAjKGI5T7/zDsk5kW5iHbfCrzqRi8=;
        b=uIXocQZSqjeXU3Yhg4dgzYk0G53PYXbwSbXugcs0wjhpZVeuN5Ky+EvoKvUJu9SCcv
         2HAcgdvXBdLgXX4/GxZXDp4KRME6rOUuMMEd8UsV/FwAe7Wmyx+Ombcxa42HaxTMIYZv
         L/lXL+o9CYlcWbceKbeuAAKXDGdie8BOCqJccW0Pod1rHCLhCNxjm25VCuVClCmU7N46
         h+HpL354ySNaXa4iN9d7NtzIUJ62AMNWwkisLneDEPg9TK80MEPEveDCs0jK4r0QP6v8
         RMEZcj/VCywPALCo4lYs89Dgp2bnO6XyftfyQBm3XKkg9x8zIScngFcg0614+ksshFrZ
         bArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853586; x=1779458386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/1EYMrQvVHAnnWAjKGI5T7/zDsk5kW5iHbfCrzqRi8=;
        b=tTszsRxGMs0LWve1c7tyQBF9RQmWEko0AuDsmvo4hj2h2lN/FOe3+Dg0SeAmSaTwba
         CxgCgPabqpfJFmawOlufZGUoCq9y2iWzSBSs5Md0kcAyvhWDVSHzSWW2aXTDIuYFfPq2
         KUwNFmWoicy25Cy+nAiJSZPI5E9EOJoVewqzLpjBPmBLi1xqZEuRbrZtLbNUBmmpSuHZ
         0UPDNiHkghTsCRvby1y3psJlDRAujNCDETF8KuBQqKTq5l/hAc8Xgpeycnb3i9k4eNhH
         93A+BlfhomIVKstkM6KFr4P5ZG47apx4foC2BvoH1kjKWMGEDsevh3yUAelZLNwMD3EZ
         Rx7g==
X-Gm-Message-State: AOJu0Yz2GNIk1gGwOizMX1QkwQcukMAWoVcGd9YM1vw5pJ3DNCrPucB1
	Ch9QRTLfXTLF2DDdrZAKV75QDQUxSZKazTo70HlD3+BVSL+OoX87UQpvVagUaNLtTwc=
X-Gm-Gg: Acq92OEmKnW/YuqurjQrIEqHgFyfxWwGU34h9BPYWdm0TjjLyCutm1gnTf4i23Rvl/B
	CEJNfgT+ywCi+fzsKWWIy65m95pwz6Y5jBwcYk4ddKlYK/0QBpc2LOdBhPkx29bJCYB0vteUQ82
	IOBpvpTmJSROol/qHkYBwE8JjO6+hhZLF3LBRhii5BxvQSepv5aPCVpl9dAdco7PbAtRLHuTThH
	3x7q7FZpaqQ+lNHM9v+04qe83VtFNDfDk+369XZoUr+/sn2J+2RuXFJk1/uBTou1bDM05V/E8E7
	8dkGTvm/ezNltbi+2dOzGiF6DW1ObWdgJ2LbC5KKnGo7eykb/8ohjBbmoaI9s9QueD9utE6Ldiq
	Sqs+3ZuPNP7QpEW2/PfcJf7Spw+jdfh1dDk0vwxgxhoVjF5sbeU/X1SvuGNd+DuaoRheByVJz5f
	GKRL2Pwc0bzG+7pTvcYMeiln6gL3Go
X-Received: by 2002:a05:622a:17c7:b0:516:508b:bf55 with SMTP id d75a77b69052e-5165a276f8cmr53859591cf.55.1778853586541;
        Fri, 15 May 2026 06:59:46 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516460cda02sm45678421cf.18.2026.05.15.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:46 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 07/11] HID: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:41 -0400
Message-ID: <20260515135941.2238861-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index ed3405c05e73..8d36ae96a3ee 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -110,7 +110,7 @@ void ish_event_tracer(struct ishtp_device *dev, const char *format, ...)
 		vsnprintf(tmp_buf, sizeof(tmp_buf), format, args);
 		va_end(args);
 
-		trace_ishtp_dump(tmp_buf);
+		trace_call__ishtp_dump(tmp_buf);
 	}
 }
 
-- 
2.54.0

