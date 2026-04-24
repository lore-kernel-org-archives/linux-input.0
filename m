Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A5269CE6;
	Fri, 24 Apr 2026 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042489; cv=none; b=LM7JAiCIehmrj6zGYWSEyNtFxhwTr4HTUKPJSWhi+9WYUQG9Ar/4Yoqmk+wMlYYsRRHZXIGAguom090B/pHgNtEqLkb/CVAh2GDeBg0jrT+tkz1Wnp1uuPpsKD+lZazTtDS18gAKsGelUjnxOoO1Ze808QR3lKWU/FMbmHuHfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042489; c=relaxed/simple;
	bh=CjWUjdFvXz0DBBTwo4qw6FxmhkHUVjNeR0TjX0xarVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD8MEqF92y3FK/8TZMlg5OWcRThl3X3PSCRnwKAdvWBAydgA4xna8TaX8s6hNCZGPYRX5YaA0W9PFEfy0ZdUllXlf+JmOZjRm5lcdfIikh86WYDP641+dwLWIIX+NlwR1RPNU+2NXO6ocpoMQSLma2EMWP/URR4u2FI/fAyEQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLP18gGd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLP18gGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F44C19425;
	Fri, 24 Apr 2026 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777042489;
	bh=CjWUjdFvXz0DBBTwo4qw6FxmhkHUVjNeR0TjX0xarVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLP18gGddxAGmOHoaMx80iBhffYGAuPAVFFrUSfglCbmYtABW8q2m9CKoq6Qy+XvY
	 1TVDk0AH5FZ23zNL9spUZt9nZhAA4Y/66QTJwVdaqnAP541OkwH/rW8ylSkuOJPx4K
	 DApgmnHNX47E3QYyLvMMGsfEkHjr5FBSAOkRGI9Fb9AA/PrlY/kpI0OvZQHZZf7H3Z
	 0jD36dkkce+4KNouMsDIaiqYLFr1gvHStDfse3o2nuas5Mj3AyzApRg57mQsTUc3yX
	 n7ha9kJRWzblJMj+ujIwSneJdMeeTxJjJipy6iUs/AieH2pwp/2h5/n6f2QIsazrAl
	 FMZMoy0VLIgaw==
Date: Fri, 24 Apr 2026 16:54:45 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Zhao Mengmeng <zhaomzhao@126.com>, Jiri Kosina <jikos@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH] HID: bpf: Sync KF_SLEEPABLE flags in
 hid_bpf_syscall_kfuncs set
Message-ID: <aeuDkTryZfgjzdcS@beelink>
References: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn>
 <DI1FOWOLC37Y.3DK99VJZDMWKI@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI1FOWOLC37Y.3DK99VJZDMWKI@gmail.com>

On Apr 24 2026, Alexei Starovoitov wrote:
> On Fri Apr 24, 2026 at 3:22 AM PDT, Zhao Mengmeng wrote:
> > From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> >
> > Pahole intersects flags across BTF_ID_FLAGS() occurrences, so omitting
> > KF_SLEEPABLE may drops the flags globally. sync this flags in
> > hid_bpf_syscall_kfuncs set to enforce consistency and safety.
> 
> Makes no sense.
> These kfuncs are not sleepable.

I'm not sure I parse correctly the reason for the dropping of the flags
by pahole, but all of those kfuncs are actually sleepable, except for
hid_bpf_input_report, which is *not* sleepable.

Cheers,
Benjamin
