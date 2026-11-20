Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165304;
	b=awKS2O/4Vr+wa0lLpdrXTnhAdNlzeQxIiegEuWHvAVuqh8oiGFY03ViZ7XK5NZF9RbqP
	 yg6atpHTNfrgTUEVhksm+NfEfsB+H6FKFgfsIEE1DXjZCDCn57ZBcaCM545OmScwZaNda
	 K5RUkghuMJxXJ//lPOaVVc3W1HIXZdgkSxM2I7cwhwoKe8stlSrLAFGFa+BDjU65CsSqX
	 9xBbxsL4p3PRVyjTk+ZgitPLNq+MUDn8iGSE63jFEA+okWdKdwUcqsvRqEMr86g9hMtSy
	 zao656RXUFKxiX0/UZolRvHOiTELho8Z6wJd4nNQ7fi5BRlnjdFjF6O0hXoaDfKiUXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165304;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o9goNXiBHQebVL3ww3uRBy5+2xu7mOLJVo7xciBwg0c=;
	b=SSuroLd6TYWKpTKhjY13ltmzOkbNAcz8F6oZu+u1qtnw1I37Q32cf5weNVR7pU8KWXdh
	 xP3JD5fY8OON05Xu5+CXCJWntrMZvqYPnKl55yT32I0Et8s5zdV96otIwJ8YqmL5sP9QO
	 5HKxZ40LmSK+Mvp575EBx/PMuBohLyM69TxHQgwNyZMDYIjjIOvzXseL3bemd04wuifTr
	 uTfC+e5KdfYK+F/Rg0vG19vA9NKXI819gYVBFGZTit567VYV3oP8Achv5l0vbgDTommg1
	 fn09SEJvCDRtXsp+lJPtXUo8lG4+dCZtxh3rW5uW7eXUgmZQp7LAt2UbCt2mt0bu8fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj6Is2Oa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DA606A320
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tj6Is2Oa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50381F000C6;
	Fri, 20 Nov 2026 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795165303;
	bh=o9goNXiBHQebVL3ww3uRBy5+2xu7mOLJVo7xciBwg0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tj6Is2OaOmFM04pVdMvnO8aAlDXECNpoeWrKMjFr2YrbY/2haCDwxswSEcNnKc6px
	 BIknbIvPxt43obxqT9ZZbd0iKNfOIgFJKgLqOht8alJAPRMQBJ2uKTj7fkgvbV5UcW
	 zDeK7LEwWrJcDKx39zVhx0dC4Mar6LUMiiRgmF0ew6j2wX54f8dyfkMZomOBZuGcKI
	 gV6OHxpuYDNqH4989cS/eu94fXxXw8NQZo/Axhcgf4s3eovP5ZclcaEeIEoKnEAOML
	 JIE8MvNttxXEn+uueaCoMSOmnBG2ZZISiYbJXPw2fjCNAsDiPsFMxwWCR9CF4w1WUI
	 jX6shpE/9tf1A==
Message-ID: <sashiko-outbox-224810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
 <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 09:01:43 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: logitech-hidpp: work flush with I/O stopped in
  hidpp_probe()
--

commit 43c05e6ba16082cedbdbc71e25086acb4e9b0851
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: logitech-hidpp: disable works before stopping transport

This commit synchronously disables hidpp->work and
hidpp->reset_hi_res_work before closing and stopping the HID transport
during probe failure and device removal.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index d5f53b35ac6f5..0e1a9fd98fafc 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  	return ret;
> =20
>  hid_hw_init_fail:
> +	disable_work_sync(&hidpp->work);
> +	disable_work_sync(&hidpp->reset_hi_res_work);
>  	hid_hw_close(hdev);

[Severity: Medium]
Can disable_work_sync() here stall waiting for in-flight work items while
device I/O is stopped?

In hidpp_probe(), hid_device_io_start() enables incoming reports during
device initialization, which can schedule hidpp->work or
hidpp->reset_hi_res_work.  Before calling hid_connect(), hidpp_probe()
calls hid_device_io_stop(), acquiring hdev->driver_input_lock.  If
hid_connect() fails and jumps to hid_hw_init_fail, disable_work_sync()
waits for those work handlers with hdev->driver_input_lock held, so any
synchronous HID++ command inside hidpp_connect_event() or
hidpp_reset_hi_res_handler() cannot receive its reply report and stalls
until each 5-second command timeout expires.  Should hid_hw_init_fail
bracket disable_work_sync() with hid_device_io_start() and
hid_device_io_stop() like hidpp_remove() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-hid-logite=
ch-hidpp-v3-0-cfe2caa1d0eb@gmail.com?part=3D4
