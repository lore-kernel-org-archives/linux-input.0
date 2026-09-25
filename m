Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A914A8B;
	Fri, 25 Sep 2026 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358774; cv=none; b=klqFJh7u6aL/HVJzalSrEpEXVEOyhm50xRJK7qVqz0wnxmWwUM7SFNZSmiLE00cPeaFea+ucX5aTjmiHgoqfnAz5tINjEUr6h+u+OUDRlDUgH7UMurFucqKmKBXjL72Ysa8dHm5i2hS5nru2psB8DHduqwmrRAHYlIBXcrhaWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358774; c=relaxed/simple;
	bh=h2F6Wlrr7DWF4srFC6zkGugGEjHOBZnfF68/9H/Z5rY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=neQAcEHkDqHMX9A/p7P8XHzbkYXI30wo6s3JoLEdQMx5u38G52jsha0ctIaqp+pdZyCd0pZHL6NQzmO9UKmaQlwPlv6ro8x/Rax4dah8e7rAH7h+1CIr0eq3Q5+gUqvWkiYjgfIew2VRhCITSaNgRj81kCbydF7XMr7qMGJMNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dybEE07j; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=6hkU80fp; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dybEE07j";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="6hkU80fp"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790358748; bh=nNXRZZyO5E6gJXFXSSEbRo7
	RUD3G589ViTisRDLWX74=; b=dybEE07jOsSg2uVQbdrgvnpMJTnRpLxDanSAyANWMHaXeM16IC
	g+Oov4sM3WMnWkgiJGGW8xu4nutrv3Tr/NqSZZvIVJ8s9+uiaRf/Typxm1P5yJhO8ZB88O64D+0
	lpOMx0wfsRL/dNzTfD7yiUy+89mL5zAxuU9//TMhic3wpj8yvnmPjWXaTl3gJAlNnSYnYr9KDbC
	NmJFr4eOi9atCKMb2gbjhSGewJ2gXNBKZseJlACHY1NqlMahuFSMUNWb4DNRVxR3qHaIJmrSwJ3
	dpm8w2QjZAy4+1mrqgOGkOBJAMz65Oo/fgW/8jFyNuEMTzdv2S4kfo7lmIfDipvSa6g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790358748; bh=nNXRZZyO5E6gJXFXSSEbRo7
	RUD3G589ViTisRDLWX74=; b=6hkU80fpF18eaotihI8czs8zqTmN9aBl918adzBeqol+4g+4I5
	AX114HYqQ5r0FqT8+yWyI6FklC5LOVeiPUBg==;
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Sep 2026 19:52:27 +0200
From: =?UTF-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
 <barnabas.czeman@mainlining.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: kavakliyigitcan@gmail.com, Lee Jones <lee@kernel.org>, Daniel Thompson
 <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek
 <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller
 <deller@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav
 Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 10/10] arm64: dts: qcom: sm6125-xiaomi-ginkgo: enable
 display, backlight and touchscreen
In-Reply-To: <fe437142-eb1e-49d3-ad3f-704066bea53b@oss.qualcomm.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
 <fe437142-eb1e-49d3-ad3f-704066bea53b@oss.qualcomm.com>
Message-ID: <37bb460f800995ee97b4867e09c04ebb@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2026-09-21 13:26, Konrad Dybcio wrote:
> On 9/11/26 10:51 AM, YİĞİTCAN KAVAKLI via B4 Relay wrote:
>> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
>> 
>> Enable the display subsystem (MDSS/MDP/DSI0), Kinetic KTD3136 
>> backlight,
>> and Novatek NT36672A SPI touchscreen on the Xiaomi Redmi Note 8 
>> (ginkgo).
>> 
>> Hardware nodes added:
>> - Fixed LCDB regulators (lcdb_lab and lcdb_ibb at +/- 5.5V)
>> - MDSS and DSI0 with Tianma 1080x2340 FHD+ video panel
>> - I2C1 backlight node at 0x36 with PMI632 GPIO 6 hardware enable
>> - SPI2 touchscreen node at CS0 with GPIO 88 interrupt and panel 
>> follower
>>   reference
>> - Touchscreen active pinctrl definition on GPIO 88
>> 
>> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
>> ---
>>  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 100 
>> +++++++++++++++++++++
>>  1 file changed, 100 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
>> index 
>> 59042a5937535c4acda064fa0f865f4f5a52d01b..f4b9e2092a814e56cdc23218025cb4166dec110a 
>> 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi
>> @@ -26,11 +26,30 @@ / {
>>  	chassis-type = "handset";
>> 
>>  	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
>> +	qcom,board-id = <34 0>, <34 1>, <34 2>, <34 3>, <34 4>, <0 0>;
> 
> This should be a separate patch with the reasoning for the change

board-id is not neccesary for this device to be able to boot so it can 
be removed. I have already done that before so it should not be readded.
> 
>> 
>>  	aliases {
>>  		serial0 = &uart4;
>>  	};
>> 
>> +	lcdb_lab: regulator-lcdb-lab {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lcdb_lab";
>> +		regulator-min-microvolt = <5500000>;
>> +		regulator-max-microvolt = <5500000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
>> +
>> +	lcdb_ibb: regulator-lcdb-ibb {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "lcdb_ibb";
>> +		regulator-min-microvolt = <5500000>;
>> +		regulator-max-microvolt = <5500000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
> 
> LAB/IBB and LCDB are separate hardware blocks, only LCDB is
> present on PMI632. It provides a pair of pos/neg bias
> voltages. Looks like downstream has a driver for controlling
> this block.
> 
> Konrad
