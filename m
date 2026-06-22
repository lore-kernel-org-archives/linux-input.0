Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074B2FE0F;
	Mon, 22 Jun 2026 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107471; cv=none; b=l2xxR6PO1H40HxLUN1ZsI++qpm/FidoxD61oSGqV0QXQFxLvNjJd1zbDx4qRlUqXc7XGX5821sNhI9qL4h/w21gir5jj+KQIJq7o5mTjB3mRHeWbZS/alkuddjM9eNxWf6fapTxCQQhR8SzdmOiTACpS9yzOv5hxoH0ipRA9nX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107471; c=relaxed/simple;
	bh=PjVTgdY6rEqsXENe70BI7SH0qlL2soygiWUC/3Citek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0Sav+UniIPr2BlaWVk1FKIjlV/hH0epuERy1O2JgonBbX6ZKBsQSbndRFkX2QZbfnbLktSG08rNVOuaTAo2omw0jfVK4uRL9KuZglnK6spR/9fHHEDMsbX1fm2Ka9guUL4mCxobUOxTHrowJ8DsYdbL9sJlb8jKR8V2wzDMTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=WlMEpfWT; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="WlMEpfWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=5lDTCjNMcgKSqs9mk4C/OB6GQoEtmwOGp4
	smLe5gbXg=; b=WlMEpfWTpkylM+kUGVphQ1yk3ldnH8hEYVkRUY4COSRIg5eU73
	erYMFq8SxA/R9UIjHWfnLav0TYHqYUjstsKVVazZQyX5jK0Pvk1bLd77E/uwH3E5
	gbBsn/bQwN2AV4nV5U1yzNEcRCl/hH1/IZ+JaY+nsulocHnm3YNZyi7Dw=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQDnnr4xzThqn6KaAg--.38470S2;
	Mon, 22 Jun 2026 13:50:55 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bot+bpf-ci@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bentiss@kernel.org,
	bpf@vger.kernel.org,
	chenyy23@mails.tsinghua.edu.cn,
	clm@meta.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	jikos@kernel.org,
	jolsa@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v2 2/2] selftests/hid: Cover hid_bpf_get_data() size overflow
Date: Mon, 22 Jun 2026 05:50:40 +0000
Message-Id: <20260622055040.1929254-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b3b148b42eb198ac7194c1c0547e47275b9f5d31133eececaf1389f17caed5af@mail.kernel.org>
References: <b3b148b42eb198ac7194c1c0547e47275b9f5d31133eececaf1389f17caed5af@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDnnr4xzThqn6KaAg--.38470S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw43tF4DZF4UGr1xZrWxtFb_yoW8tryfpr
	y5uay7Kr1DKF1I9rnrAw18AF1FvFsxXF43Jr1kGFy5Cws8CF4Igry3WryYva1rCwsY934j
	va1qva9xCa1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRh2-OU
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

On Sat, Jun 20, 2026 at 03:11:00PM +0000, bot+bpf-ci@kernel.org wrote:
> That wrapping check was introduced in 658ee5a64fcf, and the fix commit
> carries a Fixes: tag for it. Should this test commit carry the same tag?
>
>   Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")

Yes, I will add the same Fixes tag to the selftest patch in v3 so the
regression test is tied to the commit that introduced the wrapping check.

> This was raised on an earlier posting and does not look addressed:
> the callback stores the result in the get_data_overflow_check global
> and always returns 0, while the userspace test asserts on that global
> rather than on the callback return value.
>
> Could the callback just return the helper result so the test can check
> the return value directly, instead of routing it through a separate
> global?

The callback's return value is not something the test can observe
directly.  call_hid_bpf_rdesc_fixup() consumes it as a kernel-side
contract: a negative value falls back to the original report descriptor,
and a positive value becomes the new descriptor size (*size = ret).  Its
only userspace-visible effect is therefore the report descriptor size,
so checking the return value would amount to checking that size, which
means perturbing it.

Since the callback returns int and hid_bpf_get_data() returns a pointer,
the only way to return the helper result is to convert it, e.g.

	return !hid_bpf_get_data(hid_ctx, 2, ~0ULL);

On a fixed kernel the helper returns NULL, so this returns 1 and the
dispatch path truncates the report descriptor to 1 byte mid-test.  The
BSS variable records that the helper rejected the overflowing range
while the callback still returns 0 and leaves the descriptor untouched.

This matches the existing convention in progs/hid.c: callback_check and
callback2_check are BPF-side globals the userspace tests assert on, and
the existing hid_rdesc_fixup callback returns a positive size only when
it actually rewrites the descriptor (sizeof(rdesc) + 73).  The overflow
probe does not rewrite anything, so it returns 0 and reports the
helper's rejection through the BSS variable.

Thanks,
Yiyang

