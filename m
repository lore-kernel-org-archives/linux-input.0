Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD5353A9F;
	Mon, 24 Aug 2026 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602732; cv=none; b=Jl60DHDFLOh68zMYw5EQiJ9OK7krwUFZoDrcUKFv9dKgOu0H2ncmnKuYcfmK7dWQd0l+rO7oLZNwfhGkVN3QZKuzomSqD+7n1pqw+OzfhA+lCegzSaZmCihBUc3yK7lE/EmZ2ecTka29MYM16KEc/pLYP1DbaOGVtwNWqLtPGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602732; c=relaxed/simple;
	bh=tyr16mGR6SxVBht/mpNADDo0wJM2ImbrICY0DG38ANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwRoSe6EctVoIxi6QFOC5cPq0U1JSUXuQFMT/dmmFpXDSHI9ZPjA+OozeA47uXzNydTBTXUmDVgZ7Ths6V9TayBqyW/BWdxSrJKzN0KCMLlTB+mUcti8mXA6sloU9wUXTUQ1vBti3rlcwYgBznrCMvHwT1CKqSF8OrCSdYp2jLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fid6MuEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fid6MuEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C0C1F00A3A;
	Mon, 24 Aug 2026 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787602730;
	bh=t4jVqtUtrVW3PdKQr4bbF3CENZStQe22IXu28vPdv4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fid6MuEjrJ48EIXTyZlbx4vI09Yu5abzD2BlVM7oG3Ri3NOjFk4j53EiJfCokyURr
	 7HOYNDrI8b5kvCcjF9X7tPMCcCsfozPHey8F0MsP/b5LeVuCG8sZof7UOqv3pprHj/
	 1yu5Bm9Nnwpz9vP0FHSl0lqfTrApggfruW7gQeqP2SHfB8u4mBavz0O/xk5ZlZXR66
	 nsDZRlTtdzwrSPOeEHxSqZf/Rh3M6zh2tyqu7N+2sZJQIqlBs35uRfZlZ6J0GXS+kD
	 LG8aCdnQAe+wgOINmnPbpB5LJOxCe1+7PZ4IDCBIhQcHPbk8AQbnTE11QF0wLbU+tz
	 DOs3z/1V5XRMw==
Date: Mon, 24 Aug 2026 21:18:46 +0100
From: Lee Jones <lee@kernel.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <20260824201846.GC770273@google.com>
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

On Mon, 24 Aug 2026, Matteo Croce wrote:

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

Sure.  I'm not contesting the logic.

My point still stands, however.  IMHO this deserves warning status.

-- 
Lee Jones
