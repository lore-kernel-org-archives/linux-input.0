Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20304ED1BB
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836946; cv=none; b=AeK+3NoDGoYJGzMHC9bp6o7VoczatecJe4vfauIrIvJa8uhRCiVSHCvqjgJ6Kr71zQF3VXQy2g9cWyAT5Tl+uokRk0/zW062D8YrITzVQThJbC+/yhmGVleld45Pn3tKAB/aogda4foFxVmthbjKN5yxW8bkkuO8SwYk7T8KBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836946; c=relaxed/simple;
	bh=vb/TsIJ4yY5Z9gO5IJJkekNOyNChL4ptBr+gMKrDTzY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tyZV3M0FAT3zorovlsvV3POhVcub8x3RSEBHLft2dCjHujLIjNLeSe+LJi4gzGdhpUCGrVx/zMtVRjksuk6x++yeQz6UliJUy93JQ0XFefJWtZhc922OD/6gzcMAeS4Kf3OueWFd2XUSjeUTofG9tfO2NerIMWfxwsQJwdjInI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIyvmxuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIyvmxuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EEE1F0089B;
	Mon, 12 Oct 2026 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791836943;
	bh=maNb2DS6sO9QpzfkflQqygHWVDRyMjPoQ5AUHqF3ZLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIyvmxufd+CVfqN3FXGjyIzBjoQfe3Tn6csrUQ0nowIavNcKUi0CyODMz659A8ggD
	 m8Kobn5Zi9bPxDF5bllGP4E91LGsf1XkiWj3xnUk5kZMXydI0rTan8kvWw/CwlJLM8
	 sM5lJboYCIf7SaVmf5YYPhP1bb31qixqZcqNewRDWR7ogOmhcZTI+ZoWWYo4fLMlt5
	 USnWMR6WXAZjsHdbwnNQncR8MvulbIEQh52+Ni9LFA7kVoeINSILISGzE2PbOYQHGX
	 gyiCn/TP3F5eFPWBwJEhHu1SbGWUpnLjn3B2QORfAQBvgqcFkFZrWNdGDuwQMUub8d
	 O6+BYMRE/BXYw==
Message-ID: <sashiko-outbox-168594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] HID: UNCTRL: keep a single battery when a mouse has
 multiple connections
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bishwa Bhusan Saha" <contact@bishwasaha.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261013-b4-unctrl-m1-battery-v1-4-4a50203b7177@bishwasaha.com>
References: <20261013-b4-unctrl-m1-battery-v1-0-4a50203b7177@bishwasaha.com>
 <20261013-b4-unctrl-m1-battery-v1-4-4a50203b7177@bishwasaha.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 20:29:02 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] hid: uaf in unctrl_remove() due to early work cancellation and lis=
t exposure
- [High] hid: uaf of power_supply in unctrl_raw_event() racing with cross-d=
evice probe
- [High] hid: uaf of dev in unctrl_probe() error path due to concurrent bat=
tery transfer
- [Medium] hid: permanent battery loss due to missing rollback in unctrl_ba=
ttery_register()
--

commit 01440f9100f714c61f17b835003fbfa0e20c249f
Author: Bishwa Bhusan Saha <contact@bishwasaha.com>

    HID: UNCTRL: keep a single battery when a mouse has multiple connections

    This patch modifies the unctrl_m1 driver to register a single power
    supply across multiple connections (e.g., wired and dongle) of the same
    mouse. It transfers the power supply ownership when a more capable
    connection appears or disappears.

