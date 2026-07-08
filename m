Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B04343895
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518611; cv=none; b=S4EyLbAg1z831Zf2rOgMMMUx8yN2kizLMaxc3LfB/MM6TeSrmiJOybwTdjhJsFE5g40WCpJ8Qd1Ao6oIVNqRNJb6m6CFXonprA88IOS07xw3nU1F2ayihJfnl9RwJ3tWPTmXy9m688AvBD6k6/arVAp1kZD2uRfOG8sY7JnNqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518611; c=relaxed/simple;
	bh=6gpeLjoCGjWczZSVZXnQb1gK/iGJTjle70SXQ4k62lc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uOEIQriXAj5MP9r2CRsPsBR2/bep1pEB3cMAUziK9cyGVmqgjx5PGGEQLYLj/D+gmHz7HVdfLQyd2QLwEsPLTNCQWWQW6V83vJRE1JgplG+ruMWk5z3MAPo6kp7ADjN8nTsFjBcXHP7VYplbg8SwbcoFD7MXuVZd763BnH8B2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG7VV9hJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG7VV9hJ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso823276a91.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783518610; x=1784123410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buKwQuF9Xb78SedDvaSqFTvNEIsKPttq7Ewic1Ot5jk=;
        b=rG7VV9hJhQ0z5Bjw9t8JgQV40bZxsN9m2aJcmvmOeuFHIHkMVHWehyHAgoa7U2ye0H
         Y2ov4iqmODg3i22YZO3vnxvYyfvZT2gvEm0Lg1WgiM1zK6wt3YwpAT3Pju341sDuJ3GH
         p9mK89xF7GzJ7GaYkGsj+eS3SdgW5deiCoqmA7ao2MDZxGTEh/GPY1hR++VsEdUrI9H2
         oiLkrwuixAO26UIONKBi9nMlxpa53L4DoLVIISujAdSiGL1f0jMmcm9zGVVODVUHdq6y
         9EekOwKPyfd0Xxvt7rya9OTG6Hb/O6J0KWvYMfBC+0BUhSGQMP9biHMrzyNmIwjaajvo
         KBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518610; x=1784123410;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buKwQuF9Xb78SedDvaSqFTvNEIsKPttq7Ewic1Ot5jk=;
        b=Ryl7F3iy1Zf/sjLhinu0BmpN0QeiTnPPa8Os8qA5hJUdyfJh19JlgDag05Ef3AXjIg
         5GytLt4nAXuxYYvz7zt3j9gwM+3/pqVXMJxbIE8cbQY/08gLpQYbPXCmLo7o8dtYZbRu
         TWYR6azgHsFzwMZGYIt/il80Ld95GYenQXQi+cYWtt5sz+I9XodANFSkvkWB/NufPYJA
         qvKJsILVvFDBHHcgswDDbB9MfwNL9l6650qGbFIWQNlT00EGfT+ps6oG2raQjiuArQ4g
         /peVpaauHoEBn/xZlwfo64QQi9S6eASRvPHb/n4IL2Db+ZFJHy/cxaEd7pKHv8+Q/WFT
         Dfqg==
X-Forwarded-Encrypted: i=1; AHgh+RoC7MHx0FBxpoXjXMjuUAdg3+Exm1FHDip60cr3URoXxV7/JXj7mapgms3ZuXrxtSQSyeJE+LMLJNAJ1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbpv3UYaNoz/M1gZWniuzWp3jNjIrMU8QYbFvbBhFU8Dw1WHC
	G/+T4irFIy9o3blVjfq4u/sRQIPNCyW28t7Hx8pU7lnh+G5ICsb7wYf2
