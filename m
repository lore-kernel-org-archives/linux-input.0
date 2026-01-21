Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA492F39C7
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982876; cv=none; b=Z7P1+EZOfYe4mdUvFKwPhD9VLUMFDFZZBykbsf18RL2tw33vjFr98yHd52IksqMwta81VNDfEJ3yHBV/mFK+C7vgm/CVx8ZTaFt/cb1hZpil9Sv7jgO+jScaz3nXvU2qFLTWJyFuoB/7LohzAxScrYNmGPD+Q50773JwskcSQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982876; c=relaxed/simple;
	bh=3QmWU1nQquntEBkGyUahuJHSNU1fH3YnYf4oeatEaHU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BZoK9tcICredsVYyYqzwn2ygghFXwLSl1Elx6a8cf6IbSYEIzzr+Yv6hfiBxixQGe2ICCnKJur73k/5HGLrARGJl6sWKnzw/nUnH3z9V3X5Wmd+bA1IKfFhgsGxW1a491KLu/7lmUvN3snfZ03u7jGYwQ2IJEu7MToCNTX857TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zRcEPuw7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zRcEPuw7"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso862508566b.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 00:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1768982866; x=1769587666; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPEP1SMp69TkYfNcwIUjvNwM3iPh7BaIDcXmXmOoS+Y=;
        b=zRcEPuw7meIxL2jvkQJmTkd2p8t6IdmF6Ea0+305MgnOAO81WTGonj2RoEjpH0aXSb
         X6PbJbC5DKlS9R8RsRbpcYUGVe8T7pjsC1WBRpQXI9qe8jFAPfPy+AjW/J9w9exJ/UfR
         hHAIyVt0P4i/ZULvH/+H0o4rK4JmseqTmQqdyJad7YhgnTFtIMu1QCjeLp8S9KyI4l9W
         TR5qGc0k1DQwDt9GVnALsB/l4wc4LT4ZGny/IcvhF5pFifWXLJj91gTfnTZWoC/1yxy0
         ZBZwSeGr0RN7CprK/W0Vgp9vWm33NE1u8yDtSVs4EkFHxuRQNMebcgHyOuI89ocKP+DR
         +Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768982866; x=1769587666;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPEP1SMp69TkYfNcwIUjvNwM3iPh7BaIDcXmXmOoS+Y=;
        b=JQkzRk9wlON3kbODEWpZvvOWOvXX+1EVw4Q4fTypKUqE5wrPX3joleB1IEH25LEnb6
         280pqlZCRoRAWWFYGK1G3I//ITU36ZtGjqhACAzgqIRHbNj/C3W9mxP33okI4Pn6VqCg
         eIKYjji8WETq9yEeFUjVOt3StmBkl9P/CQbDSko3rJ4ZUVqn172UNwAiAZeZqvOpU6O1
         lFqgR7aYu9+eOGJwnzGYPQ4pP4ZHXEQq3G8ZcVvP24USXetRM5NO2yyn/T+3N0iF+dgu
         TSIUNSf8RAP/wv6ByfzPI1log7EZP4A+aWsd0dnMSwFYdkn7itldKYE4Vz9lJrZxaTnZ
         vCww==
X-Forwarded-Encrypted: i=1; AJvYcCVrktu6UEf/szFggCLQChBUn/RRdKP6Bm6539QuZrKF3rqv/yr7SOG7q/57RFJosF611tI7dQXb97YhTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgr76WI7WSJEYud5i3GVTM5EcYCMKnBjT2LiaAGDWFIYU1zGbb
	OroAJds3zRKC4GwkEoEsEqthkRHvJNYj1quH5UaJhg21yc+iiUG8lXHAUnNkYB/KdUk=
X-Gm-Gg: AZuq6aIhDGaeTr95xecHgUd8LRSMMEJ9YWuyve9OK969E6yNOelo+JS3uPDUYXBgFm0
	YbeFYtj9pCz8Kc5eKdd8YR3vUm9DTmCdecOyj4NRY01GCuf1/ptLIGcFrDtp92SspcrhBSqE0Ut
	77Wk8PUns5Gn3ztR4PXwEEV5L4WobU/DNt4cYc0YUm9kOYe5TBYWDTYcnMXHx6prMVTby3CfpVt
	9HSbJLeVKJs+cGXfNgTcE/viz7xnPvUjQybh2ZaeAC9eRxQcilT1N239cT5sMtxeCv0K5IZtAVH
	BaJ5Kbgie1X6j4DRzpXyM7mcvXuP+zfhIlbVjnKkYJclyPIMUYg2UB2BNAij7Hf1C0jR53ckqm2
	cFFYKyyswDXlVqbCxTI5lwtn6RuywcTQcV9ldvFcH43Qwyfl4LYYqJaYTUiWdmSgaMvFeX814ng
	HJxDkVB8Piza7VcFH/h2hV0l6Usg5IV7zz95RN+qXsK2AtJhJ+SgJGXUcA
