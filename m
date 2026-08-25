Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663C3E5EDB;
	Tue, 25 Aug 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647428; cv=none; b=YHUL4AJlBpq84S5tR8aNW+FU/zeuy1Q0INxVGQUXWOhKiQA6fd3IbXjE9BzWrtnWei0SCls0Slzn4ryzSNVH/fTmCBl1+fY4pynFznTDJeibMPAD/YCPNFtJVWiAPwFOh/gOl8c/kdzfZWFHcO83skEdzB4wiOVh8FSKjsxi6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647428; c=relaxed/simple;
	bh=eSEf0NJ/FDzTZdK6KbIhOnTFJmviX53xcLE5mdfpiqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNT0hZvi/VUIVqhFLVWxqC8pcvEsJGw7FTKr3BW7YqmW/VOFkXx89qaMKG0DqONPrv8/VA2pFTk8/B54Li3JTF+PlzyCXLlceUbSgkGKJlEymF6H/fhGZo3x6FwDjMtH1qok0UVY07In2aQuye8AQSqt8Mq0xEkQNexwGrO+BfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAJSZ5UB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAJSZ5UB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521151F00A3A;
	Tue, 25 Aug 2026 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787647426;
	bh=WZC2dlrRslY57zHDt+VshR3khc8bqhpzVRl64eOUUiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CAJSZ5UBNLE8/NBP0SDCBYiXubYo2DLQjNcYn1387Re/HCw1TkNmH6crwy2yWmcjz
	 GZj98GaQuHp7ZAJPOQkQ0NOG5us7c4z5zF+1BqxYagfH5n85y6xN9M5SzJGUX0C26R
	 Y76UprMAdFfl/UUPAf23Mz73ZCB9dwooTe0++fOmn92fUycq5LiPpvU/MaFsg2T/8L
	 OyaZNe8/ITGmUXmkbzsIJd8pXAUBQ35tiY2SqrbmWV/Y5W+eskAy7GfQiu5L94y6PL
	 b8k2R5og6HQYQMJp7B3RM8JBw45y7nDiy7Th/2faq6vO8Aqwwd3Q1LA5el+xcyAth9
	 I4x2a/+3cWPZQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 25 Aug 2026 10:43:18 +0200
Subject: [PATCH 3/3] selftests/hid: prepare
 test_rdesc_fixup_get_data_overflow for the new verifier
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-wip-bpf-safe-v1-3-ab9e0e111c5c@kernel.org>
References: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
In-Reply-To: <20260825-wip-bpf-safe-v1-0-ab9e0e111c5c@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787647419; l=2813;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=eSEf0NJ/FDzTZdK6KbIhOnTFJmviX53xcLE5mdfpiqM=;
 b=qoXOgQf22fImftlD6UPF3E9x+s7ffrNVxWAB0aOAstymIsKUz41rUcAZjwfwGOYnKMv3X1NKO
 4DX7RHE1etqC7HGcZJLCe5rjEo72R7jCDA8G95FX9fqEYJigBjLjwDN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

The new verifier in the bpf-next branch is now capable of detecting the
overflow that was triggered by test_rdesc_fixup_get_data_overflow.
This is better in terms of UI, but now the test is failing and should be
marked as expected to fail.

Add a new parameter to load_programs() when we expect the test to fail,
and dynamically validate the test by checkcing if it loads (it should
fail to load with new verifier), but if it still loads, HID-BPF should
detect the overflow itself and return an error in hid_bpf_get_data().

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 069ebdbb4d1c..7ab86296ff23 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -67,14 +67,17 @@ struct test_program {
 	int insert_head;
 };
 #define LOAD_PROGRAMS(progs) \
-	load_programs(progs, ARRAY_SIZE(progs), _metadata, self, variant)
+	load_programs(progs, ARRAY_SIZE(progs), false, _metadata, self, variant)
+#define LOAD_PROGRAMS_MAY_FAIL(progs) \
+	load_programs(progs, ARRAY_SIZE(progs), true, _metadata, self, variant)
 #define LOAD_BPF \
-	load_programs(NULL, 0, _metadata, self, variant)
-static void load_programs(const struct test_program programs[],
-			  const size_t progs_count,
-			  struct __test_metadata *_metadata,
-			  FIXTURE_DATA(hid_bpf) * self,
-			  const FIXTURE_VARIANT(hid_bpf) * variant)
+	load_programs(NULL, 0, false, _metadata, self, variant)
+static int load_programs(const struct test_program programs[],
+			 const size_t progs_count,
+			 bool load_may_fail,
+			 struct __test_metadata *_metadata,
+			 FIXTURE_DATA(hid_bpf) * self,
+			 const FIXTURE_VARIANT(hid_bpf) * variant)
 {
 	struct bpf_map *iter_map;
 	int err = -EINVAL;
@@ -128,6 +131,9 @@ static void load_programs(const struct test_program programs[],
 	}
 
 	err = hid__load(self->skel);
+	if (err && load_may_fail)
+		return err;
+
 	ASSERT_OK(err) TH_LOG("hid_skel_load failed: %d", err);
 
 	for (int i = 0; i < progs_count; i++) {
@@ -147,6 +153,7 @@ static void load_programs(const struct test_program programs[],
 
 	self->hidraw_fd = open_hidraw(&self->hid);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
+	return 0;
 }
 
 /*
@@ -904,7 +911,9 @@ TEST_F(hid_bpf, test_rdesc_fixup_get_data_overflow)
 		{ .name = "hid_rdesc_fixup_get_data_overflow" },
 	};
 
-	LOAD_PROGRAMS(progs);
+	/* newer verifier can detect the overflow at load time */
+	if (LOAD_PROGRAMS_MAY_FAIL(progs))
+		return;
 
 	ASSERT_EQ(self->skel->bss->get_data_overflow_check, 1);
 }

-- 
2.55.0

