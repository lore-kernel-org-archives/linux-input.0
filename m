Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81823A16B9;
	Tue, 23 Jun 2026 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.6.4.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195838; cv=none; b=Se4WS9TAQKsmUQMia6CHNn3lpjoy1pwYCkF6kYZ79mO1j/cBG2TUa3W45r7AdfnRtPrTeXehisM9uHrt+Q1dIzOxeyl05j7VmylrZhJ/MspgW8h8FQqcvui4SW3maPtuhRbylCj2dcztWMZrB6RqMxNbtIprQdDtSxzQRLWufX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195838; c=relaxed/simple;
	bh=pwtkzASJNVjCKSrcvxCUWWjfSCS8eiBADxrT6nIY8ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSjR9RreM3iY308P2gV/8afsQ6ZwC5nCPpEcqqHl95SiVCkNY89LwgHh/YXAP5KqRsafPOSsb2eqH052Qs/m32mh5nX3SzJPUga9lBZ9XCGwy4RzD9MVknxztn73mwwC25Ku56rrk+71P8J/qBy+fDNfIYQgKrPeldoMAXx3+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ArxDkIUR; arc=none smtp.client-ip=101.6.4.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ArxDkIUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=tMAx74kzkl2VQLZyI6GoTaNEBxiawKId4c
	gEvjG3MmM=; b=ArxDkIURLKrdK3IQT0j5lfRnL2pA1OSwgDbNf/pAId1w6Xk2vK
	FySeUBvUpa3iPCjBec2wfHS2IPfW7vu1JPn8I5sStp1RVtptPURFHS5Da7+k9MpK
	YK/xcIOXBVDZNPWwpSwEN6JeucTxcdNiSUnm2mVV9zulXhu65E7jrPb58=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXO5tVJjpq+xV3Ag--.45930S5;
	Tue, 23 Jun 2026 14:23:44 +0800 (CST)
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
Subject: [PATCH bpf-next v4 3/3] selftests/hid: Cover hid_bpf_get_data() size overflow
Date: Tue, 23 Jun 2026 06:23:15 +0000
Message-Id: <20260623062315.2694160-4-chenyy23@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:ywQGZQBXO5tVJjpq+xV3Ag--.45930S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5JFW8XFyUXw1Utr48Crg_yoWrJw43pa
	95Zan0kF1ktFn2gw18Jr4UuFWrG3Z7XrW0qr1xAFy5uws2vrW8XryxtFyjqF15urZY9wnx
	Ca4IgasrZ3W8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
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
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRWjgcUUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a HID-BPF regression check for hid_bpf_get_data() requests whose
size would overflow when added to the offset.

The new rdesc fixup callback asks for offset 2 and size ~0ULL, then
records whether the helper returns NULL. A vulnerable kernel returns a
non-NULL pointer because the runtime check wraps the addition. A fixed
kernel rejects the request. The callback records the helper result
without dereferencing any returned pointer.

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
index 96071b4800e82..2f423de831473 100644
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

