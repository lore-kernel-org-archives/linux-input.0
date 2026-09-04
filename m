Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AE4908D7;
	Fri,  4 Sep 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526395; cv=none; b=j/f+ucV6pSvJ+SHWF4oqIffM/eeolE1cfLRKwxoGMvU5Cmnoep1kkJVMn2/8EdgiPLPmXOdzzlSYlM0rSRvvd3lX0YpydM9nZh6PiARBuR3zPdmYsCijMnwe1hg6YML8lgFzAQ+KfhHoAMWu5SczoCuGEtlB8eQEMvl3CSGwMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526395; c=relaxed/simple;
	bh=L8KDIiF6iGv9ptfT58v6CZCR07cETsON7FR/0HYuHQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzS1JOuHyE/UvzJEO2gPC/lJpmg3xOSbehBeDRMRfR9eU/B4tfpQpKDwtzdV9D9Jw3BW2bwY/yvQPE/VxeL1VJYqJIEo8eA2TrmIj0gbUYNrYtoH1W4sRh9kihy8DmuEv/C6vDpOGZWTRwwV2VI0GNCl5/RTtKBc6Dc/X3Dejw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsM8aRyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsM8aRyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3F71F00A3E;
	Fri,  4 Sep 2026 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788526393;
	bh=rVMJoTW/YhpeXi6fOD69gnnxshNIuAa7yQ+rp/Ersbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TsM8aRyKsuesQpMQLsE4IzCeio6y2bf239331iqatoUx72IABNUju7mzqe6HMjtrI
	 n+V4QZvxPh4+1WyEZRRPIpJIkxlRcKZlFzHK3Y4BDe9fpTY8m8tLJgKVufRI2X6yY9
	 vMF3Tt/v+IJG/xhLI0j567+Q/KwGK1NeDfEzJHfNuqDVzCHCYfn+m+raI0VudCFOfr
	 Lef8JcoKQl8kS5Mhu6wWzgngVFlZcMj6c0IVcB8IWM7GTMkvcNXLquyKkQQnQpfJRd
	 IAJyN6yrlSXWp6u3Doo08MKZkiUGsXKDn+G+67xKKQSuY5jjDGEaA4DRiI6NUBj3nk
	 SeULcLr4ciHKA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 04 Sep 2026 14:52:59 +0200
Subject: [PATCH 1/3] selftests/hid: add define for commonly used buf size
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-wip-bpf-check_report-v1-1-efe9a2a1ed28@kernel.org>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
In-Reply-To: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788526390; l=6156;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=L8KDIiF6iGv9ptfT58v6CZCR07cETsON7FR/0HYuHQA=;
 b=5vof8CtsjDMaRabUHh/FMGT1jGmaiazR3HbEe2FuIyFIz62bUL/xuL8fUfVlL9paqOelwy+9S
 lkvYgq9cmDfCeQUVymC1QzNeJ7Z+s3uuUJxTnw0ZZ8w3RxV57tqLGEv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

If we want to add another report descriptor without report IDs with a
report size bigger than 10, we have multiple magic values to replace.

