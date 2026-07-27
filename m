Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9933F394
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116767; cv=none; b=BTu/dLS0Zt2jO18PGmCu0mRKbfKXVp338mqh72BDRtnJmMS2xj1Epqvs/dyGF9WfdWswq718MRzJiLy3PCQ5juQOO2fP3tIJxES5k5AXcZZQfuMuqy6+kbSV5rgUE5Gzbth2THrY4KyLoGl+8mblx1ya6UnjOK/2A78eCZDYnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116767; c=relaxed/simple;
	bh=LQSLrqjNB1isu20V3iKesRWxWLxYNNCCrYz8rQNCm3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DVHRnHIe1D+OQQZi5AhUWrNgW+v5G1Y/KkFS/TZY2mrvQnD8gFzyS+A9tgMqe+hfno/Q3usKnxQ9GvnEKPP3XQ0C4QLytSI0gY7FptbwpPP8kuFKctzRLdBaxO1baiP5Lw667CuYKvkn+6fAYIOaBPWgmMmBNAW6o/MSd3dUhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq1kVzMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq1kVzMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849A81F000E9;
	Mon, 27 Jul 2026 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785116765;
	bh=+zu9A4wLg58PYDRCsGqSDZLlAsdMT0vycbHaYvzF2Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq1kVzMgSBMXQJ+lFbr+J0DXS+tUgN/HOAAAWAw5TWNpm6ucQKFvaEOfJIqk+mlOr
	 ZvNquYvBm8vuqCcESgO1DgPephCeRXsqDCp27epMD//AmHFwoSTt/ur1IwLlbe9XaY
	 1JG59/QoB3PYUUoZ7SweJpjTRAxur6Oh9XDhoHTTudLEqgWaMNfatN4c94ezGcBh4J
	 15VXyoV6swEI+w0Rqj48+B6cQmOIuAzJkwIT2SdI6uQk0OIZkH6Q+qjKkmM5N9gsfy
	 s7hU5idqPfEmHEf/rALb+z90TROsGUXZgnTQRzcRSldvqMSv1hlI1lR2r6YKZB5k7b
	 98qTTiV/exV6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: corsair: fix use-after-free by reordering
 remove sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727013500.23435-2-chenchangcheng@kylinos.cn>
References: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
 <20260727013500.23435-1-chenchangcheng@kylinos.cn>
 <20260727013500.23435-2-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 01:46:05 +0000
Message-Id: <20260727014605.849A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in k90_init_macro_functions() error path leading to=
 Use-After-Free in corsair_event().
--

--- Patch [1]: [PATCH 1/2] HID: corsair: fix use-after-free by reordering r=
emove sequence ---
commit bca54ac8929144d32ee56dbe443017efaac3d7f5
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: corsair: fix use-after-free by reordering remove sequence

This commit prevents a use-after-free during driver removal by reordering
corsair_remove() to call hid_hw_stop() before cleaning up device data. It
also explicitly nullifies the drvdata->k90 pointer after freeing it.

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 21cd8b12a7572..ac12877a6db7b 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -545,6 +545,7 @@ static void k90_cleanup_macro_functions(struct hid_de=
vice *dev)
>  		kfree(k90->record_led.cdev.name);
> =20
>  		kfree(k90);
> +		drvdata->k90 =3D NULL;

[Severity: High]
This is a pre-existing issue, but does the initialization error path you are
mirroring here contain a race condition?

The commit message notes this matches the pattern in
k90_init_macro_functions(), but in corsair_probe(), hid_hw_start() is called
before k90_init_macro_functions(), meaning device events are fully active
during initialization.

If k90_init_macro_functions() encounters an error, the error path frees k90
but delays setting drvdata->k90 to NULL:

drivers/hid/hid-corsair.c:k90_init_macro_functions() {
...
fail_record_led_alloc:
	kfree(k90);
fail_drvdata:
	drvdata->k90 =3D NULL;
	return ret;
}

Could an incoming USB interrupt trigger corsair_event() concurrently, causi=
ng
it to write to the freed drvdata->k90 pointer before it gets nullified?

drivers/hid/hid-corsair.c:corsair_event() {
...
	if (!drvdata->k90)
		return 0;

	switch (usage->hid & HID_USAGE) {
	case CORSAIR_USAGE_MACRO_RECORD_START:
		drvdata->k90->record_led.brightness =3D 1;
...
}

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727013500.2343=
5-1-chenchangcheng@kylinos.cn?part=3D1
