Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286404;
	b=miaNDw6xdHU7tmtOnZJfBU7CAYCWQoIqpnTr6ofI9UYr8dNJWrm57UokE5gpM3EXX2b0
	 F+VI/xm5dKspuQbTYbPwyfk7TrqtQD+lgwrEK9TU2gbcGpxi/BjmphZ9oM94aHxj3/PcE
	 z+01LzDyqSjInBAHXHML2haIEhK6hBewEIwO32k+isuepw2ygMSDPmQvieMPVXJZZXn5x
	 EmsksYiSD4voC9YU5/FE9oMBhcFq4wU9o3xcTi8gkFu0pk0+HU742BH9xaB/DSiqaU4A0
	 UJItbVc8/5BCKrkexuoYWBMkJetqncMbOrtImeEQ8+9B+57YGylLVwLRDaHigdC3Oqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286404;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5FQeGarEnPXMJaR02I8e1FhczH3Vl6mU8tANhqtdm4Y=;
	b=2clJWlCJOTA1wf9RT1LUHDSjK8GyJuuB2EIEf1KIvAjo7VVrLlFtr87r15ABwxrkzZWm
	 2LfPgGd4dAGI6+7N/Utpx7SadS55eI0oYo83VAsQpxMqnuSNgZYNYyEuZ6w4faPdZ6cnO
	 Tr179eVwfYC8v2qV/R4+9+daBjuEzWZj+reUn9QBnhdrT2eq9R4defp3ex/bnDnBc/v07
	 Ov33cDJk8IT/Ou78KeUkk0kb0pNCOB3wczfmk7tpuvY6Kaxqp1XgiG1NPEX1K0709BPsG
	 3oBAUhqcH8IjVYmoSLUN6A2VP6NeCZSOaXvTFWpkIGEX5Fqgefj6J+pIjQ9ymNQS8Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITqlUAxP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4493606A321
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITqlUAxP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9971F008A1;
	Tue, 10 Nov 2026 04:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286403;
	bh=5FQeGarEnPXMJaR02I8e1FhczH3Vl6mU8tANhqtdm4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ITqlUAxPZ2fWc3LVsRmjND4n7rX5XVlfI+HRuhtPcjUPXsnS5AgqMBiX9Huuptx67
	 iXTqMlcCIN2xvRlZ7P/Dn+djJjUcExmJfle03YG1QUrGHDWhVtRYa7rL7CHyW53+yu
	 LaPwjEawpU0tEcYLzX38lKK1YLXOi/b6ZYifG4eLBfoAFeDeAeVgMwk1Nv6tT2RPrX
	 jXwzPUULVVfmN/EJF3AZInP6c0OvhL1DpdN4ZCcocqfx/i+facluvwDC0MMKJDnh2J
	 4iN64111rn9vLUdbCW83yzezUiQt0xAab5+eUmCYRbXlSAyyieyoy+boXMN4b2O45Z
	 mvrO2S3eBmDiw==
Message-ID: <sashiko-outbox-206246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo-switch2-usb: Improve shutdown logic with
 inbound message work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261110043420.2433197-1-vi@endrift.com>
References: <20261110043420.2433197-1-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:53:22 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: nintendo-switch2-usb: unused schedule and error bug in
  switch2_bulk_in()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] HID: nintendo: AB-BA deadlock in switch2_usb_shutdown() [1]
--

commit 6f6e1e4dbbc575c0862f97bc1dde9a1e20a88deb
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo-switch2-usb: Improve shutdown logic with inbound message work

This commit moves the scheduling of message_in_work inside bulk_in_lock
in switch2_bulk_in() and adds a shutdown check in
switch2_usb_message_in_work().

Link: https://lore.kernel.org/linux-input/a2dc00e7-9cab-4315-87a4-795f256c1=
e03@endrift.com/T/

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> index 623473f3d2161..5174a5c2dbeca 100644
> --- a/drivers/hid/hid-nintendo-switch2-usb.c
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c
> @@ -71,16 +71,14 @@ static void switch2_bulk_in(struct urb *urb)
>  	}
> =20
>  	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> -	if (ns2_usb->shutdown)
> -		schedule =3D false;
> -
>  	for (i =3D 0; i < NS2_IN_URBS; i++) {
>  		int err;
>  		struct switch2_urb *ns2_urb;
> =20
>  		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
> -			if (schedule) {
> +			if (!ns2_usb->shutdown) {
>  				ns2_usb->bulk_in[i].state =3D NS2_URB_IN;
> +				schedule_work(&ns2_usb->message_in_work);
>  				continue;
>  			} else {
>  				ns2_usb->bulk_in[i].state =3D NS2_URB_FREE;
> @@ -115,9 +113,6 @@ static void switch2_bulk_in(struct urb *urb)
>  		}
>  	}
>  	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> -
> -	if (schedule)
> -		schedule_work(&ns2_usb->message_in_work);
>  }

[Severity: High]
Does replacing the schedule check with !ns2_usb->shutdown cause failed
URBs to be processed as valid input and leave schedule unused?

Earlier in switch2_bulk_in(), schedule is only set to true when
urb->status is 0, while unhandled non-zero status codes such as -EPROTO
fall through the default branch with schedule set to false:

drivers/hid/hid-nintendo-switch2-usb.c:switch2_bulk_in() {
	bool schedule =3D false;
	unsigned long flags;

	switch (urb->status) {
	case 0:
		schedule =3D true;
		break;
	...
	default:
		dev_dbg(&ns2_usb->udev->dev, "unknown input urb status: %d\n", urb->statu=
s);
		break;
	}

Without checking schedule here, a failed URB hitting the default branch is
marked NS2_URB_IN and queued for switch2_usb_message_in_work(), passing
stale transfer_buffer data to switch2_receive_command() instead of marking
the URB NS2_URB_FREE and resubmitting it.  Removing all reads of schedule
also triggers a -Wunused-but-set-variable compiler warning.

[ ... ]

> @@ -294,6 +289,10 @@ static void switch2_usb_message_in_work(struct work_=
struct *work)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	if (ns2_usb->shutdown) {
> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +		return;
> +	}
>  	for (i =3D 0; i < NS2_IN_URBS; i++) {
>  		urb =3D &ns2_usb->bulk_in[i];
>  		if (urb->state !=3D NS2_URB_IN)

[Severity: High]
This problem wasn't introduced by this patch, but can
switch2_usb_message_in_work() and switch2_usb_shutdown() hit an ABBA
deadlock [1] when an inbound USB packet arrives during controller
disconnect?

CPU0                               kworker
----                               -------
mutex_lock(&ns2->lock)
                                   switch2_usb_message_in_work()
                                     spin_unlock_irqrestore(...)
                                     switch2_receive_command()
switch2_usb_shutdown()
  cancel_work_sync(...)
                                       mutex_lock(&ns2->lock)

 *** DEADLOCK ***

CPU0: switch2_controller_detach_cfg() -> switch2_usb_shutdown()
kworker: switch2_usb_message_in_work() -> switch2_receive_command()

switch2_controller_detach_cfg() (and the error path of
switch2_controller_attach_cfg()) calls cfg->shutdown() while holding
ns2->lock.  If switch2_usb_message_in_work() has already passed the
ns2_usb->shutdown check and dropped bulk_in_lock, it blocks on ns2->lock
in switch2_receive_command() while cancel_work_sync() waits for the work
to finish.

[1] https://sashiko.dev/#/bug/linux-6ed5071c-4448-42b6-82a2-03203abfe1da

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110043420.2433=
197-1-vi@endrift.com?part=3D1
