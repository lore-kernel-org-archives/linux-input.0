Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BF426D0C;
	Mon,  3 Aug 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778689; cv=none; b=l6qrWaVJq7O7b8zcUyOLGqg+H67ti72tiBILEygz2LxYIsfN9fXGl/1sjixmnruOQAB3p1CWFfw1INAuUyNW0snwbRgx4KWU8N4KyrAqvzM4owWBd/GJ2mB1+gvrIDS4UM+Z2+xpcllTEjZ23kT6dcaCICVTzAcE2xh8oaTvDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778689; c=relaxed/simple;
	bh=dXj4kEZZ4VeeAMBfr/+51iFmkjP1yMCasAQpKZ7IVNo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SC8HTyaQQTTRSxberN5+EP32ntvq7alQHMC5IZzeA6ZPul5ndRKoX66EHCdg+IkSthvjKx1hxljfWpLXokwljjq5qzp1JR6YcUNIArRv3WSJTLnrPhyTt/v76FGlCClAeMYWNEb0q0cc0Vs3CfDDBFVQpIfE9YEnEwyuX4uoblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2fJ2Q7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2fJ2Q7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED61F00A3A;
	Mon,  3 Aug 2026 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778687;
	bh=FPlepFw8x6lyxmBAT/NDdJMJvfAgt43x781lzPkN0PY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=L2fJ2Q7sxmEdCOlCHc1zSFSyg0KJcw8gmPYQoox5abHFR49j3MtbWLTgzWvxpyOVT
	 2WQ79RrTTe5o5JqUQzMYV4DgLkN0G7bTodOUPWJhCiIuFOfPqJMOYbdmb07IDLatae
	 Gq1lXhFuZlvrvYAoNqgDI28mnoE648zGzRBR4Y3sPkAhm/vydqg9AnJIGE1uV56XhA
	 hdn9v1GhZVWz6DJ9g/mWoldyM/N1q5KGXQMKc3yFO7S2GCuqca4vo3EzvtVUp+A1Cp
	 ijZk2h7NhuLW+gwoSGzMhkwDkLBglNgC3zBclr1gxB1O7rcGDFlcYcFZsZZQiSDihm
	 7ldWXlz+b+6eA==
Date: Mon, 3 Aug 2026 19:38:05 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: amd_sfh: return an error when response wait times
 out
In-Reply-To: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Message-ID: <07nr2024-33rr-2165-sros-7666rpo7oq2o@xreary.bet>
References: <20260624143558.39306-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Jun 2026, Pengpeng Hou wrote:

> amdtp_wait_for_response() waits for request_done before completing a
> report request. wait_event_interruptible_timeout() returns 0 when the
> wait expires, but the current code treats only negative values as errors
> and returns success on timeout.
> 
> Return -ETIMEDOUT when the response wait expires while preserving the
> existing success path when the response has already been observed.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

