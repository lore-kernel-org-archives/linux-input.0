Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488E3D1CAA
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543469; cv=none; b=mintgSDHFMOagkROtz0zDgSHorPGHT1GrNagtqBEd3pG09L6IolnvwHJw7Cw6V3ATOfVq5ty5dmYW+QFocQwyJGVnkVMJTEgsdSeslxdHIRzcbF9QmOgYTMCpA2Rtq0KkmF+Xkri2GUb6/YVauedgrGD61Qa98Kv/mqGff9i+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543469; c=relaxed/simple;
	bh=ugTt6ILnTMnZoUHl0e2CsM/+qI3iwU7wKM9ySQofanA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cxyBrXymrEMAQENOqNDxpPygpSbTLyt88PDFR7GQkGT3KoVhXmeb8Hhu9awvV3yWqO/TBy1ok+88F/TspHCSvZ3WjHWHGPKkeCeAxDoAQAvIBkYxSmshodr8Vv6gP6MvSiHGZG/TlDbtN6tptSIVbWzbI71ZnwBbtL7OJ7FwFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYdE3hK/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYdE3hK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5251F000E9;
	Mon, 20 Jul 2026 10:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784543466;
	bh=7hr87tNSiD5fW5Es3JMJm9TKJh4aUVpE+5W0LKWy2Rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYdE3hK/041dmFFIJPbzCKRdKCFrMUuF2TcmSt5uNmorX3mmpdl/Gf5AsifYju63p
	 WIz6U1TMM2+OAV5zVDJZ52D6E5Phw5E704RlCCcuhjRb+Vf8xEAnU+ISw5+1q9zakq
	 LOIjd3dKb3wtDA4ZS9Lenr4+2vv1oMO5Su9J1w/vQ9ZZcypaUWXq/x+MawoNtV+DUL
	 3xmwrV1h7fi1Uc4RpLimb/q/cp3RQe7f/rGbhj2R8USjR+gBFqs25lWDRh8HndAedP
	 re7TyR76uGY3pzXRy7qgQHf/aXxQQCYZAKzD5FMgHOvC4wRLrOagD39yVg2ukfE2CK
	 K1W8qWXy2WBCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] Input: applespi - track asynchronous SPI
 transfers in flight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720101435.13612-3-fourdollars@debian.org>
References: <20260720101435.13612-1-fourdollars@debian.org>
 <20260720101435.13612-3-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:31:05 +0000
Message-Id: <20260720103106.9B5251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced asynchronous SPI transfer tracking logic and =
`cancel_spi` flag are dead code, failing to prevent use-after-free during t=
eardown.
- [High] The asynchronous tracking mechanism signals completion to potentia=
l waiters before the inner callback finishes executing, introducing a Use-A=
fter-Free window.

Pre-existing issues:
- [High] The driver schedules `applespi->work` but fails to cancel it durin=
g driver removal, leading to a use-after-free.
- [High] Re-queueing the statically allocated `wr_m` SPI message after a ti=
meout corrupts the SPI subsystem's message queue.
- [High] A pre-existing use-after-free vulnerability exists in `applespi_as=
ync_read_complete()` during device removal.
--

--- Patch [2]: [PATCH v2 2/5] Input: applespi - track asynchronous SPI tran=
sfers in flight ---
commit 0ed887ee2137eeb7173f66b5f712a9622f7a16c3
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - track asynchronous SPI transfers in flight

This patch aims to fix use-after-free conditions during driver teardown by
tracking asynchronous SPI requests. It introduces a completion tracking arr=
ay
and a cancel_spi flag to represent concurrent read and write transfers.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index 64bbeba85ea9e..a8f8d5370e95a 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c

[ ... ]

