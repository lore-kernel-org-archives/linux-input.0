Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A917A31E;
	Thu, 23 Jul 2026 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784767615; cv=none; b=JPA3b2Lsil2Hnm/6UJwNEGkM1CoDlOJ66fne/EZRXIq0hVTJqiHAcVTBCayLu2nPS6IHZStnZfysxEY5zJ4OJe+S3Hlwq1m0v+UiJHkRo/A7yUJKfZs9NUSpKa6EA2g0/K7b0dvJAg0ugiQUU9FapXHPPsM3WSVYkNGA9crI11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784767615; c=relaxed/simple;
	bh=KpnI/sSrjrj1XHka+S7lmbkwNn89Ju1ii8SXCJj830Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ttU6oHWsfqBamG0DW8vFbN5zqZY50iurY76llzdZohzLAJg/mwYxTZcEUYSijndDDNWnHctg7pspRZ7ThYbak13D9DXjy3Lrcp5wvhq1Atf7MXEU6Jn0pSgL9LzC+neyF+KKTZVTDQhPbJx+MTPwF8vXo15QZoO2QKpqemC0VUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFDxxa7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFDxxa7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A051F000E9;
	Thu, 23 Jul 2026 00:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784767613;
	bh=FVcJA11VKUDxdCDtQsMHpWOMcl5sqbi4O+hmzJFZCqE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HFDxxa7bP5f3P78QErU9REszocchEDx17DzXaK+glto3GOi7i9Aq8d5OwL9OBmFx2
	 J7FdMuledF7HvfDIzsiu5JBs6EmQMp6vFjNZd0hSuBXfk2YpUtRbe3CuFuEF4Zy9hK
	 +6c2HM13RTw/kb/0EznvSWjwILY05+BLio+h5f8Nhk0tob0RMWXNFSlCNH9KJdEnpo
	 V0qoz377YAZ0cvcvvc+7IrPXcCNGR0T3PVoD09am/pON0M6KsW2M40pg/T6Dev+Qb3
	 zS5fAUhdPChAujo5lmEpMubaJMRAdqvHwUO7c5AOcDJ+X91CbK+IlIQjw2smC7IPXr
	 7ZgPq4X2DCEyQ==
Content-Type: multipart/mixed; boundary="===============8382247208943757258=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9a741c388d686bc53380a8862320676bc0c4c37f249a9c7b3df437cb741f2eb8@mail.kernel.org>
In-Reply-To: <20260722233518.778854-6-ihor.solodrai@linux.dev>
References: <20260722233518.778854-6-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 5/8] resolve_btfids: Fix the _impl lookup for module BTF
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: bentiss@kernel.org,jikos@kernel.org,emil@etsalapatis.com,jolsa@kernel.org,bpf@vger.kernel.org,linux-input@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 23 Jul 2026 00:46:52 +0000 (UTC)

--===============8382247208943757258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Fix the _impl lookup for module BTF
>
> process_kfunc_with_implicit_args() skips generating <name>_impl
> function when one already exists for backwards compatibility.
>
> It uses btf__find_by_name_kind(), which searches the base BTF before
> the split BTF. When resolve_btfids processes a module, a same-named
> _impl in vmlinux would be found and the module's own counterpart would
> not be created.
>
> Fix by using btf__find_by_name_kind_own() for the lookup.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

The btf__find_by_name_kind() call being changed here was introduced
along with process_kfunc_with_implicit_args() itself.  Should this
carry a Fixes: tag?

  Fixes: 9d199965990c ("resolve_btfids: Support for KF_IMPLICIT_ARGS")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29967476366
--===============8382247208943757258==--
