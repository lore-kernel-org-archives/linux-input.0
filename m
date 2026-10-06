Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC003E5594;
	Tue,  6 Oct 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294585; cv=none; b=hGKXsscht0n9PWTHN/ZokmnN8VptYZQSGH1auwj/x3uf1LOXu+wtVpQ+aLg9at5whdGBThRWaxNEyDS1HRLnZC5XxZj9tk8jRRLyjmz+dA9ik4S+Lesb03trqRS3RqhMk3ulorZYLs4xO3dO/V+nNIsAN0Oci+ZX5oJJCudCsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294585; c=relaxed/simple;
	bh=uBgbl1rRbaHSomTk5m24hvLxF+0fQvh6cs5qFlMOE6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQFDgx/zbE7cjMsVMXhnUQoykTolrrRwo9VJoMKfqJAgC8dlDP44BcM7B57Vub8v2DE4XtIPhbAx5FS+bJxvuIrPBt78sj0ioVFrEkjxkKId32Se7YDFLFN+05L5DzZHLzQ2JjINC5Kafa1nwfu/FuBjW2CcFaIc+M7D9CcFkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Qo8WdHOh; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=tJgSBLJd; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Qo8WdHOh";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="tJgSBLJd"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1791294555; bh=084aF7ITkXxD+91+eYU3/5E
	pJ1wNR0wYrX/tH5rZlVQ=; b=Qo8WdHOhbFBhjGcAK2DBeF5zjL4nMsPDSwvYD9S2KhiArvQEFM
	WY8QtddBGND8OLFziqm3CsgELKbFgvCqu0XCewzGxxtkD5WQUSBvqLorwCJO56QntphngHMI7v8
	Wef+WjnV2yvxzOWi6MS7/8hcLXl5mkr49GHfi4dKBWktgm8f9G+vbo/W1p/+l/MGHSRGe+v44Cb
	UhTt4FTYdqugrpGbh9mgxZSE/UfHcmHkrCH6/t+fc0qgfzEkJqJ9AZN/5oRxOXAhYpqdRoxnWAf
	aLtqw6cAdQqKC8DJ2urwoX3SRM/UgnXWd1KDqlK3fyzX661AqFJVyKmYaD5ZcsRCd8g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1791294555; bh=084aF7ITkXxD+91+eYU3/5E
	pJ1wNR0wYrX/tH5rZlVQ=; b=tJgSBLJdRRl87bfuSueo6cvzPr3p+Tk9150+EhFYQG1Jt7HU+P
	qSgLHOjVct7K2E6Z6UkrM6zjwQuYOuGnECCA==;
Message-ID: <f0b58a7b-6257-4dc3-b0f3-eba76ecc774f@mainlining.org>
Date: Tue, 6 Oct 2026 16:49:12 +0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] thermal: qcom: tsens: Add support for MSM8952
 tsens
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
References: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
 <20261006-msm8952-initial-support-v4-4-ecdcc1ac620c@mainlining.org>
 <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Content-Language: en-US
In-Reply-To: <suzsbvsdlfrfsnvaerphqdycaaaiu5inh5uw5wups4jmfozkbt@n4lsb5pfdhbw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, 6 Oct 2026 16:19:04 +0300, Dmitry Baryshkov wrote:
> On Tue, Oct 06, 2026 at 03:15:11PM +0300, Muzaffer Kadir via B4 Relay wrote:
>> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>>
>> Add support for tsens v1 block that exists on MSM8952
>> with 11 tsens sensors. Sensor Offsets and slope values
>> are taken from downstream.
>>
>> Link: https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1621
>> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
>> ---
>>  drivers/thermal/qcom/tsens-v1.c | 44 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/thermal/qcom/tsens.c    |  3 +++
>>  drivers/thermal/qcom/tsens.h    |  2 +-
>>  3 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
>> index faa5d00788ca..f4201748ea29 100644
>> --- a/drivers/thermal/qcom/tsens-v1.c
>> +++ b/drivers/thermal/qcom/tsens-v1.c
>> @@ -145,6 +145,37 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>>  };
>>  
>> +static int __init init_8952(struct tsens_priv *priv)
>> +{
>> +	for (int i = 0; i < priv->num_sensors; ++i)
>> +		priv->sensor[i].slope = 3200;
> 
> Where are these values coming from? The driver that you pointed out
> reads them from the QFPROM (like other tsens platforms do).

Hi Dmitry,

Slope is coming from this:
https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/arch/arm/boot/dts/qcom/msm8952.dtsi#550

calib_offset values are coming from these:
https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1756
https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/thermal/msm-tsens.c#1800

Should I drop them?

Best regards,
Muzaffer Kadir