X-Received: by 2002:a17:907:6d15:b0:b87:65c5:602f with SMTP id a640c23a62f3a-b8796afd5c2mr1453311666b.34.1768982866518;
        Wed, 21 Jan 2026 00:07:46 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e8d1sm1587021266b.2.2026.01.21.00.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 00:07:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 09:07:44 +0100
Message-Id: <DFU439A9HP2H.1Y9OS2OPAXGOI@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: milos-fairphone-fp6: Add Hall Effect
 sensor
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-fp6-hall-sensor-v1-1-69275c6bd809@fairphone.com>
 <3a17f2e5-0724-4d70-bd22-1e612142b3e8@oss.qualcomm.com>
 <DFSOPXFSOUY2.2Z6XCLCD796Q@fairphone.com>
 <wpjvuclvpjft7y2rlrmfgszkzmc5vvmohif3etqrtvymxjjyjk@h2dujh5egdvd>
In-Reply-To: <wpjvuclvpjft7y2rlrmfgszkzmc5vvmohif3etqrtvymxjjyjk@h2dujh5egdvd>

On Wed Jan 21, 2026 at 12:05 AM CET, Dmitry Baryshkov wrote:
> On Mon, Jan 19, 2026 at 04:52:23PM +0100, Luca Weiss wrote:
>> On Mon Jan 19, 2026 at 3:41 PM CET, Konrad Dybcio wrote:
>> > On 1/16/26 3:22 PM, Luca Weiss wrote:
>> >> Add a node for the Hall Effect sensor, used to detect whether the Fli=
p
>> >> Cover is closed or not.
>> >>=20
>> >> The sensor is powered through vreg_l10b, so let's put a
>> >> regulator-always-on on that to make sure the sensor gets power.
>> >
>> > Is there anything else on L10B? Can we turn it off if the hall sensor
>> > is e.g. user-disabled?
>>=20
>> It's the voltage source for pull-up of sensor I2C bus (so
>> ADSP-managed?), DVDD for amplifiers and VDD for a most sensors like
>> the gyro.
>>=20
>> So realistically, it'll probably be (nearly) always on anyways. And I
>> don't want to shave another yak by adding vdd support to gpio-keys...
>
> Why? If it is exactly what happens on the board: the device producing
> GPIO events _is_ powered via a vdd. Added Input maintainer / list to cc.

Yes, the hall sensor which is connected to the GPIO on the SoC, has an
extra VDD input which needs to be on in order for the Hall-effect sensor
to be on.

See page 133 "HALL" in the center of the page
https://www.fairphone.com/wp-content/uploads/2025/08/Fairphone-Gen.-6_-Info=
rmation-on-how-to-repair-dispose-of-and-recycle-EN-NL-FR-DE.pdf

The IC is OCH166AEV4AD where VDD is (as expected) "Power Supply Input":
https://www.orient-chip.com/Public/Uploads/uploadfile/files/20231014/1OCH16=
6Adatasheet202203221.pdf

Regards
Luca

>
>>=20
>> Regards
>> Luca
>>=20
>> >
>> > Konrad
>> >
>> >>=20
>> >> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >> ---
>> >>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 12 ++++++++++++
>> >>  1 file changed, 12 insertions(+)
>> >>=20
>> >> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/=
arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >> index 7629ceddde2a..98b3fc654206 100644
>> >> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >> @@ -32,6 +32,16 @@ gpio-keys {
>> >>  		pinctrl-0 =3D <&volume_up_default>;
>> >>  		pinctrl-names =3D "default";
>> >> =20
>> >> +		/* Powered by the always-on vreg_l10b */
>> >> +		event-hall-sensor {
>> >> +			label =3D "Hall Effect Sensor";
>> >> +			gpios =3D <&tlmm 70 GPIO_ACTIVE_LOW>;
>> >> +			linux,input-type =3D <EV_SW>;
>> >> +			linux,code =3D <SW_LID>;
>> >> +			linux,can-disable;
>> >> +			wakeup-source;
>> >> +		};
>> >> +
>> >>  		key-volume-up {
>> >>  			label =3D "Volume Up";
>> >>  			gpios =3D <&pm7550_gpios 6 GPIO_ACTIVE_LOW>;
>> >> @@ -316,6 +326,8 @@ vreg_l10b: ldo10 {
>> >>  			regulator-min-microvolt =3D <1800000>;
>> >>  			regulator-max-microvolt =3D <1800000>;
>> >>  			regulator-initial-mode =3D <RPMH_REGULATOR_MODE_HPM>;
>> >> +			/* Hall sensor VDD */
>> >> +			regulator-always-on;
>> >>  		};
>> >> =20
>> >>  		vreg_l11b: ldo11 {
>> >>=20
>> >> ---
>> >> base-commit: ef1c7b875741bef0ff37ae8ab8a9aaf407dc141c
>> >> change-id: 20260116-fp6-hall-sensor-1049f2f872ac
>> >>=20
>> >> Best regards,
>>=20

