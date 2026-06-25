Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870E383313
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352392; cv=none; b=HjUUx+wLd1Hd86oGEcAqTctAJxLQPjXjiErgmrR8HfhZ/tJ9NXRV24+i41Qm3VPn9MhFTm9G9UBsckjzFxyWx7cxB5HTySdwV9m1o5zjICc1r94A3fJBraMAsLISmrbUgwuBcuLCz4YMXhhD0T9j/NjbbqRwc/BLfeYGDBPb9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352392; c=relaxed/simple;
	bh=vwZTQ9gB8Ctb4K4qxhLn9dMYc0JvVO+/LzpdmYdL99o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L61gTz5Rq88LqP+puvu/5HpRT+IoCTDlf8s4Mqs712aDK2jObRzGvyZy0CD9L8PAfPskRFkGFLS/+3q8sBKWTy0oA5tb7hNExg98bvZ1PjynbDq6z2zCpw4p+IYeJNg2AupTK3zOLysjkcbOQr5MY1b5m3CGoDiA2NqqT8x46lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBpsm2cd; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBpsm2cd"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-139d5c9a495so2249704c88.0
        for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782352389; x=1782957189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CzOfu5Lq5E9H88P/ukWScskr+7REIahe2+HdHdRazIs=;
        b=jBpsm2cdAxIC3qh9hiKaMyRcGMf0d4kJuWbM468RKw8ZKM0x7c5/iBlFhQrn3WWBs+
         7AymFOB+1PlrT3x8c6oGLMUZ7tmPSqJCzxAjeValfUgX5su0Bne8b3LI2vdbOQSc74mU
         O63oS3hGEJwrc0wrvCaJ5bgu6Ga4drnhFqe8ctBZPnt/EXWW3cZiz7Jad9eVhzYa/QgS
         R9NxPfz+O49e955X5q1CU9z87/WTK+JVVTX8UzolsmIm3mv6vMHd+5rcUHP3JpV+05Dh
         qq+KkRFwJbSbIoCooszPjfBIRlYXrtCCcJbtO79sMNkQ8LsdZw9xDtqcqvD5DLHDoANW
         Qtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782352389; x=1782957189;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzOfu5Lq5E9H88P/ukWScskr+7REIahe2+HdHdRazIs=;
        b=A+sp7DNKzEiddq9xooK0+EaT+73gk9DKZKAEVEybjsVmQkagRIsp8MsTK/TRhzJyr9
         YJ/wHAIoA3N4Zsy0naRLzQW6tXIgdnZMlGtmEgGeWwEtVo/INsOknwCkFEweJbvMDuwf
         T5N9WbrNiNwNtYP4dzQmB9IY6SLvV3TfrlggfAxIq1spXcX3CTGi2cyhZ1pdcSICnXy2
         xAX3o6o6yWpq49GLU+2Fw4dpxhRFthmKN1FnQ35N61Zvgb66vZmz5kiuN02mzZT1wTx1
         MdH1NFgDl14hfGspqA2wQosH8MPeFdQ6RTKzRWvjMmNc6ScCKm5arXD+h1L+S4q+chVE
         PRUw==
X-Forwarded-Encrypted: i=1; AFNElJ9xFiqHmw1USbZ57S8KtT+qbHF7JRX6QLd+kvyUfp73wLaiDsxuJHaXxtM+925jakl1/JTUpskpRgSrFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwccwHDrZsAfBSKUrcdA8TJNWfvv2V5RcET/8vuPHbMA+5/vShF
	TGcSSy5WTNmE5IpjszQQfCALuI1TQfu6hj+Qd9KmcByRpVjX861sxF1F
X-Gm-Gg: AfdE7cnZspsMMtz8KZmUQ/eRW2pv4G88mgeapahMPVrPRAJJQC5vC54MNoKTBUiRT9d
	9Ewp7al4Vj3/iBlkHCLT1iqxL22Dn/i5PmDPYfF6m9kho6ORsKxf1d2lWvlVmP/rdcKYyyuHMGO
	qIDRm1URLN3abqBuNlh19yr7pj18XHAaEsh5o5whKobFZRZ4u7g9DkEQvRZ4QA1KqLWOco97Q8B
	E/+HS7WeFMknywEhBYLPKGQ6wxHmXfp/tUJfBRel+VIh5J/gCPeNS3aWbkZFpgWQCWYC0CENhW1
	bKGTUfAUNmIK8JuT/u/IxF1iPqsg30vbO2yKlXLtN//kjbjmvHRWFkIdtaMrTEFflPhgLtfSMdz
	3X3FNOm1wYRobbmNl2HdS6TxnIjieDS0gATQ403pVwSGtP6xPwWoysT2G2MAkVqfAkRDt5NJ7kD
	SwoDPXcMe6vRoYzpIJti3jUOIPJRvBvxnZkeFE8FBTLQ52n24=
