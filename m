Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BE2BEC23
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146498; cv=none; b=jTp+Sd3nsgGtSr7cgwsBf755upuGEjIiI+OSbnvZuozrb7DuF96VtnCaxIpis5okJ8nVw6yVhY88n5bELXmDGZDCe+gq7FVcXE09+Sdu1aNdYqWykS8vLjF51ES9UOuLi80bJxjdznlneeKcoHVOO6AgErRRcqviOv3wYRJnDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146498; c=relaxed/simple;
	bh=ftkLLQ0piDCyiB581mGdB9YmRW+TIbtN5sWlBZqlGAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o4xD3Tx/7jsjzxEka+WGo0cbytr1Cl8ESkVpSLEauJzDn8a/7GY1tumSFWVer5gIUmRld1k8MBSw/J7TLkEjQ+RXhAxYLNSvFQbCsOQjhNLgHIkjOjE91KNGILA7frS2ztmAZ2QOzgbBYatGmwa2O53UChlMimfPm7XGxeTMc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB6/TwGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB6/TwGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EC31F000E9;
	Fri,  7 Aug 2026 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146496;
	bh=dFaeizh9854OPFqdNDgxTG9xCOFgxjccKU2hpLHLZF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CB6/TwGP8q974eOduRFBsr5T9DgtS2YUD+yD/FqLHBvXQ0b//hSUmgN5Or4/6LEEC
	 B/ww03fv/0Rc3udcpHqqWqHASYHmNR5AMXEbn4+tQjfgedG2qxeULLa8wNRPlaZCQv
	 LqdG36ogY2TUvc9fYD2YsncNPh9qTKqjn6oALnd4RDueRrAF0CtyX7cjRfGLbSrjVl
	 y8DMpYpzfS1ZGL8AfJpkkyyPaE7qTLYEg15+hMPNZueeQLARR1eK134tl5686nzXoj
	 EMi5Lx6uh6xF9tEReW7iAqYN2n5Bfj92F4JMAvMOgPRMSno/RgjFVoPry8dhje8bgg
	 wcmXBUlTinALA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] HID: steam: Don't set feature reports when
 disconnecting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807232339.2799205-5-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
 <20260807232339.2799205-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 23:48:15 +0000
Message-Id: <20260807234816.47EC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of `steam->client_hdev` in `steam_raw_event` due to=
 lockless state read and improper teardown order.
- [High] Use-after-free of the `steam` object due to delayed works being sc=
heduled after they are cancelled in `steam_remove`.
--

--- Patch [4]: [PATCH v4 4/6] HID: steam: Don't set feature reports when di=
sconnecting ---
commit a4f986bc6df63f014c012a55b0b8e0ff17917cf8
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Don't set feature reports when disconnecting

This commit updates the driver to fail silently when setting feature reports
fails with -ENODEV during device disconnect. It prevents expected errors
from flooding the kernel log when lizard mode and IMU mode are reset.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 8d3ef523682bd..d95296b28f92b 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -570,7 +574,11 @@ static int steam_send_report_id(struct steam_device =
*steam,
>  	} while (--retries);
> =20
>  	kfree(buf);
> -	if (ret < 0)
> +	/*
> +	 * Don't log if the failure is -ENODEV, as this
> +	 * can happen normally on disconnect.
> +	 */
> +	if (ret < 0 && ret !=3D -ENODEV)
>  		hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
>  				ret, size, cmd);
>  	return ret;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the disconne=
ct
handling, is it possible for the interrupt handler to access freed memory?

Looking at steam_remove(), the client device is destroyed before the
client_opened flag is cleared and before hardware interrupts are stopped:

drivers/hid/hid-steam.c:steam_remove() {
    ...
    hid_destroy_device(steam->client_hdev);
    spin_lock_irqsave(&steam->lock, flags);
    steam->client_opened =3D 0;
    ...
}

If a USB report arrives in this window, could steam_raw_event() locklessly
read steam->client_opened (which still evaluates to true) and call
hid_input_report() on the already freed steam->client_hdev?

drivers/hid/hid-steam.c:steam_raw_event() {
    ...
    if (steam->client_opened)
        hid_input_report(steam->client_hdev, report->type, data, size, 0);
    ...
}

[Severity: High]
This is also a pre-existing issue, but does steam_remove() leave a window
where cancelled works can be re-queued?

In steam_remove(), the works are cancelled and the device is unregistered
before hardware interrupts are finally stopped via hid_hw_stop():

drivers/hid/hid-steam.c:steam_remove() {
    ...
    cancel_work_sync(&steam->work_connect);
    ...
    steam_unregister(steam);
    hid_hw_stop(hdev);
    ...
}

Because hardware interrupts can remain active in this window, incoming HID
events can still trigger steam_raw_event(). If a user presses the start
button in this window, could steam_do_deck_input_event() queue the
mode_switch delayed work?

drivers/hid/hid-steam.c:steam_do_deck_input_event() {
    ...
    schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
    ...
}

Similarly, could incoming wireless events trigger steam_do_connect_event()
and queue work_connect after it was already cancelled?

drivers/hid/hid-steam.c:steam_do_connect_event() {
    ...
    if (changed && schedule_work(&steam->work_connect) =3D=3D 0)
    ...
}

Once steam_remove() returns, the steam struct is freed via devres. Could
these pending works then execute on the freed steam object, causing a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807232339.2799=
205-1-vi@endrift.com?part=3D4
