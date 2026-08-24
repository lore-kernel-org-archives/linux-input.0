Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFA41F345;
	Mon, 24 Aug 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577415; cv=none; b=KMwBZ16wTm1Mwyc7jrLDnOjLaRHSrFDjqkv4+EeZ99zm74JAD4SGc855z2l0mes+fYo+djkzGllbjntR3arTsdQ4WtkiZWia1cRnPxjRHrHN2NRxpNJhIbGpd4Uyi2yPnk7rD2oIQKnbDsU1zZhF7OX2KbCfV5/npjuedWWYYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577415; c=relaxed/simple;
	bh=bPhJb0pYW+BOM5yltTyVkDgOtYYGT+KkL0Q5hITord4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpX4RdK18O6Fy9x+lPkNg6zs5j269Nodd3sEgMCvgHejy4jhXhzRBVPKJMCIdOWYSjZky1CCh0IQK1g7O9vnYHBfN1mdbvFVHBd2NL55HFimOIC62d9Z+gesMutvu3hKTJu8f1gj0zQxt/ZFMw28dS0l1RM6ze8dAYsTvf/zp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNbhCjcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNbhCjcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62041F000E9;
	Mon, 24 Aug 2026 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577414;
	bh=nlya3KtMQpIv3X7Nnw9ssojtpgPHT6xroyMQ6l2JBh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lNbhCjcV2vFaOcb7bBjpKOJMm5Hf28aM5eWLvWSFcIh2XKkfWFE5ZWqvKfyRGGe/J
	 cbGnrXp9m56Bsed7r3Tk+JP7NQibBCSbsbGLYbzojzCvo5EQQjTpnr4CB2aBTDxxnZ
	 BNhUpT2vBaWLSPC9w9ORqoIeBdsnZjH66DqMyd4rWj/5DHw/Yta3oi4VUyQiMRICh2
	 k6kxVwZeYaoUNfQMRlymKeyj/d2vzlWdYsXn7qiC+Pc7amfarcY6S2spK2QLUiWG1z
	 EvprEETldkS0AdF9gBx6jvzo4COzvckovdVdDRc1pVsTKW7T1g2g4Ei2Hjzs8WF3dk
	 EsAnK37VmPHWw==
Date: Mon, 24 Aug 2026 15:16:49 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Matteo Croce <technoboy85@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
Message-ID: <aoxCGPgdKqV2FkmL@beelink>
References: <20260523105545.68079-1-technoboy85@gmail.com>
 <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
 <20260824102552.GA813380@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824102552.GA813380@google.com>

On Aug 24 2026, Lee Jones wrote:
> On Wed, 10 Jun 2026, Jiri Kosina wrote:
> 
> > On Sat, 23 May 2026, Matteo Croce wrote:
> > 
> > > From: Matteo Croce <teknoraver@meta.com>
> > > 
> > > The log level for short  messages was changed from debug to warning,
> > > flooding syslog on systems with devices that regularly send
> > > short reports, in my case an UPS:
> > > 
> > >     $ dmesg |grep -c 'Event data for report .* was too short'
> > >     35
> > > 
> > > Demote it back to debug level.
> > > 
> > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > 
> > Applied, thanks.
> 
> FWIW, I'd like to contest this patch.
> 
> The warning is real.  It means that the HID report was rejected and as
> such something on the system will be now be non-functional.  Silencing
> the warning is not helpful.  It does not fix the issue, and now the user
> / admin has no idea that its even happening.
> 
> This warning has caught a bunch of genuine issues related to testing
> infrastructure and incorrectly coded firmware that have subsequently
> been rectified.
> 
> Please don't hide this issue.  Fix the root cause instead.

Please have a look at the actual code in the tree first. That patch was
applied by Jiri, yes, but IIRC it was dropped in a merge commit and is
not included in any trees AFAICT.

Cheers,
Benjamin
