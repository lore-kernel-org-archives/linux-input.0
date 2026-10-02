Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EF4766AC
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932467; cv=none; b=HJicTBqxOiAH4jX4EMeOjT7Sm+Li19n2Jn+fWXotq0+0WCYsT40QPa0fiES8kdDOQY45l0io4sRiHdZh2zp/Pdc8BAjet78QkxBb7CB/3ndZ4qEShbf3Abzj0hgcL4JkvUJuhf0+ZVO9D775qTzxDq6qzVd1/kI3fdg8d/6D708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932467; c=relaxed/simple;
	bh=5290cQ+S3VkUvgmz8YxexEdfhEURdCugElxNFak8thM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDJdpcP+vdzzOWVEGJ2GwXWfxiTkS7/T6sJHokGjR2T0b7GFYLgdcZqfeKPjvLal3zFG0bdh2bApTiLqIUjsK/4ee0d/q/EjqGn5hiZgd/wFfitAjJBtFqXhzpW1AiU9OwEsS4zt0fYdpJFH4YkYlI0M1GmwzA/3VgtAx+20IAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A44lQQBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A44lQQBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E40E1F000FF;
	Fri,  2 Oct 2026 09:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932465;
	bh=HTcKMeosnWHINk79SDS/mjCRXp67hR0EL8G9Z7p4JB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A44lQQBtHGIVdPaBvuVfc6lzlvC5R6VGih6HKDZFzrTEvBxuIo/IH/iHU7mqtBaMn
	 mE2cxzC3MzB0RPoad+opm+Rp/fYUb9w0M60hwzh/86pX//3IV5tuKHkNlHiSBXaGdu
	 EbEk1U3nLV1WemIPOrFcOliqI1wilXMpusad3nhRASZ5ap3dSqyVI1SpgwqSW2+rOJ
	 bTC74XiDnCNnGTjJHL3CwbIev8b0pMahCNPHxFNLLKvozP5PnGYl2QrWOOTsWwluUt
	 uc06w/U/mfQgmaHzLh0R4VfKhhQbnB6ILc4r9xJuZc+Vb5mSOFZgXn9SdNvR4s/EbJ
	 nHdLABcQGPH5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/4] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261002002929.1578115-2-vi@endrift.com>
References: <20261002002929.1578115-1-vi@endrift.com>
 <20261002002929.1578115-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:25 +0000
Message-Id: <20261002091425.6E40E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] hid: nintendo: devm_led_classdev_register causes circular referenc=
e and UAF
- [High] hid: nintendo: switch2_usb_message_in_work accesses ns2 without kr=
ef leading to UAF
- [High] hid: nintendo: state machine restart in switch2_remove leads to UA=
F and leak
- [High] hid: nintendo: switch2_usb_disconnect UAF due to missing usb_kill_=
urb
--

commit c3c5a054be7d9d99ff307ce80f5e14be33bc3411
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add preliminary Switch 2 controller driver

