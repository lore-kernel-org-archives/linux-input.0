Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2A3E95A8;
	Tue, 25 Aug 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647426; cv=none; b=GmqSTplvzSj2eC2Z3BrCrtwZWKxEVeMIs+CdZF0m+vSnHA2xn7BOJq3FBSz2Ox7oeQUgJE53zUxa50TnWFjIDSbBUlDu0b/pl0Xu/S700RR3CIUZ55feEjWGYzXMdyHsSml+HKS2PAaDOW8p6fWrlm621QRVZ/zCvzE+ZZ8LvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647426; c=relaxed/simple;
	bh=VSJ2yx9PJZAUfE7RZbqbWtL/IoEjvWxGntbrZQVqP8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j3xh5ISk8c5oHidBaWX6qseh3cEgaZ6a0vEFsJvoeiD2pcvH78ywtgOTZBaEtgMjinXaH+pPXAVSjo3Tth++ebFyIwY6s21Ihdp4D717D32FQMi2Jnq98mynIVPzGEqr4F4Aef/sHuYyrsvXqYvnDiim0wkZxZ5BL3YbBUt+HEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nziXvaH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nziXvaH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF861F000E9;
	Tue, 25 Aug 2026 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787647424;
	bh=d9zDo5TwWyhNym1KG6N1Ziqr0ZWASIWk12QkS9d/5R8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nziXvaH/Yqwd34J3f6BpPoPsF8v2hMX3Sw9/hx7ffHAUBaJab7/d+hfG4PmHLXtiz
	 ya7lwyps3NZOzq58fIlMqXhx2s2ftfp2WJw8eGJw5mozOE0ch2B5bafvh8TyLh5h3B
	 WRdP4Za/UtKm4qbj/NWsqA4BjU2mc+xDTlAFhc2mwoCEFUOdcWoyXtwR2fi6EDyP6u
	 LiXxPWFLsAnScc0vjYWDd8Rk361TFCrF5b6y2s78WvahUxSHFUP/HPQneUMM/W6hdw
	 GsSqmfIeDJTRFDUs8/dYIZ9EheEbZRAuiKhZNoMnkfVyi6stxt6ZvPXmc8mNhKnGM1
	 PXhZA1XC5TerA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 25 Aug 2026 10:43:17 +0200
Subject: [PATCH 2/3] selftests/hid: Add a test to ensure we can write
 fields in hid_device
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-wip-bpf-safe-v1-2-ab9e0e111c5c@kernel.org>
References: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
In-Reply-To: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787647419; l=3524;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=VSJ2yx9PJZAUfE7RZbqbWtL/IoEjvWxGntbrZQVqP8A=;
 b=E5tD9lQgmuxMi3lGXWLizRe9ciYf2Z5P+i8GUNzv2tD43okwEHvXvriAM0S9MlKI4thLDbMrQ
 AvQzFmk6YifDKGcC71coz1/TDeVV/8pT4mh5Twg3MkVLZbH8vGHHE/E
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

hid_device->{name,uniq,phys} are all writeable fields, we need to have
tests for them in case the verifier becomes too much strict.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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
index b21fbb13c926..b5d9aea1bda1 100644
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
+	for (int i = 0; i < 4; i++) {
+		if (!hid_ctx->hid->phys[i]) {
+			HID_BPF_MEMCPY(hid_ctx->hid->phys + i, " phys:coming:from:bpf");
+			break;
+		}
+	}
+
+#undef HID_BPF_CONCAT
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

