Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484733B97B
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785703311; cv=none; b=OfHbeFIwP0FDkMBufu7GcwN+DsdHaP/1S5cbxrQ0IA6gp9VXeu7TV0E88kNpOCTsWWVoOSIyAkTkZS8ETUjC5iegsEbtfv+Z4qaUs0zYRSbatggp6lP+uUUYZgb3+rHJDd4TUDT1RUWc8YdUeMRAPf8hWWZWppUk0BYs04r6IsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785703311; c=relaxed/simple;
	bh=mdAaS/ICydQwFtXsmVmKdsLGrQQdGzTBXbVf6wf941k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTzLuRxSrgIJAvFwU28rNldkIPhbahJtagUasyav3YeXUnIxmPPIpgCZIJDaZmG6UuUw/A1p74NBLtqAu7kIb+wZ4lE6iIe5taNqINSiLsycq2O20Jidd+50km85AB/Mh2luq8auTxPXF5BAe+fAneSPmoB3JZ1LLuLIr3yOoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu9SJvkz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu9SJvkz"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f611b3af9so366048f8f.3
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785703308; x=1786308108; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMvC+Rujpi9rjCvTJL9hyNOIokIpUH49tZ8qOu+YRw0=;
        b=Mu9SJvkztuEjyWA/kpIOCesOfkzTA4iWreFEmqszFn+Tdw3g+C7Rves3gVTnqbxXwq
         EI4g983IRqTWw+NDtnoiSSgiR/kdRAq/Jxb1E9RB2HiTWpK+m1i6iX1WSi5EblhfIgtP
         RxxbDO8BaGaIT3aDam0h1xBQFONrETlg+13rAC2V8rOFPY/7awkDZQuLHHI+vlSxIxrL
         1BAVlPbAq31speeXexroWNwzlg3fAyWUojC6giicxrX83M2eqc+TtowqpgNYc53Gdnoz
         TPrhD67sWnWvoekwGQFUbWUwDbXt11mKlB+xB/XEhpGf2odl0QYHGLtYV0Ko2QrSHwIM
         nXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785703308; x=1786308108;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AMvC+Rujpi9rjCvTJL9hyNOIokIpUH49tZ8qOu+YRw0=;
        b=alqD62HOmiSbNXv/bIK/cjLS2tZtX8xX4Ue85TBahm9BueRR5Wl8ZNwEWq33xf7NDV
         mnUKXjPI6vIiXDtH8pr5DZ+MA5oUWg7y1wQsZJE0LDVYoFJ2qVy12LeXw3Vq5oeKCZMh
         WH0gQwPnlUQWd0rVGgpdcCKeIHefX5liobxUwFbfslsZrntCA2GXmdDP89MpiJlspwki
         DLrCe7k0iZrtBRNRB3bbDTTTAT/k/bz7yCLZWV20s2qykGXKo7ncIU+gxpob1nnlxH69
         yLZ8iYOQS+aKaJlmx0ePiYFmj6QT4vqg8jFb6EKyolWb9FbQHy/uXePd1jOGFgu7bDtz
         VB2A==
X-Forwarded-Encrypted: i=1; AHgh+RpnoqK3gWJj4LArH3eoiWiAqU+6w/9gn8B6VSU9npIp/9p7vNPVVAkP2ytpSne/UO8umk09/g71sZBdlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDb8sle97aiu4McrUhn+6gD6Yx1Ju3OLA7yZV1so/9TJfaGo0v
	ThcGcnmQO073EUdWweC/NyHWAUTnAIx9bdjfT9oVtY2FbibPIucuKY0f
X-Gm-Gg: AR+sD11O/fDQR50DQqzGfhsHBxnqg6IkYpTEJyhSJNFbOGw4RkSkJeBUHzZ4pWbpGnR
	tPLqgit7EJ9JQPMU4lK25jcWJRArVLf8DRDxLUCeb71mJj4P5GnkIwvFVc8rplVhkdxBlJa53jh
	eWMAw/hJ7KkUJbhDUocYmK43UoQtvNVWnFU+i8blaXQqJUG6GRUKhlgDwi5Gg1+nkXAJ/T1wAEd
	3Pe4l/mnw1dUtDQUFmhxuk0XSUwHnWQG3Rfix8xvzlLosX2UiOIrL9COQMZVm6+BZN9QimtcVmr
	AGZ1ek7pPL8zMpumZu7OuCGJt20GhpsUDvxshehwICEfREBPX0jGntkzYuzO2SE4Ml9TCgYCOHL
	sggaBP7OSRP+B7eidWwzcjVN+JZlNOOb6/RUQqiDf/OcVrfcLdJMas7o2p4VDTe1j55BJXpRtLL
	kAhM84JZJLYpzkJP7wIE2UXFiqFyIHe3RGg9FrnW+lvSWDY8B6Z7tar4y3+s4roTxmSQDceGUsr
	IKFBVBaT/pd97cGKPYES5IVsg6URWXQjx5HCb5pkOR4Ida7
