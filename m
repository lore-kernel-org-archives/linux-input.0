Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEB4E323F
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553486; cv=none; b=JRHSmPx6/PRSXXFY/xdzLGn4V58SS7nFSeph5A5FBLs0nPcfM0Kg7j60IK+GHWLAkL9P8PJy481OHt9mtObuR4YwThi1Um/XiRW3InKWbPG87O1VJFRZVsIxym/92GkByOHgRDmdLTXmVfIw+MGeNae1dZcEqeI3iLaB+cbWgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553486; c=relaxed/simple;
	bh=uJCNK16YJtPSqoU0RUf9ZOjHGGa87h4AZY/AAhn9ubw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K7XSjE/as+9xs1m3iFD0tnzF0nCaUTtr01/YsywrYOXwzylJxgl45HNAocNYmKBCkgiQZZrS0mD6p3cbMdMcqhquaEulLT+xBneyvqT+z2jBGyzXQ5AjdfXiRM6M8+XgIu6U29awKKvbwpoKErcVRZ0MQ7i+VDPEOih0QXs8g68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW6fvhz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW6fvhz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8475A1F000FF;
	Fri,  9 Oct 2026 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553484;
	bh=EKaid9xpJTM+oZbaE0h9TPDiQLi6jEalrvga+nw9c/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZW6fvhz1MYP4Txye/UCFi3wWCsqEX/lEtXU2+JOc6QoNpoc9POg7SPq4Iaant/57C
	 sR9jdULiGY6ZyJNGQLXB8tSiWWFXd/NkDeJsoMyQFeFeLs+fxH82l8fZdfKX40OCod
	 mwK0QPvP1KV3s3KConVyqLnp4C1U06qJ/Pcn+ZOd2VQuv4HWWneRWCpFNoY+lytK3M
	 AmGKYGUoOYc1/osjjDIr7hz6QAyvZJVe2l00nhfua1YJV85V37gmDW4TQkbJJUhwO2
	 ftJoP1rvxVFmJA9CoqQQVrPOUErSupW6ZRkQ69UN/uV0dqZ/rrn0AAFXGUstrSO7EM
	 GvcaVoBsXsysg==
Message-ID: <sashiko-outbox-165666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/12] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261009122820.7603-10-denis.benato@linux.dev>
References: <20261009122820.7603-1-denis.benato@linux.dev>
 <20261009122820.7603-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:44:44 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: asus: UAF in hid_asus_ally_init due to missing gamepad discon=
nect re-check
--

commit b25c2490b184182f7d805afd2134e7bf9ce60b63
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support to force feedback

This commit adds support for force feedback to the Asus ROG Ally X gamepad,
using a work-queue to avoid sleeping calls in atomic contexts when sending
XInput rumble magnitude updates.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bb664bd9e140b..298f14b8713d9 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -2679,20 +2846,61 @@ static int ally_x_setup_input(struct hid_device *=
hdev, struct ally_handheld *all
[ ... ]
>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handh=
eld *ally)
>  {
> +	struct hid_device *x_hdev;
>  	struct ally_config *cfg;
> +	unsigned long flags;
>  	int ret;
> =20
[ ... ]
> +	/*
> +	 * Snapshot the gamepad interface and send the force-feedback "off"
> +	 * packet through it. usbhid_stop() frees urbout before NULLing it
> +	 * while usbhid_output_report() dereferences it unlocked, so a send
> +	 * overlapping the transport teardown would be a use-after-free: the
> +	 * device lock is taken around the send because the HID core holds
> +	 * it across remove() and the hid_hw_stop() that follows, making the
> +	 * two mutually exclusive. It is taken before intf_mutex, the same
> +	 * order the core's remove path uses, so no lock inversion exists.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	x_hdev =3D ally->ally_x_hdev;
> +	if (x_hdev)
> +		get_device(&x_hdev->dev);
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (x_hdev) {
> +		/* Failure at this point is non-critical */
> +		scoped_guard(mutex, &x_hdev->dev.mutex) {
> +			scoped_guard(mutex, &ally->intf_mutex) {
> +				ret =3D ally_x_send_ff_off(x_hdev);

[Severity: High]
Can this sequence lead to a use-after-free if the device is concurrently
unplugged?

If hid_asus_ally_init() snapshots x_hdev and takes a reference to it, but t=
he
device is unplugged before the mutex is acquired, the HID core will run the
unbind process (which takes x_hdev->dev.mutex, calls remove(), and then cal=
ls
hid_hw_stop()).=20

During this unbind, remove() safely clears ally->ally_x_hdev under
ally->intf_mutex, and hid_hw_stop() stops the transport and frees the
low-level driver data (e.g. kfree(usbhid)).

Once unbind completes, hid_asus_ally_init() acquires x_hdev->dev.mutex and
ally->intf_mutex. Because it does not re-verify if ally->ally_x_hdev =3D=3D=
 x_hdev
under the lock, it proceeds to call ally_x_send_ff_off(x_hdev) on the
torn-down transport. This forwards the request to hid_hw_output_report(),
which will dereference the freed low-level driver data, causing a
use-after-free.

Would it be safer to check if ally->ally_x_hdev is still equal to x_hdev
inside the intf_mutex guard before sending the report?

> +
> +				if (ret < 0)
> +					hid_err(hdev,
> +						"Ally failed to init force-feedback off: %d\n",
> +						ret);
> +			}
> +		}
> +
> +		put_device(&x_hdev->dev);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009122820.7603=
-1-denis.benato@linux.dev?part=3D9