This commit adds a new driver for Nintendo Switch 2 controllers utilizing a
split-interface design. It supports USB communication for Switch 2 Joy-Cons,
Pro Controllers, and GameCube NSO controllers.

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> --- /dev/null
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c
[ ... ]
> +static void switch2_usb_message_in_work(struct work_struct *work)
> +{
> +	struct switch2_usb *ns2_usb =3D container_of(work, struct switch2_usb, =
message_in_work);
> +	struct switch2_urb *urb;
> +	int err;
> +	int i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		urb =3D &ns2_usb->bulk_in[i];
> +		if (urb->state !=3D NS2_URB_IN)
> +			continue;
> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +		if (ns2_usb->cfg.parent) {
> +			err =3D switch2_receive_command(ns2_usb->cfg.parent,
> +				urb->urb->transfer_buffer, urb->urb->actual_length);

[Severity: High]
Does this access the parent controller without holding a reference?

If switch2_controller_attach_cfg() fails, the kref on the parent controller
is dropped before cancelling this worker. At the same time, if the HID devi=
ce
unbinds, switch2_remove() can drop the final kref and free the structure.

If this worker thread is preempted after reading the pointer but before
acquiring the lock, could it wake up and call switch2_receive_command() on
the freed structure?

> +			if (err)
> +				dev_dbg(&ns2_usb->udev->dev, "receive command failed: %d\n", err);
> +		} else {
[ ... ]
> +static void switch2_usb_disconnect(struct usb_interface *intf)
> +{
> +	struct switch2_usb *ns2_usb =3D usb_get_intfdata(intf);
> +	unsigned long flags;
> +	struct urb *urb;
> +	uint8_t *data;
> +	int i;
> +
> +	/* Prevent any further IN URBs from being scheduled */
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	ns2_usb->shutdown =3D true;
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> +	cancel_work_sync(&ns2_usb->message_in_work);

[Severity: High]
Could this lead to a use-after-free if an unanchored URB completes?

The USB core unanchors URBs before invoking their completion handlers.
If switch2_bulk_in() is executing, usb_kill_anchored_urbs() will not find i=
t.

This allows cancel_work_sync() to return immediately. When the preempted
completion handler resumes, it will execute schedule_work() on the devres
managed structure that may have already been freed.

Should this explicitly wait for unanchored URBs by tracking them and calling
usb_kill_urb() on each?

> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +		urb =3D ns2_usb->bulk_in[i].urb;

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
> +	struct input_dev *input;
> +	struct hid_device *hdev =3D ns2->hdev;
> +	int player_led_pattern;
> +	int i;
> +	int ret;
[ ... ]
> +		led->flags =3D LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE | LED_RETAIN_=
AT_SHUTDOWN;
> +		char *name =3D devm_kasprintf(&input->dev, GFP_KERNEL, "%s:%s:%s",
> +				      dev_name(&input->dev),
> +				      "green",
> +				      joycon_player_led_names[i]);
> +
> +		if (!name) {
> +			dev_err(&input->dev, "Failed to allocate name for player %d LED; ret=
=3D%d\n",
> +				i + 1, ret);
> +			break;
> +		}
> +
> +		led->name =3D name;
> +		ret =3D devm_led_classdev_register(&input->dev, led);

[Severity: High]
Does this create an unbreakable devres circular reference?

Using the input device as the parent for devm_led_classdev_register() links
the devres action to the input device, but the LED classdev child inherently
holds a reference to its parent.

When input_unregister_device() runs during removal, the input device's
refcount never drops to zero, leaking it and preventing devres cleanup.
The LED sysfs attributes remain active.

If userspace writes to the leaked LED attributes after switch2_remove() fre=
es
the controller structure, switch2_player_led_brightness_set() will access
freed memory.

> +		if (ret < 0) {
> +			dev_err(&input->dev, "Failed to register player %d LED; ret=3D%d\n",
> +				i + 1, ret);
[ ... ]
> +static void switch2_controller_put(struct switch2_controller *ns2)
> +{
> +	struct input_dev *input;
> +
> +	mutex_lock(&ns2->lock);
> +	rcu_read_lock();
> +	input =3D rcu_dereference(ns2->input);
> +	rcu_read_unlock();
> +
> +	rcu_assign_pointer(ns2->input, NULL);
> +	synchronize_rcu();
> +
> +	ns2->init_step =3D 0;
> +	mutex_unlock(&ns2->lock);
> +
> +	if (input)
> +		input_unregister_device(input);

[Severity: High]
Does clearing the initialization step before the blocking unregister open
a race condition that leaks the input device?

By dropping the lock before calling the long-running input_unregister_devic=
e(),
concurrent USB packets can trigger switch2_receive_command(). Since the loc=
k is
re-acquired and init_step is 0, this restarts the initialization state mach=
ine.

Because switch2_remove() hasn't cleared hdev yet:

switch2_remove()
   switch2_controller_put(ns2);
   mutex_lock(&ns2->lock);
   ns2->hdev =3D NULL;

The state machine successfully registers a completely new input_dev using t=
he
soon-to-be-destroyed hdev as its parent. This leaks the newly registered
device and leaves it with a dangling parent pointer.

> +}
> +
> +static void switch2_kref_put(struct kref *refcount)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002002929.1578=
115-1-vi@endrift.com?part=3D1
