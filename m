Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2A420477;
	Mon,  3 Aug 2026 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777966; cv=none; b=RPtE4k6hTNQm3JKB+nfCNIlraaIoJCIvZIEM7OtwV/ggrCZe1ZjSGkO93SAGseGsCkIBfAoe47kKkwJ8z6ybFp9arGomSNxzocAolRsry4fGHcusC8eqHgTdiHKPaxR7uN6MQ40h85MAgcSNbv/ezWyxNRD5HP8A2/phzcT6Atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777966; c=relaxed/simple;
	bh=1EVYDBXY8jEzoSguAG656R+OMpsZAX/JKZv9OW6hEDs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M2S84rz/BDlzcf9LK3JpPA+1c+OvY8heEULPoXlW9GyhrrouCpWKiA9zFqFbe0wfjSlo9D4rkuzWFOxvwCyPWmGL1VKGqMmAq7CWoo8wwowSkUIT3+3BsSYEuVn2Flptzxs83wP9qvfhBKpzaETR0yBlbSTuGD7ELlPw8GIIruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Al6Aw8Cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Al6Aw8Cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B151F000E9;
	Mon,  3 Aug 2026 17:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777964;
	bh=azdNOfQfg+0njIn/J9/RadvykQP9fIxdT53ym20rnUY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Al6Aw8CmUMF0GYPC29hAHYYCkZOWenMccWs4he+kmjWgPKRzql+6Xt/K1RqfviyIk
	 qEUgcPziBYrpnWEdu6hkJP2DtHzCGDxWOCufptLshn+pX42GhER4epPsT28jiQMZxe
	 4RNqikx+Dn61OijpEvgHiJiqrISRRI/0j3KguGGidSI2X/2vu716uJVR5rXD7jYc9K
	 XRV/p9jCAnKluviYVBHF1q2h+uLn/PSeEyYZ1NuLy59bSDBrs52OnENsGdELNi1IIk
	 VdxHpCq+a0Bb11R11RShlkOZnaF07AgpujFJmyb3KR6nAwM0YmPm0CPwR3aHVMta1b
	 gLk/GY2YKLMjw==
Date: Mon, 3 Aug 2026 19:26:02 +0200 (CEST)
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
In-Reply-To: <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
Message-ID: <7nps151s-q114-3589-5116-2nro3sssp6rs@xreary.bet>
References: <20260619001103.1189200-1-denis.benato@linux.dev> <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet> <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Jun 2026, Denis Benato wrote:

> > thanks. Could you please flag which patches you'd prefer to go in still 
> > for 7.1 and which ones are not critical and could wait for 7.2? The whole 
> > lot is quite big.
> Hi Jiri!
> 
> Patch 1 contains multiple fixes, mainly use of sleeping calls in atomic contexts:
> I'd say slap it in 7.1 fixes.
> 
> Patch 2 is a minor improvement removing an OOM message to align the driver
> to newer code where that would have been a flagged warning: probably a fix for
> 7.1 but there's no rush for this one.
> 
> Patch 3 is a logic fix, condition is very rare (not sure if even possible) but belongs
> to 7.1 almost certainly.

Sorry for the delay, summer kicked in :) 1,2,3 are now queued.

Thanks,

-- 
Jiri Kosina
SUSE Labs

