Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE063B19DB
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751165; cv=none; b=ZM5Q/YmDD4uP27wcAtnBVEQtS/eBbpBMV6rK5JuUEBweavLReIgRLGoqSFi3dcTePUn5vDhVwSWsQsqHaeb1l1A01dSXAfGBGI+qppQYd1FhMax6E1BZCZnXPLP6i1kp/gK25lRHpSZ58BSK3VD36z4PtLG3Fz6XqKuQvybO9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751165; c=relaxed/simple;
	bh=EcRWbLjvj5+HxttCv4wwDg08ziIUS2xvxPGRsCPtXfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YuW4pPQqtOtejVKqV7EJSEww8h709oVgtENsq+GspuLmf2Z0q8zq3wRkqSQZrShbpbvA86RHsFr1ywabgvPvfqUDKstwRRTns6LI31cm25p3LFZ8ToDEmFh+/1EDSzFQluRiyFZhWSbnEqHcukxSJVdGtIq07F2RQm3dsSAKbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbwokJ6m; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbwokJ6m"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb05b1875so4604794f8f.3
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778751160; x=1779355960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cp0hCjl/7HokOMvEpLytgICfRvv5ETaSkkbSuZLPs6Q=;
        b=XbwokJ6mDKM0dLWaxQyoAm45W8OyBbuxeuvCIB9b5puAuGnl4ieA8qaIIrawOpJEDv
         MZNQc6iOR3/9+YaJayb2N775MKOFyTEjPi7lRbzJZUVrwD4vDDqzei0m3xr7RAUAUYnv
         7amCUXVN1Ufid9gjSeT8g29T4ApnCJOa2AD/mAi80BJu3KuRkaqTAjXX8U69KEqVVBOo
         nat01AxBazI5vxJf+hx+ERgBoZybhiErApxdwl3SeNh6ExzCOw73m1/oOhMTEpUOFIpM
         D9/h8BCpg8VSWtWPxtvaG6Y+mu4qB1l6Sn1oXyC4nXUTY0bG0iX2VrsovxWW19WXY8Wf
         2oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751160; x=1779355960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cp0hCjl/7HokOMvEpLytgICfRvv5ETaSkkbSuZLPs6Q=;
        b=nGAJFHd1d2zaaL9x8ATdWq0WHsDTGeBBnNkkKBIbUiSXrRiUJBefrGouoJ9CE4SYQl
         IlaVFKxSMW8CwdlSfeYt1CbN6yBisrJ7f/LB4ziUOIqi59JXc0RHrYtY13yQkl/X1/jO
         xeBdBxUodbxGiBLZTIr8cMcjpjUXPMpSpWmJA3RklS1QjLreNxOdAVGoBdTbPUcModqb
         RUJztXxbNqxtsNIrVuDlg/QpBErq5lpKaDwZbRaciy0ei3gACD72EeERlq45nzYjjKRH
         B7qJ9gFkq/6FM1YR9zLBB/tX+pHUDiuLyre6VANv4SlcKacHINkcSQjM3Sq/i9+yNdoa
         4Izg==
X-Forwarded-Encrypted: i=1; AFNElJ8G3SHCzK1J6F/Mnd2VOwEQSHwbweK4BRCTHerKLi7YcNMdYFmmZMlyaLjkRSStkQpnfm2lp3eVfo9j1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ9OAymxgfQ+6Hxt4M4C/D0mEBZ6KssI5cTSkn3d4vyY1ak8a
	QrhZx1TmgrQZRlEvf1hkaCUiPCO7Qxm3sLzYGBNavcx7+D36lxwFCzDEZhtI713Dkcw=
