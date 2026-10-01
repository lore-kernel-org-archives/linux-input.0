Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA365192;
	Thu,  1 Oct 2026 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790895315; cv=none; b=dqSvoW8gY7N389SIKFXopEZsyEhGQKKEde8wUDeKqpfY7pbXmgPYTQ7GkdUzkW34iBWnOFNjj6g2NvzMIEau1U9gH/AT7JR3tYePs+Vfak2L+yrRKhGCurdZySsfOWtAElAG9drYo3qTGJBinNc6EG6JJiVGRaI9hI4v1FIar7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790895315; c=relaxed/simple;
	bh=G6dpS/akoWfWFRS+b1EqJB1D2YrdJ7BG9pIw7Yk0+t0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJaW+7h975ti17ZQTT2DebSaiOMXVbIY+bUSw1vOuPV7iDV3eQ5ql5N2vSgTCfEzQuzVV7ec8o+0N/Gb68w0isTVfTmX9benIvorCBYCcl8B0vQHiQ31ddQE1uuG0vkSByVOOKEyNBgz/YkFM2KbhjJRiPM0GpymrPc7UZm5JxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=oHq//uQM; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="oHq//uQM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790895314; x=1822431314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lCyyFFMJRMHkuWigp+sygAAkPMHmYO63xQHwYFQteTc=;
  b=oHq//uQMjU/i++1BJ0Jna28GrwrhH7+CFHe2TGtLflwqFnUYp/CXX9tH
   PQJEdMgAWbe1+0vmbidH5ac9ej5z8rM6OUKlyv0bQO1SzK69pASTuYbyc
   d1ExH1vmhFADjmCga6HM3OGrADu1UR5G9/w1q9YnU5Ys9Yh8dgdWK2QSo
   x6wbdAuoT7tGO6JEI/DVaQSxdyrsyKKbFTD0SaQnt7MmMMU+JEPufhuhb
   2lJvXo5KuGSnCvFxGWmpxP6LRTMPsmW0LJfi/EaNTxUymktn5bS2f6OEB
   1RX1b0JcYrZIfKgraZQTEsAxf57KYUaWoNS3QX33Ay0S6RgSWRbcs+xca
   Q==;
X-CSE-ConnectionGUID: K8pau1qOS0Ovw5X9Cimazw==
X-CSE-MsgGUID: LffK2uP0ST6x/Rjr9YoBMw==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29967306"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 22:55:13 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:29587]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.153:2525] with esmtp (Farcaster)
 id ad49fe97-04a5-4706-89c7-ac279d5032ec; Thu, 1 Oct 2026 22:55:13 +0000 (UTC)
X-Farcaster-Flow-ID: ad49fe97-04a5-4706-89c7-ac279d5032ec
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:55:13 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 22:55:12 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet
	<qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>, Christian Heusel
	<christian@heusel.eu>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
	<petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>, <linux-input@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	<sched-ext@lists.linux.dev>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	<rust-for-linux@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next v4 11/12] tools, samples: take the vmlinux BTF from vmlinux.unstripped first
Date: Thu, 1 Oct 2026 22:52:13 +0000
Message-ID: <20261001225214.12351-12-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261001225214.12351-1-wanjay@amazon.com>
References: <20261001225214.12351-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With CONFIG_DEBUG_INFO_BTF=m, which the next patch makes possible, the
vmlinux BTF is not part of vmlinux: scripts/Makefile.vmlinux strips .BTF
from it, and only vmlinux.unstripped, from which vmlinux is made, keeps
it.  The tools and samples that generate vmlinux.h from a kernel build
tree take the first vmlinux they find, so after an =m build they would
pick one without BTF and fail, e.g. the bpftool skeletons when bpftool is
built from the kernel tree right after the kernel.

Look for vmlinux.unstripped before vmlinux in each of these lists.  Every
kernel build produces it, and with =y it carries the same BTF as vmlinux,
so nothing changes there.  perf filters the candidates for a .BTF
section, but its unanchored grep also matches .BTF_ids and .BTF.link,
which vmlinux keeps with =m; match the section name exactly.

Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 samples/bpf/Makefile                       | 6 +++++-
 samples/hid/Makefile                       | 6 +++++-
 tools/bpf/bpftool/Makefile                 | 6 +++++-
 tools/perf/bpf_skel.mak                    | 8 ++++++--
 tools/sched_ext/Makefile                   | 6 +++++-
 tools/testing/selftests/bpf/Makefile       | 6 +++++-
 tools/testing/selftests/hid/Makefile       | 6 +++++-
 tools/testing/selftests/sched_ext/Makefile | 6 +++++-
 8 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index c28e65046986..fb5cd2d5b6f8 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -305,8 +305,12 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 -include $(BPF_SAMPLES_PATH)/Makefile.target
 
-VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux.unstripped))		\
+		     $(abspath $(if $(O),$(O)/vmlinux))				\
+		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped))	\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
+		     $(abspath $(objtree)/vmlinux.unstripped)			\
 		     $(abspath $(objtree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index db5a077c77fc..84566fbe4a5b 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -162,8 +162,12 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.skel.h
 
 -include $(HID_SAMPLES_PATH)/Makefile.target
 
-VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux.unstripped))		\
+		     $(abspath $(if $(O),$(O)/vmlinux))				\
+		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped))	\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
+		     $(abspath $(objtree)/vmlinux.unstripped)			\
 		     $(abspath $(objtree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index b0f7168e7943..0e25bffd0d72 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -236,8 +236,12 @@ $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
 OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
 $(OBJS): $(LIBBPF) $(LIBBPF_INTERNAL_HDRS)
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux.unstripped)			\
+		     $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../vmlinux.unstripped			\
 		     ../../../vmlinux					\
 		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index f2559de39f96..01b07dd77692 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -44,8 +44,12 @@ $(BPFTOOL):
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool OUTPUT=$(SKEL_TOOL_TMP_OUT)/ bootstrap
 
 # Paths to search for a kernel to generate vmlinux.h from.
-VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux.unstripped)		\
+		     $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../vmlinux.unstripped				\
 		     ../../vmlinux					\
 		     /boot/vmlinux-$(shell uname -r)
 
@@ -56,7 +60,7 @@ VMLINUX_BTF_BTF_PATHS ?= /sys/kernel/btf/vmlinux
 VMLINUX_BTF_ELF_ABSPATHS ?= $(abspath $(wildcard $(VMLINUX_BTF_ELF_PATHS)))
 VMLINUX_BTF_PATHS ?= $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS); \
 			do \
-				if [ -f $$file ] && ($(READELF) -S "$$file" | grep -q .BTF); \
+				if [ -f $$file ] && ($(READELF) -SW "$$file" | grep -q "[[:space:]]\.BTF[[:space:]]"); \
 				then \
 					echo "$$file"; \
 				fi; \
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 21554f089692..cf6842904934 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -73,8 +73,12 @@ HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
 RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
 DEFAULT_BPFTOOL := $(HOST_OUTPUT_DIR)/sbin/bpftool
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux.unstripped)				\
+		     $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../vmlinux.unstripped					\
 		     ../../vmlinux						\
 		     /sys/kernel/btf/vmlinux					\
 		     /boot/vmlinux-$(shell uname -r)
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index afa589a27b15..e6a841e03219 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -140,8 +140,12 @@ endif
 # Some utility functions use LLVM libraries
 $(OUTPUT)/jit_disasm_helpers.o: CFLAGS += $(LLVM_CFLAGS)
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux.unstripped)			\
+		     $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../../vmlinux.unstripped			\
 		     ../../../../vmlinux				\
 		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2f423de83147..8b85382be254 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -81,8 +81,12 @@ endif
 HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
 RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux.unstripped)			\
+		     $(if $(O),$(O)/vmlinux)				\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
+		     ../../../../vmlinux.unstripped			\
 		     ../../../../vmlinux				\
 		     /sys/kernel/btf/vmlinux				\
 		     /boot/vmlinux-$(shell uname -r)
diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 3cfe90e0f34f..f9a911c5ce33 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -37,8 +37,12 @@ HOST_LIBBPF_OUTPUT := $(OBJ_DIR)/host/libbpf/
 HOST_LIBBPF_DESTDIR := $(OUTPUT_DIR)/host/
 HOST_DESTDIR := $(OUTPUT_DIR)/host/
 
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)					\
+# With CONFIG_DEBUG_INFO_BTF=m only vmlinux.unstripped has the BTF
+VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux.unstripped)				\
+		     $(if $(O),$(O)/vmlinux)					\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux.unstripped)	\
 		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../../../vmlinux.unstripped				\
 		     ../../../../vmlinux					\
 		     /sys/kernel/btf/vmlinux					\
 		     /boot/vmlinux-$(shell uname -r)
-- 
2.47.3