X-Received: by 2002:a5d:5f42:0:b0:47f:7e91:3d55 with SMTP id ffacd0b85a97d-47fd72e70eemr11042359f8f.2.1785703308035;
        Sun, 02 Aug 2026 13:41:48 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458adc9sm28027572f8f.27.2026.08.02.13.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:41:47 -0700 (PDT)
Message-ID: <9ce239858b358c60a243e34f2d61def2f986966a.camel@gmail.com>
Subject: Re: [PATCH] HID: universal-pidff: stop the device when
 force-feedback init fails
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Baul Lee <baul.lee@xbow.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Oleg Makarenko <oleg@makarenk.ooo>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires
	 <bentiss@kernel.org>
Date: Sun, 02 Aug 2026 22:41:46 +0200
In-Reply-To: <20260729142432.16184-1-baul.lee@xbow.com>
References: <20260729142432.16184-1-baul.lee@xbow.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 23:24 +0900, Baul Lee wrote:
> universal_pidff_probe() starts the device with hid_hw_start() and then, i=
f
> force-feedback initialisation fails, returns the error through a label th=
at
> only does "return error".  The device is left started.
>=20
> The HID core does not unwind on the driver's behalf.  __hid_device_probe(=
)
> releases the devres group, closes the report and clears hdev->driver:
>=20
> 	if (ret) {
> 		devres_release_group(&hdev->dev, hdev->devres_group_id);
> 		hid_close_report(hdev);
> 		hdev->driver =3D NULL;
> 	}
>=20
> The hidraw character device that hid_hw_start() registered through
> hid_connect() is allocated with kzalloc() and added with cdev_device_add(=
),
> so it is not devres-managed and survives that.  With hdev->driver NULL,
> hid_device_remove() skips hid_hw_stop() as well, because it only unwinds
> while a driver is still attached.  The registration therefore outlives th=
e
> device on both paths.
>=20
> Opening the surviving /dev/hidrawX writes into freed memory.  KASAN repor=
ts
> a use-after-free write from hidraw_open() -> hid_hw_open() -> the
> transport's open callback, which takes a spinlock inside the freed object=
.
> A descriptor that carries a PID usage page and no input reports is enough=
:
> hidraw claims the device so hid_hw_start() succeeds, while hid->inputs
> stays empty so force-feedback init fails.  The other failure returns in
> hid_pidff_init_with_quirks() - no output reports, an allocation failure,
> pidff_init_fields(), pidff_check_autocenter(), an unusable effect count,
> input_ff_create() - all reach the same label.
>=20
> Stop the device on that path.  hid-dr.c and hid-emsff.c, which start the
> device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, already =
do
> this.  The two earlier gotos must keep returning without hid_hw_stop(),
> since neither has a started device, so give the path that fails after the
> start its own label.
>=20
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
>=20
> Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported d=
evice ids")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  drivers/hid/hid-universal-pidff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universa=
l-pidff.c
> index 549dac555d40..60180467a0bf 100644
> --- a/drivers/hid/hid-universal-pidff.c
> +++ b/drivers/hid/hid-universal-pidff.c
> @@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_device =
*hdev,
>  	error =3D init_function(hdev, id->driver_data);
>  	if (error) {
>  		hid_warn(hdev, "Error initialising force feedback\n");
> -		goto err;
> +		goto err_stop;
>  	}
> =20
>  	hid_info(hdev, "Universal pidff driver loaded successfully!");
> =20
>  	return 0;
> +err_stop:
> +	hid_hw_stop(hdev);
>  err:
>  	return error;
>  }

Actually, now that I look at it, this isn't the only place where the
stop should happen. Any error after successful hid_hw_start() should
trigger hid_hw_stop().

So for this to truly matter, you should replace
	return 0;
with
	goto err_stop;
on lines 92 and 101. Just add error value clearing so error =3D 0 because
even though we're exiting there, it's not an error. Some devices just
show up as multiple separate HID devices.

Tomasz

