Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CF449ECB
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361640; cv=none; b=GD/UNy3cwfdVewVHr+iL9C7zSvxJqmZUKs1bgTD2vfoDjPu2LC33Varb4d/+rtPRlW8YfkSFlp3Wx1+ENhINvty2vPq4fl+6m9JAyLUZKwzR+2gDw/fD61Tr9d59Rkza/A96Eaw2PN46cRu7DY/7UJhpVJhwvSqCVitVLGiRdvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361640; c=relaxed/simple;
	bh=QicaC85e7FTGi9KZZSURax+f0l1I/2RI2h4p5/+y/8E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=B3YpV669sDn+Oj2GbJkvEwOaYmUaSaZVaZ8XvXHA9A7VkA0xduq+1vK/FxwUk3iif6BfuW0W5VXeRfO7kQU8wdhxsbd+G0LJhxyCJz/cC8Q7ljmTiUstaPP5OeslC07iKxUX721I4UtWyE+1Qhh3qh1kry221XDRK0OqN/jN5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOeQdrOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOeQdrOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC681F000C4;
	Sun, 18 Oct 2026 22:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792361639;
	bh=kxLB/Ul0o2kHcexvovccWtw/Qx5ezB6Ab+vqN9G2Fqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOeQdrOBggZhx4oze0tX5DDxRdQAxb3t4h5pIBtdd6MtqI3sFKHnjrytmS4lPxjHI
	 Hr1t8jiahTFgOx5yHbPny2q7NLtA+O2r91lXNdnzhruHgU6Qmm0v39tPU+woLVqYxQ
	 kLjNjx43sdcnUCbKZrnmF2C5eIo66MxKCIjeCp5OOairIdk7QxUYMAoXLDvAMoGPXQ
	 59X1jfEmyNztOXk4ADsGdjHz3iqU53dHrkVyLLF9Hiz8ftd6MkTG9mOd4vFcbTuCmL
	 VRYQ+K1aElWOJSnfJhuP4LGR7Niz5CrnRVCUZnjdt8shXoR9Kdu/rell0OgRYNkEyU
	 87SlC5tvHVdPA==
Message-ID: <sashiko-outbox-176427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] HID: oxp: validate report size in raw_event
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018220344.1987142-7-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
 <20261018220344.1987142-7-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 22:13:58 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: oxp: out-of-bounds read in oxp_hid_raw_event() dev_dbg()
--

commit 5b821b0394212eadced6ac6427c3ff78bbef2d73
Author: Tristan Madani <tristan@talencesecurity.com>

HID: oxp: validate report size in raw_event callbacks

This commit adds report size checks to oxp_hid_raw_event_gen_1() and
oxp_hid_raw_event_gen_2() before casting the incoming report buffer to
struct oxp_gen_1_rgb_report and struct oxp_gen_2_rgb_report.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 1e691ebc1199e..af9f60d45bf29 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c
> @@ -318,6 +318,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device =
*hdev,
>  	struct led_classdev_mc *led_mc =3D drvdata.led_mc;
>  	struct oxp_gen_1_rgb_report *rgb_rep;
> =20
> +	if (size < sizeof(struct oxp_gen_1_rgb_report))
> +		return 0;
> +
>  	if (data[1] !=3D OXP_FID_GEN1_RGB_REPLY)
>  		return 0;
> =20
> @@ -391,6 +394,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device =
*hdev,
>  	struct led_classdev_mc *led_mc =3D drvdata.led_mc;
>  	struct oxp_gen_2_rgb_report *rgb_rep;
> =20
> +	if (size < sizeof(struct oxp_gen_2_rgb_report))
> +		return 0;
> +
>  	if (data[0] !=3D OXP_FID_GEN2_STATUS_EVENT)
>  		return 0;
> =20

[Severity: Medium]
Can oxp_hid_raw_event() still read past the end of data before reaching
these checks when dynamic debug or DEBUG is enabled?

In drivers/hid/hid-oxp.c, the caller oxp_hid_raw_event() logs a fixed
OXP_PACKET_SIZE (64) bytes from data before dispatching to
oxp_hid_raw_event_gen_1() or oxp_hid_raw_event_gen_2():

drivers/hid/hid-oxp.c:oxp_hid_raw_event() {
	u16 up =3D get_usage_page(hdev);

	dev_dbg(&hdev->dev, "raw event data: [%*ph]\n", OXP_PACKET_SIZE, data);

	switch (up) {
	case GEN1_USAGE_PAGE:
		return oxp_hid_raw_event_gen_1(hdev, report, data, size);
	case GEN2_USAGE_PAGE:
		return oxp_hid_raw_event_gen_2(hdev, report, data, size);
	...
}

When a short report arrives with size < OXP_PACKET_SIZE (such as a report
allocated for a smaller size via hid_alloc_report_buf() in __hid_request()
or injected via hid_bpf_input_report()), dev_dbg() will read 64 bytes out
of bounds from data before the new size checks in
oxp_hid_raw_event_gen_1() and oxp_hid_raw_event_gen_2() are reached.

Should dev_dbg() in oxp_hid_raw_event() pass size (or min(size,
OXP_PACKET_SIZE)) instead of OXP_PACKET_SIZE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018220344.1987=
142-1-tristmd@gmail.com?part=3D6
