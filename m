Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2793E51E4
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095055; cv=none; b=d8gRB65iKS2W9DR18UknssGVDJk8WMjwXoGQal6+Pq+Px/46tI3H1sXJ1Ip8qm0BMGUpoj2ErR/60tM3ng45+3khG3i+WTwbAC029DUF65oXyvL6UMmT1VzO7VTqoXtuVzZOuwwO/OUxumpjgcmPHGIapGrwTZANZ3g/0kj2f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095055; c=relaxed/simple;
	bh=NfaBRDzFvFklhzTH9t4p9EVBdLk/XaHTDMg8o9QY524=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cA0gLJGsCh9PyU8i5Vg32ZffqEHjWyy3D2pX6JpcbOSo51S8yBoxj1pXSJtVe5+5MhFB1hw4QwdvBu09Rtv5LxM5UqsK6kPZO8RXlneheOG6n+8wJ0ZKB/APhrxcYCAiw5s46/yEQguwA4FQj/zPxOwNezsql2Tfq7EAt42sIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJirnelK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJirnelK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso1032832f8f.3
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095052; x=1779699852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4dQGlI0To3jzdG+Zpi+3N86C8iuvnWf5obCtCx/S5c=;
        b=uJirnelKs1tdcsFLurQKHZ/CCHfP0RfbhTZxz1Cez1jjAiTAJupKKuIyfX9d+mIXrm
         CIfQ3vl/qG/iI5kEsWWjR7+W71lmVHqyBOCwv9M/F7/BTCSlvPzEtq9H9/Fdj8kZ2MYv
         duCB7iwt8ODSZUEGRIGEtMYMki+uEz89A9+4DZ1raiJ56Viy9+mNqgGF6hnG5oEck5rq
         gwweJURY+0a1vwBP9eu+sUUut9Gm8yY1cN+m/UBplilLUVYXUfmQ6eWFDgVY2PTVeqKG
         BF3vxejlSKCob5G6muIuV8aooNceMGOcgp8ZYTrdHILYSb4CE/LHjaikIZJZyooolU7d
         Laxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095052; x=1779699852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o4dQGlI0To3jzdG+Zpi+3N86C8iuvnWf5obCtCx/S5c=;
        b=MDKADe7XtoiZ/XoB9MnzZnplbOBl0It7xbKKFAo7ASUyAui8QCMJDNi7We3PzHeOFK
         2jxtGbku0ZtQtZQ95UHJZa1M1vntRx+jyxB9ZWTD7gW3TLveQ1KecUtggCEV4o5CMACR
         JhUzNZnjs1oHxr68wfXwxMYAN5Pv0vGFx9PxqG3Lr/p5RLinS3Ob7uQpd7AIwMi6emvu
         GZZA017Zp0DLz9+tYsVEqQ1uMMgd2pVOwt7ofNsLRhiRy7R2qeN6U0HG+bCDRk9sw76B
         Z8X5kC+CXW74zLKsDY81U4dYHy9MClRX0I1iJVhNqy3anHco4nvD32Yk7+5Efj+8Lyeo
         aNqw==
X-Forwarded-Encrypted: i=1; AFNElJ8CVq1jH5T0L8pqyePC89PMd5ebibbdrgzBQ80vd3k/n7MjXOZ1RelPnf0UJxekCsHGaKEeFtNyVpPdtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwxL7zfiK0SVspFMZIplrtMpeHSwUGQ7GKAJWyqL0psyFITXJ
	5AIWZSf5b+QVjDlzQoR4yhlqe3NjSvKMDK3xvF49Mpi9bZmGj/SZFUTxIPXJQ4zW5QU=