> @@ -421,6 +421,12 @@ struct applespi_data {
>  	bool				read_active;
>  	bool				write_active;
> =20
> +	struct applespi_complete_info {
> +		void				(*complete)(void *context);
> +		struct applespi_data		*applespi;
> +	}				spi_complete[2];
> +	bool				cancel_spi;
> +

[Severity: High]
Is cancel_spi ever initialized or set to true during driver teardown?

Looking through the patch and the driver, it appears cancel_spi is declared
but never set to true. As a result, the checks for applespi->cancel_spi in
applespi_async() and applespi_async_complete() will always evaluate to fals=
e,
leaving the new tracking mechanism inactive.

Additionally, it doesn't look like applespi_remove() was updated to wait for
!applespi_async_outstanding(applespi) during driver removal. Does the
teardown path still proceed without waiting for the tracked transfers to
finish?

[ ... ]

> +static void applespi_async_complete(void *context)
> +{
> +	struct applespi_complete_info *info =3D context;
> +	struct applespi_data *applespi =3D info->applespi;
> +	void (*complete)(void *context);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +
> +	complete =3D info->complete;
> +	info->complete =3D NULL;
> +
> +	if (applespi->cancel_spi && !applespi_async_outstanding(applespi))
> +		wake_up_all(&applespi->wait_queue);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +
> +	if (complete)
> +		complete(applespi);
> +}

[Severity: High]
Could waking up the wait queue before invoking the inner completion callback
introduce a use-after-free?

If a teardown thread is waiting on the wait_queue, it will unblock as soon
as wake_up_all() is called. This thread might then finish driver removal and
allow the devm subsystem to free the applespi structure.

If that happens, the subsequent call to complete(applespi) will dereference
the freed applespi object. Should the inner completion be invoked before
waking up the wait queue?


[Severity: High]
This is a pre-existing issue, but does driver removal fail to cancel the
scheduled workqueue?

Looking at applespi_remove():

applespi_remove() {
        applespi_drain_writes(applespi);
        applespi_drain_reads(applespi);
        ...
}

Since applespi is managed by devm_kzalloc(), its memory is freed
automatically shortly after applespi_remove() returns. If the touchpad
initialization worker scheduled in applespi->work runs after driver removal,
applespi_worker() will dereference the freed applespi structure.

Should cancel_work_sync(&applespi->work) be called during teardown?


[Severity: High]
This is a pre-existing issue, but can the command timeout logic corrupt the
SPI message queue?

In applespi_send_cmd_msg():

applespi_send_cmd_msg() {
        if (applespi->cmd_msg_queued) {
                if (ktime_ms_delta(ktime_get(), applespi->cmd_msg_queued) <=
 1000)
                        return 0;
                applespi->cmd_msg_queued =3D 0;
                applespi->write_active =3D false;
        }
        ...
        sts =3D applespi_async(applespi, &applespi->wr_m, applespi_async_wr=
ite_complete);
}

If a command times out, the driver assumes the transfer is no longer in
flight and clears its internal flags. However, the message might still be
pending in the SPI controller's active queue.

Re-queueing the statically allocated applespi->wr_m struct via spi_async()
while it is still linked in the SPI core's lists will invoke list_add_tail()
on an already linked node, which corrupts the list.


[Severity: High]
This is a pre-existing issue, but is there a use-after-free window in the
read completion handler during teardown?

During driver removal, applespi_drain_reads() waits for read_active to
become false:

applespi_drain_reads() {
        wait_event_lock_irq_timeout(applespi->wait_queue,
                                    !applespi->read_active, ...);
}

Inside applespi_async_read_complete():

applespi_async_read_complete() {
        ...
        applespi_got_data(applespi);
        ...
        acpi_finish_gpe(NULL, applespi->gpe);
}

The call to applespi_got_data() clears read_active, which wakes up
applespi_drain_reads(). This allows the driver removal thread to finish
and free the applespi object. When the completion handler resumes, it
calls acpi_finish_gpe(NULL, applespi->gpe), dereferencing the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101435.1361=
2-1-fourdollars@debian.org?part=3D2
