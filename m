Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED425BEF8;
	Mon, 16 Mar 2026 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673909; cv=none; b=KYoZD0RvkpRHKQ4SWwH03E1IvBj9UtFovX/th5Ay1InFS4mgfGmqoqwIyht3AJ5GrjXD3Q6VR9cAGpQpFU9uDrqjHCs6PFQp7lFPQ0gEwWCVOozL1deVSVDtvSDPy/NZ5XCD2SUneJGn/IZO2mCUYofjeoz4ZyWjxdb6QKzz0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673909; c=relaxed/simple;
	bh=60WgLBhdha9ysdfxqr0v03YYsLjrOMhp0f2eH8upwMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0w4zRHR+0uGDic1wXOHkjBXykPi2zdIEXcbxLap7uEOu4yyS+JkF2q9RA3u0Gt931/eDh4IO4KZsRVVkVprGANuPI8t/Q+vVUloLHFZiPV7J1e2H5uK/UUTXgQI0JG4bbRCOqpAMQArE70e9y4nUVdRxYnw9q8WcSirzD+HfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdF/Md9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdF/Md9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C88CC19421;
	Mon, 16 Mar 2026 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773673908;
	bh=60WgLBhdha9ysdfxqr0v03YYsLjrOMhp0f2eH8upwMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdF/Md9zja65zOIQSM5ItDjGqtkeuvJoXh00DDqncF0Nsibel8vDoIKZuF7D0iotf
	 ntEsehPPkGuYNiWktxMQN+jgwVfb1eh66o9N+EJ9dtzs8Cg+MjH4c7pAT5MGbutzXH
	 EkHTA/hy3HEo/oy4+s0IZUbGBig7XFhxkKvxYDvbhJqkxSqaFm8LCy3maCzQ0MZq6d
	 WRdVTFsyPxeAMqrRuRYFTSl4mnJqYga0fXVjNMyr3qzuB5IOAgjIkF3URCc5ij7IMF
	 99WtGGZWhb3qZN+PLukEJ/9yVfu6pJ2qZ51q/yKwH16WCtAn8oKekOSBU/w+ds3wDp
	 ZbW2kgn3gU0Bg==
Date: Mon, 16 Mar 2026 15:11:44 +0000
From: Lee Jones <lee@kernel.org>
To: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Cc: Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech-hidpp: Prevent use-after-free on force
 feedback initialisation failure
Message-ID: <20260316151144.GB554736@google.com>
References: <20260227100939.961011-1-lee@kernel.org>
 <aaareetB3Hhd6xgI@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaareetB3Hhd6xgI@google.com>

On Tue, 03 Mar 2026, Günther Noack wrote:

> On Fri, Feb 27, 2026 at 10:09:38AM +0000, Lee Jones wrote:
> > Presently, if the force feedback initialisation fails when probing the
> > Logitech G920 Driving Force Racing Wheel for Xbox One, an error number
> > will be returned and propagated before the userspace infrastructure
> > (sysfs and /dev/input) has been torn down.  If userspace ignores the
> > errors and continues to use its references to these dangling entities, a
> > UAF will promptly follow.
> > 
> > We have 2 options; continue to return the error, but ensure that all of
> > the infrastructure is torn down accordingly or continue to treat this
> > condition as a warning by emitting the message but returning success.
> > It is thought that the original author's intention was to emit the
> > warning but keep the device functional, less the force feedback feature,
> > so let's go with that.
> > 
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index e871f1729d4b..eee9ab6a2fc4 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4487,10 +4487,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >  		if (!ret)
> >  			ret = hidpp_ff_init(hidpp, &data);
> >  
> > -		if (ret)
> > +		if (ret) {
> >  			hid_warn(hidpp->hid_dev,
> >  		     "Unable to initialize force feedback support, errno %d\n",
> >  				 ret);
> > +			ret = 0;
> > +		}
> >  	}
> >  
> >  	/*
> > -- 
> > 2.53.0.473.g4a7958ca14-goog
> > 
> 
> Reviewed-by: Günther Noack <gnoack@google.com>

What are the subsystem preferences in terms of pokes or [RESENDS], please?

I'm happy to submit a [RESEND] if that's required to get this back into view.

-- 
Lee Jones [李琼斯]
