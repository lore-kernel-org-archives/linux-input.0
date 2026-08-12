Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D5D35E936
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498506; cv=none; b=BbRd+C1Xh5fb5eUh0pxXbt60v/GUjap2XLcUQRiKyhmw81V2etwYxcS/zJAK2RpBgTtozA+DKiLd0E84bOGiaS7ysrx54JLVr0iaIZMMY5DurlbsrETHWEsUik9aM2gKCvpmlDgfRU3H2RweV8ghrQMZv0YUVzg9m/3bhyxIClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498506; c=relaxed/simple;
	bh=cPGumQYaI5QjULsPgubuUxEwzlZwIgdzvLXUTDzZGcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svhBrWRTmcQfP43eJBdfgFBzl7rQd+qXsoO45vHQF1VUZ7rv/ANKkz3yaW2torVxEoO6XV2CkDImFxcL+75ta3iDx9BXqzs+XNK/mdHG5Eqy656vJWlpW8fpd/+RVHXhXHHlkwMlBCT22tHoJPxoEocwc59E8eOGYpXioRFiZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St5teiRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St5teiRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8936C1F00A3A;
	Wed, 12 Aug 2026 01:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498504;
	bh=ZCVQsZCpOdZhJPqgfyNITJcfe3EwIV8L6xkVGLJ24Sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=St5teiRsK7yvQqiJZ+A1lrkNt+5/7Xc9ddnT8T7EsTH/E3ovFITy654jqruxDMIR8
	 dZpQcooQQXNXP1EJN24fIUy7uC3aIR4Me5yIZBW3eefnjGwNAX478L/cX3BuFLAbR5
	 3utmKbAps1ulWVX4EtzWhIHNiNwK+YKeEjQRn+DfeL8IBSJMxW8fY3PMAFuWY8tXLK
	 wXDOMzw3t/JQ3iYzJDMY7fb2p8bdxAqHaEQhIJJBNrolbjYWfXjMkPb6bmeP0AoG03
	 L6YYcJUCdIszu7vnrD1IbKp0xc+uPhykZCiwa1rciMqeHkFOkaFLbC3WVMaC7z0zxn
	 0wbpYuhxQPBCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] HID: steam: Don't set feature reports when
 disconnecting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260812011401.3250968-5-vi@endrift.com>
References: <20260812011401.3250968-1-vi@endrift.com>
 <20260812011401.3250968-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 01:35:04 +0000
Message-Id: <20260812013504.8936C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free in steam_remove() due to incorrect cancellation ord=
er of deferred work.
--

--- Patch [4]: [PATCH v5 4/6] HID: steam: Don't set feature reports when di=
sconnecting ---
commit 460f363e27307cbdb952f6004dd3826de0898a07
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Don't set feature reports when disconnecting

When an input device is closed, we set a feature report to reset lizard
mode and IMU mode. However, if the input device is closed because it was
removed, then we will necessarily error out when sending this, resulting in
logged errors. Since an error here is expected, we should just fail
silently.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 461ebf37171b7..7226c0681ed18 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -490,9 +490,13 @@ static int steam_recv_report_id(struct steam_device =
*steam,
>  	}
> =20
>  	kfree(buf);
> -	if (ret < 0)
> +	/*
> +	 * Don't log if the failure is -ENODEV, as this
> +	 * can happen normally on disconnect.
> +	 */
> +	if (ret < 0 && ret !=3D -ENODEV)
>  		hid_err(steam->hdev, "%s: error %d\n", __func__, ret);

[Severity: High]
This is a pre-existing issue, but while reviewing device disconnects, I
noticed a potential use-after-free during device removal in steam_remove().

Looking at steam_remove(), cancel_work_sync(&steam->work_connect) is called
before hid_hw_stop(hdev):

drivers/hid/hid-steam.c:steam_remove() {
	...
	cancel_work_sync(&steam->work_connect);
	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
		hid_info(hdev, "Steam wireless receiver disconnected");
	}
	steam_unregister(steam);
	hid_hw_stop(hdev);
}

Because hid_hw_stop() is called last, hardware interrupts can still trigger
steam_raw_event() after the work item is cancelled. If a wireless connection
event (ID_CONTROLLER_WIRELESS) or an unexpected input report arrives during
this window, steam_raw_event() will invoke steam_do_connect_event(), which
re-schedules steam->work_connect:

drivers/hid/hid-steam.c:steam_raw_event() {
	...
	case ID_CONTROLLER_WIRELESS:
		...
		switch (data[4]) {
		...
		case 0x02:
			steam_do_connect_event(steam, true);
			break;
		...
}

After steam_remove() returns and the device memory is freed by devres, the
workqueue retains the pending work, which could access the freed memory when
it runs.

Should hid_hw_stop(hdev) be called before cancel_work_sync() to ensure no n=
ew
events can queue the work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812011401.3250=
968-1-vi@endrift.com?part=3D4
