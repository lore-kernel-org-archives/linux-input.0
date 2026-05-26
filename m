Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E035A388
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819402; cv=none; b=H3LVzijcaZsLYyQS7XY1Rd7TtRIlbtZGJaP2ZZqh5PkFOsfeDShdcWJmbaGkTbhiFK6DG7YXrgEEZsNYzyziSV/xXjC+Vc+SjHKRThIvcT7h6dtu0aRYYScE1p7AqXAkC5FzB3+xH9VwrSW/P0F9AsE/rCaszYMl5Zgq66xS0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819402; c=relaxed/simple;
	bh=IT58hLZh0CvK93y0/dQ3i9r0at7eyARp8xHHzCXTWBk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a1CrLWZAPXOF6jUh3UL/q5BVLRPtbUUng9YJeb8wMDVPV+fVWZfa3RYL94m/9WpTO1hz2V7zWDMzVdYYaUvxorPhmEqr+WYk7orVjvwLargakvs/GAR8yjmeo3vPzNs3pQebPnhM+bCEebodnjTsGAqqllr5ukIk2HtIsllt5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTcYKA26; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTcYKA26"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3664df32e91so12572875a91.3
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779819400; x=1780424200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s/oifU45HMXe7nUWpgXjZ4nh0ttA1REPn6O7MSo0Ir4=;
        b=hTcYKA26DWHqML2kIUkkQnByO10ZGRpIzF0075ePkTS1MSKxPTMv9Gc6sja1FIEvYX
         HTBroSX/mreSdv+kLypmY8wdCotpKYdIGHpJDLTc+9emfTb6bCw36QqgBeKlQJvQmBsd
         O788lBLNb1CWdM2tulL0zU+7sL2HrYDZ1RuitZFOAnS7T1Dh8V2aX6414eI0Mkx2gLk6
         9xLw8a16e3PCxDNbPV9bTFHi+AUaOP7qnKeRg8+0BHfHmcUrSkjSAeN+Rw35mCPo7uyF
         PHQq91flTuQ3koAmgq8tfqIjwhwyn7PcBlQK753++hpcoS14uYs2T1JnsJl+TiC99bIE
         b36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819400; x=1780424200;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/oifU45HMXe7nUWpgXjZ4nh0ttA1REPn6O7MSo0Ir4=;
        b=rB5AOU60swYRXGzt8jedVMsReWerBXQL+oMAwZ4ZeQkGHg5FkecKdpqmrwzGNlJhMn
         HpzgNTHsvJJ2ue9UsCMqQYF9API8HBfpw10qFF9QyT54s+WiMHk+pEb0bPLwY+C4IWjj
         LzdXCFzgVOYTZzvfNIjPywP/eP3w8/v7Qnbolct9VsWzd/624cMJdc5Dr3tUYd/0yLFd
         xrjAOqvp1u6Cj6p/ldtEdQLF4AQBtt9W6uJze4aJzNP8os4G5OgSRHKgdpynJ7jCfKfk
         VVWI7+OnGnNfbMuyheE+tptzzmYad/uSD1vx78P34fWfO3jgvSU3fJ2tnjezkqm3koKy
         X3mg==
X-Forwarded-Encrypted: i=1; AFNElJ82yyG0HgxP/WF6xRBCy+S0PRrnNJ2atIzUZFuJ6NigGRRiw9T0al6RCIcLFwQAhdVnpaT+6ykV/kl6uw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHeMzKlRJRuW4IRijzzj75unvEFBvIRz/TQEPDJ3L53w4ga9G
	58h5KQuf0SxJ5RI8nKA+32DxcFCboVy7RP8Tk2LWS5oIDsJ908cP2y5u
X-Gm-Gg: Acq92OHQt+1Pbft+WKD/Q7PgEJNr+0dH3ay9zSGlH9b/Lcl5Y2Gdr1dazQUowWf+6qr
	ZBCf3G24pwCqnHjhE5Hvib3JxNuG11DWDeuo3GIXA8sfbySMbHhlg9ocJedtI6lF+V4f9jCB1XH
	NamhANuWO8laRUJ3/oG3jbM1VFrG8ubeuPigtwa8TKhFiskGTfS231FlMTZkn6J7T6hZOwhykMJ
	9eiGHjVodLeqTybMK24C6xATsIUlO3oNAxOBwD9Qoq7X4l50id5xrMvSoWUoJHOh6RmKNtU6K65
	mlEO2iOzAuUzAtwev8stlSkqSr4MLb39rQOIhhaHtBpbkyW5dPwzBi9hK8T0g6cpza2q2RQZ8pw
	KAfynnHo7+Og48plfBFS9MPOgabTYinxj9vTi6M7qROYFdkldpLrd0RbWrX5edxuplnDz9uLKux
	LXDb65DqY6EC2vv94q9DITkQ3iAeMU1yOg6MhS8hz/YlBzqITZxrY2WvwQ
X-Received: by 2002:a17:903:f90:b0:2bc:dca9:f0ef with SMTP id d9443c01a7336-2beb0770a09mr232049925ad.36.1779819399983;
        Tue, 26 May 2026 11:16:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8898:e3c9:ac78:ed2c:21ce:161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5903bcasm138658885ad.77.2026.05.26.11.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 11:16:39 -0700 (PDT)
