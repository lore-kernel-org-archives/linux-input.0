Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F6735E1A3;
	Mon, 22 Jun 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113447; cv=none; b=uz5jD76B+PzdaTIw1dJx8oh7o2Iv8/8dgoahnj982iZHEPVknokozRUYujIGC8TGdmnPxoQrTXmnLbbMgf8dGzZsu9jG22xv/Ct/t7FFMCi9EGYeXV/70kufosxFytbCdFBVus4GqWT/x/Ih4uPS6bQQFOTVnP2lvTCe6s2b90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113447; c=relaxed/simple;
	bh=e7TNBBM1TSx54WnN0PHLdcpWrG9DY5ThcsVA+FaU4I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ga5rfcrZzXf6hR4F6SRvHCJupUkA41PkVan2x+6oCTyBsOWjQ57Jt9EgYIAmf3oD+gb7jBjsqnUHopJk+y9slMY6m76C7Ar2QjSm7Y2c5VA7hLDuO5Ny5/w0Xhm4UuBObP9nVHSd7YqIJ6qYJyHkX6h9TOP9KHEBTh78SgBKQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ofnIPlJI; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ofnIPlJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LvJAs+CzjL3h1SIrNq7Aq3M5TxXZ0S4NA5
	jpmZ0kSMs=; b=ofnIPlJIDdleqQenWgfncvlqYblkH76saubAOdGJel5fKj1N9o
	S1QXZoknfk4k/YUAu/LJ4aQDfM+umJDthtCGoTsoeK/8kbNTPSpPOQkIabGUudIr
	T0iv5Q/qtrieUp3dqzWxjNk3um2z3B2UikWhbkbjdBkiv86oCd9W7RZ28=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAnAJiI5DhqWyN2Ag--.33101S3;
	Mon, 22 Jun 2026 15:30:33 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/3] selftests/hid: Load only requested struct_ops maps
Date: Mon, 22 Jun 2026 07:30:10 +0000
Message-Id: <20260622073011.423657-2-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622073011.423657-1-chenyy23@mails.tsinghua.edu.cn>
References: <20260622065246.414380-1-chenyy23@mails.tsinghua.edu.cn>
 <20260622073011.423657-1-chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAnAJiI5DhqWyN2Ag--.33101S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxurWfXrWDCFWxur1UAwb_yoW5WrW3pa
	95W3yfKr10qr45W3W3Z3yUWrn5Kryvqw1fAr98W345ZFZ8Zr9Yqr1xKFWIvFy5AFWvqwnI
	vas0kr18CrWjya7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdYb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c
	0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjTR0PfvDUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

The HID selftest skeleton contains several struct_ops maps, but each test
usually wants to load only the programs named by that test.

load_programs() disabled auto-attach for all maps, but left struct_ops
autocreate enabled. libbpf can enable autoload for programs referenced by
autocreated struct_ops maps, so an unrelated program can be loaded and fail
even when the current test does not use it.

Disable autocreate for all struct_ops maps by default, then re-enable it
only for the maps selected by the test before loading the skeleton.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/hid/hid_bpf.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 1e979fb3542ba..269256e1decd8 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -86,6 +86,20 @@ static void load_programs(const struct test_program programs[],
 	self->skel = hid__open();
 	ASSERT_OK_PTR(self->skel) TEARDOWN_LOG("Error while calling hid__open");
 
+	/*
+	 * Disable all struct_ops maps by default so libbpf does not autoload
+	 * programs referenced by maps that are unrelated to the current test.
+	 */
+	bpf_object__for_each_map(iter_map, *self->skel->skeleton->obj) {
+		if (bpf_map__type(iter_map) == BPF_MAP_TYPE_STRUCT_OPS) {
+			err = bpf_map__set_autocreate(iter_map, false);
+			ASSERT_OK(err) TH_LOG("can not disable struct_ops map '%s'",
+					      bpf_map__name(iter_map));
+		}
+
+		bpf_map__set_autoattach(iter_map, false);
+	}
+
 	for (int i = 0; i < progs_count; i++) {
 		struct bpf_program *prog;
 		struct bpf_map *map;
@@ -102,6 +116,10 @@ static void load_programs(const struct test_program programs[],
 		ASSERT_OK_PTR(map) TH_LOG("can not find struct_ops by name '%s'",
 					  programs[i].name + 4);
 
+		err = bpf_map__set_autocreate(map, true);
+		ASSERT_OK(err) TH_LOG("can not enable struct_ops map '%s'",
+				      programs[i].name + 4);
+
 		/* hid_id is the first field of struct hid_bpf_ops */
 		ops_hid_id = bpf_map__initial_value(map, NULL);
 		ASSERT_OK_PTR(ops_hid_id) TH_LOG("unable to retrieve struct_ops data");
@@ -109,13 +127,6 @@ static void load_programs(const struct test_program programs[],
 		*ops_hid_id = self->hid.hid_id;
 	}
 
-	/* we disable the auto-attach feature of all maps because we
-	 * only want the tested one to be manually attached in the next
-	 * call to bpf_map__attach_struct_ops()
-	 */
-	bpf_object__for_each_map(iter_map, *self->skel->skeleton->obj)
-		bpf_map__set_autoattach(iter_map, false);
-
 	err = hid__load(self->skel);
 	ASSERT_OK(err) TH_LOG("hid_skel_load failed: %d", err);
 
-- 
2.34.1

