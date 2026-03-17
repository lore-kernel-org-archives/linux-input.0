Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DED24501B;
	Tue, 17 Mar 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739260; cv=none; b=mlfJ8CXJokaGH1zZWxVdsaHfK8ZaH+Z979kJGzlXnKBLzvChGVcHgBOQ5wg5aJqraDSlaAfVHiRg66sBweJhmDAierAHd3A0m1d2GakEzp1GOfJUxn1Mkt0WELfn3pm7qk5ZEzYec0ZB/8cF0W/4lgvleD1/GZtqaYXD39WtKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739260; c=relaxed/simple;
	bh=TkT+8N9tnqONS1xp5nZdU7WyqjSUobHLEKXktS+0jCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrbsFa/xuJ84TEiGim/hC0kxMassnho+cJ4R4eyNhJK62wAq7QgSrxbfOVLVz6zYSg1qxiLdPgcxYLPY64lLNMwDDOUAEVHEBhSYdU75KmY4HOzJ8RrGMtnf+0mHsRdR2FYCTvCSkJZXPlavLN7k/ZtlZsLhxXwPjfDpCqWh8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WadfykKT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WadfykKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514C8C19425;
	Tue, 17 Mar 2026 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739260;
	bh=TkT+8N9tnqONS1xp5nZdU7WyqjSUobHLEKXktS+0jCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WadfykKTJQ3jshSXz1A2rGgqOs4xy34tbtFDQ0RNSEP5BFeSnt7Vh5W0smffV4cS1
	 4BZMMrg4vSKcspL2juJHklOuJeVr/zML7w/zBidxrqXciraA/THsU5hKe7dXnqFFqM
	 UovixAhPKEjm/EbwiIEP4qHfMjtNFiSUGEUP9PpllZLFyxgNBsjpfD8ogNN8Dvq3BP
	 TpXAgzZZm3nIqGKIonPB3q3T0XS84PzNkDsPfYHVKaPj8Gm2jLR5HEEFF8sAsrjTSF
	 hBt6s0aW0MfnUOAjaMVLHumWHIRwomCv7Y2DezYNUzRdX7ZYhl9HHftpNPIkdZaaD5
	 dR4aR4feAvoLg==
Date: Tue, 17 Mar 2026 09:20:56 +0000
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 2/2] HID: core: Check to ensure report responses match
 the request
Message-ID: <20260317092056.GE554736@google.com>
References: <20260309145942.1496072-1-lee@kernel.org>
 <20260309145942.1496072-2-lee@kernel.org>
 <abghH9Cf5FvUpfE0@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abghH9Cf5FvUpfE0@beelink>

On Mon, 16 Mar 2026, Benjamin Tissoires wrote:

> On Mar 09 2026, Lee Jones wrote:
> > It is possible for a malicious (or clumsy) device to respond to a
> > specific report's feature request using a completely different report
> > ID.  This can cause confusion in the HID core resulting in nasty
> > side-effects such as OOB writes.
> > 
> > Add a check to ensure that the report ID in the response, matches the
> > one that was requested.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> > v2 -> v3: Cover more bases by moving the check up a layer from MT to HID Core
> > 
> > RFC query: Is this always okay?
> >            Should the report number always match the request?
> > 	   Are there legitimate times where the two would differ?
> 
> Technically, there is no reasons for a HID_SET_REPORT request to change
> the incoming buffer. So that test might break it.
> 
> I prefered fixing the calling sites (hid-multitouch and others), because
> here we are making decisions on the device behaviour which is not ours
> to make. More specifically, such a test will prevent us to fix a bogus
> device by plainly rejecting the call after the facts.

Okay, so this one is a NACK?  No changes, do not resend?

-- 
Lee Jones [李琼斯]
