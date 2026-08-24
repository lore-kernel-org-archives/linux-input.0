Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240838E8C3
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604023; cv=none; b=B3X3YFtkcW6omZCJDpnWaY2KQ1TILCrv2KzEDADuRNPhV61W8TkU0kGuFGX93WQv5LS18CRj0+LUMi4H5nVP7yq0E4sXLmj/Xt/lvMYdZ0eBLw1DLRofH6UoLjD8/QyuUPm+ZMhFMAxuLL8Aj/yBaZJaiwUCe849lPNi5ZGDkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604023; c=relaxed/simple;
	bh=5hZxCE8Uy47L/8RhXznirld9ia5AXtzwQxsHakAiveo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IBwu86EI73d1x0eOPspzPmSWSnGInbnrUC9+4HXWPrepvVvZY5SjwoqbhZ4l8ai8D7JOClCEql8WOSEvS/lkLHO/t53EqtIBSsSJDvJESnY+4UqigkU+wqxHegKcT3RrQ089mafG8uCTp41yHGjQealZ3Y/zTkld72yEIq1rkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3iGBYta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3iGBYta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E61F000E9;
	Mon, 24 Aug 2026 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787604021;
	bh=tuJXxoSufd32Zb8YkSs+EmiYEG8+kecXG7HRr8Q0kM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3iGBYtahFsvzjGXYFQuUBugD49wVqgZgAfyDKnX6o/G8l45NveneymVSrIyoP6rK
	 +nPXLVwBOYO3EkvJiltW6v1m3GRdE5CWTyThJy7pIvgSclFFvU4pTpNgqcMYVBMUnX
	 W1yB62kGW3WsjVt5Ll0W6y8i4iWXX/D9ToOF9EIS2R6IZ4V8EGVimXGXA0A/a9Qcmr
	 hUIurApHjHvsdVhwWFcHAg1IED8zprOzUSn/0PI3TxGhFPH9v9gdjHprF6yxV/2/Un
	 H1KI5RV5tPooASTlgt/p9hWcVLZ/2q8WxQILKNAkyWtWf9q4niaWUeOoYniVQYJPHr
	 3viOuVsciruow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] ALSA: usb-audio: expose the Topping M62's
 analogue gains as mixer controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824201331.304705-2-mikhail.v.gavrilov@gmail.com>
References: <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
 <20260824201331.304705-1-mikhail.v.gavrilov@gmail.com>
 <20260824201331.304705-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 20:40:21 +0000
Message-Id: <20260824204021.7D5E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] ALSA mixer callbacks access `private_data` without holding `snd_us=
b_lock_shutdown()`, leading to a Use-After-Free on device disconnect.
- [High] Memory Allocation Deadlock during System Resume due to `GFP_KERNEL=
` allocation inside `usb_interrupt_msg()`.
- [High] Use-After-Free of `tm->iface` in `topping_private_free()` because =
no reference count was taken on the USB interface.
- [Medium] The URB completion handler permanently drops the interrupt polli=
ng loop on transient USB errors.
--

--- Patch [1]: [PATCH v5 1/2] ALSA: usb-audio: expose the Topping M62's ana=
logue gains as mixer controls ---
commit da50971ed7815f82050b21f7d59c4472171b1ad1
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: ALSA: usb-audio: expose the Topping M62's analogue gains as mixer =
controls

This commit introduces a mixer quirk for the Topping M62 to expose its
hardware analogue gains and output volumes. The device hides these behind
a custom vendor protocol on a HID-class interface. The patch claims the
interface and uses an interrupt URB and scheduled keepalive messages to
sync the state with ALSA controls.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..2f42b26336266
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
> @@ -0,0 +1,587 @@

[ ... ]

> +static int topping_send(struct topping_mixer *tm, u8 target, u8 prop,
> +			s32 value)
> +{
> +	/*
> +	 * NOIO rather than KERNEL: this is called from the resume path
> +	 * too, where reclaim can wait on a block device that has not
> +	 * woken yet.  The frame is fifteen bytes; nothing is lost by
> +	 * asking for it without I/O.
> +	 */
> +	u8 *buf __free(kfree) =3D kzalloc(TOPPING_EP_BUF, GFP_NOIO);
> +	int err, actual;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The shutdown lock is what makes a write safe against disconnect:
> +	 * the teardown waits for everyone holding it before the card goes
> +	 * away, so the device and this mixer are alive for as long as it
> +	 * is held.
> +	 */
> +	CLASS(snd_usb_lock, pm)(tm->mixer->chip);
> +	if (pm.err < 0)
> +		return -EIO;
> +	topping_build(buf, target, prop, value);
> +	err =3D usb_interrupt_msg(tm->mixer->chip->dev, tm->pipe_out,
> +				buf, TOPPING_FRAME_LEN, &actual, 1000);

[Severity: High]
Could the use of usb_interrupt_msg() here cause a memory allocation deadlock
during system resume?=20

While the buffer is allocated with GFP_NOIO, usb_interrupt_msg() calls
usb_bulk_msg() which unconditionally allocates a new URB using GFP_KERNEL.
Since topping_send() is called from topping_resume(), this GFP_KERNEL
allocation might sleep on block I/O while the device is suspended, leading
to a deadlock.

> +	if (err < 0)
> +		usb_audio_err(tm->mixer->chip,
> +			      "Topping: write %02x/%02x failed: %d\n",
> +			      target, prop, err);
> +	return err;
> +}

