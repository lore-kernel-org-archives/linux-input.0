Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9733E36A;
	Sat, 20 Jun 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968269; cv=none; b=DwvIYTvsbsuJ1ZQlO5brZK29VYv64OhIMYs3Z9ljfHdGQ+ePv25paMC0u+JwBktOeTSJ+2ZhJFAAmc74hngw4QlIosQQODN+l4iCP/Xoepn2S/sNb6zrTw2V5s2EumhofSpSaPTMtIhqEprVBoTGsAXS4gN6vABOecy4ccGSWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968269; c=relaxed/simple;
	bh=JSSy07a1fddV0ZEcUrT8Xs2OmKCf7cuJkbRuUvXWwg8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qpapKnzwgv18YX61Z8yCa6oyG2WcbYROVZsUYUbMOSLKSRY+ocwqzVcKr4YLozmPnJmI9/hqRyuQkjr2fLU2Uc9q8TYOSZkEE4QyWsAmEqsQ8A/Ma41yvqs26M9Io4D5bdN81/U+qMeFHtgiaZJdsc8TkreY7nAL5V3w5aemTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+CAstK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+CAstK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECD71F00A3A;
	Sat, 20 Jun 2026 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781968268;
	bh=ukvHGq6sDhVLiCbcFdESl+aKas2jmQWGuLL7J0OAtjQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F+CAstK3tdpZSW3Q6bkfVIycW48WP7zOAuSrYARXh4FjPaQeRSMSV/4VKrDXjdMRt
	 b/lIINfF54mkxL/O9HPiTBmYLmQMh6GSLn+RvqajVDwbNhq3sPRvFNaXBeDIVeEojU
	 QFfpxo8rUHbZg1qccgxn2XHHv5xUHIeMhtHlogTgqORBnbEojgkRX6r598kMZQ1nna
	 RhUGn7rASzEmg5NJ0e9ui/CXLyN4yX7W0NR0RKkkxZKZrfFrNzSWcbvZqIIuYE6+z+
	 s/sj0ZV4aSXBDgjJSU4+DF7DlKxsKISgtD+9Xtf6nfKMBF+Wjw0StUzKQKJnRAElKz
	 4SoUu9WfwVecw==
Content-Type: multipart/mixed; boundary="===============7268032707533913629=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b3b148b42eb198ac7194c1c0547e47275b9f5d31133eececaf1389f17caed5af@mail.kernel.org>
In-Reply-To: <b9c4b268b403e2b41362dd678dca8feb35d34a9c.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
References: <b9c4b268b403e2b41362dd678dca8feb35d34a9c.1781964949.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/hid: Cover hid_bpf_get_data() size overflow
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,jikos@kernel.org,bentiss@kernel.org,bpf@vger.kernel.org,linux-input@vger.kernel.org
Cc: chenyy23@mails.tsinghua.edu.cn,shuah@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 20 Jun 2026 15:11:07 +0000 (UTC)

--===============7268032707533913629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/hid: Cover hid_bpf_get_data() size overflow
>
>     Add a HID-BPF regression check for hid_bpf_get_data() requests whose
>     size would overflow when added to the offset.
>
>     The new rdesc fixup callback asks for offset 2 and size ~0ULL, then
>     records whether the helper returns NULL. A vulnerable kernel returns a
>     non-NULL pointer because the runtime check wraps the addition. A fixed
>     kernel rejects the request. The test only checks the helper result and
>     does not dereference the returned pointer.
>
>     Also add KHDR_INCLUDES to the HID selftest build so hid_bpf.c sees the
>     current kernel UAPI HID definitions on systems whose installed headers do
>     not provide enum hid_report_type.
>
>     Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

This adds a regression test for the hid_bpf_get_data() size-overflow
bug, where the range check wrapped on a large size and returned an
out-of-bounds pointer.

That wrapping check was introduced in 658ee5a64fcf, and the fix commit
carries a Fixes: tag for it. Should this test commit carry the same tag?

  Fixes: 658ee5a64fcf ("HID: bpf: allocate data memory for device_event BPF programs")

> diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
> index 5ecc845ef792..b21fbb13c926 100644
> --- a/tools/testing/selftests/hid/progs/hid.c
> +++ b/tools/testing/selftests/hid/progs/hid.c
> @@ -240,6 +241,20 @@ struct hid_bpf_ops rdesc_fixup = {
>  	.hid_rdesc_fixup = (void *)hid_rdesc_fixup,
>  };
>
> +SEC("?struct_ops.s/hid_rdesc_fixup")
> +int BPF_PROG(hid_rdesc_fixup_get_data_overflow, struct hid_bpf_ctx *hid_ctx)
> +{
> +	if (!hid_bpf_get_data(hid_ctx, 2 /* offset */, ~0ULL /* size */))
> +		get_data_overflow_check = 1;
> +
> +	return 0;
> +}

This was raised on an earlier posting and does not look addressed:
the callback stores the result in the get_data_overflow_check global
and always returns 0, while the userspace test asserts on that global
rather than on the callback return value.

Could the callback just return the helper result so the test can check
the return value directly, instead of routing it through a separate
global?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27874238868
--===============7268032707533913629==--
