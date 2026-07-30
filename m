Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C02D8DC4
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386278; cv=none; b=RTX75YyAagv7uAJnFOCQKVvL29FyDlsfE7ZdRBA2iDzHiQyqbpJLCwZ5Fa9KDaqmwkKVM5dYS0JeaLj3Hlh5WiQjLSR2v7rjfFVdjt4FS3GbLWP/GF9+nn6wrGUZsa2+8h9H6cCA+wEpbM8DXCapxrkm0jco0YBrZuP3pvCiKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386278; c=relaxed/simple;
	bh=OSO9xXPjRQPG62SCYzBmfvwuw26AUNL4QiiHNnDPIpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pAzLsdg4vmmMTqqNxNmJJWwl3IFw7Cxs9tG5iBVgM+lGS9SPOgsSSnCDMlglvBoJHBDxiZnJ2jq1ecXKr4+UCUqhR96sx0ob8atIVOXLaEnJCMYBJEqsB49RrZl03sae0q+WPncz6lqII5o0dRip6PYAZs+XaRZROb/foQUJ+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaLAJ/yX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaLAJ/yX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0A01F000E9;
	Thu, 30 Jul 2026 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386277;
	bh=OGGMr3DTn01hSk1xfmk78USVL+1nObZLNPjj/fMNYoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kaLAJ/yXYfaqmSi1TMYksiFlMa0Io/csvi2dW3FNDHOuts6L3h801BbammZO/k8nC
	 cFCFM9aE7VtJh6TWyMvrQCUaZo19Mo/f/ZkPpmjhPHNhAxjNP37dqCYaEMagFKBeYN
	 mBuVGx8htWcVJIfK0vXsSyEEBFd6Wx4PoFpzkKywyt81gWvIpOc//I2dOpWYW8SXVc
	 wZkEY/f+mZ5/F+LG6tPawaMy3qb88g0KSsRTTAV9ID2HmuF07ZP0q4whtkrgupUfLy
	 aFtqdF/wSwGevvvgRMpJbfRy/cealEczKmA8QD9Yqz8VF4CbvLBgW9LSP7C3lVK2a+
	 c4BrXiy1QJ9oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/11] HID: steam: Add support for sensor events on
 the Steam Controller (2015)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730041251.1659029-5-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
 <20260730041251.1659029-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:37:56 +0000
Message-Id: <20260730043756.BD0A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global list dangling pointer and Use-After-Free when steam_registe=
r fails during probe.
- [High] Race condition leading to double-free of input devices in workqueu=
e callbacks.
--

--- Patch [4]: [PATCH v5 04/11] HID: steam: Add support for sensor events o=
n the Steam Controller (2015) ---
commit c819d5d2af295f0bbbbb6b163562daebd8e1a93c
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: steam: Add support for sensor events on the Steam Controller =
(2015)

Sensor support was added for the Steam Deck previously, but Steam
Controller sensor events were never added. This adds that missing support,
bringing Steam Controller support much closer to feature parity with things
like SDL and Steam itself.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 983d18d1de4fe..1ceb044e170b4 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -918,9 +1030,6 @@ static void steam_sensors_unregister(struct steam_de=
vice *steam)
>  {
>  	struct input_dev *sensors;
> =20
> -	if (!(steam->quirks & STEAM_QUIRK_DECK))
> -		return;
> -
>  	rcu_read_lock();
>  	sensors =3D rcu_dereference(steam->sensors);
>  	rcu_read_unlock();

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
leading to a double-free of the input devices in the workqueue callbacks?

If a device disconnects at the exact time a user opens the raw HID node,
steam->work_connect and steam->unregister_work can execute concurrently
on different CPUs. Both callbacks invoke steam_sensors_unregister() and
steam_input_unregister().

In steam_input_unregister(), the check-and-clear logic is not protected by a
mutex or lock:

drivers/hid/hid-steam.c:steam_input_unregister() {
	rcu_read_lock();
	input =3D rcu_dereference(steam->input);
	rcu_read_unlock();
	if (!input)
		return;
	RCU_INIT_POINTER(steam->input, NULL);
	synchronize_rcu();
	input_unregister_device(input);
}

Could both concurrent threads read a non-null pointer, drop the RCU lock,
and then both call input_unregister_device() on the same device?

[ ... ]

> @@ -968,6 +1077,12 @@ static int steam_register(struct steam_device *stea=
m)
>  			strscpy(steam->serial_no, "XXXXXXXXXX",
>  					sizeof(steam->serial_no));
> =20
> +		ret =3D steam_get_attributes(steam);
> +		if (ret < 0)
> +			hid_err(steam->hdev,
> +				"%s:steam_get_attributes failed with error %d\n",
> +				__func__, ret);
> +
>  		hid_info(steam->hdev, "Steam Controller '%s' connected",
>  				steam->serial_no);

[Severity: High]
This is a pre-existing issue, but could the error path in steam_register()
leave a dangling pointer in the global steam_devices list?

If steam_register() encounters an error during a wired device probe, such as
steam_input_register() failing to allocate memory, it returns an error code
but leaves the steam object on the global list:

drivers/hid/hid-steam.c:steam_register() {
...
steam_register_sensors_fail:
	steam_input_unregister(steam);
steam_register_input_fail:
	return ret;
}

The caller, steam_probe(), then jumps to the err_hw_close label, skipping
the err_steam_unregister label where the list state would be cleaned up:

drivers/hid/hid-steam.c:steam_probe() {
...
		ret =3D steam_register(steam);
		if (ret) {
			hid_err(hdev,
				"%s:steam_register failed with error %d\n",
				__func__, ret);
			goto err_hw_close;
		}
...
}

Because the steam object is managed by devm_kzalloc(), the kernel
automatically frees the memory when probe fails. A subsequent write to the
lizard_mode module parameter will trigger steam_param_set_lizard_mode(),
which iterates over the list and accesses the freed memory, leading to a
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730041251.1659=
029-1-vi@endrift.com?part=3D4
