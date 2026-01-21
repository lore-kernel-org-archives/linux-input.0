Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0A41B378
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973664; cv=none; b=ZPxIztdNFpkyMTpLl8QLLa/igmXYKBpUtCSocyN3KikcmhwjA6xZz+1Jhy0vd5/v4xNv7tmlNLmjD77RUZqe7iki6JdTQKN1ztICXzs5mkkBFRhTy1y5tncSFD+2B6MstjFL2Muf/rN1tFQVMRRSTSzxuqh6oZwRz4CY4JtmKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973664; c=relaxed/simple;
	bh=kGMn/SzteXybWLySz6wGLPTY2zt9TaoQFMuFNdgvwSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8zX5cbadEleGttmkGEkEbqwVL7AwbuV9xVuf1+ZwREZ8v9puUnREiJDhY2FBH/J8sEnutFZ0pER/cH1s30ER+CCix42kMlhIdU2/6LNDPVHGgIuZdW4uo44GMAHvHJPyQdeWhnhIa9h/g7JfkugrzVgPBEYnDmQX1ScMAua7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0RxuFE9; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0RxuFE9"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12336f33098so5124661c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 21:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768973661; x=1769578461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0QFwipTPR5DqdzbEaQ8Ys+o+tWAmaO3Qrn/zG23vmY=;
        b=h0RxuFE9pL96f6DRdLh5CwKYK1TxDP3fgG+lAm5Pt6LvMG80kl9Ui+g8HWpYgSkKWj
         2qDHXWAYSiKJA9yZFimGMTbdceNHa1XYoq2yGre7R/a3iGJ0jtLdQf7ckMZ7iFL7dWGq
         vVlrXzqeTFcFNl2lrqJhKXqZnblTq1+ESjUm8wmnGxbtVZqIu7+s84gjrPSJTEH78VwM
         rBEkZQmqzzv0exjvZDrw7VjOzvYbukZJk9SYb+IDtQOKglRwllT+1aBtMzMs7ntCxhut
         96sB+3kzjlo2WXPHc7L9rt/9US6D47qeyLDKhqiuydPnoqamGgpRTDo9jEKU1GMLb5LV
         Lv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768973661; x=1769578461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0QFwipTPR5DqdzbEaQ8Ys+o+tWAmaO3Qrn/zG23vmY=;
        b=BqJvnoj4mQCgZBaitWEM5b0LGnBhOBf3GVpjBnCzB8XXcrSh40yK8Wxgd8WZXbXmMw
         u0RzA/OjL8aHIL9BIfXxp5tj0tX1YHRqourX6+VphT0tgG6H4d/DbUZFTk+A6OhOPz3s
         nCCA9VI+02svE0Y+LAUN7Do+b665w3HMlb4/QogFyHYs9TWoEyhPzlMrulKRRJBfmsHp
         X5pgLPQu15YuXNW2/yFcnUaFvACH3YbbWYCx0nV+xFIi/9Z7eXrjdcvhCCypWmXcrDL9
         y+L6Kii26QSekB6mhC9BUtItabtJ33omKg+22Nyz4KZI0Pr9mR1GzfEfNqeoge9pA/8o
         Kqow==
X-Forwarded-Encrypted: i=1; AJvYcCXa+fjoNdNPk16r3ATy571MkLSGVbHsAs+s7QurpZyBkWwEq2i5EtMy2t27KlrYmClrRQ0wDVQ4X9XLHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3U2ORqjLyTfuodf/AmoworaBU/HzqjQKvZZlTfND6/UrRHNkp
	Yimj6BMBPHJzXcJ/CXZ19Xr6XbpM5dM/BlivnIUr8RqYDrx4Ni0oAypl
X-Gm-Gg: AZuq6aJEA3yN9L2zwUn2tBGItJy9WZ/NqyE9742d9CUrgVZANkTQ2LBK9YDtxmyYRgf
	RSfCWWhZwrUyN8f8WjaAeMIDickcrg3mTWQew2MKkqHMyoUAqr7PzqZv0Lj3IvonSOcLfpREDxK
	End0d/Xd4jBZ7f9aAry790b2CrHhcyFjawrMwUUcLYyAXbgftUtxEfLgtIdEoj+C5ZpHwrJUJCW
	v3QFlVxxRXVpaW23u1VbTyZaFwOewZgQoID453SyQ9bM4heTiOJANBmy7b53dpyilI7sEv0Jw9M
	y55egGAeH7qK34kwmyUPaxrOUNpESAHDR1SRwJWl1iJTFbRj6QtQYjJNNGBSQBcxlOfRWUSrbgO
	9nx+pkL6MwlsPFS77dZ+N5l5BTdJqDTOZDFpijGeUSocbDtf/gbdj5P+abOSXnWLyJyqlR8VLZW
	hYFU8BG4HWR+vuMtabCbqPoNtCMeuAebXbOXkJZNx9RAC7JNq8JJYB
