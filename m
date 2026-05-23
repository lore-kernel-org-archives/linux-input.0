Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CD946A
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520366; cv=none; b=IH/Niy+Twl25WOBYLhScJafz06OJK8sII5bG2Ep9L5Z161afnGnEDQIBlwxxGTRjdY59uH4L7inwBvlQo7+IsBdKcjBTmi130xAtwa+AmkqvCJQKvz3cf9Hx9f1eMjwy4Bogpzhn0bbyAW+mbB+rs5qPjF0rIg6W3TG34LtOi88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520366; c=relaxed/simple;
	bh=A7cq5xLTDdlpIZdsJx14s7h8AhoBiw5/Z85W0+OgMb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c9F5IUjMIllgyKpmLDwQxjltfk5Tzz+S51/o+y6OB/0IsV2Jvbg1m3Bq7d8saCZi3fM4G9cqiwEgrQKTvJGD0/WTmE5gIwDj01IwHafcCux93Tt73IpPf8PVdON4R/2BQxzzoZu65dRqPu/HTL3D184XjzbIa/b96HCub67M4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMslUWwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMslUWwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655C31F000E9;
	Sat, 23 May 2026 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779520365;
	bh=3E4YvmUuc6uP1053GbP0ihAJPameT2ASZu18gOZ429U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMslUWwtn919+/pSHT4m3XXjkj0POjEXwXW9S+uJA9ePFssxFnHBhrrGfpcQKecrx
	 YctJQ45sDNeqecC+et6Lodcnq5hE6q1dugbiGoxyFPgxk8y/Eo50LKbC580GnXfvJ1
	 LuXdrrJZoePddyR6OdLrDBPp5jHRsuo8y328tV8yb88NrUQJpXn8sZbaUlIKbcSpQk
	 khncN3MkBiK1fQ8ng1s8hJvIBzIQ45r2yysavwBC4/ErZarxDw5xzQSQhOvSnMMEhq
	 ywV7sGeX8m+bMvR1Tka4cp7vJLapP7dwKxyrdbjDPt5yS3b6MJXkWXZU1Ex+bN+071
	 uHvn0bw7HqZrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] Input: ims-pcu - fix race condition in
 reset_device sysfs callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260523050634.501509-5-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-5-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 07:12:36 +0000
Message-Id: <20260523071245.655C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect size passed to usb_free_coherent() when freeing the read=
 buffer.
- [High] Sysfs callbacks on `data_intf` race with buffer allocation/freeing=
, leading to Use-After-Free or NULL pointer dereference.
- [High] Sequence number (ack_id) race condition allows stale delayed respo=
nses to complete a new command prematurely.
--

commit 1a84560748d9dd10fa9a7709e4c015dd9ef492e6
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Input: ims-pcu - fix race condition in reset_device sysfs callback

This commit fixes a race condition in the ims_pcu_reset_device sysfs callba=
ck
by acquiring the command mutex before executing commands. This prevents data
races and corruption of the shared command buffer when commands run
concurrently.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index e6603aaf7b303..22be49d3b879d 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1152,6 +1152,8 @@ static ssize_t ims_pcu_reset_device(struct device *=
dev,
> =20
>  	dev_info(pcu->dev, "Attempting to reset device\n");
> =20
> +	guard(mutex)(&pcu->cmd_mutex);
> +

[Severity: High]
This is a pre-existing issue, but can this sysfs callback race with buffer
allocation during probe?

During ims_pcu_probe(), usb_driver_claim_interface() binds data_intf to the
driver before ims_pcu_buffers_alloc() is called:

drivers/input/misc/ims-pcu.c:ims_pcu_probe() {
    ...
	error =3D usb_driver_claim_interface(&ims_pcu_driver,
					   pcu->data_intf, pcu);
    ...
	error =3D ims_pcu_buffers_alloc(pcu);
    ...
}

This implicitly registers the sysfs attributes before the command buffers a=
re
allocated. Can a concurrent sysfs access like writing to reset_device execu=
te
ims_pcu_execute_command() and write to pcu->urb_out_buf while it is still
null?

Similarly, during ims_pcu_disconnect(), ims_pcu_buffers_free() is called
before usb_driver_release_interface() removes the sysfs attributes. Could a
concurrent sysfs operation access the freed buffers, causing a use-after-fr=
ee?

>  	error =3D ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
>  	if (error) {
>  		dev_info(pcu->dev,

There are also a couple of other pre-existing issues in this driver:

[Severity: High]
This isn't a bug introduced by this patch, but is the correct size passed to
usb_free_coherent() when freeing the read buffer?

In ims_pcu_buffers_alloc(), pcu->urb_in_buf is allocated using
pcu->max_in_size:

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_alloc() {
    ...
	pcu->urb_in_buf =3D usb_alloc_coherent(pcu->udev, pcu->max_in_size,
					     GFP_KERNEL, &pcu->read_dma);
    ...
}

However, in ims_pcu_buffers_free(), it is freed using pcu->max_out_size:

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_free() {
    ...
	usb_free_coherent(pcu->udev, pcu->max_out_size,
			  pcu->urb_in_buf, pcu->read_dma);
    ...
}

Is it possible this mismatch could cause memory leaks or crashes on
architectures that rely on the size parameter for unmapping pages?

[Severity: High]
This is a pre-existing issue, but does the sequence number initialization in
__ims_pcu_execute_command() allow stale responses to complete a new command
prematurely?

In __ims_pcu_execute_command(), pcu->expected_response is set and
init_completion() is called before ims_pcu_send_command():

drivers/input/misc/ims-pcu.c:__ims_pcu_execute_command() {
    ...
	pcu->expected_response =3D expected_response;
	init_completion(&pcu->cmd_done);

	error =3D ims_pcu_send_command(pcu, command, data, len);
    ...
}

The sequence number pcu->ack_id is only incremented later inside
ims_pcu_send_command().

If a previous command timed out, could a delayed response arrive from the
hardware during this exact window? Its sequence number would match the still
unincremented pcu->ack_id - 1 checked in ims_pcu_handle_response():

drivers/input/misc/ims-pcu.c:ims_pcu_handle_response() {
    ...
		if (pcu->read_buf[0] =3D=3D pcu->expected_response &&
		    pcu->read_buf[1] =3D=3D pcu->ack_id - 1) {
			memcpy(pcu->cmd_buf, pcu->read_buf, pcu->read_pos);
			pcu->cmd_buf_len =3D pcu->read_pos;
			complete(&pcu->cmd_done);
			return;
		}
    ...
}

Would this cause the waiting thread to wake up immediately and process the
stale data instead of the actual response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523050634.5015=
09-1-dmitry.torokhov@gmail.com?part=3D5
