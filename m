Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38761357CE1
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873809; cv=none; b=qnjgsUFJ8DkITE4+o5W995IaIFlIWzfQE2MdLSkrJFUsnKvPNHDf/91UfwsU5STDY625RQgZ9+fXdNBgF68Np745jADXgFB+spwHEGH+kHqdJWS3aengU+h7lop2Q+xsZpcKSGrYkBG8MGVe6cYW9W674KLXQSV0ajeFXdFPF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873809; c=relaxed/simple;
	bh=SX0TJI22A8teFnHvzBNEh/TClZv4DykUWAgZ0HdK/u8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L4K6JHX79oqfeCWUfDTQu2ZfWDzV+7251LdAlT+U/Ok+9QrMJcD0YWnvXSf/GHv7fJneeiq7tQb9/e7qLk9blKu65pj0E5OAkWHGiZn5XshXsRmD4isqt5w6KCbNXqZktBorEOHx+w4r5Ua5bZQQ3ZRY2kwb7OURgGBBoxC7Es0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPUm3LuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPUm3LuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991731F000E9;
	Sun, 12 Jul 2026 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783873807;
	bh=OE8OSO8e0lqtKujV5Ivh2JVP62QPJaM0GoRp0iUF0FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPUm3LuIoUqfZHfaIz6FdE+hvpcsMdDA0kAxqf8Rd//bisgpmNHuF58aGEakr7Tcy
	 NTjNw9qC0N1t9YYmu+DGoF2wv0C13QSAWTx1O6hEpv4gs7agWrwfzEQUiOxe9gQM7G
	 HqKAs3cgUlKEG5xLpbco+6vjr+W11lOA5l9lKX7WCLFOxtQMUlGLd6jTOiT311hP/E
	 +XCoDQBXEyauTdWFIZeGrCQJgmBdbRGFxYghdfh7O6Q9tDK7qyqzEcy90r/gw2DCfQ
	 ZfwgVlEpa1zGBx6HZQsGKrZmUpWFuf/YT30FqjV4bQbf+u1w2c8O3a/i7gDMBhXyBr
	 gGuyfSQPEksWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: applespi - register touchpad device
 synchronously in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260712161527.7350-2-fourdollars@debian.org>
References: <20260712161527.7350-1-fourdollars@debian.org>
 <20260712161527.7350-2-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 16:30:07 +0000
Message-Id: <20260712163007.991731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Re-entrancy in async SPI completion leads to callback slot ove=
rwrite and NULL pointer dereference.
- [High] Missing timeouts in probe error path and remove path cause indefin=
ite system hang if the SPI controller wedges.
- [High] Synchronous touchpad detection failure forces a complete driver te=
ardown, disabling the functional keyboard.
- [Medium] Lockless copy and evaluation of touchpad info struct causes a da=
ta race.
- [Medium] Timeout condition fails if the touchpad's model number is 0.
- [Low] Redundant and contradictory debugfs NULL pointer check.
--

--- Patch [1]: [PATCH 1/2] Input: applespi - register touchpad device synch=
ronously in probe ---
commit 4961cde9c37a41e959c60a2aa6d8bde99a5e96b5
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - register touchpad device synchronously in probe

