Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF203AE6F7
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068129; cv=none; b=bVnka3g0EdfxqfCJv0mWFqDhRayQceQ2kDVhM+IF1UqpybYtXSEa0WGbCmqA1RMXha2TtokDQfBvSX8ly7RV23n5LsvpNLkFXcLMbAZS5TRpq9iVW2Ju4PpTwEFvXKLt4E4y/d5yX6DxfbMJlhessqIcIzR7gesjTqpfU2vxPoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068129; c=relaxed/simple;
	bh=R2a77mienol5oSjR9Ey7rqCNJgsbwPxCgca0RoU3etw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dZPOq8wvCGgvCPzCPG6eCgtn8MD4cmyRp1bCWnMdsGhXkAASuLf3o52GizTKc9E0R2S8mnxEQefwZWuozXcUoU6Fp138qcFQ58cxeOHuSlImY0N0pmrJbMZqU4QjE9q2+GFGvJzt1dePdfjJpUxRLE1o5qrAxRKYLrYRlSXl3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=oRGTDTZ+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="oRGTDTZ+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b884a84e655so9662766b.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 23:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1769068121; x=1769672921; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2a77mienol5oSjR9Ey7rqCNJgsbwPxCgca0RoU3etw=;
        b=oRGTDTZ+hh7Jcn1+DIlE2CmZaNnFboHA7rHNJCxgwAJhPkE3dnoXze/dfdkcLQ3hg1
         gSeiDElTzqsJCu8HNfIg2Wqc9t1o/T0OgdAIQhYfS5IKBjkzeYvuUsPsmX0UosKQp12q
         jG+SgTrlvb3YbPnDwwjTCbX7vKWsm2oko7ldGkrEEJYBUQfWME9vKXQqc34YGaceTjj8
         pxS0bLHYvyKCvBxcsTGj83GyYDu3IG7Usb08/VWYd6zP5PHQ8eKd1PT9t+RIKkWGcAaf
         TFiGMP13bZpfAb8Y10hGPkdVTHT46KdLxKVqwbXMLHQL+kmQ/jUYq3fkak2cXfU79hiz
         ZuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769068121; x=1769672921;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2a77mienol5oSjR9Ey7rqCNJgsbwPxCgca0RoU3etw=;
        b=BfcTGiFRRqfbobVAsUasoHC1aAr45o6EwzgOFESKzeWP33uUKbigWkDrdBEwm8PpFu
         lWZGL086gre1UF1PESc9cMzXm6kxXZcHVnxuLzl+ar8QZN4Nsn2nD9Ai1xWu5Vwkr7Jy
         e98XFev0eHIV29Lf/Jg7gpiwbBWILvmW6pFFqpliO3QcFo8UidYHnYR1rr0P/SpZjYMQ
         ip2leCsbqdASvhRuDN+l6CJku74b/H90lmVvoogEB7xYyphXJOlvdqfgkXWuQq9jnhBk
         +IAMIFX2jJvwj1kWxM6UTNwqv3lp+aHZfu6I585GWIVJhfgoX5tZphMrw0AS7hphwdx3
         +SMw==
X-Forwarded-Encrypted: i=1; AJvYcCVZWKEqctZMtmHSMScQl0r+ta7YmUstsdWd176OHSVzO+otPZIXN8e0+p2r20xnJ62LEcn7JKeaOpSDZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0qOz8roExpqL7xCg2EN2qN4Ghm2H5Ssu1sA3aNWTwj5WgLDv
	9P6Q8Gt03J/yxgyn/L67kkonHjpGhcMZ9t/aegtfqbY7iPqfKFE4sO/KVm4qMhV/F/w=
X-Gm-Gg: AZuq6aIkN66WLks5G+cwGVvKgpGONJ5zleRmxpGJggvge2PmGzmP11Kr6k7ViXLYX7Q
	ac0zw8Pi6lEGAAZfIH8y+5CkbiYVvaYyMNLS9PF/CR9DvoQr7lS40AIRiUPf5cbPkEkrkvG9RCV
	eGtiCTqdtKda5L/b78poMG9YvVz6ACjxj4kb+v2FffVeKh3ExieyiwuHcoflVq30YrsmVLxEt5a
	ffUsq33plXQi2D/2fx/jJCH19SSb9LKGe8r+mR9Pw5oT3TvtfvhKJmUHLhCA8JkEvlkchTFb/wr
	Wq5F4PlliigjInydK5BSnNAm0W02IjAxpSm6l1it1yB394GwAsbI3deY74UF4OFy2qR/EZVkvET
	mBBgNpsTYlPIOG9unJVExqPhX65Cy7YfUXX1202k7iJthNGjix/tS0kjhaUZhU7CMVvHbHd3t3h
	zfqNbJDn6p9oO1NKRp/gdcHsIzaAthB5brzEVVpBVxFDZj9YDNHx7NdjHqds9ph0qvJ/o=
