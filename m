Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65F26D4C3;
	Mon, 24 Aug 2026 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602624; cv=none; b=gMlkL1pjRn0hpjHVder+WRlxKCGkcjeUDvfx/0hXqHrLldB5bNTDj+8ySoILbTZKTKDy/qP+uPRKcPGuLgOcHhioX4wc+Z47gT4N8ZegF63r3u3YvRVVX+/O2wKg0O/R535EUOvBo+TuLZN5NmR+6+sJFEmNvt5DaSSWTYA8Ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602624; c=relaxed/simple;
	bh=eL8mZcERIlP3ODq7vD1lXHCyHRyRPa52jrHvKHPmTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1pvLDjBMzma9I0WilXMdnMlKJpGFYj7Epn/8J7xw2i+ztyZH/1qSxrprEknZgX+/l9s8ys80enH0EcKYmjIpfEirYWFlmsPQj/mDjemp4KVf+tRt3yIjsUjj5t8/a+//TD+7cmcauqBoICVIyc0XT4b3+hk2aFwIojbJVPZA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9Y+5fkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9Y+5fkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E2D1F000E9;
	Mon, 24 Aug 2026 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787602621;
	bh=xGxsATaa75W6554aRWVNONU+q/zmbPkoaS/Zya5qAjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9Y+5fkNuKGXlcymPTcVKZjGgl4kr2yL4VGRhNya70f5r4pocKrau7oP5moHWhDFM
	 ddZNm/Zdw1cp5qkAJey5B6qG93aw2X/zOZTbDM35XFn+3EB/hF5hj836/eVo+yuidX
	 t9W3bpa+dOSPWyhkv7gqwYfLw6734UxRYGn1N5ReMAz4mWlxn0UD02YMl4YaVVgQc3
	 fFotYutD7sd8Zje1sE6Yub1A9cqoBK26ZO8LmuQIDbX5qTnJhX4TlkpS2x7I5D6sS9
	 M3KTQM+ccxBshHUSuDvacZR+xkrD3ehKNyMveM46HJw9/OtY/2Z6SijHrutDLkuDe8
	 /4i5IuZyXtY4g==
Date: Mon, 24 Aug 2026 21:16:56 +0100
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Matteo Croce <technoboy85@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <20260824201656.GB770273@google.com>
References: <20260523105545.68079-1-technoboy85@gmail.com>
 <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
 <20260824102552.GA813380@google.com>
 <aoxCGPgdKqV2FkmL@beelink>
 <20260824142200.GA770273@google.com>
 <aoxcpDR8jnuUA1nF@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoxcpDR8jnuUA1nF@beelink>

On Mon, 24 Aug 2026, Benjamin Tissoires wrote:

> On Aug 24 2026, Lee Jones wrote:
> > On Mon, 24 Aug 2026, Benjamin Tissoires wrote:
> > 
> > > On Aug 24 2026, Lee Jones wrote:
> > > > On Wed, 10 Jun 2026, Jiri Kosina wrote:
> > > > 
> > > > > On Sat, 23 May 2026, Matteo Croce wrote:
> > > > > 
> > > > > > From: Matteo Croce <teknoraver@meta.com>
> > > > > > 
> > > > > > The log level for short  messages was changed from debug to warning,
> > > > > > flooding syslog on systems with devices that regularly send
> > > > > > short reports, in my case an UPS:
> > > > > > 
> > > > > >     $ dmesg |grep -c 'Event data for report .* was too short'
> > > > > >     35
> > > > > > 
> > > > > > Demote it back to debug level.
> > > > > > 
> > > > > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > > > > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > > > > 
> > > > > Applied, thanks.
> > > > 
> > > > FWIW, I'd like to contest this patch.
> > > > 
> > > > The warning is real.  It means that the HID report was rejected and as
> > > > such something on the system will be now be non-functional.  Silencing
> > > > the warning is not helpful.  It does not fix the issue, and now the user
> > > > / admin has no idea that its even happening.
> > > > 
> > > > This warning has caught a bunch of genuine issues related to testing
> > > > infrastructure and incorrectly coded firmware that have subsequently
> > > > been rectified.
> > > > 
> > > > Please don't hide this issue.  Fix the root cause instead.
> > > 
> > > Please have a look at the actual code in the tree first. That patch was
> > > applied by Jiri, yes, but IIRC it was dropped in a merge commit and is
> > > not included in any trees AFAICT.
> > 
> > Sure, but there was an attempt to have it reapplied [0].
> > 
> > My plea goes out to both submissions.
> > 
> > [0] https://lore.kernel.org/all/aoF-jIn9gk9kJ7Pz@decadent.org.uk/
> 
> It would have been so much easier to reply to the bump instead of the
> old original submission. The bump had all the references on the commit
> shas where they were included and overwritten, which would have saved me
> time.

It was 50/50 and I chose the original patch.

The important thing is that the point was made.

Sorry if it took you the extra cycles to work it all out.

> FWIW, that bump doesn't show up in my public-inbox query, which is why I
> did not saw it.

-- 
Lee Jones
