Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3237CD56
	for <linux-input@vger.kernel.org>; Mon, 13 Apr 2026 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053174; cv=none; b=jnBGH4ErUzteS095l43SLY3h6+8iixAKVlqrHLsIKkwRrn0avMQkGYk6UbHjsbotKj1FusqJMNYGuMMqXVA7MUNbDw4ELUQp2dz03mtjU0915LcaWDK1AYavhTzqV2JL9nworkhN6C+6ym4POx7nM8iE/WxsqNr7bjrBYV+0NVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053174; c=relaxed/simple;
	bh=mEMVuATy7dHKqzrpnkbq61aIth/jimGFihuRh/sWPLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0lSkI0+FmlRltoy4TFBmTyfhmsB3nm8ZNPVyrG+btDNmzxqJlqqDWMgPUkYYnPY5Q/SqMcFK0vi4w+VODU0kTg14tFv+baxWJZW6Mk/0WJMcj3qPaXNjuj0h6qoiUI7YlCLKK0enQYiDCZkdhHg0JE/dW1rly1jCPxi/7PeIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2Crb4m8; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2Crb4m8"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1271195d2a7so5011909c88.0
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2026 21:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776053169; x=1776657969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nb0cKWhfZ2pbCxb4NS25yOctz6k2jHUyzjk8q6pYUyA=;
        b=n2Crb4m8vUbtzzPg05iuE0i+dYP3nznk16gbtVnbEex1RLg4imC3fE+eJANAdmLfOz
         k0ZZJdOqcIcG6fUU5ZYduhGIvWyJKFtsQ8Cbk/9Ikeh9S1i11nNsfhM0ZWaxR2OQTddX
         q/GjxrN625eVbZ20Vd4EkHDr9T1kIKnXeJRbgvhEVnxBwY2u1ghl8WPgamf1yTQKD7FE
         dB1jqHhGv6BdV5SXWqmSfvnpPTvSM5ODa/qrc2wJsPG6B6REzM8IQ8Q2VXcf2H66rcyk
         ddOxTY7IWwcX3kqVMvK26JYFtafu/35aFv/CaJd7UV4sVRKC4L+n9kv04b7r3I5aQenC
         1RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053169; x=1776657969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nb0cKWhfZ2pbCxb4NS25yOctz6k2jHUyzjk8q6pYUyA=;
        b=EI1KDPDP2vI3TLL8r54iNT5biohqx9BdlvyLxpcJmGyCBuPOZ8FzksHhlFFZ1xtRM9
         OOrMlS1w9wzbvVOYYIKMMrX5Pqk+Kcz/GPzCjl1w4qTEhcrYad24xJ37chxdzFzj0rZ5
         8gD9QIZJ1drngSYI0L6Xx5sY1gJzbCdrEYhKQXtf6QdCT9bM4r30bbQudXSPvMO1GbV0
         r9Xuy/xWPiXfoa3RZyaJgUO1oYzp6n+AnemB2XNdOq8xo+50qM+8yVy9hgJYwlsUEq6s
         KFE6Et0XiyTQyqLrjmjzuj3qZsOin+JJVwJUoXi64BaiPp6fikE48DsZyE+1O5QP5IIx
         MoTw==
X-Gm-Message-State: AOJu0YyUf+biu0tjo+vEwhaHe+1yT71diYUS+0puHm1ZcBM0Lng/agWb
	1u2clMii72PsJyktEXdyP5sr70u0KrQlCyG/WjoCmSQ8zIn1b/sai0Rj
X-Gm-Gg: AeBDieuWLTcfdFaXrrzpVMYuMQmNsTAL80yGqMXxIBmFjL8vhyXub/dHTkq0d/o6vYc
	8XD45ZFZ7s2xqWlcNoUG7nmdhPS9GSslo6rP47OFXjK5WTNHIQvwqEiRyMt3T01eB2iKQQphqxm
	si2+mwCsvT8gYg6hXvthJmfEtt6QhVg87Z/fG3dWo+Pomnht0itS3aP3D2CqKMqgNNt3PZEc0Ss
	ca0k0EHG+YncdbSJXORSNr3GB4AjaXRlAuAjKcMrZlAMnmlt8UIFC8zoEzSsRBGhYZoTF7jFPSZ
	uYqUYQZdoH62/wn6+wMGw90pxd3JGpJLrR4JfbzjNznt80lNo3y5acarcV+DrpolBahsrOpBQa2
	9NJkbQrVaexkWbzVKkM8qgWPf+oS8946VFYYomxuxsm8sVK52sM88ZOuAqpNT/3CjrYy8C6Pwpa
	0iF1rOwKWvSoLkGj3ySaO4fQ3Aw4OmemT2WB3VQIklxl+ulX89H+QN1tS+NLPOgdCI
X-Received: by 2002:a05:7022:2581:b0:12b:ec96:c936 with SMTP id a92af1059eb24-12c34eab249mr6929273c88.14.1776053169070;
        Sun, 12 Apr 2026 21:06:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:fd17:4617:989a:1816])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm17394977eec.3.2026.04.12.21.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 21:06:07 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:06:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: edt-ft5x06 - Support label device property for
 input name
Message-ID: <adxrORktLYWfD4TI@google.com>
References: <20260409-ft5x06-label-v1-1-21e8a9ae9a60@gmail.com>
 <adxpdaSXYAa9dLPD@google.com>
 <CALHNRZ_m-hWpmp5OgOjHEc-QHRAkmTGaJX=O_K-X6EwY-5ToFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ_m-hWpmp5OgOjHEc-QHRAkmTGaJX=O_K-X6EwY-5ToFQ@mail.gmail.com>

On Sun, Apr 12, 2026 at 11:02:59PM -0500, Aaron Kling wrote:
> On Sun, Apr 12, 2026 at 10:58 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Aaron,
> >
> > On Thu, Apr 09, 2026 at 06:16:08PM -0500, Aaron Kling via B4 Relay wrote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > The AYN Thor uses a ft5426 and a ft5452 for each screen respectively and
> > > these currently get the same input name, making them indistinguishable
> > > from userspace. Support setting a label in kernel dt to make these
> > > report uniquely.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/input/touchscreen/edt-ft5x06.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > > index ba8ff65f7ea671..c36497571b1aa1 100644
> > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > @@ -1285,7 +1285,9 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
> > >               "Model \"%s\", Rev. \"%s\", %dx%d sensors\n",
> > >               tsdata->name, tsdata->fw_version, tsdata->num_x, tsdata->num_y);
> > >
> > > -     input->name = tsdata->name;
> > > +     if (device_property_read_string(&client->dev, "label", &input->name))
> > > +             input->name = tsdata->name;
> > > +
> >
> > You should be able to differentiate them by their sysfs path.
> 
> My target use case is Android, which to my knowledge can only use
> vid:pid or device name to differentiate input devices. The sysfs path
> does not help this case.

Please work with Android team to add missing functionality.

Thanks.

-- 
Dmitry
