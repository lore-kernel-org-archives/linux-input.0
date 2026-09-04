Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29149365E;
	Fri,  4 Sep 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526399; cv=none; b=NVm7F5S/kCQ5ado6tWV+gFbYskkYnSeo0EcrC0Zk4ffOeR/sZpm0YCiLxryp5N1Za971Grb/YTyDj+099O7f7w4JEaWvFdIfNjTPhOkxbWKedUTJzgwoaL4gOJojdm8CulcnQBLrfvuJlb6gxRfAtBN/1+/g0spRhb7iPDfAL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526399; c=relaxed/simple;
	bh=i3zdWQXao6mJbUcYA6Qbebb0X6DWZLTCMR0y7Fo/qVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XYzK4V2XvG/+ca26qq/5sHOYgbz/EwZ0DbB3g7KLab63eU6mE+qMJkBtey4PlzfrbdXntxAD3aD+TiD2I2SxPQtx4LcufIwlQIol2GdvxYPVVfQ8xWTbJcAkiGY8NE7/4/Hh9tpuIjAT5fAAlTaTqzA4mLTYxxOTt4kBaMXQ5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zart/WXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zart/WXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5DC1F00A3E;
	Fri,  4 Sep 2026 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788526397;
	bh=/QBo+IywvBFKQ91oQJ//NJtvKzWxxCKh0qWpivsM9x8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zart/WXBoei/laHnQMhcj9seusOMKLAghP5oFUAjdZGV0PDw2R+ee1SxwvYf2nNZv
	 cMaYkmKh4sKtdmahiT+G/+46g1kBxqN+/P7T0zrS+JF8QopO+rwdd9VnK5IJdXLpSe
	 pFZod1vufrJo/pY2gp1wNytWdMRDu0G0VabtScQYNxIKoMMSNULC0I5ycIPu5T/QjR
	 /lsZjfrGMeHs8lWhevchQVm/a9cReEkh3L1Mt1XxJf5E3x5bGZ2RtQFZYI+u8LHKdn
	 09PREaIR8HLpuubr7hPB+TxzeRP2VEI9RE/01Hr3m5dU2wKSXnyNZbyYt3kBH0uq9b
	 NuENC68HXD9Wg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 04 Sep 2026 14:53:01 +0200
Subject: [PATCH 3/3] selftests/hid: add unnumbered variant to the hid_bpf
 tests
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-wip-bpf-check_report-v1-3-efe9a2a1ed28@kernel.org>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
In-Reply-To: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788526390; l=5643;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=i3zdWQXao6mJbUcYA6Qbebb0X6DWZLTCMR0y7Fo/qVI=;
 b=pTgH0QSp3BWXY34Z9KGAlvWrxmJJ8dlUinSv1fMpggkVG9eCxnd8LMi/iUxi4fj3DwImDNPyd
 53NRVVMykxoCuiuqNcz9BXTSQD6IS6DsTXP9sfZwsfIonhrMMsRshvw
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

A bug appeared in hid_bpf_dispatch.c where it wasn't properly handling
unnumbered reports. Add a device variant without report IDs so we can
also test them.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c    | 53 ++++++++++++++++++++++++++------
 tools/testing/selftests/hid/hid_common.h | 24 ++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c  |  2 +-
 3 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index e865ee55b4f1..d1bd07caf991 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -54,11 +54,27 @@ FIXTURE_TEARDOWN(hid_bpf) {
 	hid_bpf_teardown(_metadata, self, variant); \
 } while (0)
 
+FIXTURE_VARIANT(hid_bpf) {
+	__u8 *rdesc;
+	size_t rdesc_size;
+};
+
+FIXTURE_VARIANT_ADD(hid_bpf, numbered) {
+	.rdesc = rdesc,
+	.rdesc_size = sizeof(rdesc),
+};
+
+FIXTURE_VARIANT_ADD(hid_bpf, unnumbered) {
+	.rdesc = fido2_rdesc,
+	.rdesc_size = sizeof(fido2_rdesc),
+};
+
 FIXTURE_SETUP(hid_bpf)
 {
 	int err;
 
-	err = setup_uhid(_metadata, &self->hid, BUS_USB, 0x0001, 0x0a36, rdesc, sizeof(rdesc));
+	err = setup_uhid(_metadata, &self->hid, BUS_USB, 0x0001, 0x0a36,
+			 variant->rdesc, variant->rdesc_size);
 	ASSERT_OK(err);
 }
 
@@ -402,8 +418,11 @@ TEST_F(hid_bpf, test_hid_user_input_report_call)
 
 	args.hid = self->hid.hid_id;
 	args.data[0] = 1; /* report ID */
-	args.data[1] = 2; /* report ID */
-	args.data[2] = 42; /* report ID */
+	args.data[1] = 2;
+	args.data[2] = 42;
+
+	if (variant->rdesc == fido2_rdesc)
+		args.data[0] = 0;
 
 	prog_fd = bpf_program__fd(self->skel->progs.hid_user_input_report);
 
