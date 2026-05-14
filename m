Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E3388396
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751155; cv=none; b=tKId5jMTJNyTx3mdsqnNzh+5TUDk+ZkqHfdSqOwqHQRujgNQgPbL/kJOAM8XaJCoZki5DwZlg0Cj8Qtdk/FzhN+VLJWLvSfNCuygGcaFAmDBjP8fx/DVsuZ0DAIVyfGsSqj9QcH+N30zNDhiaFhz/Qz656H1RsOAtftkhha6S4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751155; c=relaxed/simple;
	bh=i/0OlfT29DMUOjLxI+zP/lSGgbixizaY1dSO2x2Y5o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mV8ZGpw6FLiPLd4nU/jcz2/O1NgC/ti665UoXmajwBoVu3eq7M8EZfl/ETreYv+aNUkZpibTOdaHH4j5nCEPaiINzI8ZIQVAjmhjX3I3HQhJ7WsFJEftfrH11jX/ozsa6CZadOU38HstrTQnFqovqeX7cImzuX15kuovig8BTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oc7N0XCg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc7N0XCg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d73422431so5752794f8f.2
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 02:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751152; x=1779355952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYpkMhrLfOeREVg1A6emQSE4RLjyH6VWZIyJ8FRo8sU=;
        b=oc7N0XCg782m9kROF0mMVqhvI+mqc+mWHOkCKhYDuMP/h4u5PyK9qxx2prNIN3/cNd
         ghQ52IXpYduOnFmd9tg1goxIuU/bXtUn7UM6JHippkIbSBFNW888MKrLym4UIJifvqdM
         b4z2tS3jU6XHX8bq61x+MwMek8tUBWohFXc0vcsk5KF16WQU08lqbQRYcPFZIJVUvpYk
         sfmSgF+Kx69FAqrsWRGZrAEswJBSKL7qAC+TJ7eXqdFWZI7S5U28FF0mFm3J+fwnhQfs
         atTBVhsx5Dp/7+iXyDJFRJE/51d9UKVbYRjj+Oh8T+3PDBGTcL2tn003lVE26x6b0Us/
         UcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751152; x=1779355952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYpkMhrLfOeREVg1A6emQSE4RLjyH6VWZIyJ8FRo8sU=;
        b=mOcwHBXxYqTyPXZyDmGP3jz5sqpqHUtUCReeQrMcZFkCtyrOju3h0G/TU/KAr6XLRx
         TXl7CANIVqHax0kB7f2D4k+Mgg9s67YqDjoZRhNpkreZ3if3h8Rmp62f2I25ZjZB3Z7n
         ybSNzP1Pu64VZ2tZ2wvYzZ+u5zq5Jk8YLt9woTIv/gW5OpkIAujeY3evjJen3qmi0DOV
         EXUeG4SkQJoMnotiDL80K2wz6MlEHk4JsLYAHWtzA+CZPHZcIsIDUlgqTsErePMISmAK
         89OuQeiuGoXc1pGwwHs8GLiWvfNRPJ7ZNt6OBIrywsVwSnBWhOtQnQEZKop1sCEb1+45
         Pgzw==
X-Forwarded-Encrypted: i=1; AFNElJ80EPC78gCjg2A3C5XvOCXFh0CZKy08lYAgPacOVUzcDLYR9QZzowtYU7QX5LqpvDrAJnPsYb+hgB6/yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82YWhNEUlxBhcwbGallUTFTfwgHjNl8WBZN6HTE5r4eZ3ilms
	ajqXb1oRL6J5jd8jweZlsAkiMJZyGYL6sh4uXKHlGF83iQxOSz0Y+CzmTbdGYSCC1WQ=
X-Gm-Gg: Acq92OG8dv1g/heIDe9YPWPvk0LgcDgsERVF8z8vb2j0XBZ2gN8QULLGCcBeg7jMDoM
	Sggr/JUMNEj7+iK79K1yIGT7ha3cPSCom/YU1GLICce9w7Vv5ErfcvFXxGwd8gbxzAAvDEr2cPX
	j4Ih6Rw1fknnK9E+yu7Ae4V02ZlBO6AipVTXeLY4EiMbSu4eyz8ePECEyf157PArz1A3fZ3DPoP
	445yZjwwvUaTuPSg4/xIUHNd4AOnj8VtSZqgx4xIob5jsOk1xNmTBpTaeh50JYhjE1V5V25XuJK
	uZULlGB9JQniWKx8BvrStXpgr1SejUI/Osez+sr5RPVq0QZjBD3YGteDagtruJPEXf1Frzp5pNf
	lH4mAiHLaCx/OGt2rvCoQs7PQ082tjI4/BoaGLEeWYov0JgNLw6PaAdoaNVghvacLl6Dn3JQ0tU
	+xE6ySupqsupsEIl9yOijuFAaNpfh/+y8e
