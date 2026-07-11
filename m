Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC737207D
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753773; cv=none; b=qLnbUTlEVoIly8pLtjT9l5JZRZqstrL0Zktvq0ILG5DDoxc20jbNnLdUAv6nG3G9XMG6uYzyj9J31zK56bb1etKkr/Mcc6c5rGSL97s3BWmeqCjQA/YaNp1hAnc+Lkg+kbnidjNQKJHa6nptRyTucsTRNtjSJKeAuLjMqHK8pLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753773; c=relaxed/simple;
	bh=vmFdYpcrtrnlA/QLqxhKQ/5paoT0YtORMcR5nQ5SFUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9NLBCwdLIfAERm/B/GV0vmSUC+3zjYRMUL/nwWYVQ0df6OZtX4WWhyIo4xWR1z98zT9LGjyyKNm2GoIhmCC7bTEWNQ+bKlRCwH53wND63CwDZ4BRluUoFRkevLeAYCDQf60D2LDtW3kMguZ6h2ug/XLRbw8RpYt2xzDRP64T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1n6leJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1n6leJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6761F000E9;
	Sat, 11 Jul 2026 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783753771;
	bh=mYe/vq1c4Ywg832DzbyLkfLetVvg/jov+mS21rFn1l4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1n6leJs6MaT7FOQJ74mI+6DecXzdwJIbCEywp8xdm/4MHvSpHSDCMtB6Qz/sTsuJ
	 48jWuf+14zb4JFTFogOX5+KrGhioU6wCHDLDeRwip6zsLTJNce7P0oIphGxW72TF2S
	 lT/VvXUGHe4pFDY1nGAoZ+iq5fYbXfa+blY8iCa6s2/OaP+J5HXqYgq2T9AGChGxGb
	 KBKbP6R3772ixoZCn/TtFDmEojJgtf14h3uyN+BqDvxhZdTWJiVaVEOCG29COmcF+4
	 BfVoiRgRVCtMdvEyJpGwreN7ksCCsnxQJIwxESn32tvo5Y4d6uTlFkHXI0GcrfJc1s
	 B0ZhFZZfP/y0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] Input: applespi - cancel pending work on driver
 remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711065415.7396-3-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711065415.7396-1-fourdollars@debian.org>
 <20260711065415.7396-3-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 07:09:30 +0000
Message-Id: <20260711070931.3A6761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of the applespi structure inside the SPI asynchrono=
us read completion callback during driver removal.
- [High] Deadlock/Hang on driver unbind or suspend due to un-cleared read_a=
ctive flag on CRC error.
- [High] Missing payload length validation leads to reading uninitialized h=
eap memory or old packet data.
- [High] Unbounded allocation and registration of touchpad input devices tr=
iggered by untrusted device input.
- [High] Use-after-free if probe fails after input device registration whil=
e async SPI writes are in-flight.
- [High] NULL pointer dereference when opening the tp_dim debugfs file befo=
re touchpad initialization.
- [Low] Redundant manual assignment of input_dev->dev.parent when using dev=
m_input_allocate_device().
--

--- Patch [2]: [PATCH v2 2/3] Input: applespi - cancel pending work on driv=
er remove ---
commit fee01b08b7f49cc284abe2da246718c6d357db23
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - cancel pending work on driver remove

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index 07a910cb8459f..b6b4d258d0dd5 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1847,6 +1847,8 @@ static void applespi_remove(struct spi_device *spi)
> =20
>  	applespi_drain_reads(applespi);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the read completion cal=
lback
access the private data structure after it has been freed during driver rem=
oval?

applespi_drain_reads() unblocks when applespi_msg_complete() clears read_ac=
tive:

applespi_msg_complete()
{
...
	if (is_read_compl)
		applespi->read_active =3D false;
...
	if (applespi->drain && !applespi->write_active)
		wake_up_all(&applespi->drain_complete);
}

However, applespi_msg_complete() is called by applespi_async_read_complete()
before it finishes using the applespi structure:

applespi_async_read_complete(void *context)
{
	struct applespi_data *applespi =3D context;
...
		applespi_msg_complete(applespi, true, true);
	} else {
		applespi_got_data(applespi);
	}

	acpi_finish_gpe(NULL, applespi->gpe);
}

Once wake_up_all() returns, applespi_remove() can finish, which allows devr=
es
to free the applespi structure. Does the final acpi_finish_gpe() call then
dereference a freed applespi->gpe?


[Severity: High]
This is a pre-existing issue, but can the kernel hang indefinitely during
driver unbind if an SPI read packet fails the CRC check?

In applespi_got_data(), if the CRC check fails and drain is false, it retur=
ns
early without clearing read_active:

