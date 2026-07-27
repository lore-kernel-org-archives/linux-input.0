Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88621367;
	Mon, 27 Jul 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159084; cv=none; b=m112Y3WHmwnEvrQGMvT9nkvUuxBxsoaBTKciM6muCK/tpqDQw3ffDM1eNoND0LqmZdZhEEoBcgzMSIMV0fejfddInpHod02l4HNI4BZ/q+PNHpOEPk39jJBMfY6OQl/6++eENiOHasfTXHfHd5jxo0IVHVWPX1Jp5LkVY8FqGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159084; c=relaxed/simple;
	bh=UUFWjqmd2bkOijzFQUZ1nbQKW06yZ7Z5xLVOXxT3FGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucu5yOr1fBDwHFfPCOC/vlb8+q3dZuspRBZcbHQS/61+6aKFhFXprj058k6XaAPKpTDz7BHMHU0HtdoUTvfOoHK6Ct8iY14BEtB5UwsjaSeUQatkDd3jAQxKk6PD+p1HayjbEFiRw7nTVM52kHCS5F4zshLa8tNmlW4o45FQFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 689D03EC82;
	Mon, 27 Jul 2026 13:31:19 +0000 (UTC)
Message-ID: <58230edfca51830963e328e36ebbc1b84606087f.camel@hadess.net>
Subject: Re: [PATCH] HID: logitech-hidpp: Fix FF device cleanup on init
 failure
From: Bastien Nocera <hadess@hadess.net>
To: Haoxiang Li <haoxiang_li2024@163.com>, lains@riseup.net,
 jikos@kernel.org, 	bentiss@kernel.org, e.velds@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Jul 2026 15:31:18 +0200
In-Reply-To: <20260623065200.1966629-1-haoxiang_li2024@163.com>
References: <20260623065200.1966629-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEdXuXRV6cfm7lnaPPayKxfcltC+Z0KRkOljvMJfK0bOIuPHBkmUz58HmPsuNabo0XpxvX1mRhY9YMdAiH++FFb+Z8kcPi5/vfyXrkg8FjdtfOhm20umrXwcj5LIB3+2Dd8vxsCgW9iiF/nh6lTdyI+qytzypwUXJZQQivnsh9crx8Wh2Rbhob6YMz9YuNjlq9tulKvnILXwguw8nOz1htRh2vex1SxfK5s/fOLSYO2yN8MFGHlRnUDuIXeWD5veCUVnM7ybFaIbgepf0qTnYmZU5/Z/b2Tk1CU3xwgUU4yg0nQgsxL2XiE7i6m/luB1bEhUleCF/54PP0/arMhgQj1aDBHAaZcuQ58oRHRNlmf7yNVrutKNnCvYOj9msp4mI+pH7YPx9sr9MTb/NINUUu/XbLtVTTqPt1BaTrQVhJ7mbWmt9W3qyCQArwteKTRBJLIxLRvKoamR+uASVdCNQyy1n5HYpLPaR9d7fBYZpBLCXXYMCKhYRoQGIaKXzbUUkD234ZoyFjJB9jzMUDmpRo+Smil1XRzLCDO6a61AKGKnuvTOjsKO89MJL/xiJKwUjASuQd68NMBfxgCdc8uISgowaiUjQS0QFPBQkNGydRDkVK3CfvjTW/Jyh6hzWPWVcJM9l5w/OkSJBsz6xk5QeL0Wha/6ZZoo5xGemFEekK9ig

On Tue, 2026-06-23 at 14:52 +0800, Haoxiang Li wrote:
> hidpp_ff_init() creates the input force-feedback device with
> input_ff_create(), then allocates the HID++ FF private data,
> effect ID array, and workqueue.
>=20
> If any of those allocations fail after input_ff_create() succeeds,
> the function returns an error without destroying the FF device.
> Add an unwind path that frees the private allocations made by
> hidpp_ff_init() and calls input_ff_destroy() for failures after
> input_ff_create() succeeds.
>=20
> Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for
> the Logitech G920")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Looks correct. I wish there was an easier way to handle this.

It looks like hid-bigbenff.c doesn't handle post-input_ff_create*
failure properly either.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 23 ++++++++++++++++-------
> =C2=A01 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 90b0184df777..fb2062233df2 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2861,18 +2861,19 @@ static int hidpp_ff_init(struct hidpp_device
> *hidpp,
> =C2=A0	 * ownership to FF core
> =C2=A0	 */
> =C2=A0	data =3D kmemdup(data, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> +	if (!data) {
> +		error =3D -ENOMEM;
> +		goto err_destroy_ff;
> +	}
> =C2=A0	data->effect_ids =3D kzalloc_objs(int, num_slots);
> =C2=A0	if (!data->effect_ids) {
> -		kfree(data);
> -		return -ENOMEM;
> +		error =3D -ENOMEM;
> +		goto err_free_data;
> =C2=A0	}
> =C2=A0	data->wq =3D create_singlethread_workqueue("hidpp-ff-
> sendqueue");
> =C2=A0	if (!data->wq) {
> -		kfree(data->effect_ids);
> -		kfree(data);
> -		return -ENOMEM;
> +		error =3D -ENOMEM;
> +		goto err_free_effect_ids;
> =C2=A0	}
> =C2=A0
> =C2=A0	data->hidpp =3D hidpp;
> @@ -2902,6 +2903,14 @@ static int hidpp_ff_init(struct hidpp_device
> *hidpp,
> =C2=A0		 version);
> =C2=A0
> =C2=A0	return 0;
> +
> +err_free_effect_ids:
> +	kfree(data->effect_ids);
> +err_free_data:
> +	kfree(data);
> +err_destroy_ff:
> +	input_ff_destroy(dev);
> +	return error;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> *********************************************************************
> ***** */
