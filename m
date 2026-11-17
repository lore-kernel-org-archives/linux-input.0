Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794894382;
	b=XDyqpQygR71dIbZsN3vMCE0JZzPnCzRSre3p5hJfmPZQwP+m41r0m9DPle+yj+Ja7TNj
	 9pBPD0hBoWU6VbBDWVgNIefoOQQyrt0kEdukHQ2/yjpoJIqctFsCiCGZavLVnnYAv7jRY
	 I2wRzs0tqHcsnXOga7EmnKiKMv4IkUXz6foetC5yl8+ZtUzSwjn3y86GwLvhJ6+wLgujM
	 68CpvTDSDKjTRUocHZQS2CNqirL5Bf6fU72fhtU518FAkLa6y7ILH6F+AmF9jnsk0sDTx
	 MKvytTJm18Bngegg0dwwddXWIyUSuHrGe2lvjjv0c8Oi46olLLWHUhrTyELre+NRvLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=11s5RacCD61v2mlEiATgR78GncDSVrJHxQ4dRKRnugA=;
	b=I447J0KI/XfitzTkz0wJE2TD2L2x0eUrB9ioivr+1GkA7hazL9wp+jDgGqdozpV9Sj47
	 nlQKA6fgFv2PBsRPDEbg61yp/5gjhCBSm2TfRTMt3VRCLfi8DyBAtThMx7/CnBVUwMjbv
	 aSborMevJHbr8FX2NOMqqVjLu/Tq9SJC9hsO3IHboWHSUiLDmUBktC+rT7CycJNGFy3on
	 upqgeyC0pY1AvWCqzFOD51EEx9riOELPhg+epIo9c6ITWjnXj5y6YPGgkbiykeC8PbK8C
	 qIkx1lFmSY1sWECnAOIhrwDR/7N9HR/YExFBv8PXzj5rJUrsaqvIf8f+/OrMWBYRJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8LKT1wW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF3606A31C;
	Tue, 17 Nov 2026 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L8LKT1wW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AC51F000C4;
	Tue, 17 Nov 2026 05:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794894381;
	bh=11s5RacCD61v2mlEiATgR78GncDSVrJHxQ4dRKRnugA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L8LKT1wWUcO9veDhdPeAGWXhxnD8uIWyw6lomkvyPvpzNNModLliGslOOazldOuu9
	 sDEzAA/WCuN0vIR86ujKurUVGO8d21+ShgQW3+bav8aGxE9dZmQktpLQBwnvyz9mEq
	 dbWP0NSOuotRrSYYtt71Uh0QAIUQ6WvEmPvk2PzZZzdGVldGNxTdHEIoLjpRsmL58D
	 /YYN4o6rSYJzysEWJIvKFMXNtZ5HpG9wWTqHN5ADcJinGazEwzvr+cGHEVErC3OAae
	 PUY3TJhxPAKCIZQvubQrMiMFXD7BtA1os8UgH3jpJiA6R29BYJudp2u1J7NbJTPV0L
	 CpB3O7ipYK/PA==
Message-ID: <sashiko-outbox-218219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] Input: aw86927 - stop playback over suspend and
 on shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117052112.32527-7-xiaqinghuan@mail.ustc.edu.cn>
References: <20261117052112.32527-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261117052112.32527-7-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 05:46:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] Input: aw86927: race in aw86927_close() and unbind queues
  play_work after stop
- [Low] Input: aw86927: commit message and comment mismatch on
  suspend/shutdown
--

commit 10d522b2154a0fe403051ae8e5379871fd0348a4
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

Input: aw86927 - stop playback over suspend and on shutdown

This commit adds system suspend, resume, and shutdown callbacks to stop
haptic playback and hold the chip in reset, and registers a devm action to
assert the reset GPIO on unbind or probe failure.

> diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
> index 1dbcba7988316..35a342131edff 100644
> --- a/drivers/input/misc/aw86927.c
> +++ b/drivers/input/misc/aw86927.c
[ ... ]
> @@ -444,6 +451,7 @@ static void aw86927_close(struct input_dev *input)
>  	int err;
> =20
>  	cancel_work_sync(&haptics->play_work);
> +	WRITE_ONCE(haptics->level, 0);
> =20
>  	err =3D aw86927_stop(haptics);
>  	if (err)
[ ... ]
> @@ -800,6 +809,13 @@ static int aw86927_detect(struct aw86927_data *hapti=
cs)
>  	return 0;
>  }
> =20
> +static void aw86927_reset(void *data)
> +{
> +	struct aw86927_data *haptics =3D data;
> +
> +	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
> +}
> +
>  static int aw86927_probe(struct i2c_client *client)
>  {
>  	struct aw86927_data *haptics;
> @@ -828,6 +844,10 @@ static int aw86927_probe(struct i2c_client *client)
>  		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
>  				     "Failed to get reset gpio\n");
> =20
> +	err =3D devm_add_action_or_reset(haptics->dev, aw86927_reset, haptics);
> +	if (err)
> +		return err;

[Severity: High]
Can haptics->play_work be scheduled after aw86927_close() and still be
running during driver unbind?

Clearing haptics->level in aw86927_close() while an ff-memless effect timer
is still armed lets ml_effect_timer() pass the READ_ONCE(haptics->level) =
=3D=3D
level check in aw86927_haptics_play() and queue haptics->play_work again.
This happens when an open device with an active effect is inhibited via
input_inhibit_device(), which calls dev->close() without calling
dev->flush() to stop ml->timer, or when input_flush_device() is interrupted
by a signal before input_close_device() runs.

If the driver is then unbound, input_close_device() skips aw86927_close() on
an inhibited device while input_flush_device() queues haptics->play_work to
stop the effect, and unlike aw86927_shutdown(), the devm aw86927_reset()
action does not call disable_work_sync(&haptics->play_work):

CPU0                                  CPU1 (kworker)
i2c_device_remove()
  ...
  __input_unregister_device()
    evdev_cleanup()
      input_flush_device()
        ...
        aw86927_haptics_play()
          schedule_work(&haptics->play_work)
      input_close_device()
        /* skipped: dev->inhibited */
  devres_release_all()
    aw86927_reset()
    /* regmap and haptics freed */
                                      aw86927_haptics_play_work()
                                        aw86927_stop(haptics)
                                          regmap_write(haptics->regmap, ...)
                                          <-- use-after-free

[ ... ]

> @@ -899,6 +919,51 @@ static int aw86927_probe(struct i2c_client *client)
>  	return 0;
>  }
> =20
> +static void aw86927_shutdown(struct i2c_client *client)
> +{
> +	struct aw86927_data *haptics =3D i2c_get_clientdata(client);
> +
> +	disable_work_sync(&haptics->play_work);
> +	aw86927_reset(haptics);
> +}
> +
> +static int aw86927_suspend(struct device *dev)
> +{
> +	struct aw86927_data *haptics =3D dev_get_drvdata(dev);
> +	int err;
> +
> +	guard(mutex)(&haptics->input_dev->mutex);
> +
> +	/* Block events from the memless effect timer before draining the work.=
 */
> +	scoped_guard(spinlock_irq, &haptics->input_dev->event_lock)
> +		haptics->suspended =3D true;
> +
> +	cancel_work_sync(&haptics->play_work);
> +	err =3D aw86927_stop(haptics);

[Severity: Low]
This isn't a bug, but the commit message and the comment in
aw86927_haptics_play() do not match what the suspend and shutdown callbacks
do.

The commit message states that both paths stop playback, drain the work item
and park the part in reset, whereas aw86927_suspend() only puts the chip in=
to
standby via aw86927_stop() without asserting reset, and aw86927_shutdown()
asserts reset via aw86927_reset() without calling aw86927_stop().  In
addition, the comment in aw86927_haptics_play() says the chip is powered
down and a queued event would only fail, but during suspend the chip is only
in standby and a queued event would re-arm playback over I2C.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117052112.3252=
7-1-xiaqinghuan@mail.ustc.edu.cn?part=3D6
