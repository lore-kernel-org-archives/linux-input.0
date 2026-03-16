Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314D318EE4;
	Mon, 16 Mar 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675071; cv=none; b=uCquRzZEFL07/tiPtV40sEmFfLb/m1EaVWEnU4zXrXBeidnv/HlpBIZQHDGp+PRnbGKxhPR4hiV1UjDB6wZPE9DWy5yMyEMG/4GnXwGny6mbQvzlKZpGWnPTd2KCsIECOn5tl3WfPVTNTvYSkZ8Iq6l86Kj1eIUFWZtTcBRxsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675071; c=relaxed/simple;
	bh=sD/+DQ71oYQArsKuGY5kvvBw6YB+vx4AqCWJMPfm2A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU+/gGB38OtgZQ5q/JY2AQZ+5UcxEG66EoTxaro7wp1RG+8nrZn2IgMRZbisc2TzdLrDdW+b9s3fXNTgQpW4OGQ8h1WhGjdMH5HTA63N7DdZo/UP4fsnwJcGaHi0E/Ey4BMT6WzfPW7sZlTFC1QIFrvZsReYYkNZvjvshEyAWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoLebC9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoLebC9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C5FC19421;
	Mon, 16 Mar 2026 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773675071;
	bh=sD/+DQ71oYQArsKuGY5kvvBw6YB+vx4AqCWJMPfm2A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoLebC9NH2bRqvfYTJPoxC31fXeQbXCRvUDU5dRGS9TvnCZgidhbwcQQkNPL1K1Uk
	 Pzz2RRpVt7F+si3XPMnUKY2reKfJ4K/+/icOIyhEKwrki8vitOOjSplOOhIFuyJs2E
	 dt96xBPiXDhCv0lhWcPIP2vkZ58n1iMhE1s0Agkj49UP3ZjC60mn1k6shI7sNJMz+b
	 Nc6s6C7cwlMe7fWzdntwFtAai8fA9RgsCaV853kSAmZnGPb8ZQM9NyYDHO2r4tXd3Z
	 3ndj+7fYAAHj0m+jDzF259d4Lk/l+aPRV2lvHDJjDMrkymkNNrtejRpZY5lkWRHCJe
	 E9q62AAxUN6pA==
Date: Mon, 16 Mar 2026 16:30:24 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, Bastien Nocera <hadess@hadess.net>, 
	Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Prevent use-after-free on force
 feedback initialisation failure
Message-ID: <abgh0US3fO98w18G@beelink>
References: <20260227100939.961011-1-lee@kernel.org>
 <aaareetB3Hhd6xgI@google.com>
 <20260316151144.GB554736@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316151144.GB554736@google.com>

On Mar 16 2026, Lee Jones wrote:
> On Tue, 03 Mar 2026, Günther Noack wrote:
> 
> > On Fri, Feb 27, 2026 at 10:09:38AM +0000, Lee Jones wrote:
> > > Presently, if the force feedback initialisation fails when probing the
> > > Logitech G920 Driving Force Racing Wheel for Xbox One, an error number
> > > will be returned and propagated before the userspace infrastructure
> > > (sysfs and /dev/input) has been torn down.  If userspace ignores the
> > > errors and continues to use its references to these dangling entities, a
> > > UAF will promptly follow.
> > > 
> > > We have 2 options; continue to return the error, but ensure that all of
> > > the infrastructure is torn down accordingly or continue to treat this
> > > condition as a warning by emitting the message but returning success.
> > > It is thought that the original author's intention was to emit the
> > > warning but keep the device functional, less the force feedback feature,
> > > so let's go with that.
> > > 
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > > index e871f1729d4b..eee9ab6a2fc4 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -4487,10 +4487,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > >  		if (!ret)
> > >  			ret = hidpp_ff_init(hidpp, &data);
> > >  
> > > -		if (ret)
> > > +		if (ret) {
> > >  			hid_warn(hidpp->hid_dev,
> > >  		     "Unable to initialize force feedback support, errno %d\n",
> > >  				 ret);
> > > +			ret = 0;
> > > +		}
> > >  	}
> > >  
> > >  	/*
> > > -- 
> > > 2.53.0.473.g4a7958ca14-goog
> > > 
> > 
> > Reviewed-by: Günther Noack <gnoack@google.com>
> 
> What are the subsystem preferences in terms of pokes or [RESENDS], please?

Just send a gently ping like this on the thread, this will make it pop
up in our mailboxes :)

> 
> I'm happy to submit a [RESEND] if that's required to get this back into view.

Nah, no need to send a [RESEND] when the patch is just a couple of weeks
old.

Cheers,
Benjamin

> 
> -- 
> Lee Jones [李琼斯]
> 