X-Gm-Gg: AfdE7ckSGrigKw6hHI/JVdJIYSfZHVdng0vcmmqoxHGQ8bVaRuDpw9NyBtWV3GJJ4+Q
	n7HHqJB41f1v0KXxi4kiu3rD/W9QwZLzVPTreC/7DaDUY1peqtUdY1utfTEncSKCXKRqSPucHCl
	2zG5uU7hLoyNtP9VEXxM2MDCSBgJNmaBaUtdHtoLT7iCH2Igrs170F4ECujiu4b0vcGMaB3w6T1
	vQOeo7vQ9HdFiscE3n17l1gosg94vJ4Lme861mGSGYYYf4B6vx57DPZvOfk5O2Dbl0sJhsUNsMf
	Y+NFaU65DyuAGpz/6/oW7HLPgd2Uf0kbw/45alA+uwLWBXtEfdzPwGIOOyy6CNOnuvfc0CubTCO
	S/oa8mwA53kerPXmSeDHQlVkDNNnJiByMa1N9Xch039z9/gRXlGh90dn+vfKn+bgFXEv84hL2Xz
	qAIYpSIPsaHzSSbgqj9BHdO6/UcS0i+oM9fcxX
X-Received: by 2002:a17:90a:da8b:b0:380:40b:f30a with SMTP id 98e67ed59e1d1-3893ff630b6mr2629759a91.13.1783518609657;
        Wed, 08 Jul 2026 06:50:09 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:c3f5:7690:4ad7:112f:6a41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d12fcd99sm2822926a91.2.2026.07.08.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:50:09 -0700 (PDT)
Date: Wed, 08 Jul 2026 19:20:04 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hongyan.song@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_iio=3A_temperature=3A_hid-sensor-temp?=
 =?US-ASCII?Q?erature=3A_switch_to_non-devm_iio=5Fdevice=5Fregister=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260625121611.2003780-1-sanjayembedded@gmail.com>
References: <20260625121611.2003780-1-sanjayembedded@gmail.com>
Message-ID: <F9175D53-7073-446A-8EA9-C7C06F76CB69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25 June 2026 5:46:11=E2=80=AFpm IST, Sanjay Chitroda <sanjayembeddedse@=
gmail=2Ecom> wrote:
>From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
>Avoid using devm_iio_device_register(), as this driver requires explicit
>error handling and teardown ordering=2E
>
>With devm_iio_device_register(), IIO device remains registered until the
>devres cleanup phase=2E However, driver's remove() callback removes the
>sensor hub callback and trigger support=2E This can create a race window
>where IIO device is still visible and read_raw() requests are issued=2E
>These requests might call sensor_hub_input_attr_get_raw_value(), which
>waits up to 5 seconds for a response from the sensor hub callback that
>has already been removed=2E
>
>Add an explicit iio_device_unregister() call in the teardown path to
>ensure deterministic cleanup, so that userspace can no longer access the
>device once backend resources begin to be dismantled=2E
>
>Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
>Cc: stable@vger=2Ekernel=2Eorg
>Reviewed-by: Maxwell Doose <m32285159@gmail=2Ecom>
>Reviewed-by: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>
Hi Jonathan,

There are two pre-existing issue highlighted by Sashiko which can be analy=
sed and fix in separate change if required=2E

Requesting your valuable input on this fix=2E also, this is pre-requisite =
for HID IIO devm conversation series=2E

Thanks, Sanjay

>---
>Changes in v2:
>- Added review tags of Maxwell and Andy along with stable Cc
>- Based on input from Srinivas and investigation use-after-free
>  explanation was not sufficiently justified so updated the commit
>  message with appropriate information and kept Fixes tag
>- Link to v1: https://lore=2Ekernel=2Eorg/all/20260622052135=2E1804135-1-=
sanjayembedded@gmail=2Ecom
>---
> drivers/iio/temperature/hid-sensor-temperature=2Ec | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iio/temperature/hid-sensor-temperature=2Ec b/drivers=
/iio/temperature/hid-sensor-temperature=2Ec
>index a8d3a15f9c53=2E=2Eab6ec8f659b8 100644
>--- a/drivers/iio/temperature/hid-sensor-temperature=2Ec
>+++ b/drivers/iio/temperature/hid-sensor-temperature=2Ec
>@@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_devi=
ce *pdev)
> 	if (ret)
> 		goto error_remove_trigger;
>=20
>-	ret =3D devm_iio_device_register(indio_dev->dev=2Eparent, indio_dev);
>+	ret =3D iio_device_register(indio_dev);
> 	if (ret)
> 		goto error_remove_callback;
>=20
>@@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_de=
vice *pdev)
> 	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> 	struct temperature_state *temp_st =3D iio_priv(indio_dev);
>=20
>+	iio_device_unregister(indio_dev);
> 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
> 	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
> }