applespi_got_data()
{
...
	if (!applespi_verify_crc(applespi, applespi->rx_buffer,
				 APPLESPI_PACKET_SIZE)) {
		guard(spinlock_irqsave)(&applespi->cmd_msg_lock);

		if (applespi->drain) {
			applespi->read_active =3D false;
...
		}

		return;
	}

Since read_active remains true, when applespi_remove() later calls
applespi_drain_reads(), will wait_event_lock_irq() wait indefinitely for
read_active to be cleared, resulting in a deadlock?

> +	cancel_work_sync(&applespi->work);
> +

[Severity: High]
This is a pre-existing issue, but can the device trigger unbounded memory
allocations and input device registrations?

In applespi_handle_cmd_response(), whenever an INFO packet is received,
it unconditionally schedules the initialization worker:

applespi_handle_cmd_response()
{
	if (packet->device =3D=3D PACKET_DEV_INFO &&
	    le16_to_cpu(message->type) =3D=3D 0x1020) {
...
		applespi->rcvd_tp_info =3D message->tp_info;
		schedule_work(&applespi->work);
		return;
	}
...

The worker then allocates and registers a new touchpad input device
using devm_input_allocate_device():

applespi_worker()
  -> applespi_register_touchpad_device()
  {
	touchpad_input_dev =3D devm_input_allocate_device(&applespi->spi->dev);
...
	sts =3D input_register_device(touchpad_input_dev);
...

If the device repeatedly sends 0x1020 INFO responses, won't this continually
allocate new managed devices and leak the previous ones?

>  	if (applespi->original_can_dma)
>  		spi->controller->can_dma =3D applespi->original_can_dma;
> =20

[Severity: Low]
This isn't a bug introduced by this patch, but is the manual assignment of
input_dev->dev.parent redundant here?

Looking at applespi_probe(), it uses devm_input_allocate_device(), which
automatically sets the parent to the device passed to it:

applespi_probe()
{
...
	applespi->keyboard_input_dev =3D devm_input_allocate_device(&spi->dev);
...
	applespi->keyboard_input_dev->dev.parent =3D &spi->dev;
...

The same applies to touchpad_input_dev in applespi_register_touchpad_device=
().


[Severity: High]
This is a pre-existing issue, but do applespi_got_data() and
applespi_handle_cmd_response() read out-of-bounds memory when processing
messages?

applespi_got_data() checks the packet length against sizeof(packet->data):

	if (len > sizeof(packet->data)) {
...
		goto msg_complete;
	}

But when handling the message payload, it casts the data and processes it
without checking if the packet actually contains the full struct:

	if (packet->flags =3D=3D PACKET_TYPE_READ &&
	    packet->device =3D=3D PACKET_DEV_KEYB) {
		applespi_handle_keyboard_event(applespi, &message->keyboard);

And similarly in applespi_handle_cmd_response():

	if (packet->device =3D=3D PACKET_DEV_INFO &&
	    le16_to_cpu(message->type) =3D=3D 0x1020) {
...
		applespi->rcvd_tp_info =3D message->tp_info;

If an undersized packet is received, does this lead to reading uninitialized
buffer memory (stale data) or out-of-bounds memory?


[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk if
applespi_probe() fails after the keyboard input device is registered?

In applespi_probe(), the keyboard input device is registered:

	sts =3D input_register_device(applespi->keyboard_input_dev);
	if (sts) {
...

Later in probe, ACPI GPE setup can fail, returning an error:

	acpi_sts =3D acpi_install_gpe_handler(...);
	if (ACPI_FAILURE(acpi_sts)) {
...
		return -ENODEV;
	}

Because the input device was already visible to userspace, an LED event mig=
ht
have queued an asynchronous SPI write. If probe returns an error, devres wi=
ll
free the applespi structure, but the in-flight SPI write is not cancelled.

Will the completion callback then access the freed applespi structure?

applespi_async_write_complete()
{
...
	if (!applespi_check_write_status(applespi, applespi->wr_m.status)) {
...


[Severity: High]
This is a pre-existing issue, but is there a risk of a NULL pointer derefer=
ence
if the tp_dim debugfs file is opened before the touchpad is initialized?

In applespi_probe(), the tp_dim debugfs file is created synchronously:

	debugfs_create_file("tp_dim", 0400, applespi->debugfs_root, applespi,
			    &applespi_tp_dim_fops);

However, applespi->touchpad_input_dev is allocated asynchronously in
applespi_worker(). If userspace opens the file before the worker executes
(or if the hardware never responds), applespi_tp_dim_open() will dereference
a NULL touchpad_input_dev:

static int applespi_tp_dim_open(struct inode *inode, struct file *file)
{
...
	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
		 "0x%.4x %dx%d+%u+%u\n",
		 applespi->touchpad_input_dev->id.product,
...

Could this result in a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711065415.7396=
-1-fourdollars@debian.org?part=3D2
