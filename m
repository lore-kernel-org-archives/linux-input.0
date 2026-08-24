Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F836C9CC;
	Mon, 24 Aug 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583771; cv=none; b=QqI1NBOGClp8tzq7ZXOpt0VV/CXKD3ne4BLBWH8e3xA03HUsPcR+U2LGxBKGPpq9atXcgPz0XoRWCPzpX2pwgq8b7qkvudLdP2HDlTFz2gSWdSzcrhXykquj8TKABg+vsr9OybaYiqOVK4mQNh2thuRxuh0mGiBbO+8NorD7yBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583771; c=relaxed/simple;
	bh=yRO7nMcml2xVootwT9W5F7pUh/sriQ8TahSiEi4qPEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNiBPQ4VhigHLye1z0os1K90Th1KJY/kDmQ8eccqnYiSVRramFKXzbQe3X6T67Av/Qtj6+ujw7rs+gtEHZcuwYlsEKl1UF2tl1uSe2oLhVN980HLoVTMcP9CQMeg0G9rSCgFZ6puTLV3i4zmQpt0s2RmxVxhgjuqaiXk4yia+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R17CgifL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R17CgifL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1F1F000E9;
	Mon, 24 Aug 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583770;
	bh=7fr77uhOxxfljtlZIh+hlx1JvPRfxQL+kZAuB0zh3lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R17CgifLdM4FWHgFzi95k2Xjh9wmG3NPe9fdLwXox/rLiuI1wRYvnfaZS16sHc8aG
	 UsEkcrClgha41Z5BoIGIZpv17FDsNiAmXwm4ejV+Wg2Nxh+Z22ZezTZPFVQJAw5qX5
	 VCynu+3EVbLDGGbPeByXbK4ZlfWarHvbBNJ9LKm4yfQWYsvui4HyY7RN4XKSP3VUwh
	 5xxxNDk5936Rhq6LGqgSZ+vxOpngONATguQdVgUOxHKXg73ydBhvVwEXwpIKMZuIzB
	 iRt6c5hRCslgqgT6/CdB2oszWpEAWGKXk36VdGgLfyUORBigOsc/SL6ySNFbcdcBlZ
	 P3vHkhHhgmW0g==
Date: Mon, 24 Aug 2026 17:02:45 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Matteo Croce <technoboy85@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <aoxcpDR8jnuUA1nF@beelink>
References: <20260523105545.68079-1-technoboy85@gmail.com>
 <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
 <20260824102552.GA813380@google.com>
 <aoxCGPgdKqV2FkmL@beelink>
 <20260824142200.GA770273@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824142200.GA770273@google.com>

On Aug 24 2026, Lee Jones wrote:
> On Mon, 24 Aug 2026, Benjamin Tissoires wrote:
> 
> > On Aug 24 2026, Lee Jones wrote:
> > > On Wed, 10 Jun 2026, Jiri Kosina wrote:
> > > 
> > > > On Sat, 23 May 2026, Matteo Croce wrote:
> > > > 
> > > > > From: Matteo Croce <teknoraver@meta.com>
> > > > > 
> > > > > The log level for short  messages was changed from debug to warning,
> > > > > flooding syslog on systems with devices that regularly send
> > > > > short reports, in my case an UPS:
> > > > > 
> > > > >     $ dmesg |grep -c 'Event data for report .* was too short'
> > > > >     35
> > > > > 
> > > > > Demote it back to debug level.
> > > > > 
> > > > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > > > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > > > 
> > > > Applied, thanks.
> > > 
> > > FWIW, I'd like to contest this patch.
> > > 
> > > The warning is real.  It means that the HID report was rejected and as
> > > such something on the system will be now be non-functional.  Silencing
> > > the warning is not helpful.  It does not fix the issue, and now the user
> > > / admin has no idea that its even happening.
> > > 
> > > This warning has caught a bunch of genuine issues related to testing
> > > infrastructure and incorrectly coded firmware that have subsequently
> > > been rectified.
> > > 
> > > Please don't hide this issue.  Fix the root cause instead.
> > 
> > Please have a look at the actual code in the tree first. That patch was
> > applied by Jiri, yes, but IIRC it was dropped in a merge commit and is
> > not included in any trees AFAICT.
> 
> Sure, but there was an attempt to have it reapplied [0].
> 
> My plea goes out to both submissions.
> 
> [0] https://lore.kernel.org/all/aoF-jIn9gk9kJ7Pz@decadent.org.uk/

It would have been so much easier to reply to the bump instead of the
old original submission. The bump had all the references on the commit
shas where they were included and overwritten, which would have saved me
time.

FWIW, that bump doesn't show up in my public-inbox query, which is why I
did not saw it.

Cheers,
Benjamin
