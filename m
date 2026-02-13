Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40126FD93
	for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016022; cv=none; b=GwCoyLkMBUyCLwgUcfI3US0FiaicrWrT983nAd4OpkXgZri0CwQmIiuDEBqkkxoVVsT90Dq8whLM01vchsXYkHYOL/8HHNoNjBa3l2uRKYC/z9/qJ1rOeC9f6qW/9LQlsS2UerkB1xijS5gYIYH1R+kkrw7fARwPR2YvhiWz450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016022; c=relaxed/simple;
	bh=m+/4dIleqxcRK34XC137ApK6LXbeRWLivpRAxEQgw7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQvnIG093WkMaOeUGafVVZMcHsVichEaqj3Bsx54FZNy74xCoFbIkKuG1YcrjHwOA6ZBajTQWqIaZzHC+r8R+B6d0BEVC4XRA2omJP15hGTu4UISRFjLb2W084qyJt4QEEshFxw501dYBsSwxuyvAOqfDLGizu6GcnAeqs4hDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTEl2uXz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTEl2uXz"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so187403966b.2
        for <linux-input@vger.kernel.org>; Fri, 13 Feb 2026 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771016020; x=1771620820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNTjuVW4ybK1uMeIfK0IWRcaxiigYsJ6cI61YXr3W3I=;
        b=aTEl2uXzqqhbS0BlEAyZau+HzCRjm8bxV3Syff2IHbhrnq6QWCsjACnsPnX2I6EbaB
         1ms1o9wKX7HuVYF82yhK4HoRrq4WLtiDD/JBOZ1qxbL3tS8kbJFoF0UbFzxaTGZSkdsT
         oeKdT6lEQAbpO2VWHcN0m8YVrZ13hX93Ygx28FajeyhtnmegKUKbFMRtt2BmtlwQoDh+
         JD7eImPFeTatH0TI1yDs9ohC/HEW4L99c2ICv2XVsvBaAh5fTog7GjSl5Ly5tbNKZ1/i
         +m3eWwmhbg9wnMqXtQlvHu58l0b9iwRHo9Y172yr2O0fL7dNpe6Q+wTpJelDqgv5X/13
         EZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771016020; x=1771620820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNTjuVW4ybK1uMeIfK0IWRcaxiigYsJ6cI61YXr3W3I=;
        b=XDEtLOUOoasyA36AiN6bZdY6VFIQp7ppsUvmQ1WsTVyXKEZT6Y+HC8g9sC8gRYNy7I
         qxau7UTqfJ3HxzT5T4YyyGy8Wp7W5ScTiutVZ93GGQsgEECjnLPQxmpOd67E1EdfXQOs
         vwMdrKPLSNzV5PgXI+bbBTUX+gJosh96+XGWZS5J4kM1TKlrG3JvD13/r9kybSvy+N+K
         UqHlk00jmepu7KvnZrH6mlIHNUfMb0Jvf8ULklR29zHUAuRVnIkstbCbRD0Exkmnai7y
         W5RT4U0v4oIAtYfCzEw8bQa8+QFdAW8gMdeN8WDlb7GjrpN/gRQlS4z4/hygkwPbsZJV
         iBlA==
X-Gm-Message-State: AOJu0YzhPOHtyq0DJr30DIn6FbbS0a2qoLG7uTxJl0aJErysnZEcxIOC
	lsgcBGKSSEUVKG0pnuVWKpqKbw1vxO1IlcFEEXJ3bUgIG9gL/sMhO/ENneUPZA==
X-Gm-Gg: AZuq6aK35Jcs2Q14TRKr7bnRRcjxsiPoTRVbR2eRxH7J2E4JcLuyC8cL4Mjk4WYObbJ
	86FtZVqvUoZGp0fUpVPHuJalTg71N252iZ+XpTKbVI0vhO8aYRrkNd7IEV3GRnJ+jYfeeU1GjOf
	hSRMBpCzTZsSceD6F1W6+nmRm10cLBELtBw9FlY47K5kMS8wIPv4ZzWN279TtilK8FU5PsEizKq
	Iy1mDQhPxDJAhRfYIWwrbWMMeU0d6UKu7vjG8S5Z176/SUtNoyfZTr13sXqg6ZhkD4GhSBQxyAG
	XEhaq8h5WZ9dboYSeslUd7zzSXUFcvCseAJBZfm4DDM97fUqjBwlg/uNXmB2Wmcaap8em99fAl0
	ly9LdRgZxPOt4MQ2kkgA6vcuE9kkcv/OrPFNAuOkzz7SxvX1LT48h0V9RIMzd/wVVDIkb3YlAUE
	pwlrJJcgynMYngXQ==
