Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C23B95F2
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281691; cv=none; b=Z2X5GTsmTI/GoWz3doAjaP58A6q35M1fmFolnEqPx0N3VfNPE/i7dhdeyvLonlT0cOUvFmDe9AO056rgSHzQdpxJlVuX0OmvScz0hhZCU/1173rK38PQ7CGGXSbVPRlVkos7exyJEnOO0NyMBMVPmcphdMGdawuUSOz5X3EYN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281691; c=relaxed/simple;
	bh=LmRSwQX52HdCSQ6DgmgIrFMSbUGlSX08R5zAJjefNRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT8zFO80HOcT50fEia+qGF91Du9tTjyDhYAedARAJcZdFNisvdXJX+w2h/udnJi5x42ABQlza4iM1roJtAkdNZoFrU405+ruIOwlb8WGwzDy+TFB2rzO7+8FbanVcdp3keBuDV5cm8Nhx0LIEqI6xuZoOOcsvyd5DQqF2uUPPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Yvpef8nc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Yvpef8nc"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7982c3b7dfcso40494077b3.0
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281689; x=1774886489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgN/E5MstV8O0ZehCwcajMwfgG6bTnMGl7IbsNbuSbg=;
        b=Yvpef8ncSCd/mgYgKB6DDojYjCqUdSXzm0Imxo/VsLFBrKTiZ39UcRbhTlARyeIkeu
         zqiln+ejCXT6pcaOuyLOK0Kn1piVmM8gKaB1QP6LJ/f2yVn35uLAK9NVwrkYmNuhrQRQ
         ckSk/w4EqmdE6YtectdRdWmqTqyc6LgHiq/onmWddp3WIW0uoHlDc0J8wexbkmYmL9d+
         omBSzmgqVEQBWpGfxQBBb+O/ro+vUqR9Qt/4piQICffiXSQR3NqL0Qu7Q1fzOfYR5fGV
         rugc0aj1/S5Cak4xRlTwUVTIDNChsAn67nu8eTIbv2wJ3HELfPmqHW8WRiggspNGkg/b
         c3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281689; x=1774886489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UgN/E5MstV8O0ZehCwcajMwfgG6bTnMGl7IbsNbuSbg=;
        b=qsZMm5Qd9d5t8u3xu+3X0uzEKxV/JWIoZ90lL71XPgUE4s/g9TMG4xOK2JR+epvXvS
         1lBq7vJebycfOw3IZnhsNqFqgMv6WXn2dN78XftDNbX5fULGHZAghqSVmfNt/RJ3a0Mv
         NaaYA69rXV8MiWbHDLuR3OcgDe2f6+2i83PX+NILxUCwtoqGHUy0GvouEbjPVKTYfSfh
         AqtszxiEQXU6BPl9bYcNr6N7tSl3sAs//521Gyy+hXgEZkDRwmQZhvPIH7De8IVVKa4Y
         Bva3cHbzTnydch/PRAGnxfA64ryRJ2lkBMek31gmyYV5YIAPXWaSefHbxdpJL439p8ks
         gy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrUe+UuqAGPEcLCs19JUEnp1H4RZX6DQ/tOe5KTWOKors9Gfr2MP1bGQ+86JAag8RhXUya3PGHWXMKzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+opUZClZEQccUj18k/X1v6UERgN5Xgq9C8KzEJ4/DWPV/OoU
	LzH3M4i6bGSfVamCbsdF8kIFQu7nVnx2Lae9LN8Bgz5f2E9ysHZcO1s3+vPGebFGgGo=
X-Gm-Gg: ATEYQzyCPUzFqDiSgFh/IyTjQkFH2vCly2uJBcDCKqodXqehWr1AK1NLY84oSDyuOaY
	a4Jiqjk4vs/Dth3cabt3WqXL3Lb8kUGREjdrdjGaE05jiWFJYKj2CxALxs72SER+h4kEqZeAkYp
	E4Qy3tgDjiIOagQsdOuxqTootFpYYEEIzCT5wh6Clqj8H9EJ02uQ9qtZ0CFLHOCBBMJglRk2Ggx
	w6pCejudp8uc1vILJmQXAoXFGvyE5Dodu2EttRKF3ZcHojORNZHYaVrOhLsKyC34zTaDGp3t8tx
	X/azo+u8xhRT7O2mU+HQkWbNMIeGDWtK6agXR0X4u/R1WltFGYslQHbcawlxzmD8z+3TamrRTTL
	RYXHndBP83x4w+MDuHyB+qE2Tz+vG7WLtyeq/Y4oMLZB2kdgSdorHcJleR7EKJBXghL4GKA1NWn
	wXTbmIQNEOBLaifxjgQYYbTyCpJ/gktohe8R2/EaRg9vgazB5CPZnQqt9ps+7N8CYsz0EDJvE95
	Mto
X-Received: by 2002:a05:690c:d88:b0:798:7821:8b8c with SMTP id 00721157ae682-79a90c25bc0mr126905677b3.49.1774281687685;
        Mon, 23 Mar 2026 09:01:27 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:27 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 11/19] HID: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:30 -0400
Message-ID: <20260323160052.17528-12-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index ed3405c05e73c..8d36ae96a3eea 100644
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
2.53.0

