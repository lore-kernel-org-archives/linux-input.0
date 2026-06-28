Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D434CDD
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782612579; cv=none; b=jOgws5CsN1nXSFCB7ERe3ogdGI1GX+Ojq7PCGsHa+mdWQZ01Bwie4Ma9Q3DvxNCgzKnZ7nA94uz/rK4IihSICCeR8NiOs0MKGAKAv14D1FWNRBrYe+uRf706vo7+aYQFVqdMOzwflO1Th5LFkrgP61WZ9jghTcliADXia7kxbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782612579; c=relaxed/simple;
	bh=zck6icy+x4vsdFg8GYcKL+8TiqTcgBrqQ8w4F+1NJpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iQgIcBaYZuaf1dx2WvgFHbPgRtuWke6UzUdDnrU2E6C0B3/nOPsahiE8UjUedUgHviD8MRjcFiaNoCF9UeSuvU5UeovbJykqGBpUzTtuz88MsOf0qXkUlHT14qzDAnH5xXGGvPXTTVsqRvWJAWHApzC85wT5J1zjR0ZgDdNHLKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCDkr0ju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCDkr0ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9841F00A3A;
	Sun, 28 Jun 2026 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782612578;
	bh=RpcpPkH9Pv2xfYkDvv49ONW+AEheqiH6RgsnoLj0Jtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCDkr0juRAdnHUgvh4FYrmQ1JZRdBbb+oft/ML+uTJDoZWsERA6AKe3k3cMhWrn2q
	 eLgcwkSvbzZZX1n40K73dNTG1QJcGM7tedKkbTOnM6nn36xcFDF5JFegVu4FJIQrzy
	 iFMPm78R4dXciDi6MMRmhjEeqSN3oz0IIwSk5kWyeDV9qIALRkj+sISTeEYOY6s8Ll
	 U2hjfCm4KjWNcUVCULVCU+M5s2Rro3/ej7xlGl+5yCRJlEjLbiXPEZ4GwthPGH5VGt
	 zvbminU0FIEj0JNSfQkcB6qJNgAqnjTTpwQj8iOkjPHeMuMfiBcsphcLmwgpRlChBh
	 RYc9Vjd6Jnkyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] input: atkbd: add softleds quirk for broken EC PS/2
 emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rodnei Cilto" <rodnei.cilto@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628-ideapad-kbd-leds-v1-1-50b421d94927@gmail.com>
References: <20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com>
 <20260628-ideapad-kbd-leds-v1-1-50b421d94927@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 02:09:37 +0000
Message-Id: <20260628020938.1E9841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The `atkbd` driver mutates the parent `serio` port's `write` funct=
ion pointer to `NULL`, which is a driver model violation and permanently co=
rrupts the bus state.
- [Medium] The newly added early return `if (atkbd->softleds) return 0;` in=
side `atkbd_set_leds()` is completely unreachable dead code.

Pre-existing issues:
- [High] A pre-existing race condition in `atkbd_disconnect()` can lead to =
a Use-After-Free of the `input_dev` structure in `atkbd_event_work()`.
--

commit 449f71d6f3b7e8daf08e55bc0da16d0f59475df4
Author: Rodnei Cilto <rodnei.cilto@gmail.com>

input: atkbd: add softleds quirk for broken EC PS/2 emulation

This commit introduces the atkbd_softleds mode to handle broken EC PS/2
emulation on some Lenovo IdeaPad laptops. It combines dumbkbd behaviour with
EV_LED registration to keep LED states visible to userspace without sending
the SETLEDS command. DMI entries are added for the Lenovo IdeaPad 83RR and
83SR.

> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkb=
d.c
> index 8cb4dc6fb1658..826a21dc016ab 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -600,6 +602,14 @@ static int atkbd_set_leds(struct atkbd *atkbd)
>  	struct input_dev *dev =3D atkbd->dev;
>  	u8 param[2];
> =20
> +	/*
> +	 * softleds: EC PS/2 emulation does not support AT commands
> +	 * after initialization. Accept LED state from userspace but
> +	 * never send SETLEDS (0xED) to avoid scancode corruption.
> +	 */
> +	if (atkbd->softleds)
> +		return 0;
> +

[Severity: Medium]
Is this early return reachable? When atkbd_softleds is active, atkbd_connec=
t()
sets atkbd->write =3D false.

When an EV_LED event occurs, atkbd_event() checks atkbd->write and immediat=
ely
returns -1, dropping the event before atkbd_schedule_event_work() is called.

Does this mean atkbd_set_leds() is never executed by the workqueue in this
mode, and this check will never be triggered?

[ ... ]

> @@ -1291,6 +1301,12 @@ static int atkbd_connect(struct serio *serio, stru=
ct serio_driver *drv)
>  	if (atkbd->softrepeat)
>  		atkbd->softraw =3D true;
> =20
> +	if (atkbd_softleds) {
> +		serio->write =3D NULL;
> +		atkbd->write =3D false;
> +		atkbd->softleds =3D true;
> +	}
> +

[Severity: High]
Does this permanently modify the parent bus provider's function pointer
(serio->write)?

If atkbd is unbound and another driver (e.g., serio_raw) binds to the same
port, or if atkbd is rebound, would the port remain crippled and unable to
transmit due to serio->write still being NULL?

[Severity: High]
This is a pre-existing issue, but can this sequence lead to a use-after-free
if a privileged user unbinds the driver while LED or repeat rate events are
being processed?

In atkbd_disconnect(), input_unregister_device() is called before
cancel_delayed_work_sync():

drivers/input/keyboard/atkbd.c:atkbd_disconnect() {
    ...
    input_unregister_device(atkbd->dev);

    /*
     * Make sure we don't have a command in flight.
     ...
     */
    cancel_delayed_work_sync(&atkbd->event_work);
    ...
}

If atkbd_event_work() starts executing on another CPU, it acquires
atkbd->mutex and checks atkbd->enabled. If preempted immediately after this
check, atkbd_disconnect() can proceed to set atkbd->enabled =3D false,
unregister and free the input device, and then block on
cancel_delayed_work_sync().

When the worker thread resumes, it calls atkbd_set_leds():

drivers/input/keyboard/atkbd.c:atkbd_event_work() {
    ...
    if (!atkbd->enabled) {
        ...
    } else {
        if (test_and_clear_bit(ATKBD_LED_EVENT_BIT, &atkbd->event_mask))
            atkbd_set_leds(atkbd);
    ...
}

Would atkbd_set_leds() then dereference the now-freed atkbd->dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-ideapad-kb=
d-leds-v1-0-50b421d94927@gmail.com?part=3D1