X-Gm-Gg: Acq92OHFbjW3l3YPF0uG/0GX/0XmQuxgQPS6+dXe1S6ocW1dzQiHBrOwtaVIiojt+dm
	e7vnjsUOlaGTAghNDGHr9C2nuWmxSuPg8wGL8euN/1n9SwLDZ3ETr+hfcoo+lbYJclK+O9ZrwUh
	4+fRM+TyTzim5bkC+Acx16UJSTFkK3pGrdCI5G90gC7mrxRRiK/vChxTu3MPKD5AQDQh5gssSDE
	P4r/6nKr2WFu3cUagEZ0mGP7Bw2sUrQYvBl5+5QQP8HSICClxT91MUSwZYrGCk3MzAawZ3dcJdZ
	nEX7P3b6wg7muLKi8DYg8deUxzEtsSrJoFs+6bhzFnny6BvQ5BnvczTUGBGGKnxn30TbRrOZz6B
	x4RSApE0u2gUgbSGwys2OKTLzQLe3z63dgPIlijVWliTuDsQDXDK1UsOentsUmthjwfcKQYSkoA
	9WRhquXpExxZFQ2p/Wuu4hXZUqXaC7LdY/
X-Received: by 2002:a05:600c:828d:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-48fe61eb313mr207432455e9.15.1779095051843;
        Mon, 18 May 2026 02:04:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:08 +0100
Subject: [PATCH v2 2/6] tools/build: Indent if else blocks
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-2-f12cc4f031d8@linaro.org>
References: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
In-Reply-To: <20260518-james-perf-llvm-version-v2-0-f12cc4f031d8@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These blocks are quite big and unreadable without indentation. Indent
them.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include | 76 +++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 7022e78208a2..e81e5b479c56 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -52,46 +52,46 @@ define allow-override
 endef
 
 ifneq ($(LLVM),)
-ifneq ($(filter %/,$(LLVM)),)
-LLVM_PREFIX := $(LLVM)
-else ifneq ($(filter -%,$(LLVM)),)
-LLVM_SUFFIX := $(LLVM)
-else ifneq ($(LLVM),1)
-$(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
-endif
+  ifneq ($(filter %/,$(LLVM)),)
+    LLVM_PREFIX := $(LLVM)
+  else ifneq ($(filter -%,$(LLVM)),)
+    LLVM_SUFFIX := $(LLVM)
+  else ifneq ($(LLVM),1)
+    $(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
+  endif
 
-$(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
-$(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
-$(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
-$(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
-$(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
-$(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
-$(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
-$(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
-$(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
-$(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
-$(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
+  $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+  $(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+  $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+  $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
+  $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+  $(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
+  $(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
 else
-# Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
-$(call allow-override,CC,$(CROSS_COMPILE)gcc)
-$(call allow-override,AR,$(CROSS_COMPILE)ar)
-$(call allow-override,LD,$(CROSS_COMPILE)ld)
-$(call allow-override,CXX,$(CROSS_COMPILE)g++)
-$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-
-# Host versions aren't prefixed
-$(call allow-override,HOSTAR,ar)
-$(call allow-override,HOSTCC,gcc)
-$(call allow-override,HOSTLD,ld)
-
-# Some tools still require Clang, LLC and/or LLVM utils
-$(call allow-override,CLANG,clang)
-$(call allow-override,LLC,llc)
-$(call allow-override,LLVM_CONFIG,llvm-config)
-$(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
-$(call allow-override,LLVM_STRIP,llvm-strip)
+  # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
+  $(call allow-override,CC,$(CROSS_COMPILE)gcc)
+  $(call allow-override,AR,$(CROSS_COMPILE)ar)
+  $(call allow-override,LD,$(CROSS_COMPILE)ld)
+  $(call allow-override,CXX,$(CROSS_COMPILE)g++)
+  $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+
+  # Host versions aren't prefixed
+  $(call allow-override,HOSTAR,ar)
+  $(call allow-override,HOSTCC,gcc)
+  $(call allow-override,HOSTLD,ld)
+
+  # Some tools still require Clang, LLC and/or LLVM utils
+  $(call allow-override,CLANG,clang)
+  $(call allow-override,LLC,llc)
+  $(call allow-override,LLVM_CONFIG,llvm-config)
+  $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
+  $(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)

-- 
2.34.1

