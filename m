Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224003E16BA
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095054; cv=none; b=jzjrkDRUXC5pRBBmeMaJ/YZTmEmrK9z1aixBFnPZowCGH6rhM1+inTMUtHJ9+5K7ttjSJcpywmzrAVBpp+TWKdjkE3+ltLDqGJiLwPflXjQi8YV28IrgWY2GV8auLiKW1wylVJNCTQx0aC1pJHma0x+VdhHlO0rWlc5XoZ4qKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095054; c=relaxed/simple;
	bh=i/0OlfT29DMUOjLxI+zP/lSGgbixizaY1dSO2x2Y5o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEpshsqurF2Zb0ib8MEtbD47WBF7ivoPOv/+l1XsShdoAQKF3ylDZUMI9Hx8WBkinG0RSEj0AHIMRgacz+2Kb1oB3pZrNU7qvbMC6viXduF71igj5J2wzcRWj6pDQAu9Z+phrfT+HF77cVZTdc0bUvxN0weO1pEAGlHQ2Q7nZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W0iGl2hc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0iGl2hc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44e5624c053so1080555f8f.2
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779095050; x=1779699850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYpkMhrLfOeREVg1A6emQSE4RLjyH6VWZIyJ8FRo8sU=;
        b=W0iGl2hc+IvDGg8O89hdPF4M60uNm6FefAHNtWPf1fpEZDArGSDw1aPxpvmy5WgxAg
         Z0KRzZl+KWtzrFqWJkjnazhIs5CVcY4BEL/ge66JzVDzl5HiOaLNr0MogRMKMMmG/afe
         cBP8IgtRAd9wZ3HBxgDb6PHx9AnliIgSSPs8jF2CYy/ZOPEErKg6vY9w/mLBED1fqtvF
         tHIlaKYYhMVJ5y1cHIwqJvm4EcNI7Uu+LfvY4MZOGVddRPL5sEIKARlgDyBKYUABuEOB
         LoCzttFdmou+XiXPt+K+IxVkXhcwYgNgd4LcxQ+inNnt+0002fwCwM46M/go0E9rCPz6
         1kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095050; x=1779699850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYpkMhrLfOeREVg1A6emQSE4RLjyH6VWZIyJ8FRo8sU=;
        b=tHVBulZYjZgYMSL2+pIcjlR8MGNxUm1WspJleN2g6T8mz7khiFKyn4ItmCH0uPCzHu
         6bdthcOYFutOngyBv2ZSGKixWukmKCua8/+/8a49qtJWQxwX2eL8TybEzM7hubtYJX8j
         J+9aM76V/MynVkCuCUvJ1g8kqJ0KzVhuUxVGPYNPMq4xSaqn5B9WK9i5SyrsHfQewUb3
         VSdUbHvjHsoWY8gm+1yms41vsCCkK+iJb8bKWfa+qxtBu/ea20AkZ2dqvsoIKxEziLkm
         MbczBz9PecIutjO7Dy0/CjYfHGRhCl4InZTRSmcUsyWCWukCOpiJVHQbydym5bghUEoG
         tLiw==
X-Forwarded-Encrypted: i=1; AFNElJ9GLPBlslNtKVvJhNg+PT4HoVdSRYegmS8uvo1WkttiJfeX8f/v7Li3BaFSw3yuKTIh0TfDKbN1oME02g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv0eDpHymD7AO5cuvnCVvMuI70wOpg0GhxNdtsM7BfCufaoSIc
	SR9w5FoBxxTpI/NSrTkIhA+aKMYaalUkhpF142A00AVJON2EUdthI9J8D4P8Fm15Fyk=
X-Gm-Gg: Acq92OFRkM3wBDW5bTsaZBYHiT4c4u1jsBzznMwGWH0ZskID7n+uieBojGhVdTtEAMe
	teNULnMuIKjhsPLO9KoTv138V3bcTOUR3uh1YC3A8Q13bzMmHWlT0sSFcBc9jMl7EXO9KQIVTp+
	Cy73EQyNtcu4BzVs4TFIdg+/oMc6oMPA+sc1h5TQRQ/zVyUq7aUENdqQb9pmrFLXzC1WtmtZ4hA
	fENlI5hO2qN00GkhB4cif9q0QX80eS79lBtabjNNiDefPbpbOcNf192l4mw6jcNERWkyl8ThA71
	W6eQ6MF1Oz0eeNIc+ZyTDE5KPsvX/ndK7SvpUbNsDtJbWhBYpgySNIqGUl4L0JVs+2z6mIOznax
	mZSaruP5r8wyot8ykSJgZEe4bjoksv5bYXXU0VWmLY+sIwvB22aOd1Miem2jKe8jmzTNeXpXy7m
	zYoAhS9HDh3JWUlFBAnBebxD2LKrQR9Llx
X-Received: by 2002:a05:6000:2083:b0:43e:a9ba:b194 with SMTP id ffacd0b85a97d-45e5c5dd921mr22974719f8f.34.1779095050244;
        Mon, 18 May 2026 02:04:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm35084436f8f.5.2026.05.18.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:04:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 18 May 2026 10:03:07 +0100
Subject: [PATCH v2 1/6] tools/build: Allow versioning of all LLVM tools
 defined in Makefile.include
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-james-perf-llvm-version-v2-1-f12cc4f031d8@linaro.org>
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

