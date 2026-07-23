Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07671C860C;
	Thu, 23 Jul 2026 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766773; cv=none; b=CgBuLI1D+PngCH7LpvdPxs9i7o0vC4q1K/fhPodfcHkshizmqrZdIRu0ftEvYUacqZckjjTFYMwSzw76anYeO189ohtkVMQMX18e0YpWXHP4QEV9Dyi6MdApx6oLxl/Wox2Eb6WaMWSa3Gi8APOUbcM4m9LP004cqXTgSygvvJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766773; c=relaxed/simple;
	bh=YtxKFepp1AuhG2qF2KLFBdPOhUgcxXuCWjoDzdp7n+Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S70XfBRV7Fw8N8Um6yoXs3ZHzksRz6JQWBCMo3O0qYRZx/ZFqZfP7gJwoYpvo+vMqmMELaZnUc2cOh+SsYHOhFgim1qhE7z1gZRT6yWQ0jdh4amUIEHFFT0RL8C1ELhpvnhTGdibDyIyTKOrU7hVK0J+aG59Dob922FlSAFJlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azMiedIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azMiedIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3181F000E9;
	Thu, 23 Jul 2026 00:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766772;
	bh=YtxKFepp1AuhG2qF2KLFBdPOhUgcxXuCWjoDzdp7n+Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=azMiedIh52adZagrtMm6A7NGSgKWVQjbrXdz2KIrzJyK4ITSQrHB6g4xtzE8M3r0c
	 +e8kf1+eQTBjXbliTXm+/yMrzWJakbWv5kMBJloA2Zki4ufYB1eKvUAoGDwin47/1b
	 3TjdbDe+rV2nAcswgTB8WA6z6dugJlMffHWiOWbtKitfgJKXUArRWMDPeJ0E9EtXxb
	 WEylkUmQQQp0aV1oYl3kuAzkGWZH+5kBz2w7E7hk9L6nHVf0vV5nYojr1L2axp+KPo
	 D47jBpdfKH80CfCihBCd6+MCHKseDSzuiQqU4R3bbQP7FgQOVokXBkW9txDn3jp37x
	 jAf/vg3sAs8eg==
Content-Type: multipart/mixed; boundary="===============7819124672924686355=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a65f41ab57ca5cdf28da990706b570ade7fda87d191b7f4a5d1f42e8cbb697b@mail.kernel.org>
In-Reply-To: <20260722233518.778854-9-ihor.solodrai@linux.dev>
References: <20260722233518.778854-9-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 8/8] resolve_btfids: Enforce consistent kfunc flags across BTF ID sets
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: bentiss@kernel.org,jikos@kernel.org,emil@etsalapatis.com,jolsa@kernel.org,bpf@vger.kernel.org,linux-input@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 00:32:50 +0000 (UTC)

--===============7819124672924686355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Enforce the kfunc flag consistency in resolve_btifds by hard failing
> on error and blocking kernel (or module) build.

This isn't a bug, but should 'resolve_btifds' here be 'resolve_btfids'
to match the tool name?

> [1] https://lore.kernel.org/bpf/9b2196dd-443b-4632-ae11-030cdbdc59b4@linux.dev/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29967476366
--===============7819124672924686355==--
