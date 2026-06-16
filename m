Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BFA47799E;
	Tue, 16 Jun 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627734; cv=none; b=VDorut+dvrelgXIqJhMIBlSNRiUehj8Uu+ZM6KcGeKi1aSqmJXq5IUPU/cI11fXSQuz4FSMaubDasVAoJiTZHEP7PP6GLi+BQfXiDGID3zz1zGCGhjJij6qVF0mg3NT+f4ycrnQCW+iiASxSRwhXpUIcOSep6S30CC3mvEs1eSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627734; c=relaxed/simple;
	bh=qbEFuI4yeXvZ2MwBQP4YSJlQk5kKM8aRC3sQB8VOSi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qpc9oGf4sGu5VUbrQS5dvLNCBB2AYna/HhSSYPUcgBnJjdTdrTTbNBBjtnEbOb1sKyhZ5uBrsVBF/IEJ0pVsz7gPoJgHt5S4JICpuQmiUkjeFidYliL1pV8aTwUHGQR7wOcChDp5Aq9/lokWo7nzFWHTPaxHLGnDkTUh3EnvJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=cvpG0k5J; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="cvpG0k5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=+rrWj
	roSdQ+G389uqQdakkrfKwWhXx8nkavz2LbiPlY=; b=cvpG0k5Jihili3DbgIZjW
	5/ZuZ50pOid/qDsLvyOiGbIqr2DtDbl42t5PvIVMR/D5BrKt0nrjBRXqHcUQ1/IA
	WYgPyVhZoll4truNdBM7bpHvgXkUSUV4Jj13ek8YcSOYDuSu61HyuDFAMFbsQRcF
	KKzvhPwrhcwstZ9fSQfSzo=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQDn+6A9ezFqyT1PAg--.61078S2;
	Wed, 17 Jun 2026 00:35:13 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] HID: bpf: Fix hid_bpf_get_data() range check
Date: Tue, 16 Jun 2026 16:35:05 +0000
Message-Id: <cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQDn+6A9ezFqyT1PAg--.61078S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5uw1fuFWDCFyUXF4Utwb_yoW8tw45pa
	n5Grs0kr1DtFy7uw1xAFW8tryrCFZ7X3yUCryxZry7Z3ZagFy8GFyIkFyDWF93GrWFgr12
	9r10qrsF9w12yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7xRLXoxUUUUUU==
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

  git diff --check origin/master..HEAD: OK
  scripts/checkpatch.pl --strict -g origin/master..HEAD: OK
  make O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616 \
    drivers/hid/bpf/hid_bpf_dispatch.o: OK
  make -C tools/testing/selftests/hid \
    O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616 \
    OUTPUT=/tmp/hid-selftest-026 \
    VMLINUX_BTF=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616/vmlinux \
    KHDR_INCLUDES=-isystem /root/ebpf-verifier-bug-detection/kernel-build/bpf-next-hidbpf-20260616/usr/include \
    hid_bpf: OK

The sanitized UAPI headers were generated in the build tree with
headers_install.  The final install/copy step reported missing rsync in
this environment, but the generated build-tree usr/include was present
and used for the selftest build.

Yiyang Chen (2):
  HID: bpf: Fix hid_bpf_get_data() range check
  selftests/hid: Cover hid_bpf_get_data() size overflow

 drivers/hid/bpf/hid_bpf_dispatch.c      |  3 ++-
 tools/testing/selftests/hid/Makefile    |  2 +-
 tools/testing/selftests/hid/hid_bpf.c   | 11 +++++++++++
 tools/testing/selftests/hid/progs/hid.c | 18 ++++++++++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)


base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
-- 
2.34.1

