Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855C261B70;
	Thu, 26 Feb 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108561; cv=none; b=iKyf1RdvQ39ntjPSfWUs4Z95B8w+4xk8RtUQwmFqsAPrP5a/aguKgyhiroFqYfjoX0bNR5I0aq9/KLnDfAgf3gs1d4OeJrTVeBAL5crgX837le8mnYLvu0bT2ID52nCKqKOJrIEa322af8UECidqF2nSIOiRIVvdM/oQkC1d6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108561; c=relaxed/simple;
	bh=pDUQ3U6u0AZuQaoY38Nd1cd4YlhwPhZcnTqYdko34JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNB66dIPsakHH3BpF2yo/GoS8ijsfj8b1wdKZ+7Qj2fYRM2ubp7stgvqEAz7PLhoSG4izWsqgdCTLnqKKzucVlE38WSqDZsPdv5c3e7xRDaoQojwzfWXKv/5opr7cc9LxrrgGRDLmKfaK8lwXCCAdD3i3KiAtDgdhzwU655EZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS/rZe74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS/rZe74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CFBC19423;
	Thu, 26 Feb 2026 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772108561;
	bh=pDUQ3U6u0AZuQaoY38Nd1cd4YlhwPhZcnTqYdko34JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DS/rZe74nTK2sp+eRtG3gH6PgJCBD+6pREJb6cUfNrmEGz6NVlzNMzz/KkDUqqBsQ
	 m8MhOxTAGR9AfLcopMURyf3MHNggcmBVaEXLPVk/C79LJ/+RYlQfOTDHc6OtE01HOq
	 JU0rC/VzNlZ01sTPZokTPc/r3FeaWZ3SkobJBp4IjY6AidGn10ZmX/BIh6ag3dX555
	 SesML7a/5YdRUbWTFdC+UwFFJiNhHwbxJW2OwyENc2ARuEloGW8qgnFeNJLoOElSQl
	 +RQPd/DJJT5Ur6/gcdFisX1MJFeJXEju+JcN+8ct3oCA+55+bT5VWnuMxkTzL5YhGL
	 aqXrky7xd+kKA==
Date: Thu, 26 Feb 2026 13:22:37 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, David Rheinsberg <david@readahead.eu>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <aaA6fioiB9_aiBrA@plouf>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
 <20260226111816.GA8023@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226111816.GA8023@google.com>

On Feb 26 2026, Lee Jones wrote:
> On Tue, 24 Feb 2026, Jiri Kosina wrote:
> 
> > On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> > 
> > > Long story short: that patch is too intrusive as it makes assumption on
> > > the behavior of the device. We need to understand where/if the bug was
> > > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > > implementation.
> > 
> > Thanks a lot for the analysis, Benjamin!
> > 
> > I asked about that here:
> > 
> > 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> > 
> > So let's wait for Lee to clarify. Until that, the patch stays out of the 
> > branch.
> 
> Thanks to both of you for looking into this.  I appreciate your efforts.
> 
> This is very much real world.
> 
> Is there a way to add an errata for the PS3 controller?
> 

Unfortunatelly no. uhid merely emulates what a device can do, and HID is
a convention. So if we were to have a special case to PS3 controllers,
we would then start having to maintain an endless list of quirks when
the issue is *not* in uhid, but in the processing of the device after
(maybe in hid-core?).

Cheers,
Benjamin
