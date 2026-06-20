Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D983242AC;
	Sat, 20 Jun 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781965375; cv=none; b=SAW4FaHCqjLSETup5e5V9fZXqP/CJW3J9ntel1Co6KZCaK2IPfQGzFYW4iJCkH1pzzLkD9B0vkwwxSpF4HdZwnh1HG40I+Qw9ma7y7sb5lZ2eR2GkYZ+/lVmfadz4E9LmkJQuaL1pDUybtrcqDghnBOpakLB9lQvliPttNY7LAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781965375; c=relaxed/simple;
	bh=Qq4qRaR6cyuaf8bfnOwlcdMg/K0Eld5LP9Zp59TaI0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzN0jXOcChuLgA+0EW+D3dYgyTFhjOoN27XRJSca62zDpVtVLZYLoZO+Xza8Ni2t0Rp6ptYo/yNUObjcnyWjqNt/1/T4hHduiO/zZsVxdmyfafoVj1MVba+kNCJK/K25uY2Jvwk6MM7oV6kmUrp84k8fZSrnNFeKgKD92VjtRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=F2MTBXaN; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="F2MTBXaN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=/YSzKvP+6OvD5Tjl/dg3jAaqkQM9nPdYE6
	tSdOD5rpY=; b=F2MTBXaN6MPAO4gcVY131F+fmg6vQuRcUuoDgMUo++lNioYOap
	fMw/6Aiy+jq5HZPzhIO/Xoe/yX/MjG/rID5nOjAZTY4emRnS8ASsAlKY+lYRaogk
	AFus8HmVEmVD4lzDKZF+l21nvTYhpkrnKVm/YHzIPKGHq4UrzwWFOx/ak=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQBH0bsbojZqXHGQAg--.53711S2;
	Sat, 20 Jun 2026 22:22:32 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/2] HID: bpf: Fix hid_bpf_get_data() range check
Date: Sat, 20 Jun 2026 14:22:15 +0000
Message-Id: <cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQBH0bsbojZqXHGQAg--.53711S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5uw1fuFWkZryUCrW3Wrg_yoW8KFy3pa
	95GrsIkr1DtF9rWw17ArW8Ary5Ga97XayUGry8ZFyUZ3ZagFn7JFyIkryDWF90k3yYgr1a
	9a40qrsFgw12yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRt5r4UUUU
	U
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

hid_bpf_get_data() exposes a pointer into the HID-BPF context data when
the caller-provided offset and size fit inside ctx->allocated_size.
The helper currently checks that range with:

  rdwr_buf_size + offset > ctx->allocated_size

Since both operands are unsigned, a very large size can wrap the sum and
make an out-of-range request look valid.

Patch 1 changes the helper to reject offset values beyond the allocation
and then compare the requested size against the remaining bytes.

Patch 2 adds a HID-BPF regression check that asks hid_bpf_get_data() for
offset 2 and size ~0ULL from an rdesc_fixup callback and expects NULL.
It also adds KHDR_INCLUDES to the HID selftest build so the userspace
test sees current kernel UAPI HID definitions.

Validation, rebased and tested on bpf-next master e4287bf34f97
("selftests/bpf: Work around llvm stack overflow in crypto progs"):

  git diff --check e4287bf34f97..HEAD: OK
  scripts/checkpatch.pl --strict -g e4287bf34f97..HEAD: OK
  make O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616 \
    drivers/hid/bpf/hid_bpf_dispatch.o: OK
  make -C tools/testing/selftests/hid \
    O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616 \
    OUTPUT=/tmp/hid-selftest-026-v2 \
    VMLINUX_BTF=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616/vmlinux \
    KHDR_INCLUDES=-isystem /root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616/usr/include \
    hid_bpf: OK

Changes in v2:
  - Drop the temporary data variable around the overflow
    hid_bpf_get_data() call in the selftest callback.
  - Correct the Fixes tag to commit 658ee5a64fcf ("HID: bpf: allocate
    data memory for device_event BPF programs").

v1: https://lore.kernel.org/bpf/cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (2):
  HID: bpf: Fix hid_bpf_get_data() range check
  selftests/hid: Cover hid_bpf_get_data() size overflow

 drivers/hid/bpf/hid_bpf_dispatch.c      |  3 ++-
 tools/testing/selftests/hid/Makefile    |  2 +-
 tools/testing/selftests/hid/hid_bpf.c   | 11 +++++++++++
 tools/testing/selftests/hid/progs/hid.c | 15 +++++++++++++++
 4 files changed, 29 insertions(+), 2 deletions(-)


base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
-- 
2.34.1

