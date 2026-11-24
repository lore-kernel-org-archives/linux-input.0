Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485792;
	b=bUtYLiwcOzKB/DEmRQKw2E3cQWgvR6ea5//yOTn07RP1zf5DF3CLTldQuI5Rjrz/0M55
	 kVWJtz/dnJedylvZDQoxOuNBVtB0dwsz0IzTb6yuHvekNEl//zOK0tI0ayIhAoNf93Sal
	 nZTk4bTdTdeJRmoGl4qtcMza/OcF1lpZG++pEINpRVwRbgOmaocls8ZDnviwru/KeN7FV
	 xwMU1qHNopVXdxDRFLsj2Wt7F5GNhdeu0IXIzg8opcQ9sIT/0R9prDEaZxMvgFtbJ0vID
	 Vtliyr4TTZi/NV+Xu+9yT/ZK6Hm5Z6LjVLNiCHGbfPNXH5uLvQNN1MZnW0+am5TqSug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kt8dk7Aa6T6YNlLk28kW3BrJ5BHIb7GeM1dAn5MysX0=;
	b=OOQSVCVdaq/PEfsD18pjFgE2w4VdzbJ2Ov18aZWPaLpBHnVVsfBm0pUPz5TgRPUHQVXX
	 2ZFZT1vmWE6gZsp3PJ5+BLmT+XgfF3lq5yCDeySS5M63PPQADX4JLb59zGq4v2LIbKXbE
	 5Wd4LGOwWBWUKTtj+ducWZ+h4IxrdSJo0qAZ4bTbHtoChEo1biqkFyBr8PghxteZGCTZk
	 aact2Q9rwWZyGw4O5hSwM1eFC777FxneXa5Gz+MJS92+dhXraJGrA7/vts8rTsX9PJaSZ
	 hcIy38D4POzj9Slwi6R0/Zmv2x7BXwADc2vY33t0QEQy6erORRI5gNz3tBHwzJejrLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddurdLh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0A606A31E;
	Tue, 24 Nov 2026 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddurdLh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3221F000C6;
	Tue, 24 Nov 2026 02:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795485792;
	bh=Kt8dk7Aa6T6YNlLk28kW3BrJ5BHIb7GeM1dAn5MysX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddurdLh5+MnCGQGQKPLdIEEt1abS3qf+5B1zlqlTEbdz9PeL7uMPoq9PUaOyN7Op3
	 JNLXBQfPwy7BEjB3fMTew+BPgULbEfXVbddaWt6V7l/PkCRTJl7EGvWELtLly2DzQ3
	 /0STm0RJ72ZeXuywJu35XszKFTy2BJCdSef/LtGAt59nx/vwmDmVxt44m7kbYmnbFH
	 dNMu+Ejox4CfDKN1v6hyGDQ7+kxYRFiD5QbQCH0ZRjiNDhaTyKzvmkgfvRj7hPMCZX
	 Tv1+cvdQjg2HeKxMVBk7eeiGArBX0nVhZe8XkcyqVhTNemqRxj9PU1OvNKC/GZHx/q
	 /n3js7F+aD2Lw==
Message-ID: <sashiko-outbox-230375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] Input: aw86927 - stop playback over suspend and on
 shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124015028.1427420-7-xiaqinghuan@mail.ustc.edu.cn>
References: <20261124015028.1427420-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261124015028.1427420-7-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 02:03:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] Input: aw86927: missing Signed-off-by trailer in commit message
- [Medium] Input: aw86927: uninitialized work_struct in aw86927_reset()
  on probe error
- [Medium] Input: aw86927: race in aw86927_close() allows timer to
  restart playback
- [Low] Input: aw86927: inaccurate chip state claims in commit message
  and comment
--

commit a797a001f2024a181e85b8bd947512d590b74fb5
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

> Input: aw86927 - stop playback over suspend and on shutdown
>
> Playback is not stopped across system sleep or shutdown: an effect
>   that is
> being played when the system suspends keeps the chip driving the
>   actuator,
> and nothing holds the chip in reset on shutdown or unbind.
>
> Park the chip in standby on suspend (resume leaves it in reset, as probe
> does), assert reset on shutdown, and drain the work item in a devres
> action
> so it runs on unbind as well: the memless effect timer can queue the
>   work
> again when input_close_device() is skipped for an inhibited device, and
> the
> work must not reach the regmap after the device is gone.
> Changes since v2:
>  - [sashiko, 2026-11-17, High] "race in aw86927_close() and unbind
>   queues
>    play_work after stop": the devres action now drains the work item
>   before
>    asserting reset, so an effect timer that re-queued the work
>   (inhibited
>    device, or a flush interrupted by a signal) cannot reach the regmap
>   after
>    the device is gone.  aw86927_shutdown() calls the same helper.
>  - [sashiko, same report, Low] "commit message and comment mismatch on
>    suspend/shutdown": the message now states that suspend parks the
>   chip in
>    standby without asserting reset and shutdown asserts reset without a
>    separate stop, which is what the code does.