X-Received: by 2002:a05:6000:4014:b0:44a:2555:f8a9 with SMTP id ffacd0b85a97d-45c7814a511mr10431648f8f.10.1778751151725;
        Thu, 14 May 2026 02:32:31 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:08 +0100
Subject: [PATCH 1/6] tools/build: Allow versioning of all LLVM tools
 defined in Makefile.include
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-1-6cac1a9a4c8d@linaro.org>
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

The version of LLVM tools can be given on the build command with
LLVM=-15, but this isn't applied to all tools. For example $(CC) gets
versioned, but $(CLANG) doesn't. This causes a Perf build with LTO=1 to
fail with an error about mixed clang versions:

 ld.lld: error: libperf/core.o: Unknown attribute kind (86)
   (Producer: 'LLVM18.1.8' Reader: 'LLVM 15.0.7')

This file has two "ifneq ($(LLVM),)" blocks adjacent to each other, so
merge these blocks making it obvious that all tools should be versioned
consistently and there is nothing special about each block.

This also reveals that ?= and "allow-override" are used inconsistently
between the blocks. "allow-override" is technically only required for
builtin variables, but isn't only used on them, and doesn't do any harm
if used on a non-builtin. Make them all "allow-override" for
consistency. The only functional difference this will cause is if there
is a file level definition of one of the variables followed by an
"#include of Makefile.include" which will now overwrite. But this isn't
done and in a later commit some of the duplicate definitions will be
removed for good measure.

There are also some other LLVM tools that are not defined here and will
be moved in a later commit.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/scripts/Makefile.include | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 41971a68972d..7022e78208a2 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -61,10 +61,18 @@ $(error Invalid value for LLVM, see Documentation/kbuild/llvm.rst)
 endif
 
 $(call allow-override,CC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+$(call allow-override,CLANG,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
+$(call allow-override,HOSTCC,$(LLVM_PREFIX)clang$(LLVM_SUFFIX))
 $(call allow-override,AR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
+$(call allow-override,HOSTAR,$(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX))
 $(call allow-override,LD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
+$(call allow-override,HOSTLD,$(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX))
 $(call allow-override,CXX,$(LLVM_PREFIX)clang++$(LLVM_SUFFIX))
 $(call allow-override,STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+$(call allow-override,LLVM_STRIP,$(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX))
+$(call allow-override,LLC,$(LLVM_PREFIX)llc$(LLVM_SUFFIX))
+$(call allow-override,LLVM_CONFIG,$(LLVM_PREFIX)llvm-config$(LLVM_SUFFIX))
+$(call allow-override,LLVM_OBJCOPY,$(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX))
 else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -72,26 +80,21 @@ $(call allow-override,AR,$(CROSS_COMPILE)ar)
 $(call allow-override,LD,$(CROSS_COMPILE)ld)
 $(call allow-override,CXX,$(CROSS_COMPILE)g++)
 $(call allow-override,STRIP,$(CROSS_COMPILE)strip)
-endif
-
-CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
-ifneq ($(LLVM),)
-HOSTAR  ?= $(LLVM_PREFIX)llvm-ar$(LLVM_SUFFIX)
-HOSTCC  ?= $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
-HOSTLD  ?= $(LLVM_PREFIX)ld.lld$(LLVM_SUFFIX)
-else
-HOSTAR  ?= ar
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
+# Host versions aren't prefixed
+$(call allow-override,HOSTAR,ar)
+$(call allow-override,HOSTCC,gcc)
+$(call allow-override,HOSTLD,ld)
+
+# Some tools still require Clang, LLC and/or LLVM utils
+$(call allow-override,CLANG,clang)
+$(call allow-override,LLC,llc)
+$(call allow-override,LLVM_CONFIG,llvm-config)
+$(call allow-override,LLVM_OBJCOPY,llvm-objcopy)
+$(call allow-override,LLVM_STRIP,llvm-strip)
 endif
 
-# Some tools require Clang, LLC and/or LLVM utils
-CLANG		?= clang
-LLC		?= llc
-LLVM_CONFIG	?= llvm-config
-LLVM_OBJCOPY	?= llvm-objcopy
-LLVM_STRIP	?= llvm-strip
+CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
 # Some tools require bpftool
 SYSTEM_BPFTOOL	?= bpftool

-- 
2.34.1

