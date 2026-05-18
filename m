Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B533E6DD8
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095061; cv=none; b=HheGt/Ycfp88Hhh3l0HEv4kF4VDvICh0ON1nlTH6gqxltNXutM9S/tWGK8VH5buhxAZWQystluGjijR11F2ADzQVycBB5OuZGhRm1jUODT3FDcLf/mcNIOT+jYPwbReGt3t3PONRdnT/Puk0jIBdyUKW9nQkwPh6ccDO5MprPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095061; c=relaxed/simple;
	bh=VNADPzNywG/CBzEz1od+vE4Iyn6WTlo+l45ZhJwh9Ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2mKiuFi/gNrl68gXMt2ZWJewyU5Rzw+XwPwTmhBOjtOCT7fc/eoaFqGRKprI6Kua3ENwapYJitaPYX10fh7+927NPkpuFvn7F9W56hfYZH+K2k72Pm9MgYHHPg0uHvznCrM+W78iGrD40Z1ICxnRSL/GKBnjnnXsrsP1yny7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxfCx9wq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxfCx9wq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1015386f8f.0
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095057; x=1779699857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bn8F5gVJpOGPGF8wz0bSPAbJHDWXhciwJhA1pFc6s6s=;
        b=sxfCx9wqOEw1p2gLRQZSPHrDa22AjIxtqfnfnSSMh+RARllOwCq4NtsGCFlHzGxXD/
         HEJ5+8R1tX/AIo+ibR6E7PskrF8ZWNvi5So8HgnqyohvFzbanpU81j7TwIzZhGn2uFID
         DT4yfKMHpv9Be9JIxt1Tbql7LPc2vIjvV7OGrygD26OgEzYXLzN1qIob43l7tobXb6IT
         N6cLqii7fV2N2FnIrgOOtVsBOv9D/y2B5phPWeTkHGRHhMF5v3tmNl0A/larnM4Z7nKs
         YYqmcf86EEf+bOduQiFn+p5ZzoDHBevyhPfajvouiZwD5FDMSmTi/FNQ1QYUNIX1W0TM
         tTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095057; x=1779699857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bn8F5gVJpOGPGF8wz0bSPAbJHDWXhciwJhA1pFc6s6s=;
        b=QSnGTLwYnkDxysZRyGri85X8hl2xvbRL/7oDYm2DnynYfLd+kJlFAqB/g7/AyCv5ah
         ynUE4lqSX6QREgAVA2NizY8RKE1S3tiU1W3d00RuTor0l+UOZPRMmIg1q0YRllhrxUig
         WSg+GDjwx932ftjuFNJoKp9Vykzma/NarRWHhJl/og5NNB4GCY+U74CDWEwNrh45foPT
         N3irALnr2N9FYC5df44fTDULronFme3WB35uLoAMeQE/0GWEXwHnFtYAIXEHMsHhEa4r
         Y04z0Ci799lCu7hOKG5w02iz1plTUwVL+mzTCtpzc5Pfup/lVmQML7s6oPpLXvQJGfHL
         tuWg==
X-Forwarded-Encrypted: i=1; AFNElJ8FCnw69y8aLVNyHSFra6AAHt5uYRP6K7LG8juDekWjdMOxsZIcInWvV19g048vDkHu8veI4evIJdevxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrwWQzp/tN6tpvQ6xWsanPMcMyiNtgzXdmU2bgE5db0mq6ufH
	wTh3FLiDt4p9UViqNNcaW3iKjcpvDzgOYaiQb2uG9nof7G+UrPY4z5wnoXc/qi7BIY0=
X-Gm-Gg: Acq92OGBBdNLMmpgEuf0jI36CSIlFZlCRvPzz4knWX5tUWfmifFgbaNoHLNmfwSajuV
	ZqSUVkDCyQk9dHQ1w6aO/znW5MaMNvu6WvUMcqrdJWWbdxNnmKtDogWNswe7cju/gWTX4qi2EnY
	TuIXa1hu1yxG9vOpRcBDYiKxezzRRx12hmrSUMpRuVYOp0OZMq2naNokgNJb+MwV01loRcLELDI
	azMy6+wGDIeb8/M4VX34QBBqu3XeJVQ10JqZ7tzKsF8iPRj7CdUbbZSB/46UtSs1GyLuE+NuYR5
	fKeyvR+/d0pCb9JTd+S9ZiIRv7nHY32uvIRqIrRONqWfZ1LnAsLEvvuOXRGSunySuZEkfz5WQef
	PQxfrONMq73j/+axcR8U2PCFD5/dq1lPe9RWnBJk3rFSTfey3GDWGMgfp09AyS2WLPT5FawkB6H
	0prSzGB76JyySBR/w8TBDTZFnltuEYC9N/
X-Received: by 2002:a05:6000:2c0c:b0:44a:46bc:e5e2 with SMTP id ffacd0b85a97d-45e5c5b3980mr21428210f8f.9.1779095056738;
        Mon, 18 May 2026 02:04:16 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:11 +0100
Subject: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
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

Building with LLVM=... could result in a different version of lld being
used than the main toolchain for liburandom_read.so because it's
hardcoded to "lld" in this makefile.

Make it consistent with the rest of the LLVM toolchain by adding an LLD
variable to Makefile.include. Keep the fallback for other architectures
in tools/testing/selftests/bpf/Makefile as it seems like it's something
specific to this make rule and shouldn't be global.

Clang only accepts either a full path to "/x/x/ld.lld" or "lld-15" style
inputs to "-fuse-ld=", so the only way to make it work with both
prefixed and postfixed paths is to always take the full path. Also I
don't think the original use of "lld" over "ld.lld" was significant as
this is always a linux build, so that can be changed to make it work in
both cases.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include       | 2 ++
 tools/testing/selftests/bpf/Makefile | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 380ad84ac51e..5c2d505cba62 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -67,6 +67,7 @@ ifneq ($(LLVM),)
   $(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
   $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
   $(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+  $(call allow-override,LLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
   $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
   $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
   $(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
@@ -91,6 +92,7 @@ else
   # Some tools still require Clang, LLC and/or LLVM utils
   $(call allow-override,CLANG,clang)
   $(call allow-override,LLC,llc)
+  $(call allow-override,LLD,ld.lld)
   $(call allow-override,LLVM_CONFIG,llvm-config)
   $(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
   $(call allow-override,LLVM_STRIP,llvm-strip)
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6ef6872adbc3..836e783f0170 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
-LLD := lld
+USE_LD := $(shell command -v $(LLD))
 else
-LLD := $(shell command -v $(LD))
+USE_LD := $(shell command -v $(LD))
 endif
 
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds
@@ -258,7 +258,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
 		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
 		     -Wno-unused-command-line-argument \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
+		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,--version-script=liburandom_read.map \
 		     -fPIC -shared -o $@
 
@@ -268,7 +268,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -Wno-unused-command-line-argument \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
-		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
+		     -fuse-ld=$(USE_LD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
 		     -Wl,-rpath=. -o $@
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c

-- 
2.34.1

