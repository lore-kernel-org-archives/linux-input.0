Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8B224F3;
	Sat, 20 Jun 2026 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781965375; cv=none; b=nbMkpLIhEoDTRInG6XqmNAsnpfHDXBstbYIM8oOIm7xBX2iDJIr96eTZxgWzdVrjvMFUb3cjH1nVoFJHjJ48Q22vd8IE2/A1eucDo6a8s+v6INuPeCy83oNveVhifAk69Jh6zou5uFdKcV9yfCcuChyijOK0uRwxKbeCmsZ49Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781965375; c=relaxed/simple;
	bh=eKV78Cg24xS2tDh5BHI9wGlGxETb4a8lrNbht2SvlJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dS+cRoKIitIAnvQEzD6ezV8crvBNY8J6jd6B16oXLtvSrflheayOSR7i3OzazCZG4qxvxbnKy0r7eHo/WiCrAFcYbT1on2fXWiR9OIZr79J1pWPfSXy+4grc9WNnu8I37L/4CNv9KCVju9UAfn1IGlKx3zmBU6LlolgtgsdCR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=kSvQya12; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="kSvQya12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=/SxY0nOvQJLzkWoR8G6HQYMCgBAOyM2oKj
	ZM5THvRwM=; b=kSvQya12YWeFcbKEZ7s/KDC+Tg0vrY0HSS2BaJY3AQ//KHMcaj
	/M8jWAtjk7d56xtIVHC63+Vc2yowxlMrES7TP/U0Q0aXv60tlUCNJFJm/Vrl68aw
	OqS/Mxm2uRd3tHxd2Zi0AE8y//Nt9bBASVgq9UacMwGqXEzslQVQ9fLtg=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQBH0bsbojZqXHGQAg--.53711S3;
	Sat, 20 Jun 2026 22:22:37 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/2] HID: bpf: Fix hid_bpf_get_data() range check
Date: Sat, 20 Jun 2026 14:22:16 +0000
Message-Id: <6dbee73169b80f27a63dbf3db3488649df61b65d.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781627122.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQBH0bsbojZqXHGQAg--.53711S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrJFy5CFyUJFyrWrWkCrg_yoW8XrWUpw
	s5JrWakr42qrn7Ar4DKr4kGayrCa92g34UGFy8uF98uwnxXF1UJFyDtF98uay5Ar95CF9r
	KrZ0qr1xXr17AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdjb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5V
	A0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_
	Wrylc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7sRXNVgUUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

hid_bpf_get_data() returns a pointer into the HID-BPF context data when
the caller-provided offset and size fit inside ctx->allocated_size.

The current check adds rdwr_buf_size and offset before comparing the
result against ctx->allocated_size. Since both values are unsigned, a
very large size can wrap the sum below ctx->allocated_size and make the
helper return a pointer even though the requested range is not contained
in the backing buffer.

Use a non-wrapping range check instead: reject offsets beyond the
allocation, then compare the requested size with the remaining bytes
after the offset.

Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index d0130658091b0..09b45c40d84f0 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -299,7 +299,8 @@ hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr
 
 	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
 
-	if (rdwr_buf_size + offset > ctx->allocated_size)
+	if (offset > ctx->allocated_size ||
+	    rdwr_buf_size > ctx->allocated_size - offset)
 		return NULL;
 
 	return ctx_kern->data + offset;
-- 
2.34.1

