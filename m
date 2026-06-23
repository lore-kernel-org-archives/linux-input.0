Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DFF37B41A;
	Tue, 23 Jun 2026 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.6.4.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196079; cv=none; b=OaPVIorODwgkls5+PRaoQL1znvhx9kNgrfBQDuLz4VbzMdBWXb2jVE5xfKGgAdS6gMVqRIcPb3ETmUdTTADKrvh/Cmsma9UQ/Orn3bvY9BT50NMdFEZJeuik5cdYSy/cIy1HkLA8k3u3L0GjDHXYoXjyKONkYk+24yqDn6IAOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196079; c=relaxed/simple;
	bh=e7TNBBM1TSx54WnN0PHLdcpWrG9DY5ThcsVA+FaU4I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TtWcEihXAdI9RyrEGYWEZLov7tiPQwpd6NEo6wTDyAnotSzVhKkCJQjmcpYjjTSftwjo1M7OK0kD2Pe5524NFL63co4dljJDopC0FXF1Nj8u4E/GBp8/qhAFzSVRNLF6WqLWU1yUkzJX8ASDV62Rz6cGtpSN7k/Pu0ETc4pjpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ejOy4Z8t; arc=none smtp.client-ip=101.6.4.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ejOy4Z8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LvJAs+CzjL3h1SIrNq7Aq3M5TxXZ0S4NA5
	jpmZ0kSMs=; b=ejOy4Z8t5x9Jz1rZIAQESYmepbRzxUTNkExRTAecnRaSv28lA9
	eEqvfUF0y+Dg/arN02aNqm4/VaRGSyZyGrNmGpL8ZsI3LoOKZg2dvULepeqqbRP9
	k4RjJlzcIoxzWlpbhfboE3jod94m7v4iiNUQaRIAnkNyisOIVTgNtT7Ew=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXO5tVJjpq+xV3Ag--.45930S4;
	Tue, 23 Jun 2026 14:23:38 +0800 (CST)
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
Subject: [PATCH bpf-next v4 2/3] selftests/hid: Load only requested struct_ops maps
Date: Tue, 23 Jun 2026 06:23:14 +0000
Message-Id: <20260623062315.2694160-3-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623062315.2694160-1-chenyy23@mails.tsinghua.edu.cn>
References: <20260623062315.2694160-1-chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBXO5tVJjpq+xV3Ag--.45930S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxurWfXrWDCFWxur1UAwb_yoW5WrW3pa
	95W3yfKr10qr45W3W3Z3yUWrn5Kryvqw1fAr98W345ZFZ8Zr9Yqr1xKFWIvFy5AFWvqwnI
	vas0kr18CrWjya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GF1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRXDGYUUUUU
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

