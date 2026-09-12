Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F337FF53
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183542; cv=none; b=gDpsNt3Ma5sJxW4cQSX5u9Avz4nK4ahISRiynTJfZVjlPu+E+z+R5aMh6cQphjPpeefPO8uw0EHXYGUmGNfC3mh1gHgXnxgISJUiu5h/MjMZsz0KRC1AH3s8dryoRH5Ii3MhrUmUpuRw6ZlcamdANzU3aGI1QpBLzUQ1hqqmR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183542; c=relaxed/simple;
	bh=UhwnN4vliJ1hAnVMnAnG0Uss0qY25WJzIDO/l7lL2BU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKFQwXr//dd6Ci1XQTwyyDvbwrR0IqicSWSY7+NOSzsELhyKt5KsVFrHrNLz8uus9GBRpp/AIQOJiJTLUkXjre+oGx5ooUy8ZQst4r3TPdYm/KKRog7znknAMEiNDKFDAUPSc8ph5yilop8IpcbZy/UFz/0k3IhOAVteZ66YcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8BABatu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8BABatu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28AE1F000FF;
	Sat, 12 Sep 2026 03:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183541;
	bh=2B+OEDoEUshB1T+oeHlTvgviEqe3Hff4cM5cyfIg6uI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8BABatuW58uUDGEqqZD1p+cCDNJcChjt50OOb216FGm5pvxBgNet7yrdydNG4Zim
	 8+F0z573LnPSNDXTuSOO6VXfO4IvcvbNSsVSids6PNLLMqG82CqMueTeTV2Z4wSI3l
	 0b7FwIhxcj1FQaXD2bSI+bpZDaRD91lQuyF1SIY1+7XwQiqv5u+AFll4LLlnGVCSKn
	 WNH8CWA3qVIapq5unxvc2t/MPNm6rht1+tx0TJa2C8MMYV1MoxPk9YSDH8/uCjZj0U
	 7ld0Fo4YhE/YEQaIwq/+QUvmviX1EIlGfkVC63SsQgVgK1HCQ0Z+hHJroJTP9UTgip
	 H3yKmUMenKK1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/12] Input: xbox_gip - Add new driver for Xbox GIP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912030426.2997003-2-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:25:40 +0000
Message-Id: <20260912032540.E28AE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing and misordered work cancellations lead to Use-After-Free d=
uring device teardown and probe failure
- [High] Memory leak of input device due to dynamic devm allocation during =
logical device reset
- [High] Input devices are improperly destroyed during system suspend
- [High] Incorrect metadata version check logic causes parsing failures on =
older controllers
- [Low] Race condition when checking `!urb->anchor` to determine if an URB =
is idle
--

commit 16c368dc90338176b4ca692834653e9db715d0b4
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Add new driver for Xbox GIP

