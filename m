Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898335;
	b=Z0Xn0k38SFqDP3wIToG+Sbr++eCoMMtRzCkVHPBG1ZhzV3r3aF2hLkL2n0Rg8c2a6oyu
	 fQaOs9/usqBj1QUVrqp/sy8NoCOPwPL3Yiu71kkYvUQjLYgeGv1bNmcpYoa/vbMiI2+Nl
	 iZoIeTMAwcGymwDaCSOY/3fPBoTFV+SyQuI8XLFoUHdqOTt9DaSJljSEipMvk0AY49+NK
	 b77Yo1GWvHpE+Vk8H21ROWFJ/61k7V5DZTyNvseUSvtty+Yiyl/FTMh/YAFrEk6alHTWx
	 pvlWqm7vh3ROwpihjS4H6tcUbpONohLcMmF4+r5vWaRq1zMjCyEF738rApUjaUjUqfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
	b=YlmSCUV+Bv3rk2AE3KmjLR9AqFvJxACIjHMOBGiAmw/zOYLCfccDjkP4aV7S/GgCz3HF
	 PVtY9gv+OBD6QNJmtgQwauGNZH2tpiSPH5TSzTMgRE33rnDepVbbMZUGMaFUHvgLH8Fg4
	 dE6xcILdXXYmePPYNbhcIU5GHId1nJVD7e38u96uFXL+Ku4O3dN0yrXtuX8+It8VP0LQ9
	 xSYHScR3JUJiQocbxwykqpO/H8ZnKo1kBFAzS7xkssVCaT4+7tvJh64K4cNl5DD8VNMhw
	 uSR88Xp2wdqq40DM0vcAPs96KkEIunsr/vfoKrdIU7nDVpSAzyCy9AbyUb3ROk/9vTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DF606D806
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951DF606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3516054eec.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898335; x=1794503135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=ezhGUhXoIUl09y6+rx0VThMrADfNJzLtbjELvheIq2XUjEVn+F/n+Ri2C53TV9L6Aq
         JdGhkEmCnwmkPVTv0OB6x5RGwGBQJHUjt1KyKJv1eSBurgKo52RA3J8/QRIyxJZsDOQU
         n7s5HLJdofzUUsrlUP5HhN1OEHjO1pTWgNUtwsTp5+pkRYp1fI+C+uqlY+LxQRirvNrb
         Ex3MFhTRMHWMTtME2TIEuo7EsT/3ZplABIXud7NOWlPeo0lDAdVbld/IOwaCZ8vfz4uj
         z22wAGLVFJBUWinFMtheNWfoQbFjMbEjptQEjYgl4R/mPdYwQwSpcnETlWlj/Aj3CrCr
         m0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898335; x=1794503135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=c2iHDHivvCTE+bFPZ8xdllTlXPLxnoObPXN5HB9NE/B/RTDLL60Wpq0LK+eXyDzgqD
         XxcTWoSTep+JDBDZz2tMCCktf9IbZMMk61qBezAOXfVKGc4n5d+Fr5au8fg8iriTIrIy
         V02JMjdewTuVkJA3wwL7p4wqA0t2MvgFPdxij8QJuv8Dtpfy9/g4E7jYX0GJyydGfP0x
         a7wJSrNNAYURcKvG6o87WX5PXAUvOMCCLTWomT0Qpp3/iC0XCFBGEJAR5ihxPYyLz0zf
         Tdl66KYnlsgUA2mZsIHjoarJ/X5r40SdROC1NV7UxCJ0bm9AKUwhSQk0h83U1lGgoqZv
         ghbQ==
X-Forwarded-Encrypted: i=1; AKwUvByWjTmOZCwPbdxX7sxLk+ec5yE3AbTzYeYOUkkNkPZtjD4HZLBm64XV9bXJiCWs1pNdgxwdEXY7NjR6Ew==@vger.kernel.org
X-Gm-Message-State: APuU4Z+uyzIMArQzXfgGt2htOHbQaSbQambeTuNG43nd8249OkEss+Ka
	pv0bsgU+SxOV04Tty+LPItRMOVWVqEGWNMs43SbekEs3EB67ANGsa8KE
