Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139642C4F6
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345271; cv=none; b=kN3h4n6+fhtQiN6IpCTphygrYLW2ixc1fVmR24Ipfuip/zW+/nD/dCdOR7bVIkldF2iZiKa3Ec4g84tu5TlxIUs5iNuRzPKfIDeanW6SgH+/eCoiLVqk7ixhv0VTKXmQWHOhiErBXV1lkT95ZZUCY4BOgfxaWmi87Q1UBrw5KRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345271; c=relaxed/simple;
	bh=CvXnptDxWoiUuxltSdI56WGxljloVCvLtvbGh5aGQgo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lun2Dpi4leBq9vdXHmQi62PDzJyaO+hd5qNt8CFgShI0R0l1Dsdm/baxYf0UnuEI+/NHhD1NYLOUpa6VoxPW3sfxfmJ4V5dMi9HAIV44mje8CZFDbk3MFz8uxS2xdVIkIQgrCSCO8QoDXBR1uJsyKPIOEdbdndHnImg/k9RF9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imN5ADlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imN5ADlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1D81F00A3A;
	Wed, 29 Jul 2026 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345265;
	bh=lOhiCaS6CR5tjFk8wsyAFea1A+2ZPyx+w/5+wFy9g0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imN5ADlSg2upz8ciwHCFZRX9j9qKru6n2ic5U6kRLVwvUFaEMqYbEblI596Xz2yTb
	 iNZlWrP6dNAFeKNMcmxZAY9S4qvcOoL9stb66kQWxEEKJIUjx5yup18scV08hucPgF
	 Tnvkpj2GuOYBdUayTEJQqHs+3R0izLzSbpB6+VeTUxsc0wcTUrPZhR2cTatah9Kxyt
	 qmwnuGIa41DEv7QwjWQWJ/PBy8Q7mS5YrCthOfqZUw3QxB/MdXe48aFaXkJOnVc7IP
	 sJCk5M8EtjPcKSfR9qmpM2V3lbITtP2983pIY307tHPogRqnI0lE/7fDCEFWF6kEuE
	 pLj8Q6eBgaPkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] HID: wiimote: use scoped cleanup in wiimote and
 led probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael Passos" <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729164928.1138468-4-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-4-rafael@rcpassos.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:14:25 +0000
Message-Id: <20260729171425.9D1D81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The new `__wiimote_probe_cleanup` scoped cleanup function fails to=
 cancel asynchronous work queues (`init_worker`, `queue.worker`), shut down=
 timers, and unload modules before freeing `wdata`, leading to a use-after-=
free and memory leaks on the probe error path.
- [High] An out-of-bounds array read occurs in `wiimote_modules_load()` due=
 to integer promotion of the uninitialized `player_id`, causing the index c=
alculation to yield -1.
--

--- Patch [3]: [PATCH v3 3/4] HID: wiimote: use scoped cleanup in wiimote a=
nd led probes ---
commit 54b3fd3af006d3a0af4f6d249c24ee95bd657f14
Author: Rafael Passos <rafael@rcpassos.me>

HID: wiimote: use scoped cleanup in wiimote and led probes
   =20
Cleanup code in wiimote/led probe function, using the scoped cleanup.
This prevents mistakes in future changes to this function.

> diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-cor=
e.c
> index 762b3c383194e..31ee86affc553 100644
> --- a/drivers/hid/hid-wiimote-core.c
> +++ b/drivers/hid/hid-wiimote-core.c

[ ... ]

> @@ -1772,16 +1772,40 @@ static void wiimote_destroy(struct wiimote_data *=
wdata)
>  /* Global id allocator for wii remotes */
>  static DEFINE_IDA(wiimote_ida);
> =20
> +#define WIIMOTE_PROBE_HW_STARTED  BIT(0)  // hid_hw_start succeeded
> +#define WIIMOTE_PROBE_HW_OPENED   BIT(1)  // hid_hw_open succeeded
> +
> +static void __wiimote_probe_cleanup(struct wiimote_data *wdata)
> +{
> +	if (!wdata)
> +		return;
> +
> +	if (wdata->player_id)
> +		ida_free(&wiimote_ida, wdata->player_id);
> +
> +	// safe, debugfs checks IS_ERR_OR_NULL
> +	wiidebug_deinit(wdata);
> +	// safe, checks dev for NULL
> +	device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
> +	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
> +	if (wdata->probe_state & WIIMOTE_PROBE_HW_OPENED)
> +		hid_hw_close(wdata->hdev);
> +	if (wdata->probe_state & WIIMOTE_PROBE_HW_STARTED)
> +		hid_hw_stop(wdata->hdev);
> +	kfree(wdata);

[Severity: High]
Does this missing cancellation cause a use-after-free or memory leak if the
probe fails later?

During wiimote_hid_probe(), after hid_hw_start() and hid_hw_open() succeed,
the hardware is active and can generate HID events. These events are
processed by wiimote_hid_event(), which can asynchronously schedule
wdata->init_worker and wdata->queue.worker.

If a subsequent probe step like ida_alloc_min() fails, this cleanup function
runs and frees wdata without cancelling the work queues (cancel_work_sync()=
),
shutting down timers (timer_shutdown_sync()), or unloading modules.

If a worker accesses wdata after it has been freed, could it trigger a kern=
el
crash?

> +}
> +
> +DEFINE_FREE(wiimote_probe_cleanup, struct wiimote_data *,
> +	__wiimote_probe_cleanup(_T))
> +

[ ... ]

> @@ -1790,68 +1814,54 @@ static int wiimote_hid_probe(struct hid_device *h=
dev,
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>  	if (ret) {
>  		hid_err(hdev, "HW start failed\n");
> -		goto err;
> +		return ret;
>  	}
> +	wdata->probe_state |=3D WIIMOTE_PROBE_HW_STARTED;
> =20
>  	ret =3D hid_hw_open(hdev);
>  	if (ret) {
>  		hid_err(hdev, "cannot start hardware I/O\n");
> -		goto err_stop;
> +		return ret;
>  	}
> +	wdata->probe_state |=3D WIIMOTE_PROBE_HW_OPENED;

[Severity: High]
Can an event arriving here before player_id is initialized cause an
out-of-bounds read?

If the device sends a status report or hotplug event immediately after
hid_hw_open() completes, wiimote_hid_event() triggers and schedules
wdata->init_worker.=20

The worker calls wiimote_init_detect() -> wiimote_init_set_type() ->
wiimote_modules_load().

Because wdata->player_id is only populated later in this function, it is
still 0 when wiimote_modules_load() is called.

In wiimote_modules_load(), the calculation (wdata->player_id - 1) promotes =
to
int and evaluates to -1. The modulo operator (-1 % 4) yields -1, leading to
an out-of-bounds access on the player_leds array:

drivers/hid/hid-wiimote-core.c:wiimote_modules_load() {
    ...
    wiiproto_req_leds(wdata, player_leds[(wdata->player_id - 1) % 4]);
    ...
}

Could this lead to an infoleak or kernel oops?

> =20
>  	ret =3D device_create_file(&hdev->dev, &dev_attr_extension);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729164928.1138=
468-1-rafael@rcpassos.me?part=3D3
