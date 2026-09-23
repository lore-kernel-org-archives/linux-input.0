Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A58377EBF;
	Wed, 23 Sep 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170288; cv=none; b=CctxNkZEDkEDagGprrUTItzfRRj1px9EhWGT1W4BPXLWuIgvsFGYUrEXptIF9MNqXvKY9EI26ewzqzacra1m8mvd+I/WNYBd6UV3edO1Y+a+RxgKE0qyiyRaxlABvdWKjlNw4m29hlqARlYkrN/k/ss4wq1lxf6gUyuiajoYI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170288; c=relaxed/simple;
	bh=wZeXpVolzs6V2NC6Lw232s5lDmrvCpj1CvIyha35Sko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac1oI2dQ/9v5dDR2wcjrAWTUKiCl4S4tiQb1KE9dziEJStHCPAyF/rq/W1khkJBYg6Qo5Qc3iPwq2bRDygvvWzlGqHYMECGGM2v5BtVTEDQu3+tM2Cz2SkVCZ1kUe43xfuSniuZXjHERNnnhs6k4mx+CM1oqcoT7GWDSUUPxRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDMwfC+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDMwfC+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B561F000FF;
	Wed, 23 Sep 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170286;
	bh=Aww3JXo92r84laW6cGsdXW74k6w81Ph5fQsxSvJZDr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dDMwfC+x4mByGTzaSU9V7p7Tp2Qxxa3zozhyYB23cu+rqLwuKSqk38/Wz0TZRj1o4
	 qKnhXaJCjSklN/WPnM1dXi80mf1kLMbidSLirfQXRFmFRuFMCCf32DKFeaoRVnVIY4
	 I4mfM9kq73cDcajGFk5clOWWhmJ6T22zbgiqG8rk6vNLrS4fdtuQ2thO/kzumIh/ea
	 klNkE8bBi6z/LHAywzJ1z3EBXnGpBvOSDY3/PQsQGf+jwOnZLiJVheJV5VjmtfVRPI
	 clCOmCDgFmv51l/p+hmaz7aMb8/qVwf3fG905mYBsOVi46SERZRo94uV9ADyCnnTlO
	 AscJfphX9Qqag==
Date: Wed, 23 Sep 2026 15:31:22 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Ruzal <daminovruzal7@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
Message-ID: <arPT9zIoypn5V3PT@beelink>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com>
 <aquWNXpJuQr8HLBU@beelink>
 <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com>
 <aqwUYWPz_nORoFr6@beelink>
 <33a7c239-ede5-4091-ba72-ff429d97013c@gmail.com>
 <816a300c-1f63-4d4a-a0f9-8eef5bd7e748@gmail.com>
 <arJ-vvEvd93l_aAp@beelink>
 <41f8ed8e-1466-4002-8411-bf9871da2adc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f8ed8e-1466-4002-8411-bf9871da2adc@gmail.com>

On Sep 22 2026, Ruzal wrote:
> Hi Benjamin,
> 
> Got it, the uhid SET_REPORT explanation makes a lot of sense.
> 
> Are you already working on the BPF fixup, or should I write it and open a merge request in the udev-hid-bpf repo?

If you could work on it yourself that would be great

FWIW, I tried playing with the new HID_REPORT_DESCRIPTOR but if this
allows to read the current report descriptor, this doesn't allow to
amend it, making things a little bit too complex to implement properly.
So it would be simple enough to use the same old bits checking and
changing so you get the BPF quickly out.

Cheers,
Benjamin

> 
> I can test it anytime.
> 
> Cheers,
> Ruzal
> 
