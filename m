Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C918372690;
	Tue, 17 Mar 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739030; cv=none; b=SqkfJozJu8B/zHn4uCBPfqGxwq3+ubtgyTP+2mgYSQBMDDf8DJjq3Im34a0pRCvZkBhZxh3p3G6HFIsRLwlVC2Rt1mfaFYtncTtjKlONgfBOw/BWcH+31TmRJwMdLPfGrkPEwGxulq52dHrEdOEst7n+3MJ4LsuqKELEsCHECaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739030; c=relaxed/simple;
	bh=sps2xEkJ5fLnXyj7+r20YsNPf96ijrzh4N6CRE8KfGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1cA48bCHyBl6Gz5u2El8PaorTEdor4TVHImgCY4/HDhlcnfx+/PW+NnYJnub3KpiBUVSmz4JkAS0o79S1zLqVxb9vn9+fbi/HZmyEgM7tyXKhNa2pbSLTAvPud/2HAI8oqZ3vt3AaOTZn1cujU6/E7NaNm0VyjOiRP2duglUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ropqWAzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ropqWAzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CB3C19425;
	Tue, 17 Mar 2026 09:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773739029;
	bh=sps2xEkJ5fLnXyj7+r20YsNPf96ijrzh4N6CRE8KfGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ropqWAzvExGJ9aC0ICwKY0hu/NWGs2oa1RWRVFkM7FjiuemuHYDmr4QKgzS9JX7h4
	 XvIQT9ZQ6+m4zvJGszwvBBCteoRwAqE/36nCnQ4wGJkPGL9nSSRtawP9O5oB3gtHM9
	 RvGoXHPsGLvIy1AcQYMnw3AvKTnqNBhrbVK5xUkCozE53r9fvtN6ZghToMmQTuhifU
	 JldPanuocyhnjQaYhkssVPf4N0kTPBnwpLqPyJOJRJxq4Z16nNRW850O7AQlcJmQAr
	 Vxa80LqdYZZ7bDnV8xodAd47dX58Mg+oKbDeET8e/xfkSvpz1I3jCrTaShOPjEaanZ
	 LiLvgupCejrig==
Date: Tue, 17 Mar 2026 09:17:04 +0000
From: Lee Jones <lee@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Prevent use-after-free on force
 feedback initialisation failure
Message-ID: <20260317091704.GD554736@google.com>
References: <20260227100939.961011-1-lee@kernel.org>
 <aaareetB3Hhd6xgI@google.com>
 <20260316151144.GB554736@google.com>
 <abgh0US3fO98w18G@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abgh0US3fO98w18G@beelink>

On Mon, 16 Mar 2026, Benjamin Tissoires wrote:

> On Mar 16 2026, Lee Jones wrote:
> > On Tue, 03 Mar 2026, Günther Noack wrote:
> > 
> > > On Fri, Feb 27, 2026 at 10:09:38AM +0000, Lee Jones wrote:
> > > > Presently, if the force feedback initialisation fails when probing the
> > > > Logitech G920 Driving Force Racing Wheel for Xbox One, an error number
> > > > will be returned and propagated before the userspace infrastructure
> > > > (sysfs and /dev/input) has been torn down.  If userspace ignores the
> > > > errors and continues to use its references to these dangling entities, a
> > > > UAF will promptly follow.
> > > > 
> > > > We have 2 options; continue to return the error, but ensure that all of
> > > > the infrastructure is torn down accordingly or continue to treat this
> > > > condition as a warning by emitting the message but returning success.
> > > > It is thought that the original author's intention was to emit the
> > > > warning but keep the device functional, less the force feedback feature,
> > > > so let's go with that.
> > > > 
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > >  drivers/hid/hid-logitech-hidpp.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > > > index e871f1729d4b..eee9ab6a2fc4 100644
> > > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > > @@ -4487,10 +4487,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > > >  		if (!ret)
> > > >  			ret = hidpp_ff_init(hidpp, &data);
> > > >  
> > > > -		if (ret)
> > > > +		if (ret) {
> > > >  			hid_warn(hidpp->hid_dev,
> > > >  		     "Unable to initialize force feedback support, errno %d\n",
> > > >  				 ret);
> > > > +			ret = 0;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	/*
> > > > -- 
> > > > 2.53.0.473.g4a7958ca14-goog
> > > > 
> > > 
> > > Reviewed-by: Günther Noack <gnoack@google.com>
> > 
> > What are the subsystem preferences in terms of pokes or [RESENDS], please?
> 
> Just send a gently ping like this on the thread, this will make it pop
> up in our mailboxes :)
> 
> > 
> > I'm happy to submit a [RESEND] if that's required to get this back into view.
> 
> Nah, no need to send a [RESEND] when the patch is just a couple of weeks
> old.

Understood, thank you.

-- 
Lee Jones [李琼斯]
