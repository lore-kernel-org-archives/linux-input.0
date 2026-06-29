Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF93F9F2E;
	Mon, 29 Jun 2026 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724871; cv=none; b=p5KkU+LcYMED+Lib0mv/txWwH24uNbUvSzLC5pqbo48le1zs4ehp2mF0aFJD9Zzs/tDh8VomsfaP3PvOqQ7s84lkfJFE0PaIKIcmAz7FkLqWkor0BWCDzXGIIekqSr78l4p7DzRLk2nYk/7dT5gJ3iWvYxlCIV0dvFNeX8ttcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724871; c=relaxed/simple;
	bh=zBmEYxQyao+weZknUOzdBl9opUrgmxcQ3Dt+/QG0vAc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HgTCyLY6aYVw4zOIzTnpeAKAHJxWJyLY0LjeXvUY6lA+0C7XZKKeU8UFo+fB+HargAMbWCkxAyP2Y/zL3aZ8v40uwj/x6BSDkAgji64r9XL4dwGvStdqqSNI0if3gs4EfbirrIGTmObNN+NqoTp4CckvdLq2jDFlkifngNjBng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwahQ1T+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwahQ1T+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107191F000E9;
	Mon, 29 Jun 2026 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724869;
	bh=ouxnXvXcy9WPtGdaW9ah31IFAhA4g1leWJ+w3pSH53Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bwahQ1T+gIKSwnoEcQwP770l+1qYB3tcHM0uvgrHVeKFGRK3wcA4oREb5lagf83kP
	 T1rEzBwMNL7plXFA9IxaSoZDBpvX5lawbFia/fLn5vIPrQJuEGwxpe4yZxOy4A/OTR
	 xDg0CoXHKTGVyx4NepVjRNCvyjb3lXPvOQ+eJ1H94krL/iEZrGcYtN492uJbTj1gvi
	 yAwaxbauEPigeoFYn92Eud55AsbaYCUVtkrAT+obB5+jnUeyGleLHVQnupwm7ImFvZ
	 4/SxIvXQsf9ixvCZ6EynovcXsPMgTEoAIa3d/apEzmDlF5r/9oH/MsOKes5g3f3YFS
	 omMHeECvdDAIw==
Date: Mon, 29 Jun 2026 11:21:06 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>, 
    Denis Benato <benato.denis96@gmail.com>, 
    Antheas Kapenekakis <lkml@antheas.dev>, 
    Connor Belli <connorbelli2003@gmail.com>
Subject: Re: [PATCH v5 0/5] HID: asus: security fixes and more hardware
 support
In-Reply-To: <20260619001103.1189200-1-denis.benato@linux.dev>
Message-ID: <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Jun 2026, Denis Benato wrote:

> Hi all,
> 
> I have added support for controlling the (way too bright) XG mobile
> LEDs in hid-asus and added the i2c version of already supported
> hardware that was probed only when it's a USB: these are two separate
> features changes and are the only two that are not fixes for
> pre-existing issue (see below).
> 
> Auto-review bot has spotted a bunch of pre-existing problems alongside
> problems in my own code therefore at this point I am going to fix the
> more problems I can and including those fixes and improvements in this
> patchset.
> 
> For v4 I decided to follow Antheas' suggestion of reusing the existing
> workqueue and by making it more generic I solved a good bunch of issues.
> 
> The v5 iteration is simply me fixing a bunch of bugs in new code spotted
> by the bot. Thanks for providing such a useful tool!
> 
> On a side node this patchset has a few more warnings: specifically
> "WARNING: Prefer kzalloc_obj over kzalloc with sizeof" but it's a false
> positive as that would introduce sleeping calls in atomic contexts.

Denis,

thanks. Could you please flag which patches you'd prefer to go in still 
for 7.1 and which ones are not critical and could wait for 7.2? The whole 
lot is quite big.

Thanks,

-- 
Jiri Kosina
SUSE Labs