[ ... ]

> +static void topping_urb_complete(struct urb *urb)
> +{
> +	struct topping_mixer *tm =3D urb->context;
> +	const u8 *f =3D urb->transfer_buffer;
> +	int idx, value, err;
> +	bool changed;
> +
> +	if (urb->status)
> +		return;		/* resubmitted below only when running */

[Severity: Medium]
Will this early return permanently drop the interrupt polling loop on
transient USB errors?=20

If urb->status returns a non-terminal error such as -EPROTO or -EILSEQ due
to bus noise, the handler exits without resubmitting the URB. This would
stop the hardware update stream permanently until the device is replugged.

> +	if (urb->actual_length < TOPPING_FRAME_LEN)
> +		goto resubmit;

[ ... ]

> +static int topping_ctl_get(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct topping_mixer *tm =3D elem->head.mixer->private_data;
> +
> +	guard(spinlock_irqsave)(&tm->lock);

[Severity: High]
Does this code need to take the ALSA USB shutdown lock before dereferencing
the private data?=20

If a userspace process continuously accesses this mixer control while the
USB device is physically disconnected, topping_private_free() could free
the tm structure during or just before the execution of this callback.
Without CLASS(snd_usb_lock, pm)(chip), this might lead to a use-after-free.

> +	ucontrol->value.integer.value[0] =3D tm->val[elem->control];
> +	return 0;
> +}
> +
> +static int topping_ctl_put(struct snd_kcontrol *kctl,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct usb_mixer_elem_info *elem =3D kctl->private_data;
> +	struct usb_mixer_interface *mixer =3D elem->head.mixer;
> +	struct topping_mixer *tm =3D mixer->private_data;

[Severity: High]
Is it possible for the mixer->private_data pointer to be freed concurrently
here?

Similar to topping_ctl_get(), if the device is disconnected, this callback
might execute after topping_private_free() has already freed the tm
structure. Taking the ALSA USB shutdown lock before dereferencing the data
would prevent this use-after-free.

> +	const struct topping_ctl_desc *d =3D &tm->ctls[elem->control];
> +	int value, err;

[ ... ]

> +static void topping_private_free(struct usb_mixer_interface *mixer)
> +{
> +	struct topping_mixer *tm =3D mixer->private_data;
> +
> +	if (!tm)
> +		return;
> +	cancel_delayed_work_sync(&tm->keepalive);
> +	if (tm->urb) {
> +		usb_kill_urb(tm->urb);
> +		usb_free_coherent(mixer->chip->dev, TOPPING_EP_BUF,
> +				  tm->inbuf, tm->inbuf_dma);
> +		usb_free_urb(tm->urb);
> +	}
> +	if (tm->claimed)
> +		snd_usb_release_iface(tm->iface);

[Severity: High]
Could tm->iface have already been freed by the USB core here?

Since the interface was claimed without incrementing its reference count
via usb_get_intf(), the USB core might unbind and free this secondary HID
interface upon device unplug while the ALSA sound card is still held open by
userspace. Later, when the card is closed, this function will pass the freed
pointer to snd_usb_release_iface(), causing a use-after-free.

> +	kfree(tm->val);
> +	kfree(tm->kctl);
> +	kfree(tm);
> +	mixer->private_data =3D NULL;
> +}

[ ... ]

> +int snd_topping_init(struct usb_mixer_interface *mixer)
> +{
> +	struct snd_usb_audio *chip =3D mixer->chip;
> +	struct usb_interface *iface;
> +	struct topping_mixer *tm;
> +	int ep_in =3D 0, ep_out =3D 0, interval =3D 5;
> +	int i, err;
> +
> +	iface =3D topping_find_iface(chip, &ep_in, &ep_out, &interval);
> +	if (!iface) {
> +		usb_audio_err(chip, "Topping: no vendor HID interface\n");
> +		return 0;	/* not fatal: the card still plays */
> +	}
> +	if (usb_interface_claimed(iface)) {
> +		usb_audio_err(chip,
> +			      "Topping: the HID interface is already claimed\n");
> +		return 0;
> +	}
> +
> +	tm =3D kzalloc_obj(*tm);
> +	if (!tm)
> +		return -ENOMEM;
> +
> +	tm->mixer =3D mixer;
> +	tm->iface =3D iface;

[Severity: High]
Should we be taking a reference to the interface here using usb_get_intf()?

Caching the pointer without an additional reference can leave the pointer
dangling if the USB core unbinds the interface on physical disconnect before
topping_private_free() is invoked.

> +	tm->ctls =3D topping_m62_ctls;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824201331.3047=
05-1-mikhail.v.gavrilov@gmail.com?part=3D1
