Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248B411695
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543006; cv=none; b=XkoDtjdFDLqPVyIOESFs4/9feC8uNlJSkn5WiMsEnGlZzMO7au/va5S82HYNwbP128eLTHZ6/HhlHKNH1WOWZk+qsykDU8LzbB1/sVl3fiAFfHRMJMtcWDI+dieh9EXCbHQ5adhHC0or3MYFfN4VV6FWpR5j3XmTuU1UlRAdSt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543006; c=relaxed/simple;
	bh=ugRjNXgy5zZmr4yLkm3ltLmexl/4+s0Ke6vrNd/dml4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oSCZgMZo66kln/yoN+oV/mQpE6xHotmby2T46+9jxmfX613WCxcHtpQx4Zvrl7GFX+z4xOTwZ03jvfWBgMZFBAT5qpeMd1OqCCjRn0fUjR8fUfkW4ZsvhsaJDRlgnJiDwp+8jIotATHSRXSH57OS5NBnF3GC3s0/f61/oZ4uUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rca8knqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rca8knqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41681F000E9;
	Mon, 15 Jun 2026 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781543005;
	bh=C/enA5KltlGj1tPALX4vEUo/u+CshtKBEWR5inV9/RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rca8knqcNkKbyZes5VQdyic18ZxVld3o5QZ/WWfMhRUkX0vI67zcVbR8/u17lsF2X
	 vTMjX9FekwuSa6FbNZGNJy79evbdQ+X73Nk4biMH1ribWUSWWkf+uuRwQG3hs18maZ
	 ugrEiB+4Fg+/Zrb7OQkZeiTLnPvoH1OgqvXHlNMe2FsoW17I48qJlsNYK8CWAedH9N
	 J5bDc/s5pMQSP7MlNi0/X1n1O4FgPyqtRH/P5+6AemUNFAsx4WNfzSK45WpZHEmJ3V
	 zs2eeVT72gTczu6YzMxb/+6LJpRF1b3d1PSZBeMYhdn1bLFX9GxsUZu+hao843kCBN
	 K27i/bYVq827w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] HID: asus: refactor the two workqueues and init
 sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260615165058.3845-2-denis.benato@linux.dev>
References: <20260615165058.3845-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:03:24 +0000
Message-Id: <20260615170324.F41681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleeping in atomic context due to implicit GFP_KERNEL allocations =
in HID event handlers.
- [High] Data race on shared `hid_report` object when calling `hid_report_r=
aw_event()` asynchronously from the workqueue.
- [High] Use-After-Free due to un-canceled workqueue items if `hid_hw_start=
()` fails during probe.
--

commit 29efc59c7a1d251ec0726f58d50488da03f9ba12
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: refactor the two workqueues and init sequence
   =20
    Join the two workqueues into one reusing the stopping mechanism
    of the brightness workqueue, use the joined workqueue to also
    move the asus_wmi_send_event() sleeping call away from atomic
    context and add a size check in asus_raw_event().

    Link: https://lore.kernel.org/all/20260613154732.60A4B1F000E9@smtp.kern=
el.org/

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -331,25 +380,71 @@ static int asus_e1239t_event(struct asus_drvdata *d=
rvdat, u8 *data, int size)
[ ... ]
> +static int asus_kbd_fn_lock_set(struct asus_drvdata *drvdata, bool enabl=
ed)
> +{
> +	struct asus_work_action *action;
> +	unsigned long flags;
> +
> +	action =3D kzalloc_obj(struct asus_work_action);

[Severity: High]
Does this allocation sleep in an atomic context?

Because kzalloc_obj() implicitly uses default_gfp() which resolves to
GFP_KERNEL, this introduces a blocking allocation. Since
asus_kbd_fn_lock_set() is called directly from the raw HID event handler
asus_event() which runs in an atomic context, this might trigger kernel
panics or deadlocks under load.

> +	if (!action)
> +		return -ENOMEM;
[ ... ]
> +static int asus_kbd_wmi_fan_send(struct asus_drvdata *drvdata, u8 *repor=
t_data,
> +				 size_t report_size)
> +{
> +	struct asus_work_action *action;
> +	unsigned long flags;
> +
> +	if (report_size > FEATURE_KBD_REPORT_SIZE) {
> +		hid_err(drvdata->hdev, "Invalid report size for fan event: %zu\n", rep=
ort_size);
> +		return -EINVAL;
>  	}
> =20
> +	action =3D kzalloc_obj(struct asus_work_action);

[Severity: High]
Similarly, does this kzalloc_obj() introduce a blocking allocation in an
atomic context?

asus_kbd_wmi_fan_send() is invoked from the asus_raw_event() handler, which
also executes in an atomic context.

> +	if (!action)
> +		return -ENOMEM;
[ ... ]
> @@ -569,59 +668,151 @@ static int asus_kbd_disable_oobe(struct hid_device=
 *hdev)
[ ... ]
> +static void asus_kbd_wmi_fan(struct hid_device *hdev, struct hid_raw_eve=
nt_data *data)
> +{
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret;
> +
> +	ret =3D asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
[ ... ]
> +	/* Fallback: pass the raw event to the HID core */
> +	hid_report_raw_event(hdev, HID_INPUT_REPORT,
> +			     data->report_data, data->report_size,
> +			     data->report_size, 1);

[Severity: High]
Can this data race with native HID IRQ delivery?

If notifying the WMI system of a fan key event fails, the deferred work
handler asus_kbd_wmi_fan() falls back to injecting the raw event into the
HID core using hid_report_raw_event().

However, hid_report_raw_event() parses the report and mutates the shared
report->field state arrays without taking any locks. Because the workqueue
bypasses the hid->driver_input_lock semaphore used by the native IRQ path,
a concurrent hardware interrupt targeting the same report ID could race with
this workqueue. This might lead to unsynchronized reads and writes to
field->value and field->new_value, potentially corrupting the core HID
report state.

> +}
[ ... ]
> @@ -1294,6 +1465,12 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
[ ... ]
> +	ret =3D asus_worker_create(hdev, drvdata);
> +	if (ret) {
> +		hid_warn(hdev, "Failed to initialize worker: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  	if (ret) {
>  		hid_err(hdev, "Asus hw start failed: %d\n", ret);
>  		return ret;
>  	}

[Severity: High]
Could this leak a pending work item and cause a use-after-free if
hid_hw_start() fails?

During driver probe, asus_worker_create() creates a devres-managed worker
struct. Next, hid_hw_start() connects the device, invoking
asus_input_configured(), which synchronously schedules a FN_LOCK_SYNC
work item on the global workqueue.

If hid_hw_start() subsequently fails (e.g., due to an input registration
error later in the sequence), asus_probe() captures the error and returns
it directly, bypassing the err_stop_hw label. Consequently, it fails to
call asus_worker_stop() or cancel_work_sync().

The devres framework will automatically free the worker memory, but the
scheduled work item remains active. When the system workqueue eventually
executes the pending work, it will dereference the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165058.3845=
-1-denis.benato@linux.dev?part=3D1
