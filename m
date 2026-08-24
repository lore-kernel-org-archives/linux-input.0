Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D381338E8AD;
	Mon, 24 Aug 2026 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604069; cv=none; b=Rmbw2U8gJnC6OGCnN43s9fYHwyAJuboJbLr2VGRCz+ontEGp+LMrSyLTIeGmMmSP5h+bUpwuQMl0ToCOCLbbDfEJVyV8CmBP0b0pcVvwdZ2dp0fdq+eAnMDwrLtTJ2wzUpLPxBrNV46Z4sErTlFA3+2i63tRhZU7+a2qOiwgURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604069; c=relaxed/simple;
	bh=D8x/zHsYFI9Cnq7qojAIRMThdyU5pO/yr8b1mPF4STc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2JZqw6i7mxCUnMYb8LQPbBpqXekRHfy5whnb1t3rLRWa4Zgfe9ysy5PmvG8I5/A5tS2en+I4xS9dCyZPDBis/PsUWwtd8Ov9nwy+KeNkJ+0/UTnF+Jpw322iMwuLjV16IrI/m2Tag74An4Tp8xxSkCDvr2YnhZF+X0hE8lQeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8tgi0dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8tgi0dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E96B1F000E9;
	Mon, 24 Aug 2026 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787604068;
	bh=bVPPr5FVv8/CLqsIIJmCJBYUKUEhQ6YONnTNyU6hapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G8tgi0dqjVex37Er1EWH9Pev6DrtegNuKpF4wjJndlsGj4rxn2fM/xKQSCIUvd47c
	 c/+U0VMBmCi5f4U2exEbpPTXyCdM3fcVx/scdGTuaNB+xiqjD0/b05w5hAwkAG6P2V
	 Be8Mp+z8GNrL4Vcjsywa75fd15t3p1d9dFd7pkn3WVV94ENQ/wXS2faPvhAdCJREkn
	 f5i7ZP+wy+Ci3TXSUgSjuc9NHp+mebqxgyXn93oFdVFQwNyoL5MOvrr5ONoqzMOskF
	 vI9t8X2reza4C2yjN/4EIzniMrCvL5PzJEvjeQMYlIUjt9hiaxft8E73JFquedj15w
	 h6YmYySy78d9A==
Date: Mon, 24 Aug 2026 22:41:04 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <aoyraknxt1TLhRe4@beelink>
References: <20260523105545.68079-1-technoboy85@gmail.com>
 <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
 <20260824102552.GA813380@google.com>
 <CAFnufp1pvgqvQqa_L+XFAsVd=rds4L9L14tg7B5kHtRdKFwViw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp1pvgqvQqa_L+XFAsVd=rds4L9L14tg7B5kHtRdKFwViw@mail.gmail.com>

On Aug 24 2026, Matteo Croce wrote:
> Il giorno lun 24 ago 2026 alle ore 12:25 Lee Jones <lee@kernel.org> ha scritto:
> >
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
> >
> > --
> > Lee Jones
> 
> Hi,
> 
> the message was debug long before and was promoted to warning during a refactor.
> With my patch I just restored the previous priority.
> 

Sorry, but no. The new kernel code restored the old behavior: if the
incoming buffer is long enough but the incoming report has a shorter
size, we still have the dbg_hid() call, so it's transparent for users.

The hid_warns are now only emitted when there is an obvious error with
the report *that the kernel can not fix*.

So having this patch would do exactly what Lee said: this would prevent
users to understand why their device doesn't work.

This patch "fixed" a temporary wrong attempt at solving an OOB, the old
behavior is restored, we should not even have this type of arguments.

Cheers,
Benjamin
