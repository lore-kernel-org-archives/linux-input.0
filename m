Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD03E274C;
	Mon, 31 Aug 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218311; cv=none; b=d8RHone6YF+YJUXVx0Q7Lwyly56iBaoG6v1wYe36nFxll+KEofqEHKJ/1x7ccOv5uCBm/yr18VXTQ906UFsXrjqaH4YZuZu9ztRmXdwY1r3s+niHpfsKqK4iSCOJp5KUDZ2IftbFPevh4A4jxezUOX22+9VQgyvagkYPsYnYzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218311; c=relaxed/simple;
	bh=bivl00aXJzLo0QkaUmlOlS45C1LsXDSzR+GV+Zh4vtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI1OizQZFK+hJHNe7t5mbl/5AYkcNZSeiNhUBvkywJgit+4mGksvH3HjalXJe6ejdT2BvM7IC0tqziN2HMcYZC2UKxhth5KszvrUueeZdUiD4kldsSWNsJ/jgBhkl1tquwN1aCNbGoZjhh7RqqqGCHE0bVpG5rITH2Hqsmdrses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEpub1GD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEpub1GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C821F00A3D;
	Mon, 31 Aug 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218310;
	bh=VUcB70G9P5jAx1yv7UiuVEK89XWTWDQ7iyZGCes5l14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EEpub1GDLIWivbpz2qLUS0PPs5/wDfsBlQfEsGphBi9/qFrATneAt5gyVOV8JFowj
	 Lz3zVEvjVVRFtagsTEYoj5BMOk7kZh26+ruKvXGC1j6S3xeKpsHzdYH6Wcg1Y2a592
	 dn/t/fjZT32l4aZ9/d+OIp9Hr5jkn0mcArj0mar+8KMMa2D0qJRXwrHqnLJjXvjbwp
	 7sZEuv9BkMQmkxJMLlp5lqMLIviri9Hq7k0PRRXXAEXhNgpqQzintdPdbCItV+R2oi
	 IzgdaVckXYDJUkniyUm/UywlmFgQSj9rfc/E+vnXTCqXqLLRGhop9BbCKSGDTQCF2R
	 kb2w0iVfQ+c6w==
Date: Mon, 31 Aug 2026 18:18:29 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] Input: tsc2007 - Read "ti,poll-period" as u32
Message-ID: <20260831231829.GA1244140-robh@kernel.org>
References: <20260831194352.1185860-1-robh@kernel.org>
 <apXaYJhFnC0UCHb0@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apXaYJhFnC0UCHb0@google.com>

On Mon, Aug 31, 2026 at 12:51:44PM -0700, Dmitry Torokhov wrote:
> Hi Rob,
> 
> On Mon, Aug 31, 2026 at 02:43:51PM -0500, Rob Herring (Arm) wrote:
> > The "ti,poll-period" property is documented as a normal uint32 cell.
> > The driver used a u64 helper, which makes the helper type disagree with
> > the schema even though the stored value is still small.
> > 
> > Read "ti,poll-period" with the u32 helper matching the documented DT
> > cell size.
> > 
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/input/touchscreen/tsc2007_core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> > index e4d7da0f4434..e2f49b37e18c 100644
> > --- a/drivers/input/touchscreen/tsc2007_core.c
> > +++ b/drivers/input/touchscreen/tsc2007_core.c
> > @@ -221,7 +221,6 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
> >  static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
> >  {
> >  	u32 val32;
> > -	u64 val64;
> >  
> >  	if (!device_property_read_u32(dev, "ti,max-rt", &val32))
> >  		ts->max_rt = val32;
> > @@ -237,8 +236,8 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
> >  	if (!device_property_read_u32(dev, "ti,fuzzz", &val32))
> >  		ts->fuzzz = val32;
> >  
> > -	if (!device_property_read_u64(dev, "ti,poll-period", &val64))
> > -		ts->poll_period = msecs_to_jiffies(val64);
> > +	if (!device_property_read_u32(dev, "ti,poll-period", &val32))
> 
> Do we need to handle -EOVERFLOW and keep compatibility with device trees
> that used /64/ to match driver implementation? Or we expect that there
> were/are none?

I suspect there aren't any users. Nothing upstream for sure and there 
never was. We could probably just delete the property.

Rob