This patch simplifies the applespi driver by making touchpad detection and
registration synchronous during probe rather than using an asynchronous wor=
ker.
It also introduces timeouts for wait events and changes the probe type to p=
refer
asynchronous execution by the driver core.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b5ff71cd5a701..c1065a6ba96c8 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
[ ... ]
> @@ -607,13 +612,61 @@ static void applespi_setup_write_txfrs(struct apple=
spi_data *applespi)
>  	spi_message_add_tail(st_t, msg);
>  }
> =20
> +static bool applespi_async_outstanding(struct applespi_data *applespi)
> +{
> +	return applespi->spi_complete[0].complete ||
> +	       applespi->spi_complete[1].complete;
> +}
> +
> +static void applespi_async_complete(void *context)
> +{
> +	struct applespi_complete_info *info =3D context;
> +	struct applespi_data *applespi =3D info->applespi;
> +	unsigned long flags;
> +
> +	info->complete(applespi);
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +
> +	info->complete =3D NULL;

[Severity: Critical]
Can this execution order cause a nested applespi_async() call to mistakenly
view the slot as occupied?

Because info->complete(applespi) executes before info->complete =3D NULL, i=
f the
callback queues a new SPI message, it might see this slot as still in use.

> +
> +	if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
> +		wake_up_all(&applespi->wait_queue);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +}
> +
>  static int applespi_async(struct applespi_data *applespi,
>  			  struct spi_message *message, void (*complete)(void *))
>  {
> -	message->complete =3D complete;
> -	message->context =3D applespi;
> +	struct applespi_complete_info *info;
> +	int sts;
> =20
> -	return spi_async(applespi->spi, message);
> +	if (applespi->cancel_spi) {
> +		if (!applespi_async_outstanding(applespi))
> +			wake_up_all(&applespi->wait_queue);
> +		return -ESHUTDOWN;
> +	}
> +
> +	/*
> +	 * There can only be at most 2 spi requests in flight, one for "reads"
> +	 * and one for "writes".
> +	 */
> +	if (!applespi->spi_complete[0].complete)
> +		info =3D &applespi->spi_complete[0];
> +	else
> +		info =3D &applespi->spi_complete[1];
> +	info->complete =3D complete;

[Severity: Critical]
Does this blindly overwrite the second slot if the first is occupied, even =
if
the second slot is also in use?

If a re-entrant call happens before info->complete is cleared in
applespi_async_complete(), this might overwrite the callback of a concurrent
in-flight transfer. This could lead to a NULL pointer dereference or
use-after-free later.

> +	info->applespi =3D applespi;
> +
> +	message->complete =3D applespi_async_complete;
> +	message->context =3D info;
> +
> +	sts =3D spi_async(applespi->spi, message);
[ ... ]
> @@ -963,12 +1016,18 @@ static void applespi_debug_update_dimensions(struc=
t applespi_data *applespi,
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
>  {
>  	struct applespi_data *applespi =3D inode->i_private;
> +	struct input_dev *touchpad;
> =20
>  	file->private_data =3D applespi;
> =20
> +	/* Pairs with smp_store_release in applespi_register_touchpad_device() =
*/
> +	touchpad =3D smp_load_acquire(&applespi->touchpad_input_dev);
> +	if (!touchpad)
> +		return -ENODEV;
> +

[Severity: Low]
Is this NULL pointer check redundant?

The commit message states that the patch "obsoletes the need for async work
cancellation on driver remove and debugfs NULL pointer checks." However, th=
is
adds a new NULL pointer check.

Since the probe is now synchronous, the debugfs file isn't created until the
touchpad is fully registered, making it impossible for touchpad_input_dev t=
o be
NULL here.

>  	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
>  		 "0x%.4x %dx%d+%u+%u\n",
[ ... ]
> @@ -1324,26 +1383,14 @@ applespi_register_touchpad_device(struct applespi=
_data *applespi,
>  	return 0;
>  }
> =20
> -static void applespi_worker(struct work_struct *work)
> -{
[ ... ]
> -}
> -
>  static void applespi_handle_cmd_response(struct applespi_data *applespi,
>  					 struct spi_packet *packet,
>  					 struct message *message)
>  {
>  	if (packet->device =3D=3D PACKET_DEV_INFO &&
>  	    le16_to_cpu(message->type) =3D=3D 0x1020) {
> -		/*
> -		 * We're not allowed to sleep here, but registering an input
> -		 * device can sleep.
> -		 */
>  		applespi->rcvd_tp_info =3D message->tp_info;
> -		schedule_work(&applespi->work);
> +		wake_up_all(&applespi->wait_queue);

[Severity: Medium]
Is there a data race here since the 112-byte message->tp_info struct is cop=
ied
locklessly before waking the wait queue?

>  		return;
>  	}
[ ... ]
> @@ -1757,6 +1803,22 @@ static int applespi_probe(struct spi_device *spi)
>  	/* trigger touchpad setup */
>  	applespi_init(applespi, false);
> =20
> +	/* set up the touchpad as a separate input device */
> +	sts =3D wait_event_timeout(applespi->wait_queue,
> +				 applespi->rcvd_tp_info.model_no,
> +				 msecs_to_jiffies(3000));

[Severity: Medium]
Because applespi->rcvd_tp_info.model_no is evaluated locklessly without an
acquire memory barrier, could the waiting thread observe a non-zero model_no
and wake up before preceding fields are fully committed to memory?

[Severity: Medium]
What happens if a legitimate touchpad reports a model_no of 0?

Since applespi->rcvd_tp_info.model_no is used as a boolean flag, a value of=
 0
would cause the wait condition to fail and trigger the 3-second timeout, ev=
en
though the hardware responded successfully.

> +	if (!sts) {
> +		dev_err(&applespi->spi->dev,
> +			"Timed out waiting for device info\n");
> +		sts =3D -ETIMEDOUT;
> +		goto cancel_spi;
> +	}

[Severity: High]
Does a touchpad detection timeout here completely abort the driver probe and
disable a fully functional keyboard?

In the previous asynchronous design, a missing info packet safely skipped
touchpad registration while leaving the keyboard intact.

> +
> +	sts =3D applespi_register_touchpad_device(applespi,
> +						&applespi->rcvd_tp_info);
> +	if (sts)
> +		goto cancel_spi;
> +
>  	/*
>  	 * By default this device is not enabled for wakeup; but USB keyboards
>  	 * generally are, so the expectation is that by default the keyboard
> @@ -1789,25 +1851,50 @@ static int applespi_probe(struct spi_device *spi)
>  			    &applespi_tp_dim_fops);
> =20
>  	return 0;
> +
> +cancel_spi:
> +	acpi_disable_gpe(NULL, applespi->gpe);
> +	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +	applespi->cancel_spi =3D true;
> +	wait_event_lock_irq(applespi->wait_queue,
> +			    !applespi_async_outstanding(applespi),
> +			    applespi->cmd_msg_lock);

[Severity: High]
Does this probe error path lack a timeout?

The commit message mentions adding 3-second timeouts to prevent suspend/rem=
ove
hangs, but if the SPI controller wedges, this wait_event_lock_irq() could h=
ang
indefinitely. This same issue appears to be present in applespi_remove().

> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +
> +	return sts;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712161527.7350=
-1-fourdollars@debian.org?part=3D1