X-Received: by 2002:a05:7022:f304:b0:11b:9386:8254 with SMTP id a92af1059eb24-1244b36f538mr12507910c88.41.1768973661409;
        Tue, 20 Jan 2026 21:34:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361df88sm19588566eec.18.2026.01.20.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:34:20 -0800 (PST)
Date: Tue, 20 Jan 2026 21:34:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Minseong Kim <ii4gsp@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] input: synaptics_i2c - cancel delayed work before
 freeing device
Message-ID: <ztalz7evj3yijuzx7m6yyealexdbfpky3ksughcv2n2ieamvwg@zbudj3q7oga5>
References: <20251210032027.11700-1-ii4gsp@gmail.com>
 <xeski4dr32zbxvupofis5azlq2s6fwtnuya7f3kjfz5t7c2wnq@jbvlajechlrd>
 <aTlmwhOF3zB1UkrI@kernel.org>
 <py7u3qpp6s4nfdceefufkjpbyhkj7wp2kyetlw54vlhdp4gmwn@6vghr6bqkbxc>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <py7u3qpp6s4nfdceefufkjpbyhkj7wp2kyetlw54vlhdp4gmwn@6vghr6bqkbxc>

On Fri, Dec 12, 2025 at 08:38:23PM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 10, 2025 at 09:25:38PM +0900, Mike Rapoport wrote:
> > Hi,
> > 
> > On Tue, Dec 09, 2025 at 08:40:54PM -0800, Dmitry Torokhov wrote:
> > > Hi Minseong,
> > > 
> > > On Wed, Dec 10, 2025 at 12:20:27PM +0900, Minseong Kim wrote:
> > > > synaptics_i2c_irq() schedules touch->dwork via mod_delayed_work().
> > > > The delayed work performs I2C transactions and may still be running
> > > > (or get queued) when the device is removed.
> > > > 
> > > > synaptics_i2c_remove() currently frees 'touch' without canceling
> > > > touch->dwork. If removal happens while the work is pending/running,
> > > > the work handler may dereference freed memory, leading to a potential
> > > > use-after-free.
> > > > 
> > > > Cancel the delayed work synchronously before unregistering/freeing
> > > > the device.
> > > > 
> > > > Fixes: eef3e4cab72e Input: add driver for Synaptics I2C touchpad
> > > > Reported-by: Minseong Kim <ii4gsp@gmail.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
> > > > ---
> > > >  drivers/input/mouse/synaptics_i2c.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> > > > index a0d707e47d93..fe30bf9aea3a 100644
> > > > --- a/drivers/input/mouse/synaptics_i2c.c
> > > > +++ b/drivers/input/mouse/synaptics_i2c.c
> > > > @@ -593,6 +593,8 @@ static void synaptics_i2c_remove(struct i2c_client *client)
> > > >  	if (!polling_req)
> > > >  		free_irq(client->irq, touch);
> > > >  
> > > > +	cancel_delayed_work_sync(&touch->dwork);
> > > > +
> > > 
> > > The call to cancel_delayed_work_sync() happens in the close() handler
> > > for the device. I see that in resume we restart the polling without
> > > checking if the device is opened, so if we want to fix it we should add
> > > the checks there.
> > > 
> > > However support for the PXA board using in the device with this touch
> > > controller (eXeda) was removed a while ago. Mike, you're one of the
> > > authors, any objections to simply removing the driver? 
> >  
> > No objections from my side.
> 
> Hmm, it looks like it is still referenced from
> arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
> 
> Marek, is this device still relevant?

I see these devices (SanDisk Sansa Fuze+) for sale on e-bay, so I guess
there is a chance it will be used...

Minseong, could you please prepare a v2 that would check if the device
is opened in resume before restarting polling? It should take input
device's mutex and then use input_device_enabled().

Thanks.

-- 
Dmitry
