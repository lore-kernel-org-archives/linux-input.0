Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963F35F5ED;
	Mon, 22 Jun 2026 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111214; cv=none; b=dcEAZAMg6r/Rm1VFWuXyhk+owHFTnx6MiDENac1TNkpzuZ77NtSCBTqtamTNgHfupILKgDb3XeHzT/LrqRMGX3bM/HkVM9ladVAppaQKlAuhb4dZeWFw0Rn+U5Y79twPjpf7URq76pwKGisZ24QAyo+rYS8K8P4yTtNJUymcxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111214; c=relaxed/simple;
	bh=Uc8DgKWYFc8dSHH9ZBDpfCdXQEAJCpqmoKmwVMdIyhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgadFROvC7+baa11s+39KAHKBikPhknZ7aTjOGdIqTFfT34Q6jieN23xA0ln7S3uIfWbJhGBJc2vk/1UQh4Dmx7oNzfIfmI6hh/gT1mH5FP2adGxy3iJQAupNeRmtgljnZ/L9918OZ3lJdsUvOetZBe1SGVS219B+s/LHVSAaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=bK2McrOi; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="bK2McrOi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=TRFmslgIvNAMQuDTnCBEzGHfA7NpVQD7Tc
	RNEV8BwbU=; b=bK2McrOi/U5Jp/uS0Bf7+gVu+kfzjHgZgWGYGdIGfXRvi/HYvP
	r9Q/EJ4w+nsGxKTXZHfeBU4UXBIeHBqe1FGbnP63RCYwk8nKKKoXEC0A+rgjE7XD
	tp6i6I9yhrsFzQq8r8ZFV3V/KtV5K6ija/sD41oMStEhepZAbHHBb/J5A=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQAXLKHN2zhq_N1wAg--.43447S2;
	Mon, 22 Jun 2026 14:53:18 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/3] HID: bpf: Fix hid_bpf_get_data() range check
Date: Mon, 22 Jun 2026 06:52:43 +0000
Message-Id: <20260622065246.414380-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQAXLKHN2zhq_N1wAg--.43447S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrAw1DWw48uw1fJFykAFb_yoW8tr1UpF
	Z3Wa15Kr1Utr13CF1xCrWUGryrGan5XF47Jry8Wa4rZws8uF1kJ34IkFyjvFy5A34vgr1Y
	v340qFnI9wnFva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR1q2_U
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

hid_bpf_get_data() exposes a pointer into the HID-BPF context data when
the caller-provided offset and size fit inside ctx->allocated_size.
The helper currently checks that range with:

  rdwr_buf_size + offset > ctx->allocated_size

Since both operands are unsigned, a very large size can wrap the sum and
make an out-of-range request look valid.

Patch 1 changes the helper to reject offset values beyond the allocation
and then compare the requested size against the remaining bytes.

Patch 2 updates the HID selftest loader to create only the struct_ops
maps requested by the current test, so unrelated programs from the shared
HID-BPF skeleton are not autoloaded.

Patch 3 adds a HID-BPF regression check that asks hid_bpf_get_data() for
offset 2 and size ~0ULL from an rdesc_fixup callback and expects NULL.
It also adds KHDR_INCLUDES to the HID selftest build so the userspace
test sees current kernel UAPI HID definitions.

Changes in v3:
  - Split out a HID selftest loader fix that disables autocreate for
    unrelated struct_ops maps.
  - Add a Fixes tag to the selftest patch.
  - Keep the BSS result flag in the rdesc fixup callback and explain why
    the callback must still return 0.

Changes in v2:
  - Drop the temporary data variable around the overflow
    hid_bpf_get_data() call in the selftest callback.
  - Correct the Fixes tag to commit 658ee5a64fcf ("HID: bpf: allocate
    data memory for device_event BPF programs").

v2: https://lore.kernel.org/bpf/cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn/
v1: https://lore.kernel.org/bpf/cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (3):
  HID: bpf: Fix hid_bpf_get_data() range check
  selftests/hid: Load only requested struct_ops maps
  selftests/hid: Cover hid_bpf_get_data() size overflow

 drivers/hid/bpf/hid_bpf_dispatch.c      |  3 ++-
 tools/testing/selftests/hid/Makefile    |  2 +-
 tools/testing/selftests/hid/hid_bpf.c   | 36 ++++++++++++++++++++-----
 tools/testing/selftests/hid/progs/hid.c | 15 +++++++++++
 4 files changed, 47 insertions(+), 9 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

