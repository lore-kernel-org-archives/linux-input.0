Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872F39060B;
	Tue, 23 Jun 2026 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195824; cv=none; b=jA+satzufJ2beLhQKTtaBjg5s4ya+gGGnLryrFK7wWS6XjiCKZO8E4Uou9rJZNfYXztZW06zSZJdkHzbi6Z+sm7q5zR4O5kboL6V81ihHZrE5u0Os8len0xaip0KW4932Ueq19FHG3swegbcTBob4LQQRO/C9Ns2NbcEhY5YK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195824; c=relaxed/simple;
	bh=UEKI5XyyrKyd+53gsALTgR8Kp3Pdc7P1e5RZFL9e16c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bn8U2TMsAlehS+EYdEYyiYjJsWdoloYd70d2/Ph+mHUrxahKx+BUykThgtVfRTAxyQr+HH4k74oEyiiwQ/EQyuAonQ1/vWhK+pJUGDZe/1ATKCsm/naIUfWdPGy+UwCbvdIdNQXlC1Xmeu2SoPtakCqbsNzu9EhEUtA9KUVYI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=VbSEG5y6; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="VbSEG5y6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=xRBZU
	xJ2G2amxV0G6KtKYpBDOev4SgzYGyEIllHZPtY=; b=VbSEG5y6Sny6c79qRzGQJ
	5pnx3hfmomcBslmcfUfWyprJ7ZLtvpg+ONYqyH1KhKOJqdesFkTdLWAjYjG6w8vw
	6ZdFa6JV1czYh0ToouSMUsJp+7YMnbnj1eXTqoqvzMjt9e/Zcw9d+DgN4jSGpPBc
	Ibx0daVXRD/Y48XyAz5QSE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXO5tVJjpq+xV3Ag--.45930S2;
	Tue, 23 Jun 2026 14:23:26 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/3] HID: bpf: Fix hid_bpf_get_data() range check
Date: Tue, 23 Jun 2026 06:23:12 +0000
Message-Id: <20260623062315.2694160-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBXO5tVJjpq+xV3Ag--.45930S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrAw1DWw4xWrWrJrWxCrg_yoW5JFy7pF
	Z5Ww45Kr1Dtr1xCrn7KrWUCry5Gan5XF4UWry8Wa4rZwsxWF18X34I9FyY9FZ8A34vg3WY
	va40qFnF93ZrZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRYYLkU
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

hid_bpf_get_data() exposes a pointer into the HID-BPF context data when
the caller-provided offset and size fit inside ctx->allocated_size.
The helper currently checks that range with:

  rdwr_buf_size + offset > ctx->allocated_size

Since both operands are unsigned, a very large size can wrap the sum and
make an out-of-range request look valid.

Patch 1 changes the helper to use check_add_overflow() for the range end
and then compare the computed end against ctx->allocated_size.

Patch 2 updates the HID selftest loader to create only the struct_ops
maps requested by the current test, so unrelated programs from the shared
HID-BPF skeleton are not autoloaded.

Patch 3 adds a HID-BPF regression check that asks hid_bpf_get_data() for
offset 2 and size ~0ULL from an rdesc_fixup callback and expects NULL.
It also adds KHDR_INCLUDES to the HID selftest build so the userspace
test sees current kernel UAPI HID definitions.

Changes in v4:
  - Use check_add_overflow() in hid_bpf_get_data() before comparing the
    computed range end against ctx->allocated_size.
  - Update the fix commit message to describe the overflow-helper check.

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

v3: https://lore.kernel.org/bpf/20260622065246.414380-1-chenyy23@mails.tsinghua.edu.cn/
v2: https://lore.kernel.org/bpf/cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn/
v1: https://lore.kernel.org/bpf/cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (3):
  HID: bpf: Fix hid_bpf_get_data() range check
  selftests/hid: Load only requested struct_ops maps
  selftests/hid: Cover hid_bpf_get_data() size overflow

 drivers/hid/bpf/hid_bpf_dispatch.c      |  5 +++-
 tools/testing/selftests/hid/Makefile    |  2 +-
 tools/testing/selftests/hid/hid_bpf.c   | 36 ++++++++++++++++++++-----
 tools/testing/selftests/hid/progs/hid.c | 15 +++++++++++
 4 files changed, 49 insertions(+), 9 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