Date: Tue, 26 May 2026 23:46:35 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jikos@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_35/36=5D_iio=3A_pressure=3A_hid-sensor-pre?=
 =?US-ASCII?Q?ss=3A_drop_hid=5Fsensor=5Fremov?=
 =?US-ASCII?Q?e=5Ftrigger=28=29_using_devm_API?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260526165451.6a587221@jic23-huawei>
References: <20260524192943.1196773-1-sanjayembedded@gmail.com> <20260524192943.1196773-6-sanjayembedded@gmail.com> <0a8ebbd2-5de6-48d2-9218-f7b816eb3455@wanadoo.fr> <39A229F0-436E-4AAC-82A4-9B04733E9EE3@gmail.com> <20260526165451.6a587221@jic23-huawei>
Message-ID: <0ECF854F-D979-47F9-8988-3D3E1217513B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26 May 2026 9:24:51=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eor=
g> wrote:
>On Mon, 25 May 2026 22:35:50 +0530
>Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom> wrote:
>
>> On 25 May 2026 3:39:11=E2=80=AFpm IST, Christophe JAILLET <christophe=
=2Ejaillet@wanadoo=2Efr> wrote:
>> >Le 24/05/2026 =C3=A0 21:29, Sanjay Chitroda a =C3=A9crit=C2=A0: =20
>> >> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> >>=20
>> >> Use devm_hid_sensor_setup_trigger() to automatically release resourc=
e
>> >> during fail, unbind or removal of driver using devres framework=2E
>> >>=20
>> >> This simplify the setup, remove goto, avoid manual resource cleanup =
in
>> >> teardown path=2E
>> >>=20
>> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> >> ---
>> >>   drivers/iio/pressure/hid-sensor-press=2Ec | 10 +++-------
>> >>   1 file changed, 3 insertions(+), 7 deletions(-)
>> >>=20
>> >> diff --git a/drivers/iio/pressure/hid-sensor-press=2Ec b/drivers/iio=
/pressure/hid-sensor-press=2Ec
>> >> index fee7dcb86801=2E=2E8438498c9aeb 100644
>> >> --- a/drivers/iio/pressure/hid-sensor-press=2Ec
>> >> +++ b/drivers/iio/pressure/hid-sensor-press=2Ec
>> >> @@ -291,8 +291,8 @@ static int hid_press_probe(struct platform_devic=
e *pdev)
>> >>     	atomic_set(&press_state->common_attributes=2Edata_ready, 0);
>> >>   -	ret =3D hid_sensor_setup_trigger(indio_dev, name,
>> >> -				&press_state->common_attributes);
>> >> +	ret =3D devm_hid_sensor_setup_trigger(dev, indio_dev, name,
>> >> +					    &press_state->common_attributes);
>> >>   	if (ret) {
>> >>   		dev_err(dev, "trigger setup failed\n");
>> >>   		return ret;
>> >> @@ -301,7 +301,7 @@ static int hid_press_probe(struct platform_devic=
e *pdev)
>> >>   	ret =3D iio_device_register(indio_dev); =20
>> >
>> >Hi,
>> >
>> >Looks like devm_iio_device_register() would now make sense and simplif=
y things even further=2E
>> >
>> >CJ =20
>>=20
>> Hi CJ,
>>=20
>> Yes, as mentioned in cover letter most of HID IIO drivers have potentia=
l and will converted to devm based driver gradually=2E
>
>This is putting a lot of churn and many patches on a critical driver
>(given this device is in a lot of laptops)=2E As such I think it's fine
>to do prep for devm in separate changes, but the final per driver change
>should be one per driver to go fully devm rather than doing it in smaller
>chunks=2E  I obviously want to see this well tested, and don't want to ha=
ve
>to keep asking people to test 'the next' set of changes=2E
>
>Jonathan
>

Hi Jonathan,

I understood and agreed with you=2E To add devm API support we have common=
 separate change and on top of while updating driver instead of updating a =
single devm, I shall update all possible driver to devm=2E I think we can k=
eep this series for few time for the review and next series would incorpora=
te fully devm change and also attempted to use b4 to handle long series=2E

Later in that we can plan to proceed for testing instead of partial devm d=
river series validation=2E

Thanks, Sanjay
>>=20
>> Welcoming all suggestions and especially if someone can validate and ha=
ve Tested-by tag=2E
>>=20
>> Thank, Sanjay
>>=20
>> > =20
>> >>   	if (ret) {
>> >>   		dev_err(dev, "device register failed\n");
>> >> -		goto error_remove_trigger;
>> >> +		return ret;
>> >>   	}
>> >>     	press_state->callbacks=2Esend_event =3D press_proc_event;
>> >> @@ -318,8 +318,6 @@ static int hid_press_probe(struct platform_devic=
e *pdev)
>> >>     error_iio_unreg:
>> >>   	iio_device_unregister(indio_dev);
>> >> -error_remove_trigger:
>> >> -	hid_sensor_remove_trigger(&press_state->common_attributes);
>> >>   	return ret;
>> >>   }
>> >>   @@ -328,11 +326,9 @@ static void hid_press_remove(struct platform_=
device *pdev)
>> >>   {
>> >>   	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(&pdev->d=
ev);
>> >>   	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>> >> -	struct press_state *press_state =3D iio_priv(indio_dev);
>> >>     	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>> >>   	iio_device_unregister(indio_dev);
>> >> -	hid_sensor_remove_trigger(&press_state->common_attributes);
>> >>   }
>> >>     static const struct platform_device_id hid_press_ids[] =3D { =20
>> > =20
>
