Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925403F9280;
	Tue, 25 Aug 2026 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651730; cv=none; b=IfJtSHyHG0HrgD1JwauWmIFZAg12+kmkEbz9Zu/JYtTTaDq78HcIWGMWN/oLjsj7YVUoH2Xz9wmsae9Ymg5J/FwgENC0FwXnLvkOfkG4WzbjtxGxSqvsui5gV4W8l3xTGB6ffC2451WVxKdwjxpie9rD3sHNOH0JG6iNoi05QWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651730; c=relaxed/simple;
	bh=P2KQ/vyTrdHO6s9F0ZWZjYHFLaT52t9NCZb6L0bqJhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhJG4ZyMkw6fVtHveqVBdTRX+ew23IK2C0Ln3lCdls7Vq85zugtlxUirTpxL1r/dyX7cScI/yoyYeHCLB3UG7/Pn6n9m+vnlAjV1CeZhvpkGItPBd/Db+p/ewSz3sYFckJj1V6alp4wLA96NkecJyUNMz0BEFwfJExwvQ03sgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpOn7g0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpOn7g0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092E1F000E9;
	Tue, 25 Aug 2026 09:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787651729;
	bh=aOutTEc1i+OTXu+DEaWvTQVVwS39UPOhxfXFCuwBi7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CpOn7g0soseDua5adXULlXuFReWZDcNtM8Qj/nw3rXWmlGUBPGYRaBK0Ms9iW420U
	 Hrjuh95prE619/cZroq3m7x6Ty5wueSW5jFDfANftb59/w+/WblH6cdqB5in3glHqq
	 RlrS4ZucOIWRp72HGkPvdoFUeHWYIF2RsPXS5LViTocH607fHhMOrYm3qj8fusYRjO
	 qQDfqDOX3kc4sjZlUMHE/4NdM/5ds7N9FY59W1IQfDy+vd1I0/xE88IU8Lk00X67/R
	 NntRmhpKk2k2oJffrizujPKIOiEOojIcbyu0gC0EsRiq/H7Jxj23kIS1FC93jYkAd2
	 RwUOMaUxte9Dw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 25 Aug 2026 11:55:12 +0200
Subject: [PATCH v2 2/3] selftests/hid: Add a test to ensure we can write
 fields in hid_device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-wip-bpf-safe-v2-2-d044355c09d8@kernel.org>
References: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
In-Reply-To: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787651723; l=3670;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=P2KQ/vyTrdHO6s9F0ZWZjYHFLaT52t9NCZb6L0bqJhg=;
 b=Q2B1gXkhHSFe+nXeMCFMbz0MToK1ota0semx5OoZZdLOtg64MZFDl9rDK58N7ChOwHhK+xB4e
 JuKMWbMar1xD4HgvIHNveWHSRFhJmoRzjywSvYbvIN8Gu232EXCvNfW
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid_device->{name,uniq,phys} are all writeable fields, we need to have
tests for them in case the verifier becomes too much strict.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- sashiko fixes:
  - iterate the for loop up to 5, to account for dev_id >= 1000
  - properly undef the correct macro
---
 tools/testing/selftests/hid/hid_bpf.c              | 26 ++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 26 ++++++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  3 +++
 3 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index b851339308c2..069ebdbb4d1c 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -909,6 +909,32 @@ TEST_F(hid_bpf, test_rdesc_fixup_get_data_overflow)
 	ASSERT_EQ(self->skel->bss->get_data_overflow_check, 1);
 }
 
+TEST_F(hid_bpf, test_rdesc_fixup_change_uniq_name_phys)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_rdesc_fixup_change_uniq_name_phys" },
+	};
+	char expected[256], buf[256] = {};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWNAME(sizeof(buf)), buf);
+	ASSERT_GE(err, 0) TH_LOG("HIDIOCGRAWNAME");
+	ASSERT_STREQ("name coming from bpf", buf);
+
+	snprintf(expected, sizeof(expected), "%d phys:coming:from:bpf", self->hid.dev_id);
+
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWPHYS(sizeof(buf)), buf);
+	ASSERT_GE(err, 0) TH_LOG("HIDIOCGRAWPHYS");
+	ASSERT_STREQ(expected, buf);
+
+	err = ioctl(self->hidraw_fd, HIDIOCGRAWUNIQ(sizeof(buf)), buf);
+	ASSERT_GE(err, 0) TH_LOG("HIDIOCGRAWUNIQ");
+	ASSERT_STREQ("uniq:coming:from:bpf", buf);
+
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index b21fbb13c926..361dc7eaad22 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -255,6 +255,32 @@ struct hid_bpf_ops rdesc_fixup_get_data_overflow = {
 	.hid_rdesc_fixup = (void *)hid_rdesc_fixup_get_data_overflow,
 };
 
+SEC("?struct_ops.s/hid_rdesc_fixup")
+int BPF_PROG(hid_rdesc_fixup_change_uniq_name_phys, struct hid_bpf_ctx *hid_ctx)
+{
+#define HID_BPF_MEMCPY(target, str) \
+	__builtin_memcpy(target, str, sizeof(str))
+
+	HID_BPF_MEMCPY(hid_ctx->hid->name, "name coming from bpf");
+	HID_BPF_MEMCPY(hid_ctx->hid->uniq, "uniq:coming:from:bpf");
+	/* hid_bpf relies on a phys being a rand % 1024 */
+	for (int i = 0; i < 5; i++) {
+		if (!hid_ctx->hid->phys[i]) {
+			HID_BPF_MEMCPY(hid_ctx->hid->phys + i, " phys:coming:from:bpf");
+			break;
+		}
+	}
+
+#undef HID_BPF_MEMCPY
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops rdesc_fixup_change_uniq_name_phys = {
+	.hid_rdesc_fixup = (void *)hid_rdesc_fixup_change_uniq_name_phys,
+};
+
 SEC("?struct_ops/hid_device_event")
 int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index cdca912f3afd..05698793762a 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -61,6 +61,9 @@ enum hid_report_type {
 
 struct hid_device {
 	unsigned int id;
+	char name[128];
+	char phys[64];
+	char uniq[64];
 } __attribute__((preserve_access_index));
 
 struct bpf_wq {

-- 
2.55.0