X-Received: by 2002:a17:907:720f:b0:b73:8639:cd96 with SMTP id a640c23a62f3a-b8fb42258eamr168589966b.24.1771016019899;
        Fri, 13 Feb 2026 12:53:39 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3f1388sm1094332a12.28.2026.02.13.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 12:53:39 -0800 (PST)
Date: Fri, 13 Feb 2026 22:53:38 +0200
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH 3/5] input: drv260x: Check the device ID at initialization
Message-ID: <aY-O1sGWZAgRBrMl@jekhomev>
References: <20260211235902.4156624-1-jekhor@gmail.com>
 <20260211235902.4156624-4-jekhor@gmail.com>
 <aY4NfZm80ofkxzNW@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY4NfZm80ofkxzNW@google.com>

On Thu, Feb 12, 2026 at 09:28:51AM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 12, 2026 at 01:46:53AM +0200, Yauhen Kharuzhy wrote:
> > To ensure that the device is accessible on the I2C bus, read the status
> > register and check the Device ID field in drv260x_init().
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  drivers/input/misc/drv260x.c | 44 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> > index f613c81fa2ba..f08a3d6c3ed8 100644
> > --- a/drivers/input/misc/drv260x.c
> > +++ b/drivers/input/misc/drv260x.c
> > @@ -56,6 +56,13 @@
> >  #define DRV260X_LRA_RES_PERIOD	0x22
> >  #define DRV260X_MAX_REG			0x23
> >  
> > +#define DRV260X_STATUS_ID_MASK		0xe0
> > +#define DRV260X_STATUS_ID_SHIFT		5
> > +#define DRV260X_ID_DRV2605		3
> > +#define DRV260X_ID_DRV2604		4
> > +#define DRV260X_ID_DRV2604L		6
> > +#define DRV260X_ID_DRV2605L		7
> > +
> >  #define DRV260X_GO_BIT				0x01
> >  
> >  /* Library Selection */
> > @@ -305,10 +312,47 @@ static const struct reg_sequence drv260x_erm_cal_regs[] = {
> >  	{ DRV260X_CTRL4, DRV260X_AUTOCAL_TIME_500MS },
> >  };
> >  
> > +struct drv260x_id_map {
> > +	u8 id;
> > +	char *name;
> > +};
> > +
> > +static const struct drv260x_id_map drv_260x_devids[] = {
> > +	{ DRV260X_ID_DRV2605, "DRV2605"},
> > +	{ DRV260X_ID_DRV2604, "DRV2604"},
> > +	{ DRV260X_ID_DRV2604L, "DRV2604L"},
> > +	{ DRV260X_ID_DRV2605L, "DRV2605L"},
> > +};
> > +
> > +static char *drv260x_get_model(u8 id)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(drv_260x_devids); i++)
> > +		if (id == drv_260x_devids[i].id)
> > +			return drv_260x_devids[i].name;
> > +
> > +	return NULL;
> > +}
> > +
> >  static int drv260x_init(struct drv260x_data *haptics)
> >  {
> >  	int error;
> >  	unsigned int cal_buf;
> > +	u8 id;
> > +
> > +	error = regmap_read(haptics->regmap, DRV260X_STATUS, &cal_buf);
> > +	if (error) {
> > +		dev_err(&haptics->client->dev,
> > +				"Failed to read DRV260X_status register: %d\n",
> > +				error);
> > +		return error;
> > +	}
> > +
> > +	id = (cal_buf & DRV260X_STATUS_ID_MASK) >> DRV260X_STATUS_ID_SHIFT;
> > +
> > +	dev_info(&haptics->client->dev, "ID: %u (%s)\n", id,
> > +		 drv260x_get_model(id));
> >  
> >  	error = regmap_write(haptics->regmap,
> >  			     DRV260X_RATED_VOLT, haptics->rated_voltage);
> 
> If the device is not available this regmap_write() will fail so I am not
> sure why we need all this new code.

Mostly for informational purposes about the detected model. Maybe you are
right, and this is unnecessary.

> 
> Thanks.
> 
> -- 
> Dmitry

-- 
Yauhen Kharuzhy