This commit introduces a new driver for the Xbox One/Series controller
protocol, also known as the Gaming Input Protocol. It adds a scalable
framework for specialized Xbox devices by parsing dynamic capabilities
through device metadata.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 0000000000000..b662cd7bddfa2
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> +static int gip_send_raw_message(struct gip_attachment *attachment,
> +	uint8_t message_type, uint8_t flags, uint8_t seq, const uint8_t *bytes,
> +	int num_bytes)
> +{
[ ... ]
> +	for (i =3D 0; i < MAX_OUT_MESSAGES && !urb; i++) {
> +		if (!intf->out_queue[i].urb)
> +			continue;
> +		if (!intf->out_queue[i].urb->anchor)
> +			urb =3D &intf->out_queue[i];
> +	}

[Severity: Low]
Is this check for a free URB safe against concurrent completion handlers?

The USB core unanchors the URB via usb_unanchor_urb() just before executing
the completion handler. Checking !urb->anchor allows picking and modifying
this URB while its previous completion handler is still running, which can
lead to data races.

[ ... ]
> +static int gip_parse_device_metadata(struct device *dev,
> +	struct gip_metadata *metadata, const uint8_t *bytes, int num_bytes,
> +	int *offset)
> +{
[ ... ]
> +	bytes =3D &bytes[*offset];
> +	num_bytes -=3D *offset;
> +	if (num_bytes < sizeof(*header))
> +		return -EINVAL;

[Severity: High]
Does this unconditionally require the buffer to be large enough for the full
v1.1 header structure?

Older devices running v0.1 metadata protocols would send a naturally shorter
header, which would cause initialization to fail entirely here.

[ ... ]
> +	if (metadata->version_major > 1 || metadata->version_minor >=3D 1) {
> +		/* HID descriptor support added in metadata version 1.1 */

[Severity: High]
Will this logic incorrectly pass for older metadata versions like 0.1 and 0=
.2?

Because the condition uses an OR operator, a version with version_major =3D=
=3D 0
and version_minor >=3D 1 evaluates to true. This would cause the driver to
attempt parsing v1.1 fields (hid_descriptor_offset) out of bounds on a
shorter v0.x header.

Could this be checked as:
version_major > 1 || (version_major =3D=3D 1 && version_minor >=3D 1)?

[ ... ]
> +static int gip_setup_input_device(struct gip_attachment *attachment)
> +{
> +	struct input_dev *input;
> +	int rc;
> +
> +	if (!attachment->driver || !attachment->driver->setup_input)
> +		return -ENODEV;
> +
> +	rcu_read_lock();
> +	input =3D rcu_dereference(attachment->input);
> +	rcu_read_unlock();
> +	if (input)
> +		return 0;
> +
> +	input =3D devm_input_allocate_device(to_gip_device(attachment));

[Severity: High]
Does this dynamically allocate devm resources that are leaked on logical
resets?

This allocates the input device using devres tied to the parent usb_interfa=
ce.
When the controller is logically reset (e.g. handling a new
GIP_CMD_HELLO_DEVICE), gip_reset_attachment() explicitly unregisters this
device but does not destroy the devm allocation action.

[ ... ]
> +static void gip_free_devices(struct gip_attachment *attachment)
> +{
> +	struct input_dev *input;
[ ... ]
> +	if (input)
> +		input_unregister_device(input);
> +}

[Severity: High]
Could this leave the devres action tracking the input device intact on the
parent?

Successive re-enumerations will allocate additional input_dev instances
without freeing the old ones, leaking memory linearly over time until the
physical USB device is unbound.

[ ... ]
> +static int gip_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +{
[ ... ]
> +	/* Pre-create the first attachment, as it should always exist */
> +	attachment =3D gip_ensure_attachment(gip, 0);
> +	if (IS_ERR(attachment)) {
> +		gip_deinit_input(&gip->data);
> +		gip_deinit_output(&gip->data);
> +		if (gip->audio.intf) {
> +			gip_deinit_input(&gip->audio);
> +			gip_deinit_output(&gip->audio);
> +		}
> +		rc =3D PTR_ERR(attachment);
> +		goto err_cleanup;
> +	}
> +
> +	/* Don't init audio interface -- we aren't using it yet */
> +
> +	usb_set_intfdata(intf, gip);
> +	return 0;
> +
> +err_cleanup:
> +	devm_kfree(to_gip_device(gip), gip);
> +
> +	return rc;
> +}

[Severity: High]
Does this error path fail to cancel the gip->receive_message work?

If gip_ensure_attachment() fails, gip_deinit_input() kills the URB, but the
scheduled work is not canceled before freeing the gip structure via
devm_kfree(), leading to a use-after-free.

[ ... ]
> +static void gip_disconnect(struct usb_interface *intf)
> +{
> +	struct gip_device *gip =3D usb_get_intfdata(intf);
> +	int i;
> +
> +	if (!gip)
> +		return;
> +
> +	gip_shutdown(gip);
> +
> +	usb_kill_anchored_urbs(&gip->data.out_anchor);
> +	if (gip->audio.intf)
> +		usb_kill_anchored_urbs(&gip->audio.out_anchor);
> +
> +	gip_deinit_input(&gip->data);

[Severity: High]
Can a late URB completion handler re-queue work after gip_shutdown() runs?

gip_shutdown() synchronously cancels gip->receive_message and
attachment->rumble_work, but the input URB is not killed until later in
gip_deinit_input().

If the URB completes in this window, gip_urb_in() will re-queue the
receive_message work. usb_kill_urb() waits for the completion handler but
doesn't cancel newly queued work. gip_disconnect() then frees the memory,
causing the pending work to execute on a freed gip structure.

Additionally, gip_shutdown() cancels attachment->rumble_work before
input_unregister_device() runs. A concurrent userspace ioctl could
trigger gip_play_effect() to re-queue the work right before the attachment
is freed.

[ ... ]
> +static int gip_suspend(struct usb_interface *intf, pm_message_t message)
> +{
[ ... ]
> +	gip_shutdown(gip);
> +
> +	return 0;
> +}
> +
> +static int gip_resume(struct usb_interface *intf)
> +{
> +	struct gip_device *gip =3D usb_get_intfdata(intf);
> +
> +	if (!gip)
> +		return 0;
> +
> +	if (usb_submit_urb(gip->data.urb_in, GFP_KERNEL))
> +		return -EIO;
> +
> +	return 0;
> +}

[Severity: High]
Are input devices destroyed during suspend and never properly restored?

gip_suspend() calls gip_shutdown(), which unregisters and destroys all input
devices. Upon gip_resume(), the driver only resubmits the input URB but fai=
ls
to recreate the input devices.

If the controller doesn't automatically send a GIP_CMD_HELLO_DEVICE, the in=
put
device is permanently lost. Even if it does, it will create a brand new evd=
ev
node, breaking the state of hotplug-unaware userspace applications across
system suspend/resume cycles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D1