X-Gm-Gg: Acq92OEt1oFj7kjypJXDhdWa05PJlMufD7FKo7wOiZo1G0Gj0l/rc8d4f3hKOy27R9i
	+h/bgbKPYHY0ccIV8qYsSVXuk8ER6nDq4kDnz+GX45MuaNJRlJHbS8VxTIcb6G5m50mXMwuPdNI
	Nh6vVuL19vSGL21fh8LPQ47EYO463b/4/D1UsHzOrDH8L1qYYN3eKW/K9UOJm88W+jCqWN18yxk
	rCiZdqQNQxKeTZVnrOjRTn9xSTqZQguaBVynPADaJlwcrKUaOPEZrT65dFY451zHd2j/luhvQGm
	ioMs5UlbV96dyWHpk7l3WKjnO0dml7N4atZ/5avI8w6TXgYCdQvwnxPmoySHKA1V475wxeQkZoD
	PfiNiozpic6yzsvE/yv2QcoHLaWr9ZTymBMa+ZB6j8bdi0luE/SWREo/wnYkeULZvho3KSYbHHD
	H5X8uEyvc0h/RZ6FAz3dwOptTOa0pjpBTCfnAtuFZB6vU=
X-Received: by 2002:a05:6000:1863:b0:43c:ffb1:2214 with SMTP id ffacd0b85a97d-45c57b050f5mr11407660f8f.16.1778751159863;
        Thu, 14 May 2026 02:32:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5097164f8f.26.2026.05.14.02.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:32:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 May 2026 10:32:13 +0100
Subject: [PATCH 6/6] tools/build: selftests: Remove some duplicate
 toolchain definitions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-james-perf-llvm-version-v1-6-6cac1a9a4c8d@linaro.org>
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

Try to remove some, but not all duplicate toolchain definitions. In
these instances, their makefiles already include
tools/scripts/Makefile.include which defines these in a consistent way.

STRIP is the only one that was set with an '=', but I don't think it
was significant so that difference can be dropped.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/bpf/resolve_btfids/Makefile    | 3 ---
 tools/lib/api/Makefile               | 4 ----
 tools/lib/subcmd/Makefile            | 4 ----
 tools/lib/symbol/Makefile            | 4 ----
 tools/perf/Makefile.perf             | 6 ------
 tools/testing/selftests/bpf/Makefile | 1 -
 6 files changed, 22 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 7672208f65e4..6fdb6302e0a2 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -20,9 +20,6 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
 		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
 HOSTPKG_CONFIG ?= pkg-config
 CROSS_COMPILE =
 
diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 8665c799e0fa..a228fdb5adba 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 INSTALL = install
diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 8703ab487b68..9f1ddcf0504d 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-LD ?= $(CROSS_COMPILE)ld
-AR ?= $(CROSS_COMPILE)ar
-
 RM = rm -f
 
 MAKEFLAGS += --no-print-directory
diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 426b845edfac..d692abe8add6 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -9,10 +9,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 #$(info Determined 'srctree' to be $(srctree))
 endif
 
-CC ?= $(CROSS_COMPILE)gcc
-AR ?= $(CROSS_COMPILE)ar
-LD ?= $(CROSS_COMPILE)ld
-
 MAKEFLAGS += --no-print-directory
 
 INSTALL = install
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 63276bf55856..948abfd2ee8d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -174,11 +174,6 @@ endef
 
 LD += $(EXTRA_LDFLAGS)
 
-HOSTCC  ?= gcc
-HOSTLD  ?= ld
-HOSTAR  ?= ar
-CLANG   ?= clang
-
 # Some distros provide the command $(CROSS_COMPILE)pkg-config for
 # searching packges installed with Multiarch. Use it for cross
 # compilation if it is existed.
@@ -213,7 +208,6 @@ FIND    = find
 INSTALL = install
 FLEX    ?= flex
 BISON   ?= bison
-STRIP   = strip
 AWK     = awk
 
 # include Makefile.config by default and rule out
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 44ba829e5d4d..b3e356c34479 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -3,7 +3,6 @@ include ../../../build/Build.include
 include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
-CXX ?= $(CROSS_COMPILE)g++
 OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
 CURDIR := $(abspath .)

-- 
2.34.1

