Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94038E100;
	Tue, 23 Jun 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198169; cv=none; b=SgipdBjgtbva6qjUeET2ZgrvPqhVscvVdp1xF1ORSQ8BUCqMar59EPoGiQg1YrS173T8/mzFjt2Xu0vgymEgSxqGdSYJOO9tO5h4+SgwOZBtiTaN0gbtJT2qNAKMBSacfJLdZCHhLj0V4C0qHkcKN8fjDbRIqDpwwVZ+4FoxGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198169; c=relaxed/simple;
	bh=KDgWG86KfHSgVTf4BN4n++KMvrERfWblJ8Nf8/B08aY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Gpf+0scM+zBxw7/VrSbnh+k93ZcmdPF1E/b917eJesEIv0+D9SQiVHWKtL/7MUubIMeJozameGOPrTRCd9eTbCcD2+Hcl7g8n8JtAANqn0fxzMkutGtFdRhCnyxroTOT7s3oPXtDn1dr1QK29ZS7TA00hz0dDJLUcmIXSz8Nocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnwMaytY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnwMaytY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103C81F000E9;
	Tue, 23 Jun 2026 07:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198168;
	bh=SXUWqHGIHiqUCck+vpo0kOzQsvFZt4rxGpG96zpHsvQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LnwMaytYhrzsWNMym3qqgeKBSM6D03S005lEpXTTOV63QhjaRy3kCtevzdhyT6KLL
	 471wwf+jMcOVU3TpsY8y11HCAy8NTJMSxBu+DsMPFmjtMRkdfJ5DiVmiyftgFPRMiY
	 OU/IzH4+BKH4xufhdnIlAnlY7Y0G6vW5RZT5+XLFGnpdJHQj/EqL6noE9l2GhWto9E
	 MsdkT3+S8Z5rq9lEV7aOVSE6tBfE0p9+3tpIg0Oz9sZgFUvB6RmZKBMJ8nzN4tN9w6
	 kxVxU5hqyJaPts1Kj3xScWA2AmNT36RGOoEY5dHa+hRVaU6DDBApJEYgDKNFQUNViI
	 j4amf3Y3j429A==
Content-Type: multipart/mixed; boundary="===============0681819030601824907=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7511b00f74cb18c82fb6bf3e9870b0e9ebdb027345adb46f0b043c169f78039@mail.kernel.org>
In-Reply-To: <20260623062315.2694160-3-chenyy23@mails.tsinghua.edu.cn>
References: <20260623062315.2694160-3-chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/hid: Load only requested struct_ops maps
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,jikos@kernel.org,bentiss@kernel.org,bpf@vger.kernel.org,linux-input@vger.kernel.org
Cc: chenyy23@mails.tsinghua.edu.cn,shuah@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 07:02:48 +0000 (UTC)

--===============0681819030601824907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The HID selftest skeleton contains several struct_ops maps, but each test
> usually wants to load only the programs named by that test.
>
> load_programs() disabled auto-attach for all maps, but left struct_ops
> autocreate enabled. libbpf can enable autoload for programs referenced by
> autocreated struct_ops maps, so an unrelated program can be loaded and fail
> even when the current test does not use it.
>
> Disable autocreate for all struct_ops maps by default, then re-enable it
> only for the maps selected by the test before loading the skeleton.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

This looks like a fix for the auto-attach-only handling that left
struct_ops autocreate enabled, which was added by commit f64c1a459339
("selftests/hid: disable struct_ops auto-attach").  Should this include:

  Fixes: f64c1a459339 ("selftests/hid: disable struct_ops auto-attach")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28007198717
--===============0681819030601824907==--
