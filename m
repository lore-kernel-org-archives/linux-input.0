Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C413F9A13;
	Tue, 25 Aug 2026 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651732; cv=none; b=l/KgsjYYW2VsoIVl8pcEXr0tf/KanNuAoqDayRvJhoUtIRIINTV+aIJez7OLDxEVHtjXkDhjF/elBZUrSxhrcpvsX5N0ZBtutUj9yaeWCKpkFn3vpauFKAfniBoLe4x6UO8H7c3lhCRZIuUse+Uu8tWGKVzsom6af12VpO1Bngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651732; c=relaxed/simple;
	bh=eSEf0NJ/FDzTZdK6KbIhOnTFJmviX53xcLE5mdfpiqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNanJQHDStZeykCTucXE4VPI3TOCHFxWYCM7H3/3aimNdclNbjIN6wDlAwiREsn5KmCrbakEl+gjo950DRPrODzD2lZgrlTt8UPqoOltEwEuQI0B3lcBN8DXUS+BYOat/KEPk2oaSn1i7/L0pIJPv2s+Dt8Ub7SiRo7NdNIGhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2ny6szC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2ny6szC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC601F00A3D;
	Tue, 25 Aug 2026 09:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787651731;
	bh=WZC2dlrRslY57zHDt+VshR3khc8bqhpzVRl64eOUUiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a2ny6szCQa5DmKWNzLkTr7goce+1gD8GIgnMi1uZHjOvoaECgubxfOVymB2tO8as5
	 3gS+qLK5/3zZSImGMC7p5Dn7bi1+rbAZvu3d1gj96GLGXPKT53vSkOQLqHJvrp5eKW
	 MYdGgZgIToOdqFWIwGyHDWtvrOT1jnEjwFgqvuM35XmVdo0S63v4nWPhbx2L3SXmGm
	 ZXqqlbJELUp+AMIha3xxv6iPwxVV3zfkrFcl1n6VmHCNTsSOFpe2PNACaaz8CkMQyg
	 dAYgQPAaXBZ54Frb/WCxcfnm97rhLsnh9d12qi3gWbN9o6E7LV8bHFUhZ+tj8bwvOK
	 adsf+B29OXoUg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 25 Aug 2026 11:55:13 +0200
Subject: [PATCH v2 3/3] selftests/hid: prepare
 test_rdesc_fixup_get_data_overflow for the new verifier
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-wip-bpf-safe-v2-3-d044355c09d8@kernel.org>
References: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
In-Reply-To: <20260825-wip-bpf-safe-v2-0-d044355c09d8@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787651723; l=2813;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=eSEf0NJ/FDzTZdK6KbIhOnTFJmviX53xcLE5mdfpiqM=;
 b=Tl3rtj8QfIhNkymGgKEWgE/7jpo3QHfOjMvQGI8TZhjXg573kAwO6lieRPewg7aj71cva2UU5
 amC2fx4gIpKB7RXRfi7NMCUnS8a+eMXE2JQsETMGRC/kiQ41cOmjRUa
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