X-Received: by 2002:a05:7022:1b02:b0:139:ba7d:84a7 with SMTP id a92af1059eb24-139dbab9cc3mr479372c88.13.1782352388816;
        Wed, 24 Jun 2026 18:53:08 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:8899:9e33:2452:7e79:e768:7b49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f318f3sm2791314c88.2.2026.06.24.18.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 18:52:54 -0700 (PDT)
Date: Thu, 25 Jun 2026 07:22:49 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Maxwell Doose <m32285159@gmail.com>, jikos@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, hongyan.song@intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_iio=3A_temperature=3A_hid-sensor-temp?=
 =?US-ASCII?Q?erature=3A_switch_to_non-devm_iio=5Fdevice=5Fregister=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260623200616.56a44b3e@jic23-huawei>
References: <20260622052135.1804135-1-sanjayembedded@gmail.com> <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com> <CAKqfh0Hk12rA7wkU9wbse=n9qbOgbmxK0vhP6Enj-R2yKCohuQ@mail.gmail.com> <0e198f80c6f28e448611e02e1fe20af632931dd3.camel@linux.intel.com> <20260623200616.56a44b3e@jic23-huawei>
Message-ID: <438AD440-7511-4F04-B6D7-53C0D61AE733@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24 June 2026 12:36:16=E2=80=AFam IST, Jonathan Cameron <jic23@kernel=2E=
org> wrote:
>On Mon, 22 Jun 2026 13:50:22 -0700
>srinivas pandruvada <srinivas=2Epandruvada@linux=2Eintel=2Ecom> wrote:
>
>> On Mon, 2026-06-22 at 10:27 -0500, Maxwell Doose wrote:
>> > On Mon, Jun 22, 2026 at 10:26=E2=80=AFAM srinivas pandruvada
>> > <srinivas=2Epandruvada@linux=2Eintel=2Ecom> wrote: =20
>> > >=20
>> > > On Mon, 2026-06-22 at 10:51 +0530, Sanjay Chitroda wrote: =20
>> > > > From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> > > >=20
>> > > > Avoid using devm_iio_device_register(), as this driver requires
>> > > > explicit
>> > > > error handling and teardown ordering=2E
>> > > >=20
>> > > > Mixing devm_* APIs with goto-based error unwinding breaks the
>> > > > expected
>> > > > LIFO resource release model and can introduce race windows during
>> > > > device
>> > > > removal=2E In particular, the IIO device may remain visible to
>> > > > userspace
>> > > > while dependent resources are already being freed, potentially
>> > > > leading
>> > > > to use-after-free issues=2E =20
>> > >=20
>> > > Please explain this use after free case here=2E
>> > >=20
>> > > Thanks,
>> > > Srinivas =20
>> >=20
>> > My guess is that because the device would still be registered but
>> > would actually be removed, sysfs still has "wild" pointers to
>> > read_raw() and write_raw() (which don't exist anymore), causing the
>> > UAF=2E If I'm wrong feel free to correct me though=2E =20
>>=20
>> iio_device_unregister() will be last one to be called after device
>> removal from devm action handler=2E This will cleanup attributes=2E So,
>> read_raw() or write_raw() can be called=2E The problem can be handlers
>> for read_raw() and write_raw() if anything there which are dependent on
>> clean done by hid_temperature_remove()=2E Here callbacks are cleaned up=
,
>> so nothing to respond to read  sensor_hub_input_attr_get_raw_value(),
>> so it has to wait for 5 seconds to timeout, which is not great=2E So
>> nothing against change done here=2E
>>=20
>> But still not sure any use after free case, unless I am missing
>> something=2E
>>=20
>Agreed that to call UAF you need an explained path (and preferably
>testing that it happens)=2E  The timeout issue Srinivas calls out is
>sufficient for us to merge this as a fix, but the patch description
>should then talk about that=2E
>
Thank you all for the review=2E

I investigated the remove path in more detail=2E I agree that my original =
use-after-free explanation was not sufficiently justified=2E

The issue is actually the teardown ordering=2E With "devm_iio_device_regis=
ter()", the IIO device remains registered until the devres cleanup phase, w=
hile "remove()" first removes the sensor hub callback=2E During this window=
, the IIO device is still visible to userspace and "read_raw()" requests ma=
y be issued=2E These requests eventually wait for a response from the senso=
r hub callback, but the callback has already been removed, resulting in the=
 operation timing out=2E

I'll update the commit message in v2 to describe this observable behaviour=
 instead of mentioning a potential use-after-free=2E The code change itself=
 remains the same=2E

Thanks, Sanjay

>Thanks,
>
>Jonathan
>> Thanks,
>> Srinivas
>>=20
>>=20
>
