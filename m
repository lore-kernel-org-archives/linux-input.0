Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067A45517B;
	Fri, 16 Oct 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140298; cv=none; b=Wy37jHjlb+YUEwtSiAiwEoSC0IU/+kknN5JfN1KLJTDzJbEezUZRy6Xth5vdftXwRAdUBSD+TA2rXgNgyFDbe8YwdeAroAfR84Py8eiKG+OmwbMar62h3GPv8L8iI8WOc8pWo+sd2dkc+WG0QPt4Oo4oHJTEgfvWaxS0Nqw8JZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140298; c=relaxed/simple;
	bh=IqJZOTcSuTsF9AN7jx4X4c6Z8ByWBO3P9ly06oEG7/E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NcG7LsBICQI7M2r4qm0wy6hqNkk1ieri5oPsc36i8loaKjSHQcIPMYBzHrl6oCVl58B5nC4weWnt+xVM0PRPSZbGI01XPqugUVg3G6105GKtETlH+tlGyFpqbXvtImkXTuzXXdE5dAUvCNsu5KfHSBj7Zfz7MxSwfJEkM+hm68s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUvnU1Ky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUvnU1Ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BC71F000C4;
	Fri, 16 Oct 2026 08:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792140297;
	bh=4Im0ALqUocGw4CXB/IaSt8EWtvxHXNtxt+pKNlENh8k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hUvnU1Ky1VIGb7BtZQ/K/ehLu06r+dTrMErn+ImhYCQhO+laTour4qDD+TEOOl9f4
	 ACyTxz8JsLlqT8fw4bp3KXORj01kl34SvFFPp81AEcKeaoSoxcpbgNg5+nGS/vx6vH
	 03+WEirDkRXXlbSOGFSTnHZT3MSFfPOlyaCOg/wL2ymJGGvzq/YfF2rtiAoSxgwoUT
	 rleGfIdakyB4G1wXTfoYoh1RPt/L9q70N1avygqKz7HzGPONhqB6NO1f/7BKFN7v89
	 Dn8T2ZsZzaeLiMf4FKsE6rJC/iM8T/FEpPgIyOJ5oBrdBHYpjRPNhPvPEeNf6RD8eI
	 +eN+MUE7Mef7g==
Date: Fri, 16 Oct 2026 10:44:54 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: linux-input@vger.kernel.org, Karlos Abel <kabel@voidship.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: always accept EV_SYN in input_event()
In-Reply-To: <asx50uz6iafsyAd5@google.com>
Message-ID: <29q8q37o-q7ss-918q-q633-9s994557rqo8@xreary.bet>
References: <asx50uz6iafsyAd5@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 11 Oct 2026, Dmitry Torokhov wrote:

> Commit 0cd587735205 ("Input: preallocate memory to hold event values")
> moved allocation of dev->vals into input_allocate_device(), which caused
> input core to accumulate events reported while seeding initial device
> state before input_register_device().
> 
> However, because EV_SYN is only set in dev->evbit during
> input_register_device() (and some drivers also overwrite dev->evbit
> directly before registration), any EV_SYN/SYN_REPORT events sent before
> registration were dropped by is_event_supported(), leaving those seeded
> events stuck in dev->vals until the next SYN_REPORT after registration.
> 
> Always accept EV_SYN in input_event() and input_inject_event() without
> checking dev->evbit so input_sync() flushes dev->vals as intended.
> 
> Reported-by: Karlos Abel <kabel@voidship.net>, 
> Fixes: 0cd587735205 ("Input: preallocate memory to hold event values")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Makes sense to me, thanks. FWIW:

	Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs

