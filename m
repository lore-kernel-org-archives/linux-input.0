Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDB2BEC2A
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386374; cv=none; b=r/tfKgmCqGyl9zrunnVyEdg8MUwv6sfdfvHLLEj/S7T0wlQc6FX+t42qOQmIP09Nh1kdky109tAw2VsVM522dVS1TVXFUK5CKTNgSoul1J9Hc+qV/aEJ4O4YE8A4WyxZYIQBMpK3Ax3SaNkd2buM22Tb6/KAWu4R7/q80E2XQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386374; c=relaxed/simple;
	bh=ODtcBa/jyAxj9rimdAEPlUyq0qV21C4Zz2xK1ctvrpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZjMK+sQitStnYwhkkUWDrZ2M5FQSk+aEgWFd5MEZsDS8KsbTGB3qtMgycw9WzS0i3U+Ic/PCsHTRolCc1KR9MpKTviwcwmfHPGtfedcNK85jRP6FPiFnx4GhJ8PyxGWo6vgwZ9bTLE/G9AsoiMBm6vCSCd7n/6ri3DH9nSfkZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU3FpUEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU3FpUEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94E91F000E9;
	Thu, 30 Jul 2026 04:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386372;
	bh=aW3QJsMqJ4lkYfCALFv6MP19gTNegknJ2qD5XkoS2ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WU3FpUEZLNMGEWExsXxf3Yh4BalHwuqDuoJigBOlhJazu1Jxv8J+lF8Ke5d0whYMi
	 1DZhikucAuVxJLVxq6oqCrL31h3IgIySLc/LmLo02aCfa2YxViGZqz4kcKfIaQaa3K
	 50RvEM3OWnLiemEqwesXfis/IjNKutxmHIWkSFbWFUH/Cu/gdtjEWF89jhKdvNWdIs
	 XV7vafQ3PRVP1Fa0jtXrCg6yKzRz4M0G5mWuC6rAOryHn9lJBatE9fN5ZdajdyoIsF
	 vTgjPOZQ4k3AiY9cl1/xFsAXDw20cxCI7J5K8ZYt4/S0Hp5QloAJfRh1cs5olbFUP1
	 Ww9KZUbbh5hpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] HID: steam: Rearrange teardown sequence
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730041251.1659029-8-vi@endrift.com>
References: <20260730041251.1659029-1-vi@endrift.com>
 <20260730041251.1659029-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:39:32 +0000
Message-Id: <20260730043932.B94E91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free due to `work_connect` rescheduling after cancellati=
on in `steam_remove`.
- [High] Race condition leading to use-after-free in `steam_probe` error pa=
th.
- [High] Lockless TOCTOU race in `steam_raw_event` leads to Use-After-Free =
of `steam->client_hdev`.
--

--- Patch [7]: [PATCH v5 07/11] HID: steam: Rearrange teardown sequence ---
commit 0f9077495b7412b91d8e827f54f32dc26780b709
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Rearrange teardown sequence

This patch reorders the teardown sequence for the Steam controller driver to
address a narrow window where callbacks could be scheduled with a dangling
pointer. It also moves the cancellation of rumble and mode switch work to
steam_unregister().

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 12203d61922f7..663fda8a86fdb 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -1441,25 +1444,24 @@ static int steam_probe(struct hid_device *hdev,
>  static void steam_remove(struct hid_device *hdev)
>  {
>  	struct steam_device *steam =3D hid_get_drvdata(hdev);
> +	unsigned long flags;
> =20
>  	if (!steam || hdev->group =3D=3D HID_GROUP_STEAM) {
>  		hid_hw_stop(hdev);
>  		return;
>  	}
> =20
> +	hid_hw_close(hdev);
>  	hid_destroy_device(steam->client_hdev);
> -	cancel_delayed_work_sync(&steam->mode_switch);
> -	cancel_work_sync(&steam->work_connect);
> -	cancel_work_sync(&steam->rumble_work);
> -	cancel_delayed_work_sync(&steam->coalesce_rumble_work);
> -	steam->client_hdev =3D NULL;
> +	spin_lock_irqsave(&steam->lock, flags);
>  	steam->client_opened =3D 0;

[Severity: High]
This is a pre-existing issue, but does this sequence leave a window for a
use-after-free on steam->client_hdev?

In steam_remove(), hid_destroy_device(steam->client_hdev) is called to free
the virtual client device while the hardware is still active, since
hid_hw_stop() has not been called yet.

Meanwhile, steam_raw_event() locklessly checks if the client is opened befo=
re
dereferencing steam->client_hdev:

drivers/hid/hid-steam.c:steam_raw_event() {
    ...
    if (steam->client_opened)
        hid_input_report(steam->client_hdev, HID_FEATURE_REPORT,
                         data, size, 0);
    ...
}

If an interrupt fires and passes the client_opened check, could it get
preempted, and then resume to call hid_input_report() on the freed
client_hdev pointer after steam_remove() completes the destruction?

> +	spin_unlock_irqrestore(&steam->lock, flags);
> +	cancel_work_sync(&steam->work_connect);
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>  		hid_info(hdev, "Steam wireless receiver disconnected");
>  	}
> -	hid_hw_close(hdev);
> -	hid_hw_stop(hdev);
>  	steam_unregister(steam);
> +	hid_hw_stop(hdev);
>  }

[Severity: High]
This is a pre-existing issue, but can steam->work_connect still be
rescheduled after it is cancelled here?

In steam_remove(), cancel_work_sync(&steam->work_connect) is called, but
hid_hw_stop(hdev) isn't called until the very end.

If a wireless connect or disconnect event arrives in between,
steam_do_connect_event() unconditionally reschedules the work:

drivers/hid/hid-steam.c:steam_do_connect_event() {
    ...
    if (changed && schedule_work(&steam->work_connect) =3D=3D 0)
        ...
}

When steam_remove() finishes, the steam object is freed by devres, leaving a
dangling work item in the system workqueue. Will this lead to a
use-after-free when the scheduled work executes?

[Severity: High]
This is another pre-existing issue, but does the error path in steam_probe()
have a similar race condition with work_connect?

In the steam_probe() error path, steam_unregister() is called before
cancel_work_sync(&steam->work_connect):

drivers/hid/hid-steam.c:steam_probe() {
    ...
err_steam_unregister:
    if (steam->connected)
        steam_unregister(steam);
err_hw_close:
    hid_hw_close(hdev);
err_hw_stop:
    hid_hw_stop(hdev);
err_cancel_work:
    cancel_work_sync(&steam->work_connect);
    ...
}

steam_unregister() clears the device state by setting steam->serial_no[0] =
=3D 0.

If steam_work_connect_cb() is currently queued and runs concurrently, it
will see connected =3D=3D true and call steam_register().

Because serial_no was cleared, steam_register() re-registers all input
devices and adds the steam object back to the global steam_devices list.

After the work finishes, cancel_work_sync() silently returns, steam_probe()
returns an error, and the steam object is freed by devres. Does this leave a
freed object in the global list and registered to input subsystems, leading
to a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730041251.1659=
029-1-vi@endrift.com?part=3D7