X-Gm-Gg: AYBFou17M4X1J5UyinaZL0TC0MOlmM6a0EaUljpReK/jAHfQIN14AvkxLyTMauTA2vG
	6L/XoAunYziAvzdieyn0Ti+XYW99BOtR0gv1Ymi6FMwpqRPSpni9kOMrH31Qk/MyURo/dfsTpW0
	gBapyWTZKvxV6rcnvqfzXqnxTAy0lQ7uXAfHqkNs5hOfWzdivkaNZQbicy+ewRxKIe+AFV1J2Bt
	xxcagzQm3Ky83XuqToNZ7f79siExQVEntFBkwojI9iIxjKMcIHbXgA9hBCOCUbb+kjvZ+N7b005
	0IhUztBo1aXoSixV3iwchump2p4v4vGgESbh8qgS8TAcS0Inh40ViORbRFcrKUXnkfCto+miW5o
	eZHqCVJHeVMqcmHMRUsI08gsozQ5Aji/IBwr4m7rIUTBWkW4bUJZlUENl0ohyAmjj231ZB74uqf
	bHte+YwcR3WQ4YUoxCqHlj4Y2G2dbhBEmj+H3WhbYc9mYQRww0LIkpaofQLhM/gZXAzTAPwVw3x
	a1jCQ0nISqXsDYQysARulnbwRQUUsyTZ6W25x74LZH47r37670fndXNDh0UrA/Q37GMp1KC8Y8/
	HWif1is9lBQVomN9jDELCxUX7buWbn1xx6rkWrF/3ksj3CzYnt3ZVQ0KPzVrVYauNUz9xtqeUQh
	sGpXGCd65UGqk2QM=
X-Received: by 2002:a05:7300:fa0d:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-36d7feb8e1amr5835338eec.11.1793898334471;
        Thu, 05 Nov 2026 09:05:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm23943795eec.25.2026.11.05.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:05:33 -0800 (PST)
Date: Thu, 5 Nov 2026 09:05:29 -0800
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
Message-ID: <auy2plYVi723Qt42@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Manual serio binding connects a driver before driver core can admit the
> device. A rejected binding therefore arrives after functional setup.
> 
> Keep the port ID check and use device_driver_attach() for the existing bus
> probe path. Driver core then serializes admission and handles probe failure
> before publishing the binding.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/input/serio/serio.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..604440244c1ca 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
>  
>  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
>  {
> -	int error;
> -
> -	if (serio_match_port(drv->id_table, serio)) {
> -
> -		serio->dev.driver = &drv->driver;
> -		if (serio_connect_driver(serio, drv)) {
> -			serio->dev.driver = NULL;
> -			return -ENODEV;
> -		}
> +	if (!serio_match_port(drv->id_table, serio))
> +		return 0;
>  
> -		error = device_bind_driver(&serio->dev);
> -		if (error) {
> -			dev_warn(&serio->dev,
> -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> -				 serio->phys, serio->name,
> -				 drv->description, error);
> -			serio_disconnect_driver(serio);
> -			serio->dev.driver = NULL;
> -			return error;
> -		}
> -	}
> -	return 0;
> +	return device_driver_attach(&drv->driver, &serio->dev);

I am not sure how safe it is, serio (and gameport) have pretty elaborate
structure and locking rules because they can recurse into themselves (to
support case of Synaptics touch-pads with pass-through PS/2 ports).

But this call is for user-initiated probing anyways, I am not sure if it
even needs "trust" handling.

... And I even thinking if we really need to keep these custom
attributes or if I can rip them out in the future ...

Thanks.

-- 
Dmitry
