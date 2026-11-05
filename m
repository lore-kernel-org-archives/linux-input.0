Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910900;
	b=AQjQZtTrZnlrxEK6Mfcizc5CuT70CdIwfObDRMEZlo79foo7LEkjuCmm/vOJInDo0TdN
	 +tlfDkhjmZYYRaIYJ6RAvfZt6sgUEtXGK9IqDBnpQhqY8Wdb4EtobLiYEUADe85JHbyB0
	 VztzIp3rZJkJwmqRzkXmqUcitMYWZHBVufw0PXlfsVR3GxpsawttDWky1eE9CpXQYXQ+A
	 4L40TDCnF2AHunoqVTcLGhGDs3fqN7HPqdnfZYvIvhdb9wPK0/GvFa76U1sVxv/MWIBTf
	 ybfWjqWT4BkoCaPaZDXgWDxKH3WHZrB94wjukNMVZjEkeI1oiR8mvTd34B0/DgDUGlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
	b=NmyK8rrKSiJZzKZkIgE92wKMz+oCefRheM29oz1T7GBNkTzYUBnjusqNdPDguYybXMnt
	 88oHNayeo0zOI0oshWrT5ruixIxMvD1XIdovRQ6WQPNiUBnAkc2msTqIXSXlAba1J50Be
	 bzNjTLBw8e3eW8cpDebxDnsW3WNHF4CydgR3ZpZk7PW4GRgIiNiwjl6FJVRqdx0yvLDBY
	 tOUmGdWZxcIxrDtnWRWw8r4OQRQft9PCEGclNDfBQjivcvM8mteXTiNDaDQYrg7vDyrxn
	 of8Wy0J4Skr+l86pHfFVMAFr+3RYLLRWHmolvTpQEvkNc1ALC+N6lVjzQxKZ5jmN9Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfDV8RqH;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7006606A332
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7006606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfDV8RqH
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae58d17cd9so248479c88.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910899; x=1794515699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=tfDV8RqHdxq2Tir67Fgi3R8YmRMnkFni198pbJyN+2f/wlgyg1u3H/zAskp5NHkOv7
         tIdkAuAZ8WUJ1kMmFVB+y6fHOz8B/caj8wD6aThvegmX02BzNu06iJykZNQp0y6aCkds
         RlikDnWVU951ugzrT3mYdlzvFKlHh7U4jsRYSXIG1h4+jf8Ji6Bx4VcBvQSsJCCbdeY9
         mB7Z2NGEfuJN8Celqb7oNC5peWi2IHdFiN3NSUJbZlwldHAE4GnOhIkhY+aC2WxclROa
         S4gSdge+AsM35XlqkfzkRHJ1/+Vy2cjQlMpoMljhOELSER57fCOwoNKU+WxKYNt0B3OE
         B7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910899; x=1794515699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=QTgfP6ezbc5ADVoQ7gMaAKtENerVwhu1nE9BpuX26qpu9j0l44OkHstLAPtk/YY5M/
         4nE4IiQn7dztj1YGnWP6jV21MF4oSzFdD8OEjOinR61z+aGqINNv7HwlzM9VHnlonD4z
         NS0nFOWC83lG7fu+/NEY9pICu78HWvZHfY5cjjrYSPwa/8zYNui2iYKKMqMF7/5woc92
         dooHWELcs3NaUol+8RSg51Gjq98qeLlZmPiiLkciDLury4Wqws+eUCtp0GO1beUg+Yst
         qO/Gteias70Pgr5ourAqCjV3i14CfHTPg3cIxrm41qllSu4m6oqXfPXjT9Xm9rVyD8g1
         dZDw==
X-Forwarded-Encrypted: i=1; AKwUvBxHDDony5PAHwgm62XHu6BmsD8GaIDfFXFa/42K3a/v9qCYBn3D4v0spB8+H0XD0ngk5nSFKVfdtKAsNA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+5i8WgGhwJ/UW0G96+5kO0AxbeUDDCq5OZjZEPbItYCs5R0wKf
	6XzQv//t5/nOaIt90gOC2gbbBmo7A1aTj6wh4nv4zpm039BNYkYqWutT
