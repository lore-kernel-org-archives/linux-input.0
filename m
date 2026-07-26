Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28B282F3C
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785061639; cv=none; b=Beyfck48jJrBigFv683Br5LO7c2dHzvDeyilTJ2hF84bWmhMBylZY331ibWjeTKqUNWLW7dYzR3Xh+Y5qQtMM8f2JYRfvtrDdOKgzBuD+1IXl7hUCh5E8OefQzhrhv9nZotMnbuGamDyrw++ouj0sVakrB/1bpj8tDbrdJbdB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785061639; c=relaxed/simple;
	bh=T1tnxD5AMOBLPBsIHBxPQSS5k5PfHchWSRPZ8HcUazY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P3WyOTGtDsPmctIExdjIr0tdhUnF3w3Ge/ZmFj5/2rVnBEcTAab0CvdQ6AstGHf0woyTAjcZTfKM4lucjAcCqf5A4fC2s6bB2zLZmqFBYzFpCJef6xGDWPBXY0mgf4yd4Gw2wOWXSw9QKv/3Lubz9MyeWnvd+PXRmHiUYosQOwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9XgQMGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9XgQMGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E691A1F000E9;
	Sun, 26 Jul 2026 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785061638;
	bh=97+ynmatqcT5GSln6+EIy5JgYYF5uVbhDLFemEZ9COA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9XgQMGn0dDc/VaqGB+IiIZ6L7nm/ijhY7bRhAqZPJOD8Ive5ANJQkhbmgYi3JizB
	 t1y1MB3vvHzZc4qqI4eqFPQgDwVLrwbBMm13OCgTnR01PbsHQria29FJFoq1hRZ5k/
	 DIXE5W8xzeVbT/9QPtdUwo0kdfS8fRKcHwhQFbLhiCZH4ro6C2yPyHwzer+IWirx0E
	 73w/iCsmjd4a2mtpBrgLjTakHph7BvFWLoYelpl81QgrMwUwzvE8WJ9KG++7CgULiG
	 I74izwMGfyx2faJdeExd9enspUY+U6giObCLB7XSyCV9pKIuksrUBz/tZxgKIzZMFk
	 0sHCnWHO+yJZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/13] platform/x86: bitland-mifs-wmi: use
 devm_blocking_notifier_chain_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eliav Farber" <farbere@amazon.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260726101739.33170-7-farbere@amazon.com>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-7-farbere@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 10:27:17 +0000
Message-Id: <20260726102717.E691A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference in `bitland_mifs_wmi_notify()` =
when handling events for the CONTROL WMI device.
--

--- Patch [6]: [PATCH v4 06/13] platform/x86: bitland-mifs-wmi: use devm_bl=
ocking_notifier_chain_register() ---
commit b97b8d7c2a6f0ffd33788a7a075476a57a269e06
Author: Eliav Farber <farbere@amazon.com>

platform/x86: bitland-mifs-wmi: use devm_blocking_notifier_chain_register()

This commit simplifies the driver by replacing the combination of
blocking_notifier_chain_register() and devm_add_action_or_reset()
with a single call to devm_blocking_notifier_chain_register(). It
also removes the now-unused bitland_notifier_unregister() callback.

> diff --git a/drivers/platform/x86/bitland-mifs-wmi.c b/drivers/platform/x=
86/bitland-mifs-wmi.c
> index b0d06a80e89ef..576d6f3733b4c 100644
> --- a/drivers/platform/x86/bitland-mifs-wmi.c
> +++ b/drivers/platform/x86/bitland-mifs-wmi.c

[ ... ]

> @@ -721,13 +714,9 @@ static int bitland_mifs_wmi_probe(struct wmi_device =
*wdev, const void *context)
>  		return ret;
> =20
>  	drv_data->notifier.notifier_call =3D bitland_notifier_callback;
> -	ret =3D blocking_notifier_chain_register(&bitland_notifier_list, &drv_d=
ata->notifier);
> -	if (ret)
> -		return ret;
> -
> -	return devm_add_action_or_reset(&wdev->dev,
> -				       bitland_notifier_unregister,
> -				       &drv_data->notifier);
> +	return devm_blocking_notifier_chain_register(&wdev->dev,
> +						     &bitland_notifier_list,
> +						     &drv_data->notifier);
>  }
> =20
>  static void bitland_mifs_wmi_notify(struct wmi_device *wdev,

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer=20
dereference in the notification handler.

During bitland_mifs_wmi_probe(), data->input_dev is only allocated if the=20
device type is BITLAND_WMI_EVENT. However, if firmware sends a hotkey=20
event to the control device, bitland_mifs_wmi_notify() will run without=20
checking if data->input_dev is actually allocated:

bitland_mifs_wmi_notify()
    ...
    case WMI_EVENT_OPEN_APP:
    case WMI_EVENT_CALCULATOR_START:
    case WMI_EVENT_BROWSER_START: {
        guard(mutex)(&data->lock);
        if (!sparse_keymap_report_event(data->input_dev,
                                        event->event_id, 1, true))

Could this cause a kernel panic in sparse_keymap_report_event() since it=20
doesn't defensively check for a NULL input_dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726101739.3317=
0-1-farbere@amazon.com?part=3D6
