Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0037A4AF
	for <linux-input@vger.kernel.org>; Tue,  3 Feb 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112184; cv=none; b=ROAiSAmBubzMPhKPpFHBPvl8Ykd46K0Sov2rcjHzT6Owr8ze+WWcAchdtNvF2Wmh030WRFfFUAc6iPne9kTBhccUPkFeBMC/c158vD8XYuIaFzoPpu9P9gwQpnKNpxgJol8nc3UDxmlsAxIzsAYSni9p2Boltfedn/Gl+Bi5wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112184; c=relaxed/simple;
	bh=8U2aCtDoyNBYX4tZKHQggHHtkY7qa/5Oyp4XlYpfO+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlELufR2hl/E0Ann//UC4i+YRa1K7KLLpfScd4W5i5LiYNLABrrm05N1YNundF5J9PBGEq61glMwVDiCkDz3f0ZCgxp35qZAAxFOIhdmEEerjtwtL1RWdKyo2BqM0h+LWjXMG4e1uvcvoInM1CDbPTI+Is0omS7nBoVP9kL7cTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jill0SN1; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jill0SN1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b74f839bdfso409515eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2026 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112181; x=1770716981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFGheamZ8aEsx41A3zYIiu3pbbEmnChDtUyKtntCxg8=;
        b=jill0SN1eeRBRqttmfdbyB8JyqUzyvw5o/zdJMdiVB1o0GmX5q8qVTKfQ5SdLiBRs+
         80gD0NTOtc6AZcF6zhW776koo579ws5srE1ryLki4+YoecztYvHxhKKmxXUuzgdRvnRX
         szxUJiVAu5Sn9Ux9du+stgQgtRU3+KkNWLDYVhVd2C6LcIaWuj8ghplG/i++fWZfuaj/
         K4YchJrIdNVLh5/soeiA3pwgkTOpGXTjmLHIqRrsNQXban2yLMug1vWaBVbsyiUvTsD4
         l4zFron18oMZbr5PEIDNmyETxdgvlsI33d1nr5N+JEMyuyv2iYOFRuozlpsKslcVwS16
         VE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112181; x=1770716981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFGheamZ8aEsx41A3zYIiu3pbbEmnChDtUyKtntCxg8=;
        b=CSjl5cTrzfYZs+N7hOu8mye/1fWwPZKKbQ2uPq/B1gSbdZJYnk526auHamNlZh9Hu6
         IFD5i/uFImAnFLCleg9q9+sAXJaJSR16ZgOlfigioZB741VWJqr/olTr1vG3oWEy3jw+
         L0mF1uaSwfhIMqmdwkHqy2LAfFVwYpy6iz4by5chfpEJbi3sg+H2ac/d4iVkKwfHh/t0
         WAzuUcY9q8NxXGCnXlR3xfVX+0KJRP8BQ8QqvqbSn8lglzJG9v6Y1lvv7yHF6bYN5VAr
         O7M9P1Z0s/H+NE7Z1MF39JrLmOZsVH+vgkfTJyJY/lgylOLOJbGCHk384Y6S2LA5cL3i
         HtGA==
X-Forwarded-Encrypted: i=1; AJvYcCUdXKPwZWK2abpVjSUkFadejeGU0d5U20e5hQS9NwXpYjbJCS0egAwM9yowjI9t8jOGaIUNLP30/+54ZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQK5m5sIaMPdBbhNgZT45WJvP4cX3s3OXc1kD1qDDijFFPu5wK
	CERITrx/A0Jx1QQzt0uOSdjaW5tj/tszqw3vaU35QUG7N3UQTVdqc3HY
X-Gm-Gg: AZuq6aL6DSmFBxtis0ZJugBozgaDJVYLwX6A+ycOs9IHoqgoXVPtxn6VKeUN71tB9xq
	ec+feMNGsYEYiWUZk551NKyn16KL4UB7AoPbVL5ITsv5wGnX7TKxnazQBT7F104mnqp/X+Eco0q
	opb6U30dt562I7mihNvFn3CyRADVEv839yPbsdkr+ZI6f7QWSwU8j6sqjvwuOSZ0yWuccs008mU
	y/RzjofWwd8HFHVuLhFja6WHR5z4t5nqY0viox2Oa1Z7/Mowzhpe8QNfGlPchX7yViYIylU8rTJ
	V2/h6fuhUEun1jKJ/iBR4PLSeUX83oUCSFiEhm/nsflUUQVxTJz6dg8yxrOJn5HeI7kr0+XvC58
	wyM//waicLdIqMlBpaMrJWscZ3xAsa2h0SJlMi3clL7OgsvoHaofWc7ahiyyjjeop+S7rIP7ZW0
	MOK8aXqWcpVUUSmL2fIm+NzNOpAj5BE34LUZR4Z0A4xLBYD4lW