Put a #define once and for all, so we don't have dangling ones.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c    | 38 ++++++++++++++++----------------
 tools/testing/selftests/hid/hid_common.h |  3 ++-
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index b851339308c2..e865ee55b4f1 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf.h>
 
 struct hid_hw_request_syscall_args {
-	__u8 data[10];
+	__u8 data[MAX_BUF_SIZE];
 	unsigned int hid;
 	int retval;
 	size_t size;
@@ -168,7 +168,7 @@ TEST_F(hid_bpf, raw_event)
 	const struct test_program progs[] = {
 		{ .name = "hid_first_event" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -219,7 +219,7 @@ TEST_F(hid_bpf, subprog_raw_event)
 	const struct test_program progs[] = {
 		{ .name = "hid_subprog_first_event" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -277,7 +277,7 @@ TEST_F(hid_bpf, test_attach_detach)
 		{ .name = "hid_second_event" },
 	};
 	struct bpf_link *link;
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err, link_fd;
 
 	LOAD_PROGRAMS(progs);
@@ -362,7 +362,7 @@ TEST_F(hid_bpf, test_hid_change_report)
 	const struct test_program progs[] = {
 		{ .name = "hid_change_report_id" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -389,13 +389,13 @@ TEST_F(hid_bpf, test_hid_user_input_report_call)
 {
 	struct hid_hw_request_syscall_args args = {
 		.retval = -1,
-		.size = 10,
+		.size = MAX_BUF_SIZE,
 	};
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
 			    .ctx_in = &args,
 			    .ctx_size_in = sizeof(args),
 	);
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err, prog_fd;
 
 	LOAD_BPF;
@@ -435,7 +435,7 @@ TEST_F(hid_bpf, test_hid_user_output_report_call)
 {
 	struct hid_hw_request_syscall_args args = {
 		.retval = -1,
-		.size = 10,
+		.size = MAX_BUF_SIZE,
 	};
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
 			    .ctx_in = &args,
@@ -484,7 +484,7 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 		.retval = -1,
 		.type = HID_FEATURE_REPORT,
 		.request_type = HID_REQ_GET_REPORT,
-		.size = 10,
+		.size = MAX_BUF_SIZE,
 	};
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
 			    .ctx_in = &args,
@@ -517,7 +517,7 @@ TEST_F(hid_bpf, test_hid_filter_raw_request_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_filter_raw_request" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -570,7 +570,7 @@ TEST_F(hid_bpf, test_hid_change_raw_request_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_hidraw_raw_request" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -596,7 +596,7 @@ TEST_F(hid_bpf, test_hid_infinite_loop_raw_request_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_infinite_loop_raw_request" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -619,7 +619,7 @@ TEST_F(hid_bpf, test_hid_filter_output_report_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_filter_output_report" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -672,7 +672,7 @@ TEST_F(hid_bpf, test_hid_change_output_report_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_hidraw_output_report" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -696,7 +696,7 @@ TEST_F(hid_bpf, test_hid_infinite_loop_output_report_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_infinite_loop_output_report" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -722,7 +722,7 @@ TEST_F(hid_bpf, test_multiply_events_wq)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_multiply_events_wq" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -760,7 +760,7 @@ TEST_F(hid_bpf, test_multiply_events)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_multiply_events" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -794,7 +794,7 @@ TEST_F(hid_bpf, test_hid_infinite_loop_input_report_call)
 	const struct test_program progs[] = {
 		{ .name = "hid_test_infinite_loop_input_report" },
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
@@ -848,7 +848,7 @@ TEST_F(hid_bpf, test_hid_attach_flags)
 			.insert_head = 0,
 		},
 	};
-	__u8 buf[10] = {0};
+	__u8 buf[MAX_BUF_SIZE] = {0};
 	int err;
 
 	LOAD_PROGRAMS(progs);
diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
index e3b267446fa0..4567336f131d 100644
--- a/tools/testing/selftests/hid/hid_common.h
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -13,6 +13,7 @@
 #include <linux/uhid.h>
 
 #define SHOW_UHID_DEBUG 0
+#define MAX_BUF_SIZE 10
 
 #define min(a, b) \
 	({ __typeof__(a) _a = (a); \
@@ -110,7 +111,7 @@ static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
 
 static pthread_mutex_t uhid_output_mtx = PTHREAD_MUTEX_INITIALIZER;
 static pthread_cond_t uhid_output_cond = PTHREAD_COND_INITIALIZER;
-static unsigned char output_report[10];
+static unsigned char output_report[MAX_BUF_SIZE];
 
 /* no need to protect uhid_stopped, only one thread accesses it */
 static bool uhid_stopped;

-- 
2.55.0

