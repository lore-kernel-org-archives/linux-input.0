Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A053D3490
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751164; cv=none; b=bljBjlJWoHasLbqD2nlvOwU+eQyIyeOI1wsPjZ0wIdHEqDozFsqHwJESxZ6Pmh0mnrkNOMXMjw9OkFTXRBs+yB3uUzWYUZwF1n9PswcQLEWtX8u3ny91zOgeI2ixQy4Axnkr+Bt4dlSqDGH9CbFPmRXJtSJYEiCRgb/yl9EeeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751164; c=relaxed/simple;
	bh=rZB6cVP+OB68GQ9mGdUKO+TcRKpuZdabKai7x8UMJI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZkBgejMzbcxjYDz+iI1kr1/2cVFoY3DM9N1gDhq/tzkhZwm0BpUa1Pg8ampn2B0cYDUqbZTI4yTKEUunOOXfoqMG931rKXTnrGM49l8kgUN3kdmrE1/UXwRWlR+4xUcQ3eez4lpmCtFDjAwAX91FeNER9s3dKf0z3DOxdkXAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K06+my5v; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K06+my5v"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45562c41ec7so3859760f8f.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 02:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751158; x=1779355958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xKmC3f9l+RG3PTmyEhaHWpzz2ePbx7CweTWHocme8c=;
        b=K06+my5vcQEgaWNs9UVMQZyL3U0bos8Nvf/4lGC1tCTXoBNqCpqS6SGUgIZC0Gbwau
         k0a5YhpXoOIFDn05fRAk4eOpz4FS6+iup+DN3mz4BTVNsDBtztfWf4VLG24lbcVdVLLM
         0Fap84qn5CLkZ6sEFDn7Iq1WwlACp9AOHsL5uhCEv/jU7Fy1xCxdkgGA9MGh2Dmze2dj
         ShifqMdb6dfUt9MBkTBEsX8EEEMgbBH46RN2dx8JTygxVpepSQN0CXiB7F0lvAfaPu67
         2jYrtg2j+xOOacr0PFzwkD/GkKTT8mEwjTlcnMdMgrEayLzyzo0t+QlENFrJrdhGBKNb
         1dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751158; x=1779355958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xKmC3f9l+RG3PTmyEhaHWpzz2ePbx7CweTWHocme8c=;
        b=enRgMUdvnc/AxE/1pWIcqyY49PeFr8dfLRpxTcjXlW95ghZHBUY+krHYK006jxdiRu
         9fD7ZTk5+I2ggzErbBGDp9GAUwUvmmAuN8b2Jw40+7++lOI/o//nvIGxdoaB4PLrUSqR
         4x5VmWZ5E/vpX+2h8es5J6yNFxXJwUPfS54NZ0UMuasM8NWuE/ydHAOxynhfZ8ZABbzG
         yYQd+eCIXf+ZRydUYiWlJkUUUMpfc9mwxoLiKagMPDLth9i92j8IsL7tekjJj4hyfOHM
         W/hehmfYtI7Q4IyvqG6fzN3qbFa+h3L+3OwCBF5UvnqClMBVdSiLbniJrKGEEsQnvMe3
         FZ1Q==
X-Forwarded-Encrypted: i=1; AFNElJ81OfBINdx52s+lzoBuImCxMqlC88BtZ88CAM3h6HjCeIT3scFCmK265tcNBDb7OAyDEjHFquFtNOOALg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8r6lofo4EA8k/fhTbrtIK4TTPrgIEXjdjJ1srF/EU4hweEj7E
	XhOIZTcS9zo7u2vWk1BVyOvZNhhcPuyx/85zW8MrMiBDdsVSyGodSJ2cTUYAycdEu2cy1N0LAVg
	THkD2P1g=
X-Gm-Gg: Acq92OH8L5yQonwjJu0A5s/iN9NPifnO0NtJ7RBwxQiZqMI1oVuAqrlNAko3j/Y2zdz
	7pvvbECDJW/OZPwUlE7xQuyA1OyP5oLya9DRuC7PfhRhxky+wmBRyUjBVWx6E6FLBKrpPtn+woK
	6TVJhUQBkM0eWRWSQjhu96lV+yGtA6cCFchwcQambrnEvstSUtaNW7Q/Tf8qT3xBjwZvmvJ4om6
	4nPTTDsuCnqAmBkmTN/fSgYNibDOrvOJOwkN7WkwVee08cx6FxpzoyZe8Uvw7IIxJ4Uksk24xw/
	KxOGaFz6dtq9hqzBRseEo+3cD7hJOz5eD5ZC1vO9/I+pzvRzyp/wo22ALrkqrGlLr9qaCGr+n6M
	+Spfnw+q7xBZDMvHxATuhumBhT25hc4EzelWH15aRr3LycUirheXuJmQfYmqoqQR+adlSa+Bi4I
	F98yK6CWHiMauP3eZQoO9yFWLobdUczS27
X-Received: by 2002:a05:6000:40da:b0:450:e33b:23de with SMTP id ffacd0b85a97d-45c57dea159mr11278250f8f.2.1778751158215;
        Thu, 14 May 2026 02:32:38 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:12 +0100
Subject: [PATCH 5/6] tools/build: selftests: Allow versioning LLVM lld
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-5-6cac1a9a4c8d@linaro.org>
References: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
In-Reply-To: <20260514-james-perf-llvm-version-v1-0-6cac1a9a4c8d@linaro.org>
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
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, leo.yan@arm.com
X-Mailer: b4 0.14.0

Building with LLVM=... could result in a different version of lld being
used than the main toolchain for liburandom_read.so because it's
hardcoded to "lld" in this makefile.

Make it consistent with the rest of the LLVM toolchain by adding an LLD
variable to Makefile.include. Keep the fallback for other architectures
in tools/testing/selftests/bpf/Makefile as it seems like it's something
specific to this make rule and shouldn't be global.

Clang accepts either a full path or "ld.lld-15" style inputs to
-fuse-ld= so this will work with LLD defined the same way as the other
LLVM tools. However, for full paths, we need to use ".../ld.lld" instead
of the generic driver "lld", but I don't think the original use of "lld"
was significant as this is always a linux build.

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
index 6ef6872adbc3..44ba829e5d4d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
 
 # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
-LLD := lld
+USE_LD := $(LLD)
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

