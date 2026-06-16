Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A782F745E;
	Tue, 16 Jun 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627735; cv=none; b=gJQxGDN2SPjaAJgLZuXdlUeNt6HfEZEGTm40sLJGQL3c49C8WwL2e3pBN2Afbyi87HAVxRlFVX2o6fW9lL/Dj+zkrxKQsEpCZvlFR7VwOOzdU8KR99F2kfJPbUO/p45sDyP+awWcbYm5M/JqtJqgR3YhisCH20qAJ9n4qSMdwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627735; c=relaxed/simple;
	bh=uiVxNiO+c1HbRk9khD1X+vm48S7nNpaOMmCxtwAZV2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5V/0ddTonM8stX/U7sZyR+UF2+nPZr+kF+ePNO1AX9jFtxGgsSuugldWR3VYNwBzTtETbLEvA49hiubphjJNQzZlYgk4wHXzDulAYpE5yIkSYqrM2U1OUaXh7oTCvviLbvSHt171DSTwknuW7GJAjRL4dh7UmEuAoCNZxGB574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CftAT7OW; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="CftAT7OW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ZYlUOPFiM4BHD5zvwDWzA3VmXhx2aOIeUM
	Z5QywzWlg=; b=CftAT7OWruDlH/OfJydg6aU5nLZeaK7pYpmf+dPNXd2D71ggVB
	zJv/2RzBxn+3oRWc9/CmvClcuFToZJu14/SGXoQ0IbBJetlzkTfhDCqJgPtZo9ZS
	kRkzM8hvA6HneOxLI/+Tm4BTW/fxf4OxI3hpoYwte0EFXlT5QBsR0j0Lc=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQDn+6A9ezFqyT1PAg--.61078S3;
	Wed, 17 Jun 2026 00:35:15 +0800 (CST)
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
Subject: [PATCH bpf-next 1/2] HID: bpf: Fix hid_bpf_get_data() range check
Date: Tue, 16 Jun 2026 16:35:06 +0000
Message-Id: <783681f27625a11ed58f00221be046643232a2fc.1781627122.git.chenyy23@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:ywQGZQDn+6A9ezFqyT1PAg--.61078S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrJFy5CFyUJFyrWrWkCrg_yoW8Xr4kpw
	s5JrWYkr4jqr97AF4DKr1rKayrCan2g34UKFW8uFy3u3sxZF18JFnrtF98uay5ArZ5CFsr
	CrZ0qr1xXr1UAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdYb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
	AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0E
	x4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI
	8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_
	GFv_Wrylc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvj4RQyCXUUUUU
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

Fixes: 4171954f56fb ("HID: bpf/dispatch: regroup kfuncs definitions")
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

