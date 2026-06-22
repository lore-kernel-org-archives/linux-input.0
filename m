Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DC2369981;
	Mon, 22 Jun 2026 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113449; cv=none; b=lFF9oAad5s8anyv1mZKb57oc2/WabBiESVG+YvbtY/CY2WA7cIuqI+T0LPU2i42Cp+Teqri+TrEMe1HoTBUVe4bBROuZ8Zd/JeRwpDqga7azn6DUcDJNadvcKtgUkW7RtnPqwaE+MPePcWPdNsiaOQI+RuoTsYnL4oUNvwM1g2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113449; c=relaxed/simple;
	bh=AHbuZhj85bfW2iKkadSEoexvL79aFcpn+xlQaDGT++Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rpC8kXrxJcEUI5uKH1KbpdZ0g02M/CPsoHxSPpBvUfCZDSJ5gedlS+Sz4zawv9uuIUmM8gOI/b9rgRanDWn8cj72Zmyf9eJdKEMjMqt4GVttaqMjRggMkflBP0o6AuWp91N9674giUpR4virqY8VyACc8FRn8Pn33rU3hQQXBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=npYR1M47; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="npYR1M47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Cdv8y7SM7yZVnVBJMTVz0BsmeUgtn6gxh/
	EOqFobexY=; b=npYR1M47PgOMmn8FnF6cseiStdc+91mFOdlMAL6iLp4nTwov94
	Mil94WO5teabjlyUoFmc+56jRl7d8xd2j+Zmcu+36DIanzBCL+ny+vKM26WNkgls
	cmTCTvCOkYh+ki0CeXesFs1VTbEblJy59qdn8VsBHE8zzZSXhC8jLbJqM=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAnAJiI5DhqWyN2Ag--.33101S4;
	Mon, 22 Jun 2026 15:30:35 +0800 (CST)
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
Subject: [PATCH bpf-next v3 3/3] selftests/hid: Cover hid_bpf_get_data() size overflow
Date: Mon, 22 Jun 2026 07:30:11 +0000
Message-Id: <20260622073011.423657-3-chenyy23@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yQQGZQAnAJiI5DhqWyN2Ag--.33101S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5JFW8XFyUWF4UAr1UJrb_yoWrJw43pa
	95Za90kF1ktFn2gw18Jr4UuFWrGFn7XrW0qr1xAFy5Zws2vrW8XryxtFyjqF15CrZ09wnx
	Ca4IgasrZ3W8XaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GF4l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRha9-UUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a HID-BPF regression check for hid_bpf_get_data() requests whose
size would overflow when added to the offset.

The new rdesc fixup callback asks for offset 2 and size ~0ULL, then
records whether the helper returns NULL. A vulnerable kernel returns a
non-NULL pointer because the runtime check wraps the addition. A fixed
kernel rejects the request. The test only checks the helper result and
does not dereference the returned pointer.

The callback reports the helper result through BSS and returns 0
intentionally. hid_rdesc_fixup return values are consumed as report
descriptor fixup results, so a positive test-result value would be
interpreted as a replacement report descriptor size.

Also add KHDR_INCLUDES to the HID selftest build so hid_bpf.c sees the
current kernel UAPI HID definitions on systems whose installed headers do
not provide enum hid_report_type.

Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/hid/Makefile    |  2 +-
 tools/testing/selftests/hid/hid_bpf.c   | 11 +++++++++++
 tools/testing/selftests/hid/progs/hid.c | 15 +++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 50ec9e0406aba..357c6eb5ff5ee 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -24,7 +24,7 @@ CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
 
-CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT) $(KHDR_INCLUDES)
 CFLAGS += -I$(OUTPUT)/tools/include
 
 LDLIBS += -lelf -lz -lrt -lpthread
diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 269256e1decd8..b851339308c21 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -898,6 +898,17 @@ TEST_F(hid_bpf, test_rdesc_fixup)
 	ASSERT_EQ(rpt_desc.value[4], 0x42);
 }
 
+TEST_F(hid_bpf, test_rdesc_fixup_get_data_overflow)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_rdesc_fixup_get_data_overflow" },
+	};
+
+	LOAD_PROGRAMS(progs);
+
+	ASSERT_EQ(self->skel->bss->get_data_overflow_check, 1);
+}
+
 static int libbpf_print_fn(enum libbpf_print_level level,
 			   const char *format, va_list args)
 {
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 5ecc845ef7921..b21fbb13c926f 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -13,6 +13,7 @@ struct attach_prog_args {
 
 __u64 callback_check = 52;
 __u64 callback2_check = 52;
+__u64 get_data_overflow_check;
 
 SEC("?struct_ops/hid_device_event")
 int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
@@ -240,6 +241,20 @@ struct hid_bpf_ops rdesc_fixup = {
 	.hid_rdesc_fixup = (void *)hid_rdesc_fixup,
 };
 
+SEC("?struct_ops.s/hid_rdesc_fixup")
+int BPF_PROG(hid_rdesc_fixup_get_data_overflow, struct hid_bpf_ctx *hid_ctx)
+{
+	if (!hid_bpf_get_data(hid_ctx, 2 /* offset */, ~0ULL /* size */))
+		get_data_overflow_check = 1;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops rdesc_fixup_get_data_overflow = {
+	.hid_rdesc_fixup = (void *)hid_rdesc_fixup_get_data_overflow,
+};
+
 SEC("?struct_ops/hid_device_event")
 int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
-- 
2.34.1

