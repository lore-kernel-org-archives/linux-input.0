Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794161562;
	b=LIFSnLsXns1aGWRuFI0zWs0vHoQKxTSCWJNREhNCL1dCDI6pYBcLO3iDtjPKsbOerLCJ
	 Ftn/imr++bsR/ll6mK02h3E256gb49WIbWcQfzxm7pIVchUZ+TiPuJtIQz3oHTKT4XYZs
	 zLcURK5cFvBcBSUrnGyvMZIfoxlGzRYjqkD3D+LjdObLOULD4YRuxmoXd01/8CeSU9DMr
	 SyTdoKXNwnHqK0PEmE6iIH1/jcqj2OEFz8vpkPdBuwjzRcePaIA6K4Jev3qlcDN5dtya+
	 EHPI/OjbvJ6j9u3Jo0iarzG95xT8JBpxo+iqEiL55aBvfTbXx9IaeJClOWfHxY4/Hww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794161562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bL+CVzi1BCspXVrcUqLqj3fXYTflPR6wIEHZAqYNHs8=;
	b=z7aT047qcqo2zuP5TnyyM94sJlgb6kuAL9ReAox1pzf92PoXVCusuqoSq8f2oQpgucXi
	 KLKoHuYuE2CCtpBp89U77BjqiAiLWHaBruRg2q1B3YjMI3Rggd0XasoMbsBM2btgaWIhb
	 f91AaicjHf4w/evrZg2ctMlPYA9RDbXmiiXt9rNitaIy7KbARlLPQP9W7RMCk3WK9rMJ4
	 o+9JyApIKSxe1PqF2bkIc/U4PlA8h+9mbgAvJ8jrTl5KsdQ16tNt1uqqfqr5H6ndEIbn+
	 02i2oL7cNuz+kJVVgxbwtUrI9/HkcSf/jQBfGRDTzBD8EiNtJXnEMjFKgbLazjbejdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAJC6hJA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696E606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAJC6hJA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD52D1F0089F;
	Sun,  8 Nov 2026 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794161562;
	bh=bL+CVzi1BCspXVrcUqLqj3fXYTflPR6wIEHZAqYNHs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kAJC6hJAvzt4Jf40VCbPmk8P8z6395HTyLPmJjOS1La1hUUb3W6kp1HbqUBFEcW/Z
	 QqPe05IVCFpJ2bBTGQz6NRgNJbGZLhI1mpJuv0/AADKxd6g0frm8ZT93nlrU0poyg3
	 kRNMZE44Xph7Dv7LI+RmyyDw/dWqsN4QrFWjJM0HZV777rvcPkHC4813zLURK+doVs
	 xvlCIAJzJINVe2MK2GW+mwqUWNlso1VSvNPcxuYfJl8JbK9k2xjhNXBRsCPr6cF9Bk
	 DE+2kWZOgYnhKCueidOcl93NHVLER2mB0TnYt+eYcdktO4HFKiDaEBREcbctFFwo4l
	 nFe/sbaA82q0g==
Message-ID: <sashiko-outbox-203898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: microsoft: fix use-after-free of ff_worker on
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: hyunjungg <hj351016@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108175205.722820-1-hj351016@gmail.com>
References: <20261108175205.722820-1-hj351016@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 18:12:41 +0000
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
- [Medium] HID: microsoft: cancelling ff_worker after hid_hw_stop()
  races with stop()
- [Low] HID: microsoft: Fixes trailer cites 73c5b254c365 instead of
  1cfc77a64b71
--

commit 4c6868d5ba6d04af120ee3895542c5a22d96e529
Author: Hyunjung Ko <hj351016@gmail.com>

