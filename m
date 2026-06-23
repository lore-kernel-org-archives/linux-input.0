Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5BC3A4F2F;
	Tue, 23 Jun 2026 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.6.4.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195837; cv=none; b=DyW3hpmsOrsG0ZrkhNGXnso/CWR0vrW/EtuKVaHRdLorhNJGjkwQfhzfwW17z3kMkZB3HVHLo5pzlgula5DI/qhST7XRy28Ywx4EDjNLNu4F93U6HAHVZkNUrb9jW6RYyz0PgGfZ56C2edH430JKiXcbBtcss9YxO1Wrir/M09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195837; c=relaxed/simple;
	bh=NBQu0KaVCL/162zkq0/yG4ZyejgGOpXB0lP/fT5Zes8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpE0HVBBjUEwFy9Y+rgeyxa/9YJZRTN0Eho4faO9Jo4MRFhlfu6cjazq333IYHacXFPS0SSgDK9gtAocVG6YTdeui4RnjNBrR6s9i8BHG79ISrzq4HP8ky/tEuaqDlnfTkl/ZUouywA2JQnXHSdtIgt/rVYX0mXFd9coHGd/+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=hS5sxciZ; arc=none smtp.client-ip=101.6.4.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="hS5sxciZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Bqs2pFxtcHjp+5Vwe9NDTZNLt27ZdnICMD
	9kYAGKKcc=; b=hS5sxciZ3vF/VwZZWo/v7wSzAegDADkE1M0EPNQWcCf8Q6eZi4
	p8rKVNKjeJhWnjRpYMyigSCrugn9tdGeqANXhjNGqmpuIKXaU+hfBl1gIOy8frZb
	7DT1LpeJdt9kCzgPfhOth75e4F+PoxRLHyHn6pI188NCxTiNKNsTWTotA=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXO5tVJjpq+xV3Ag--.45930S3;
	Tue, 23 Jun 2026 14:23:28 +0800 (CST)
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
Subject: [PATCH bpf-next v4 1/3] HID: bpf: Fix hid_bpf_get_data() range check
Date: Tue, 23 Jun 2026 06:23:13 +0000
Message-Id: <20260623062315.2694160-2-chenyy23@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:ywQGZQBXO5tVJjpq+xV3Ag--.45930S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrJFy5CFyUJFyrWrWkCrg_yoW8AF45pr
	4kArW3Ar4jvw17CF4j9r1vka45Ca1vqryUGFy8uFy3uwnaqF1DWF1ktFy5Cay5ZrZ5GFZr
	GrWqqr1xXr17ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUd2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c
	0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0z_rcT3UUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

hid_bpf_get_data() returns a pointer into the HID-BPF context data when
the caller-provided offset and size fit inside ctx->allocated_size.

The current check adds rdwr_buf_size and offset before comparing the
result against ctx->allocated_size. Since both values are unsigned, a
very large size can wrap the sum below ctx->allocated_size and make the
helper return a pointer even though the requested range is not contained
in the backing buffer.

Use check_add_overflow() to reject wrapped range ends before comparing
the requested range end against ctx->allocated_size.

Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d0130658091b0..536f6d01fd14c 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -17,6 +17,7 @@
 #include <linux/kfifo.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include "hid_bpf_dispatch.h"
 
 const struct hid_ops *hid_ops;
@@ -296,10 +297,12 @@ __bpf_kfunc __u8 *
 hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr_buf_size)
 {
 	struct hid_bpf_ctx_kern *ctx_kern;
+	size_t end;
 
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
 
-	if (rdwr_buf_size + offset > ctx->allocated_size)
+	if (check_add_overflow(rdwr_buf_size, offset, &end) ||
+	    end > ctx->allocated_size)
 		return NULL;
 
 	return ctx_kern->data + offset;
-- 
2.34.1