X-Gm-Gg: AYBFou0ii3gdGfXFF33ORw/fDAklbFvpGa+/dOmospwtQSGBcb1EAzIObhQEmErQGWy
	d3++NoWxuhGGYWi6SLR0sH6V47oFq5MiFDHwd7BgZqO2zZ+f2DgPVjAmWnYVQHvmC6GMGl98KMk
	qanT5PWMbr/DCmgv1ZeR15Ju48PdsjbY01jLllkZHG+iDdVdFr8ltfQPMobvnwCYNRQtSiHIdRv
	A3jR9NuBOhXEl3YMjyP0KFgkV4kuzLPthNHyR+7j8oreZKAnUGi8+N4nksrPfp9dZZhzyH0v8rh
	TOnZcRvc2BZwjmkhxIPKzK/O1QqZsDevAo3GORMohJ7q/skRiqzfhxojWsNeLUa0ufFp+wpC0AF
	DUIn8j7emg6DnCO8ESnJCyOZrwxI8URcmrCJR9Sq41geIXTPHtckNOIbSBo0Iy+AVtiDmzGD89L
	BMjMH2sFLy4gPFwwRuCdT/Dw+/dKCUyooNOAQRpXsmW/MmYCXNxJiaS3J+QuL7DcQVzQRD/F2rl
	2dPSE9s+Pwh7I7cEAXJfam8a8W7BX0AGasHe1QVFJCAtc+mP6mRqeQFuWPE5YyxiFShcndsIbOg
	05B4j1h7KD1P6AKqNBK+EhN3uCNnvmFJEpM91Mu74cPogeb5ysjRnnvT1Oa+7eauHDH54ug=
X-Received: by 2002:a05:701b:2050:20b0:166:5552:780a with SMTP id a92af1059eb24-1b25d31e5a2mr163714c88.8.1793910898553;
        Thu, 05 Nov 2026 12:34:58 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed274sm649631eec.18.2026.11.05.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:34:57 -0800 (PST)
Date: Thu, 5 Nov 2026 12:34:53 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Message-ID: <auzno3uoL5Pfojfl@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
 <auy2plYVi723Qt42@google.com>
 <20261105191940.GI8298@unreal>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105191940.GI8298@unreal>

On Thu, Nov 05, 2026 at 09:19:40PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 09:05:29AM -0800, Dmitry Torokhov wrote:
> > On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Manual serio binding connects a driver before driver core can admit the
> > > device. A rejected binding therefore arrives after functional setup.
> > > 
> > > Keep the port ID check and use device_driver_attach() for the existing bus
> > > probe path. Driver core then serializes admission and handles probe failure
> > > before publishing the binding.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/input/serio/serio.c | 24 +++---------------------
> > >  1 file changed, 3 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > > index 54dd26249b027..604440244c1ca 100644
> > > --- a/drivers/input/serio/serio.c
> > > +++ b/drivers/input/serio/serio.c
> > > @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
> > >  
> > >  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
> > >  {
> > > -	int error;
> > > -
> > > -	if (serio_match_port(drv->id_table, serio)) {
> > > -
> > > -		serio->dev.driver = &drv->driver;
> > > -		if (serio_connect_driver(serio, drv)) {
> > > -			serio->dev.driver = NULL;
> > > -			return -ENODEV;
> > > -		}
> > > +	if (!serio_match_port(drv->id_table, serio))
> > > +		return 0;
> > >  
> > > -		error = device_bind_driver(&serio->dev);
> > > -		if (error) {
> > > -			dev_warn(&serio->dev,
> > > -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> > > -				 serio->phys, serio->name,
> > > -				 drv->description, error);
> > > -			serio_disconnect_driver(serio);
> > > -			serio->dev.driver = NULL;
> > > -			return error;
> > > -		}
> > > -	}
> > > -	return 0;
> > > +	return device_driver_attach(&drv->driver, &serio->dev);
> > 
> > I am not sure how safe it is, serio (and gameport) have pretty elaborate
> > structure and locking rules because they can recurse into themselves (to
> > support case of Synaptics touch-pads with pass-through PS/2 ports).
> > 
> > But this call is for user-initiated probing anyways, I am not sure if it
> > even needs "trust" handling.
> 
> This patch does not change the locking; the lock was already held on paths such
> as the rescan path. This change makes that explicit.

Does this enforce synchronous probing?

Anyway, I would like to get rid of this special probing in serio core.
Given that the code path is only triggered by explicit user request I do
not believe we need to worry about supporting trust notion here, so
please drop it from the series.

Thanks.

-- 
Dmitry
