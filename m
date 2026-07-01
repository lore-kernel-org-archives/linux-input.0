Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672E3B19BA;
	Wed,  1 Jul 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894672; cv=none; b=LS8OhG5lQgvteWtF+9kzMeOgWoU/9KpCzD+BlfmQ5beSXm0Pwf7IvcTCqDaHCq4caBM2rR0Ty+ixr4Ferr9v2pVS2gqP9TFIXTFZ9PjaxDnHU9Rmv8IsHUvJ2gG1jpfEnUJhY1ZdlMw0KCOTuIpg61fIKVrdPIoa1+mR1Iui/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894672; c=relaxed/simple;
	bh=jprOyV/DD4/LfRUQG4yVWARPLbfqTCpN1bGCNR/tePI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WjsNkASsgAtcWrpZtwrCAq0WYCIyVqpvhmpTuTbSfItHZokztJAO32jf0P1OL8jWZjYhx8zbou5qevhmlp0VM1OT0RoW3aKqrPRO1hdxwtEFWr12NxmRF5pEoFhl8E43YXiWmH70hcczGgeBiyWuIp5H/a20xjeZU30sQ200A6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Phs5DCuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Phs5DCuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05351F00A3E;
	Wed,  1 Jul 2026 08:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782894670;
	bh=SV6y/pSdqriYvdQyK430YEucFJ4EprNC4pyu5Kq6/To=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Phs5DCuDYJ4dTGbjlfavjjBD1qS9aVBplqquSLvvQu63y7OHaSA4h+obDeffot0cQ
	 bcJR/ob7vSBG+op5+TwdsdDUzgXQoqOX3wF1LQ++iqLbLOiN4Ip/1pTrD21G84EnXG
	 DRtuPw/eqvc82s3H4I3CZb6qQuxA12gVspKs/gMvKSmiEO11/CVAQxokKI19EBdaQg
	 wJCyglBDi3LP+UMCHo6c028oqTyd6T+shgWBCXP3kKLPuhIa7PakM561FFZexP/ySv
	 zITnF0LR2Yfq7aoIXY1tOuxnrBYNeNEcUVt687Yx1FYvBHVAWQW1ZWgzrTdDq9HKOI
	 mDMIjwe9kAqXg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, bpf@vger.kernel.org, 
 linux-input@vger.kernel.org, Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260623062315.2694160-1-chenyy23@mails.tsinghua.edu.cn>
References: <20260623062315.2694160-1-chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v4 0/3] HID: bpf: Fix hid_bpf_get_data() range
 check
Message-Id: <178289466766.3396796.5020458265842663360.b4-ty@b4>
Date: Wed, 01 Jul 2026 10:31:07 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 23 Jun 2026 06:23:12 +0000, Yiyang Chen wrote:
> hid_bpf_get_data() exposes a pointer into the HID-BPF context data when
> the caller-provided offset and size fit inside ctx->allocated_size.
> The helper currently checks that range with:
> 
>   rdwr_buf_size + offset > ctx->allocated_size
> 
> Since both operands are unsigned, a very large size can wrap the sum and
> make an out-of-range request look valid.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/upstream-fixes), thanks!

[1/3] HID: bpf: Fix hid_bpf_get_data() range check
      https://git.kernel.org/hid/hid/c/2d044049421d
[2/3] selftests/hid: Load only requested struct_ops maps
      https://git.kernel.org/hid/hid/c/5aad55011a37
[3/3] selftests/hid: Cover hid_bpf_get_data() size overflow
      https://git.kernel.org/hid/hid/c/eebbef7c468a

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

