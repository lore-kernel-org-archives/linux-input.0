Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57003415F3B;
	Mon, 24 Aug 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581325; cv=none; b=EJUw2n71bDMeAGCJinkdeSUrCpOyHSq7C8xjPOa3aqFdLMhY69QKk/3rgpT00IoDN8S5fryfJlLYBk7EXzfs++04orJ6ZCluCRmRnmEhDcJI73MkLJ4MRo3DhM42wqq16iSzr6s3kSS8RVg4Eb0ckk4puzZHI6o0BxgjEs2o/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581325; c=relaxed/simple;
	bh=8qBrPMLYalRRyvlMzy9VjkhYhnxWwOpyaX3SrqiSeag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4xElajfRaNnGiT6ng86SWm6m9p14IQpasEXrfbjWkHHH3EkCWMoWyw4Lp36FZapATSOCI0iy1H4DkGaLjunnOGmlDfEq8+iz/RodHETtS4tnNqPobM2o6doMGpnqUIcBiMGr71+vmQ3Fkd57pJO3/SdrHFokspauQmiXgzyn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS9Dse9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS9Dse9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17031F000E9;
	Mon, 24 Aug 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787581324;
	bh=BfVu3hlW/e2uArFtGuxyrgISA6Xl7wgeR5DF1xioUsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eS9Dse9KS+crpfV87I94tKj9H0Xw7pT+DfHR38vP7suY7jHt5uL4zACJbv8Hh5wfD
	 MO/Vc9W3kjAKprQuXNIhgR9KuCr9cRmojMoI5kF8jifrtNrl9/QcgHe/m74xuKDyyg
	 KI3pUly6ni42vnKF7YLGmVdwzCCHoOiLK7sS/OqescHePP1VWgkfrClJNIxk+gZ4v1
	 B6uUfN1FYSMwH7kH9ezE5VaiwD7tGBEcPJaaVj+Hy4MOfp7+Hc+Eckhwlca1kWcEfJ
	 kMIeUKHEWMYC3+p4TIdyEmVz0HRDruBmM+T5D4OvJcj4C9JX40sfo58AoyupcctmM+
	 fD07lX49qLcXQ==
Date: Mon, 24 Aug 2026 15:22:00 +0100
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Matteo Croce <technoboy85@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <20260824142200.GA770273@google.com>
References: <20260523105545.68079-1-technoboy85@gmail.com>
 <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
 <20260824102552.GA813380@google.com>
 <aoxCGPgdKqV2FkmL@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxCGPgdKqV2FkmL@beelink>

On Mon, 24 Aug 2026, Benjamin Tissoires wrote:

> On Aug 24 2026, Lee Jones wrote:
> > On Wed, 10 Jun 2026, Jiri Kosina wrote:
> > 
> > > On Sat, 23 May 2026, Matteo Croce wrote:
> > > 
> > > > From: Matteo Croce <teknoraver@meta.com>
> > > > 
> > > > The log level for short  messages was changed from debug to warning,
> > > > flooding syslog on systems with devices that regularly send
> > > > short reports, in my case an UPS:
> > > > 
> > > >     $ dmesg |grep -c 'Event data for report .* was too short'
> > > >     35
> > > > 
> > > > Demote it back to debug level.
> > > > 
> > > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > > 
> > > Applied, thanks.
> > 
> > FWIW, I'd like to contest this patch.
> > 
> > The warning is real.  It means that the HID report was rejected and as
> > such something on the system will be now be non-functional.  Silencing
> > the warning is not helpful.  It does not fix the issue, and now the user
> > / admin has no idea that its even happening.
> > 
> > This warning has caught a bunch of genuine issues related to testing
> > infrastructure and incorrectly coded firmware that have subsequently
> > been rectified.
> > 
> > Please don't hide this issue.  Fix the root cause instead.
> 
> Please have a look at the actual code in the tree first. That patch was
> applied by Jiri, yes, but IIRC it was dropped in a merge commit and is
> not included in any trees AFAICT.

Sure, but there was an attempt to have it reapplied [0].

My plea goes out to both submissions.

[0] https://lore.kernel.org/all/aoF-jIn9gk9kJ7Pz@decadent.org.uk/

-- 
Lee Jones
