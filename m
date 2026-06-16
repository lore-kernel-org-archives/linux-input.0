Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05C2D8DD0
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608928; cv=none; b=vAl7QA4CpDo6fiRPeGZcfO/7UnMpNfBeKu7wCM5M8yPY+xD58O5bBS1jjs7pvJhKpkYK7eWzTrugKUCF0YVpTJz45UhTgpygSDjiz6r044LQ631rTYOQ7p/5DCfR+qYk520n/laV7YLg6ORSFFe4C6nVkCCoKXN35PXedntkJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608928; c=relaxed/simple;
	bh=QHHP1tlQRckJ6P+nySpLXGHHWasj2rfniCdDRzyyils=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qE2xaUE+B7jRNhixiBJ+yRwoeybXta/PPd4pDdiMRJXRRgkxK82lmcOoPtLkg++UKbYA52wPtlXbWSsHBxJ2Jd1Nk2rCgx5sxZLD/r6IEOg+0IFLYKPxSeYyTaifa1xkI0zAigsTQow4WkiEvPfXq0Ph3bPTeYkIHHzY2lhWMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzeXuReL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzeXuReL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BE81F00A3A;
	Tue, 16 Jun 2026 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781608927;
	bh=8i5GWISq+Bu+bZ1PjJBIAIzpeSRLGsMyGDChbEdH/+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzeXuReLxtoCBuo0TPX0gTysOB/5y+2hALW2/xqo0YMFWxMgUHrgzWm8wqSa5w4jr
	 S7q6ExEpHyZ6ju9vHX2ZuXcDnPSdA0LEz/OHGgL47iTaKuGpL/XEOdNWO4drGbRYTK
	 tkWm9HG4U4I62dDc+sNyB7I43n5PzlluyeREfg98buZBK4T2ZouBrYlfYNBkFHpatW
	 7+OnjPniXRyEVIG9vdewbA5Zz5c+B3bZ18f8D6nurXt07pQKJq8P/VGNwewuHSb1Uf
	 pqZjS+A7CsjcJ0Nl9Wx9nDK285689k5sQBCnTV5tGvi05Fq7zamGVcD9c/YeMff8UE
	 2NBf8s7ny6q6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] iio: hid-sensors: add missing blank line after
 declarations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-1-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-1-0cd544286575@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:22:06 +0000
Message-Id: <20260616112206.F2BE81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but pending asynchro=
nous suspend work is cancelled during device removal, leaving hardware powe=
red on indefinitely.
--

commit fb90a2bc06515600f67795b51872db81c06e23a2
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: hid-sensors: add missing blank line after declarations

Add a blank line after variable declarations to improve
readability and align with kernel coding style.

> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/driver=
s/iio/common/hid-sensors/hid-sensor-trigger.c
> index 417c4ab8c1b27..c8ccf96f3d035 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct de=
vice *dev)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb =3D iio_device_get_drvdata(indio_dev);
> +
>  	schedule_work(&attrb->work);
> +
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem where
pending asynchronous suspend work might be cancelled during device removal,
leaving the hardware powered on indefinitely.

During driver removal, iio_device_unregister() disables active iio buffers,
triggering buffer_predisable(). This calls hid_sensor_power_state() with
state false, which queues an asynchronous suspend:

hid_sensor_power_state() {
	...
	} else {
		atomic_dec(&st->user_requested_state);
		pm_runtime_use_autosuspend(&st->pdev->dev);
		ret =3D pm_runtime_put_autosuspend(&st->pdev->dev);
	}
	...
}

Immediately after, hid_sensor_remove_trigger() is called:

hid_sensor_remove_trigger() {
	if (atomic_read(&attrb->runtime_pm_enable))
		pm_runtime_disable(&attrb->pdev->dev);

	pm_runtime_set_suspended(&attrb->pdev->dev);
	...
}

Because pm_runtime_disable() cancels any pending asynchronous idle/suspend
work, is it possible the autosuspend work gets cancelled before execution?

If the work is cancelled, pm_runtime_set_suspended() would only update the
software pm state, leaving the actual physical hardware permanently powered
on. Does the driver need a synchronous suspend in the removal path before
disabling runtime pm?

> =20
> @@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(s=
truct device *dev)
>  {
>  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>  	struct hid_sensor_common *attrb =3D iio_device_get_drvdata(indio_dev);
> +
>  	return _hid_sensor_power_state(attrb, true);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-15-jun-hid=
-iio-alignment-v1-0-0cd544286575@gmail.com?part=3D1
