Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB7380FE5;
	Wed, 17 Jun 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684832; cv=none; b=hv/ZK39SMuHnJ+TQJJFqEebUddApB5Gze5n3y05KReKBzv85PgsODyqYWKI9sqOEYTS/S27HQF5ALxCdRrp5mhhllse3ZPgPpLTj4FqjsLBMeGz0/VODj0dWc2Gad3mieFRRjRkJmPT4FXejVtcYRu0WwW5Zs4SrEAZwVelUlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684832; c=relaxed/simple;
	bh=au7s3tY9sd4ilGF4tDEw3c2Cz9OTjKmpfv09TH2aySM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdPgnVriR7MPIdZ3FRwueA6ecy8d2BHI83VyIE0IdOICjf9rAqSw5NmkdL2cKnCZSoU2O/ewCxvZAN4ha9Fjr2GJOje8hG9Uw642g2Fu+MGtb5axlQWo1zFe6lTGVm3am479qSfcxuj1cCg1b1EyoJYucTR51by+0u2nz1Ter+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f65kacSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f65kacSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEFE1F000E9;
	Wed, 17 Jun 2026 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781684831;
	bh=40SvXufwyxvHfuZjlmqW6QfZ8RlPLo3n2S4syU+UwnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f65kacSpZs8KVe5Eyk0jCFbvpBEcRawbg78sX50JFuTdBUGlYUbLVUVCEdkUldrHV
	 kSEWxPpwKL5gMiuW/O9WS8ZGCBHUsxD53sMV7IVYe9+v/5P/TFraUYcEzZ9bhiJ09T
	 cgeJpvslhCt3RyXW2RJe9P2fCe03LkIpcJKU4cuSy7Dq3zeaLz32ATX9IcFJPX0RQu
	 mi7BTkdeJ7E2MAmBTYgfM7/nmsM8qHM1ixUiorxPZP2/gMO5o3lAqElhbcbdFyTP1g
	 pNo70Jvcq6qd4Yn7A8qEpszYnnOHPq3BdsPp+YyFc6sUQ1E7ajt/+BElQCDn4ZB5KG
	 sC8pnI7uhx6Fg==
Date: Wed, 17 Jun 2026 09:27:07 +0100
From: Lee Jones <lee@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: core: Fix OOB read in hid_get_report for
 numbered reports
Message-ID: <20260617082707.GB10056@google.com>
References: <20260616112700.1990813-1-lee@kernel.org>
 <2026061649-sphinx-ancient-e3c0@gregkh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026061649-sphinx-ancient-e3c0@gregkh>

On Tue, 16 Jun 2026, Greg Kroah-Hartman wrote:

> On Tue, Jun 16, 2026 at 11:26:56AM +0000, Lee Jones wrote:
> > When a caller passes a size of 0 to hid_report_raw_event() for a
> > numbered report, the function originally called hid_get_report() before
> > performing any size validation.
> > 
> > Inside hid_get_report(), if the report is numbered (report_enum->numbered
> > is true), it unconditionally dereferences data[0] to extract the report ID.
> > With a size of 0, this results in an out-of-bounds read or kernel panic.
> > 
> > Fix this by moving the numbered report size validation check before the
> > call to hid_get_report(), ensuring that size is at least 1 before
> > dereferencing the data pointer.
> > 
> > Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/hid/hid-core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.

Sure, why not! :)

Cc: stable@vger.kernel.org

-- 
Lee Jones
