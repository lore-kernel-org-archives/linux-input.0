Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B225B095
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020538; cv=none; b=HfVdIasSBXi/AKXk+hmSM7sVszX6VzTtBEBiHW9cuQIJoDh5r4EvUJBKTf+9d44tjg+WG9DS/d0c5JNTZBJpAfpOfQHAPeB8LWecZuZapkrC0C/8vNNZMxhkAKovWvU3mHZKQ+Oe7evWRWq2W0+ZRbT+lxxrXdSY3cz0sMZb76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020538; c=relaxed/simple;
	bh=uT+teHOd6AuLBa68I6BP3JJrADbvUt7PDRiNn7D8QOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ahcmvLzl37o5eWPjyIFKlhXCDbbOi+KvU+s0uAkOosv/YK5uYz+l9G9czZmgMSLwqPJbYW1cbRvqUkldrnf3e13TyivPgOO6COm4DZwtuYOOufsKHiLySjYKFU/GXxpAwaqG4JykHTI6uoDUneMSZgW+Xf9onBNZmUWgw4+WQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJgOwdVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJgOwdVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB0D1F000E9;
	Thu,  6 Aug 2026 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020536;
	bh=dLoCLh8nT7lyQ9KOpv8mnlSblezFOiQpOwu3x/KMpWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJgOwdVv3yL0orr6amyn+4dqYE0gyZPdEumCrPOL43KA8S/bOVBFLnuf99Mxk14tC
	 CBJQSBuU/nd677vjKfcRWgTcBcxy21FZWfcQ9II2C+wkjMMLgn7IDMcpI80jgFBhQK
	 MVZYm8vtC+7ZDnDWbbNiPTPGkHLXzZT4fqbuM6lbNIbzqs/8BIGGwfwfOYZfsVNcsU
	 IE/n7phLBayc0JJORc5IKR+XnOnN5wwqZf1q0uQsgJxw8cKnK2ygPq84Sou+w5fSYd
	 tO/zICwPSkyqhPZYdGZzb53zvtqPVmiPACyLWkOYu2LQNN08vnthk44aSse03Axuw1
	 JGGq+fT4Ojzrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] iio: position: hid-sensor-custom-intel-hinge:
 convert probe and teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-12-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-12-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:48:56 +0000
Message-Id: <20260806124856.8BB0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a possi=
ble Use-After-Free (UAF) during driver unbind or probe error due to missing=
 synchronization with concurrent hardware events.
--

--- Patch [12]: [PATCH v5 12/13] iio: position: hid-sensor-custom-intel-hin=
ge: convert probe and teardown to devm-managed resources ---
commit 9db33d404c2c76bf6835ddae77ee4ee1c86c8f21
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: position: hid-sensor-custom-intel-hinge: convert probe and teardown to=
 devm-managed resources

This patch converts the HID IIO driver resource management to use
devm-managed helpers, tying the lifetime of resources to the device.
It simplifies the probe path by removing explicit error handling and
eliminates the remove callback.

> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drive=
rs/iio/position/hid-sensor-custom-intel-hinge.c
> index 7f6186fea0047..101d84b533c9e 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c

[ ... ]

> @@ -320,37 +321,13 @@ static int hid_hinge_probe(struct platform_device *=
pdev)
>  	st->callbacks.send_event =3D hinge_proc_event;
>  	st->callbacks.capture_sample =3D hinge_capture_sample;
>  	st->callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage, &st->callback=
s);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage, &st=
->callbacks);

[Severity: High]
This is a pre-existing issue, but can this sequence lead to a write-after-f=
ree
if a hardware event races with driver unbind or probe error?

During devm cleanup, sensor_hub_remove_callback() removes the callback from
the list without waiting for concurrent readers. The cleanup then immediate=
ly
frees the hinge_state structure allocated earlier.

If a concurrent HID hardware event triggers sensor_hub_raw_event(), can it
fetch the callback and execute hinge_capture_sample() after the structure
has been freed:

drivers/iio/position/hid-sensor-custom-intel-hinge.c:hinge_capture_sample()=
 {
    ...
    st->scan.hinge_val[offset] =3D *(u32 *)raw_data;
    ...
}

Should there be synchronization to ensure concurrent hardware events have
completed before the memory backing the callback is freed?

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_remove_trigger;
> -	}
> -
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_callback;
> +		return ret;
>  	}
> =20
> -	return ret;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D12