@@ -421,8 +440,13 @@ TEST_F(hid_bpf, test_hid_user_input_report_call)
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
 	err = read(self->hidraw_fd, buf, sizeof(buf));
-	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
-	ASSERT_EQ(buf[0], 1);
+	if (variant->rdesc == rdesc) {
+		ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	} else {
+		ASSERT_EQ(err, 64)
+		TH_LOG("read_hidraw");
+	}
+	ASSERT_EQ(buf[0], args.data[0]);
 	ASSERT_EQ(buf[1], 2);
 	ASSERT_EQ(buf[2], 42);
 }
@@ -448,8 +472,11 @@ TEST_F(hid_bpf, test_hid_user_output_report_call)
 
 	args.hid = self->hid.hid_id;
 	args.data[0] = 1; /* report ID */
-	args.data[1] = 2; /* report ID */
-	args.data[2] = 42; /* report ID */
+	args.data[1] = 2;
+	args.data[2] = 42;
+
+	if (variant->rdesc == fido2_rdesc)
+		args.data[0] = 0;
 
 	prog_fd = bpf_program__fd(self->skel->progs.hid_user_output_report);
 
@@ -465,9 +492,14 @@ TEST_F(hid_bpf, test_hid_user_output_report_call)
 	ASSERT_OK(err) TH_LOG("error while calling bpf_prog_test_run_opts");
 	ASSERT_OK(cond_err) TH_LOG("error while calling waiting for the condition");
 
-	ASSERT_EQ(args.retval, 3);
+	if (variant->rdesc == rdesc) {
+		ASSERT_EQ(args.retval, 3);
+	} else if (variant->rdesc == fido2_rdesc) {
+		ASSERT_EQ(args.retval, 65)
+		TH_LOG("report size error, should have 64 + 1 extra byte for the report ID 0");
+	}
 
-	ASSERT_EQ(output_report[0], 1);
+	ASSERT_EQ(output_report[0], args.data[0]);
 	ASSERT_EQ(output_report[1], 2);
 	ASSERT_EQ(output_report[2], 42);
 
@@ -879,6 +911,9 @@ TEST_F(hid_bpf, test_rdesc_fixup)
 	};
 	int err, desc_size;
 
+	if (variant->rdesc != rdesc)
+		SKIP(return, "not compatible report descriptor");
+
 	LOAD_PROGRAMS(progs);
 
 	/* check that hid_rdesc_fixup() was executed */
diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
index 4567336f131d..b7890ba2878f 100644
--- a/tools/testing/selftests/hid/hid_common.h
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -13,7 +13,7 @@
 #include <linux/uhid.h>
 
 #define SHOW_UHID_DEBUG 0
-#define MAX_BUF_SIZE 10
+#define MAX_BUF_SIZE 128
 
 #define min(a, b) \
 	({ __typeof__(a) _a = (a); \
@@ -98,6 +98,28 @@ static unsigned char rdesc[] = {
 
 static __u8 feature_data[] = { 1, 2 };
 
+static __maybe_unused unsigned char fido2_rdesc[] = {
+	0x06, 0xd0, 0xf1,	/* Usage Page (FIDO Alliance) */
+	0x09, 0x01,		/* Usage (U2F Authenticator Device) */
+	0xa1, 0x01,		/* Collection (Application) */
+	0x09, 0x20,		/*  Usage (Input Report Data) */
+	0x15, 0x00,		/*  Logical Minimum (0) */
+	0x26, 0xff, 0x00,	/*  Logical Maximum (255) */
+	0x75, 0x08,		/*  Report Size (8) */
+	0x95, 0x40,		/*  Report Count (64) */
+	0x81, 0x02,		/*  Input (Data,Var,Abs) */
+	0x09, 0x21,		/*  Usage (Output Report Data) */
+	0x15, 0x00,		/*  Logical Minimum (0) */
+	0x26, 0xff, 0x00,	/*  Logical Maximum (255) */
+	0x75, 0x08,		/*  Report Size (8) */
+	0x95, 0x40,		/*  Report Count (64) */
+	0x91, 0x02,		/*  Output (Data,Var,Abs) */
+	0x06, 0x00, 0xff,	/*  Usage Page (Vendor Defined Page 1) */
+	0x09, 0x22,		/*  Usage (Vendor Usage 0x22) */
+	0xb1, 0x02,		/*  Feature (Data,Var,Abs) */
+	0xc0,			/* End Collection */
+};
+
 #define ASSERT_OK(data) ASSERT_FALSE(data)
 #define ASSERT_OK_PTR(ptr) ASSERT_NE(NULL, ptr)
 
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index b21fbb13c926..605d8a5f9cb2 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -98,7 +98,7 @@ struct hid_bpf_ops change_report_id = {
 
 struct hid_hw_request_syscall_args {
 	/* data needs to come at offset 0 so we can use it in calls */
-	__u8 data[10];
+	__u8 data[128];
 	unsigned int hid;
 	int retval;
 	size_t size;

-- 
2.55.0