> diff --git a/drivers/hid/hid-unctrl-m1.c b/drivers/hid/hid-unctrl-m1.c
> --- a/drivers/hid/hid-unctrl-m1.c
> +++ b/drivers/hid/hid-unctrl-m1.c
[ ... ]
> @@ -181,32 +181,32 @@ static int unctrl_battery_register(struct unctrl_de=
v *dev)
>  	if (owner) {
>  		struct power_supply *owner_battery;
> =20
>  		cancel_delayed_work_sync(&owner->battery_work);
>  		/* so a raw_event cannot touch the supply being unregistered */
>  		scoped_guard(spinlock_irqsave, &owner->lock) {
>  			owner_battery =3D owner->battery;
>  			owner->battery =3D NULL;
>  		}
>  		power_supply_unregister(owner_battery);
>  	}
> =20
>  	battery =3D power_supply_register(&dev->hdev->dev, &dev->battery_desc,
>  					&config);
>  	if (IS_ERR(battery)) {
>  		ret =3D PTR_ERR(battery);
>  		hid_err(dev->hdev,
>  			"%s:power_supply_register failed with error %d\n",
>  			__func__, ret);
>  		return ret;

[Severity: Medium]
If power_supply_register() fails here, does the original owner's battery=20
remain unregistered forever?

We just cancelled the owner's work and unregistered its battery above, but=
=20
the error path doesn't restore it. Could this leave the active device=20
permanently without battery reporting?

>  	}
> =20
>  	power_supply_powers(battery, &dev->hdev->dev);
[ ... ]
> @@ -312,11 +312,11 @@ static int unctrl_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  	if (ret)
>  		goto err_del;
> =20
>  	return 0;
> =20
>  err_del:
>  	mutex_lock(&unctrl_lock);
>  	list_del(&dev->list);
>  	mutex_unlock(&unctrl_lock);

[Severity: High]
Is there a use-after-free risk in this error path due to a concurrent=20
battery transfer?

During the time between the failing unctrl_battery_register() returning and=
=20
re-acquiring the lock here at err_del, could a concurrent unctrl_remove()=20
on another connection find this dev in unctrl_connections?

If that happens, the other thread would transfer its battery to this failing
dev and schedule dev->battery_work. This work would remain active after=20
kfree(dev) is called at the end of this function.

>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
>  	hid_set_drvdata(hdev, NULL);
>  	kfree(dev);
>  	return ret;
>  }
[ ... ]
> @@ -336,15 +336,15 @@ static int unctrl_raw_event(struct hid_device *hdev=
, struct hid_report *report,
[ ... ]
>  	scoped_guard(spinlock_irqsave, &dev->lock) {
>  		/* the receiver reports 0% while the mouse is switched off */
>  		dev->battery_capacity =3D min_t(u8, data[4], 100);
>  		dev->mode =3D data[5];
>  		dev->online =3D dev->battery_capacity !=3D 0;
>  		battery =3D dev->battery;
>  	}
> =20
>  	/* only schedules a work, so this is safe from the completion path */
>  	if (battery)
>  		power_supply_changed(battery);

[Severity: High]
Can power_supply_changed() dereference a freed pointer here?

If a new connection probes concurrently, it can call unctrl_battery_registe=
r(),=20
which acquires this dev->lock, sets dev->battery =3D NULL, and immediately=
=20
calls power_supply_unregister().=20

Since power_supply_unregister() synchronously frees the battery, and this=20
code drops dev->lock before using the cached battery pointer, could this=20
lead to a use-after-free?

>  	return 0;
>  }
> =20
>  static void unctrl_remove(struct hid_device *hdev)
>  {
>  	struct unctrl_dev *dev =3D hid_get_drvdata(hdev);
>  	struct unctrl_dev *other;
> =20
>  	/* Stop polling before the transport goes down. */
>  	if (dev) {
>  		cancel_delayed_work_sync(&dev->battery_work);

[Severity: High]
Could dev->battery_work be rescheduled after this cancellation, leading to
a use-after-free?

Since dev is still in the global unctrl_connections list here (it isn't=20
removed until the mutex_lock(&unctrl_lock) later in the function), could a=
=20
concurrent unctrl_probe() or unctrl_remove() from another device find it,=20
transfer a battery to it, and call schedule_delayed_work()?

If so, the rescheduled work might execute after kfree(dev) is called.

>  		hid_hw_close(hdev);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-unctrl-=
m1-battery-v1-0-4a50203b7177@bishwasaha.com?part=3D4