X-Received: by 2002:a05:7300:214e:b0:2b7:20fe:821d with SMTP id 5a478bee46e88-2b820eae81cmr742075eec.10.1770112181077;
        Tue, 03 Feb 2026 01:49:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ea13:571:b19b:36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16d01c4sm21943170eec.2.2026.02.03.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:49:40 -0800 (PST)
Date: Tue, 3 Feb 2026 01:49:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
Message-ID: <aYHBgLyIttd4lkn6@google.com>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
 <aX6whqw7XyaKMd9m@google.com>
 <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>
 <DG4EAYDXMGQS.2MKAJKDFQCFEG@fairphone.com>
 <34fa533c-b9ab-4025-b9ad-4041837e790c@oss.qualcomm.com>
 <aYCCv6nI2QkvD8rb@google.com>
 <6fa17bda-4d4a-4b31-99a2-1d2b606b663b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fa17bda-4d4a-4b31-99a2-1d2b606b663b@oss.qualcomm.com>

On Mon, Feb 02, 2026 at 04:11:51PM +0100, Konrad Dybcio wrote:
> On 2/2/26 12:04 PM, Dmitry Torokhov wrote:
> > On Mon, Feb 02, 2026 at 11:19:36AM +0100, Konrad Dybcio wrote:
> >> On 2/2/26 11:14 AM, Luca Weiss wrote:
> >>> Hi Konrad,
> >>>
> >>> On Mon Feb 2, 2026 at 11:12 AM CET, Konrad Dybcio wrote:
> >>>> On 2/1/26 2:49 AM, Dmitry Torokhov wrote:
> >>>>> Hi Griffin,
> >>>>>
> >>>>> On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
> >>>>>> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
> >>>>>>  
> >>>>>>  	chip_id = be16_to_cpu(read_buf);
> >>>>>>  
> >>>>>> -	if (chip_id != AW86927_CHIPID) {
> >>>>>> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
> >>>>>> -		return -ENODEV;
> >>>>>> +	switch (haptics->model) {
> >>>>>> +	case AW86927:
> >>>>>> +		if (chip_id != AW86927_CHIPID) {
> >>>>>> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
> >>>>>> +			return -ENODEV;
> >>>>>> +		}
> >>>>>
> >>>>> If we are able to query chip ID why do we need to have separate
> >>>>> compatibles? I would define chip data structure with differences between
> >>>>> variants and assign and use it instead of having separate compatible.
> >>>>
> >>>> dt-bindings guidelines explicitly call for this, a chipid comparison
> >>>> then works as a safety net
> >>>
> >>> Are you saying, that
> >>>
> >>> 1. we should enforce dt-bindings == CHIP_ID (what's currently done)
> >>
> >> This
> > 
> > No. If there is a compatible chip with different ID (for whatever reason
> > - maybe there is additional functionality that either board does not
> > need or the driver does not implement) we absolutely should not refuse
> > to bind the driver.
> > 
> > Hint: this thing is called _compatible_ for a reason.
> 
> Right, the reason you have in mind is fulfilled by fallback compatibles
> 
> (i.e. "vendor,actualchipname", "vendor,similarchipname" where the driver
> only considers the latter becuase the software interface hasn't changed)

And having chip_id checks will break this...

> 
> > 
> >>
> >>>
> >>> or
> >>>
> >>> 2. we should have both compatibles with no handling based on compatible,
> >>>    but only use CHIP_ID at runtime to change behavior
> >>
> >> This is spaghetti
> > 
> > I really do not understand the aversion of DT maintainers to generic
> > compatibles. We see this in I2C HID where we keep adding compatibles
> > for what could be described via device properties.
> 
> This is because it's the only way to allow for retroactive changes that
> do not require changing firmware. That's why ACPI carries new identifiers
> for even very slightly different devices too. Once the firmware containing
> (ACPI tables / DTB) is put on a production device, it is generally not
> going to ever change.

They are actually solving slightly different problem. In ACPI world they
allocate a new ID to represent a peripheral in a given design, down to
it's firmware behavior. It encodes much more than chip ID that DT
maintainers want to key off of.

> 
> CHIP_ID registers are a good tool to validate that the author of the
> firmware table is doing the right thing, but solely relying on them
> encourages creating a "vendor,haptic" compatible, which I'm sure you'll
> agree is totally meaningless.

Is it? If a piece of hardware speaks i2c-hid protocol why do I need to
know the exact chip that is being used? Depending on the chassis and the
size of the sensing element and the version of the firmware that is
loaded into it the behavior and timings of the same chip may be very
different.

> 
> That's especially if the naming scheme makes no sense and you can't
> even factor out a common wildcard-name (which also happens to be the case
> quite often)
> 
> Plus a compatible is used to restrict/modify the set of allowed/required
> properties, so having an "actual" compatible is required for schema
> validation to work

Yes, in cases where there is not a common set of properties having
different compatibles makes sense. But in cases when the device is
supposed to have vendor-agnostic behavior insisting on myriad
compatibles makes little sense.

Thanks.

-- 
Dmitry