X-Received: by 2002:a17:906:c14c:b0:b87:6:371d with SMTP id a640c23a62f3a-b8800364d31mr589925666b.49.1769068121412;
        Wed, 21 Jan 2026 23:48:41 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654535c49f4sm15830469a12.31.2026.01.21.23.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 23:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 08:48:40 +0100
Message-Id: <DFUYB761EVX6.35AVTPBTUV0A6@fairphone.com>
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-input@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: milos-fairphone-fp6: Add Hall Effect
 sensor
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-fp6-hall-sensor-v1-1-69275c6bd809@fairphone.com>
 <3a17f2e5-0724-4d70-bd22-1e612142b3e8@oss.qualcomm.com>
 <DFSOPXFSOUY2.2Z6XCLCD796Q@fairphone.com>
 <wpjvuclvpjft7y2rlrmfgszkzmc5vvmohif3etqrtvymxjjyjk@h2dujh5egdvd>
 <DFU439A9HP2H.1Y9OS2OPAXGOI@fairphone.com>
 <t4yjnuty7tmvs4vqzm4vdid7oowicy7hcnmqmu6nqtit3yru55@zpo6kprnarth>
In-Reply-To: <t4yjnuty7tmvs4vqzm4vdid7oowicy7hcnmqmu6nqtit3yru55@zpo6kprnarth>

On Wed Jan 21, 2026 at 9:06 PM CET, Dmitry Torokhov wrote:
> On Wed, Jan 21, 2026 at 09:07:44AM +0100, Luca Weiss wrote:
>> On Wed Jan 21, 2026 at 12:05 AM CET, Dmitry Baryshkov wrote:
>> > On Mon, Jan 19, 2026 at 04:52:23PM +0100, Luca Weiss wrote:
>> >> On Mon Jan 19, 2026 at 3:41 PM CET, Konrad Dybcio wrote:
>> >> > On 1/16/26 3:22 PM, Luca Weiss wrote:
>> >> >> Add a node for the Hall Effect sensor, used to detect whether the =
Flip
>> >> >> Cover is closed or not.
>> >> >>=20
>> >> >> The sensor is powered through vreg_l10b, so let's put a
>> >> >> regulator-always-on on that to make sure the sensor gets power.
>> >> >
>> >> > Is there anything else on L10B? Can we turn it off if the hall sens=
or
>> >> > is e.g. user-disabled?
>> >>=20
>> >> It's the voltage source for pull-up of sensor I2C bus (so
>> >> ADSP-managed?), DVDD for amplifiers and VDD for a most sensors like
>> >> the gyro.
>> >>=20
>> >> So realistically, it'll probably be (nearly) always on anyways. And I
>> >> don't want to shave another yak by adding vdd support to gpio-keys...
>> >
>> > Why? If it is exactly what happens on the board: the device producing
>> > GPIO events _is_ powered via a vdd. Added Input maintainer / list to c=
c.
>>=20
>> Yes, the hall sensor which is connected to the GPIO on the SoC, has an
>> extra VDD input which needs to be on in order for the Hall-effect sensor
>> to be on.
>>=20
>> See page 133 "HALL" in the center of the page
>> https://www.fairphone.com/wp-content/uploads/2025/08/Fairphone-Gen.-6_-I=
nformation-on-how-to-repair-dispose-of-and-recycle-EN-NL-FR-DE.pdf
>>=20
>> The IC is OCH166AEV4AD where VDD is (as expected) "Power Supply Input":
>> https://www.orient-chip.com/Public/Uploads/uploadfile/files/20231014/1OC=
H166Adatasheet202203221.pdf
>
> If we add regulator support to gpio-keys do we expect it to be
> per-gpio/per-key? Or we'd recommend splitting into several instances of
> gpio-keys so that there is on set of supplies per gpio-keys device?

In my opinion it would fit in this case in the event-hall-sensor node,
that next to gpios =3D <&tlmm 70 GPIO_ACTIVE_LOW> we get a
vdd-supply =3D <&vreg_l10b>.

Regards
Luca

>
> Thanks.

