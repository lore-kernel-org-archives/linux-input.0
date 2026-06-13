Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E43FC0A
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365654; cv=none; b=Ent/bnMouajfSEhjOQ6qqrC5TjWTbBhuUr3IosnfIocOO5p4K7dXH/qL8J5XEVs1acDG95T7hoSxQVh+EIR1WdYYBw5LzOdwxsVqImFmPZwyO3F5RvddmBf+I6vezHtjZ4c9iIlmGiJZhbJcUIjzX/tp5pzbUhx2htCTA8nJKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365654; c=relaxed/simple;
	bh=FoGjMCHQGP4KY1rwlDGAkthT26Uu2RmQerjQ3zPBDeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nWhqwzQN1WRwYuIj2ISuAQy/D07WjBiP8rTW+vzpuDKBjMmNK8Eqtbrrd/b5Lq68suyjMWbaO8fk+ka0cbGrT/a749D1QcV/n39VslkznjSgCtNaEul1qMyQvIYJEkGmrhwismH3tfKBGAEIxaCQzSiHjQoGFg0sNF1nuZWrFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbCc7RlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbCc7RlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A4B1F000E9;
	Sat, 13 Jun 2026 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781365652;
	bh=1jVXWxiKaoCpW1piZd4JkIz9q5mIFyroglxQVRIYgIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbCc7RlFUGrkwn6zuKTGhnj40f7fFvWiQCWLWlHnfSzKMt/RCxhIS2xFmd7dIcuIv
	 ufIC2lNfLf1Loe5AA1PgAWKliv+73OC7wbpGQb0wUtdi1CqrzF3H38Ke7MocxMQK6E
	 jo0EH/EIPhnQCbYhR9ZURcjC8aKZ7U2/T5XPy5vGDEvJ4v51unYTmxxZOGTBrtttWW
	 N7FU92Is3wtBJhEnP90CkKUMluaZR3Mjz5vzroN3bDLrA7ZsUAItfqtcdWF0t7nhoK
	 6QyjXel/Il+yCeD09v0OATCZf9/SHWYyyHm87oNGHMK4YFADUYC8A74bZxborzXgRO
	 wyqKOiTZTZxOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] HID: asus: mitigate possible use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260613153029.2559774-2-denis.benato@linux.dev>
References: <20260613153029.2559774-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 15:47:31 +0000
Message-Id: <20260613154732.60A4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing initialization of `fn_lock_sync_work` leading to `WARN_ON`=
 in `cancel_work_sync()`.
--

commit 317502709e07b71f7cfc9f30cf392aa744d4f88d
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: mitigate possible use-after-free

The kbd_backlight pointer is not being set to NULL after being freed in
asus_kbd_register_leds and other portions of the driver checks that field,
therefore set the pointer to NULL after being freed.

Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..c2a5edebbd7a7 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -777,6 +777,7 @@ static int asus_kbd_register_leds(struct hid_device *=
hdev)
>  	if (ret < 0) {
>  		/* No need to have this still around */
>  		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> +		drvdata->kbd_backlight =3D NULL;
>  	}
> =20
>  	return ret;

[Severity: High]
This is a pre-existing issue, but since the patch touches driver teardown
safety, does the current teardown logic in asus_remove() safely handle
uninitialized work structs?

In drivers/hid/hid-asus.c:asus_input_configured(), the work struct is
conditionally initialized:

    if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
        drvdata->fn_lock =3D true;
        INIT_WORK(&drvdata->fn_lock_sync_work, asus_sync_fn_lock);
        asus_kbd_set_fn_lock(hdev, true);
    }

However, for some devices (like those with QUIRK_ROG_NKEY_KEYBOARD and
QUIRK_HID_FN_LOCK quirks), the HID core might skip input checks if the
device does not have inputs. If asus_input_configured() is never called,
fn_lock_sync_work remains zero-initialized.

When the device is unbound, drivers/hid/hid-asus.c:asus_remove() calls:

    if (drvdata->quirks & QUIRK_HID_FN_LOCK)
        cancel_work_sync(&drvdata->fn_lock_sync_work);

Can this trigger a WARN_ON(!work->func) in __flush_work() if
cancel_work_sync() is called on the zero-initialized work struct,
potentially causing a panic on systems with panic_on_warn=3D1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613153029.2559=
774-1-denis.benato@linux.dev?part=3D1