> HID: microsoft: fix use-after-free of ff_worker on teardown
>
> ms_play_effect() schedules ms->ff_worker to send the force-feedback
> report; ms (and ms->output_report_dmabuf) is devm-allocated, so it is
> freed by devres after ms_remove() returns. The work was never cancelled
> on teardown, so ms_ff_worker() could run against freed memory.
>
> Draining the work is not quite enough on its own:
>
>  - hid_hw_stop() in ms_remove() unregisters the input device, whose
>    teardown (input_ff_flush() -> ms_play_effect()) can re-queue ff_worker,
>    so the work must be cancelled *after* hid_hw_stop(), not before;
>  - ff_worker was only INIT_WORK()'d in ms_input_configured() for devices
>    with force-feedback, so cancelling it unconditionally would hit the
>    WARN_ON(!work->func) in __flush_work() for the other MS devices; and
>  - if hid_hw_start() fails in ms_probe() after force-feedback was
>    registered, its unwind can likewise schedule ff_worker, which was then
>    left pending when ms_probe() returned.
>
> Initialise ff_worker unconditionally in ms_probe() (so it is always valid
> to cancel), cancel it on the hid_hw_start() error path, and cancel it in
> ms_remove() after hid_hw_stop().
>
> Not runtime-tested (requires MS force-feedback hardware).
>
> Fixes: 73c5b254c365 ("HID: microsoft: Add rumble support for Xbox One S c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

[Severity: Low]
Should the Fixes tag reference 1cfc77a64b71 ("HID: microsoft: move FF
initialization to .input_configured()") instead?

73c5b254c365 ("HID: microsoft: Add rumble support for Xbox One S
controller") defined ms_remove_ff() to call cancel_work_sync() after
hid_hw_stop() in ms_remove(), and only initialized force-feedback after
hid_hw_start() succeeded.  1cfc77a64b71 ("HID: microsoft: move FF
initialization to .input_configured()") deleted ms_remove_ff() and moved
INIT_WORK() and input_ff_create_memless() into ms_input_configured().

> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index a7d3493a6141e..1042a5247c4e5 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c

[ ... ]

> @@ -377,6 +382,7 @@ static int ms_probe(struct hid_device *hdev, const st=
ruct hid_device_id *id)
>  				HID_CONNECT_HIDINPUT_FORCE : 0));
>  	if (ret) {
>  		hid_err(hdev, "hw start failed\n");
> +		cancel_work_sync(&ms->ff_worker);
>  		return ret;
>  	}
> =20
> @@ -384,7 +390,16 @@ static int ms_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
>  }
>  static void ms_remove(struct hid_device *hdev)
>  {
> +	struct ms_data *ms =3D hid_get_drvdata(hdev);
> +
> +	/*
> +	 * hid_hw_stop() unregisters the input device, whose teardown can
> +	 * re-queue ff_worker via input_ff_flush() -> ms_play_effect(). Drain
> +	 * the work after hid_hw_stop() so it cannot run against the
> +	 * devm-freed ms once ms_remove() returns.
> +	 */
>  	hid_hw_stop(hdev);
> +	cancel_work_sync(&ms->ff_worker);
>  }

[Severity: Medium]
Does waiting until after hid_hw_stop() to cancel ms->ff_worker allow
ms_ff_worker() to call hid_hw_output_report() concurrently with or after
hdev->ll_driver->stop()?

CPU0                                  kworker
ms_remove()
  hid_hw_stop(hdev)
    hid_disconnect(hdev)
      ...
        input_ff_flush()
          ...
            ms_play_effect()
              schedule_work(&ms->ff_worker)
    hdev->ll_driver->stop(hdev)
                                      ms_ff_worker()
                                        hid_hw_output_report(hdev, ...)
                                          hdev->ll_driver->output_report(..=
.)
                                          <-- runs during or after stop()
  cancel_work_sync(&ms->ff_worker)

hid_hw_stop() invokes hdev->ll_driver->stop(hdev) immediately after
hid_disconnect(hdev) before returning to ms_remove() (and similarly when
hid_hw_start() unwinds on failure in ms_probe()).  For Bluetooth and UHID
transports, this queues an output report after hidp_stop() has purged the
transmit queue or after uhid_hid_stop() has queued UHID_STOP.

Calling disable_work_sync(&ms->ff_worker) before hid_hw_stop() would drain
any in-flight work while the transport is still active and prevent
input_ff_flush() from re-queueing it during input device teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108175205.7228=
20-1-hj351016@gmail.com?part=3D1