[Severity: High]
The commit message is missing a Signed-off-by: trailer.

> diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
> index e1b811e183ea2..a94eb27a82b1b 100644
> --- a/drivers/input/misc/aw86927.c
> +++ b/drivers/input/misc/aw86927.c
[ ... ]
> @@ -335,22 +337,26 @@ static int aw86927_haptics_play(struct input_dev *d=
ev, void *data, struct ff_eff
>  	struct aw86927_data *haptics =3D input_get_drvdata(dev);
>  	int level;
> =20
> +	/* The chip is powered down; a queued event would only fail. */
> +	if (haptics->suspended)
> +		return 0;

[Severity: Low]
This isn't a bug, but is this comment accurate?  aw86927_suspend() only
parks the chip in standby mode via aw86927_stop() rather than powering it
down, so events are ignored here to avoid restarting playback while
suspended.

Similarly, the commit message says "resume leaves it in reset, as probe
does", whereas both aw86927_probe() and aw86927_resume() leave the chip out
of reset in standby mode with SRAM initialized.  The "Changes since v2:"
notes should also go below the "---" separator rather than in the permanent
changelog.

[ ... ]

> @@ -410,6 +417,7 @@ static void aw86927_close(struct input_dev *input)
>  	int err;
> =20
>  	cancel_work_sync(&haptics->play_work);
> +	WRITE_ONCE(haptics->level, 0);
> =20
>  	err =3D aw86927_stop(haptics);
>  	if (err)

[Severity: Medium]
Can clearing haptics->level in aw86927_close() without blocking
aw86927_haptics_play() cause ml_effect_timer() to restart playback while or
after the device is closed?

When the input device is inhibited via input_inhibit_device(), or when
input_flush_device() is skipped for a revoked client or interrupted by a
signal in evdev_release(), active memless effects are not flushed before
dev->close() runs:

CPU0                                    CPU1 (<softirq>)
aw86927_close()
  cancel_work_sync(&haptics->play_work)
  WRITE_ONCE(haptics->level, 0)
                                        ml_effect_timer()
                                          aw86927_haptics_play()
                                            /* haptics->level (0) !=3D leve=
l */
                                            WRITE_ONCE(haptics->level, leve=
l)
                                            schedule_work(&haptics->play_wo=
rk)
  aw86927_stop(haptics)
                                        aw86927_haptics_play_work()
                                          aw86927_play_sine()  <-- restarts

Because haptics->level is reset to 0, even a constant-magnitude effect that
previously matched haptics->level sees a level change on the next timer tick
and schedules play_work, leaving the actuator running while the device is
closed or inhibited.

[ ... ]

> @@ -762,6 +771,20 @@ static int aw86927_detect(struct aw86927_data *hapti=
cs)
>  	return 0;
>  }
> =20
> +static void aw86927_reset(void *data)
> +{
> +	struct aw86927_data *haptics =3D data;
> +
> +	/*
> +	 * Drain the worker before the regmap can go away: this action also runs
> +	 * from devres on unbind, where input_close_device() may have been skip=
ped
> +	 * (inhibited device) and the memless effect timer can have queued the
> +	 * work again.
> +	 */
> +	disable_work_sync(&haptics->play_work);
> +	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
> +}
> +
>  static int aw86927_probe(struct i2c_client *client)
>  {
>  	struct aw86927_data *haptics;
> @@ -790,6 +813,10 @@ static int aw86927_probe(struct i2c_client *client)
>  		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
>  				     "Failed to get reset gpio\n");
> =20
> +	err =3D devm_add_action_or_reset(haptics->dev, aw86927_reset, haptics);
> +	if (err)
> +		return err;

[Severity: Medium]
Does aw86927_reset() call disable_work_sync(&haptics->play_work) before
haptics->play_work is initialized if probe fails early?

aw86927_probe() does not call INIT_WORK(&haptics->play_work, ...) until
after the software reset, aw86927_detect(), interrupt register setup, and
devm_request_threaded_irq().  If any of those steps fails, devres runs
aw86927_reset() with play_work.func still NULL, triggering
WARN_ON(!work->func) in __flush_work().  Initializing haptics->play_work
before devm_add_action_or_reset() avoids this regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124015028.1427=
420-7-xiaqinghuan@mail.ustc.edu.cn?part=3D1
