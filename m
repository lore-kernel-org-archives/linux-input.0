Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D992F3A6B77
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786081035; cv=none; b=ne6S19FnsxRLSY9IO24osxvasS3RLY76BsflEE5JE3t2/SyFUsyBuSbWjHI6NqHLYXHj/wdsAIHuOPgpQ8NgLR7O5XsWMO9XGA/NMTOAFrgDQg3dArbAD2LZg3dG30IJx7lpkrdpug7fjmKMUtn8DGH+7aFgO5UYnJdr8UeIMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786081035; c=relaxed/simple;
	bh=SP1T8OGlEToGqLkC6vpfib9OAvXoJ3FDgqUAXMLKhKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9b+rQmd0veEd3aF/z8J+YgjH9qptN/HO+4L0EJhIRmn940I9OW8qVopm9JuZf1zW04PYuQgTYtOqEv920Cue4xcqhN10gFdvoDEuGZSKLKwoi8yCHeYbU3CNDwKE2J3K1RdKnso0nRT/TxTW/RPJUGgzOqED+vD4G+ydb7r8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boRB13lQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boRB13lQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E39C1F000E9;
	Fri,  7 Aug 2026 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786081033;
	bh=/BHRgh2RdP25jN3CtkDXXDuG20JxQMBcXbwYwHv+e2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=boRB13lQm8n9ZFBhXQYlFPwkthdlyKiHwLrvZwFfxy5ffBSGkedXq69L1+hjOtU7v
	 DiQDnpoDKm9fzIXlmzVoXtXrtdLQt5KjdpuLv4da65N3hv2oP+11MiIaehnR+M42Up
	 mfLab1jXe6MiZFbRQDA2HOW0XXrBiZHRJufBBhXtu2gaPUZ4bmt1jgQDm+guv99dEE
	 ZXqEWfBuSFSU2vvSmqtqXtw58/pLVBQ/IP5J0DltOfcAsZ7RkAsDrLlQZa93NQQJyN
	 q9BQnuq3meFfSOQjr4mw5imTbJX/m8xhnCD0yPWl4Zi7hTM4eV7awhZ6bzG95PGjEx
	 egnDHLJP5dOUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: sony: fix use-after-free when removing GHL devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260807052328.11404-1-fanwu01@zju.edu.cn>
References: <20260807052328.11404-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 05:37:12 +0000
Message-Id: <20260807053713.4E39C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In the `sony_probe()` error path, driver-specific resources regist=
ered during `sony_input_configured()` are not cleaned up when probe fails a=
fter `hid_hw_start()`, leading to a Use-After-Free.
- [High] The GHL poke timer and its URB are not paused during system suspen=
d, causing the poke loop to permanently stop and the device to freeze upon =
resume.
--

--- Patch [1]: [PATCH] HID: sony: fix use-after-free when removing GHL devi=
ces ---
commit 60eeab13afba312995f6d575044d513de06674d1
Author: Fan Wu <fanwu01@zju.edu.cn>

HID: sony: fix use-after-free when removing GHL devices

This commit fixes a use-after-free issue during the removal of GHL devices
by using timer_shutdown_sync() to prevent timer re-arming. It also adds
usb_kill_urb() to drain any URB the callback submitted before freeing it.

> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index e75246d29e16d..f7929a7848be4 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2424,7 +2424,8 @@ static void sony_remove(struct hid_device *hdev)
>  	struct sony_sc *sc =3D hid_get_drvdata(hdev);
> =20
>  	if (sc->quirks & (GHL_GUITAR_PS3WIIU | GHL_GUITAR_PS4)) {
> -		timer_delete_sync(&sc->ghl_poke_timer);
> +		timer_shutdown_sync(&sc->ghl_poke_timer);
> +		usb_kill_urb(sc->ghl_urb);
>  		usb_free_urb(sc->ghl_urb);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at how the GHL poke
timer is managed, is the timer properly paused during system suspend?

If the system enters suspend and the USB bus is suspended, what happens if =
the
timer fires? It looks like usb_submit_urb() in ghl_magic_poke() will return=
 an
error and fail to re-arm the timer:

drivers/hid/hid-sony.c:ghl_magic_poke() {
	...
	ret =3D usb_submit_urb(sc->ghl_urb, GFP_ATOMIC);
	if (ret < 0)
		hid_err(sc->hdev, "usb_submit_urb failed: %d", ret);
	...
}

Neither sony_suspend() nor sony_resume() appear to pause and restart this
timer loop. Does this mean the poke loop silently dies upon suspend, causing
the GHL device to freeze when the system resumes?

[Severity: High]
This is also a pre-existing issue, but seeing the teardown sequence in
sony_remove() raises a question about the error path in sony_probe().

When hid_hw_start() succeeds, it internally calls the driver's
sony_input_configured() callback, which allocates resources and adds the
device to the global sony_device_list.

If a subsequent check in sony_probe() fails, it jumps to the err label:

drivers/hid/hid-sony.c:sony_probe() {
	...
err:
	usb_free_urb(sc->ghl_urb);

	hid_hw_stop(hdev);
	return ret;
}

This error path does not appear to call sony_remove_dev_list(sc) or
sony_release_device_id(sc) like sony_remove() does. Since sc is managed by
devm_kzalloc(), the memory is freed when probe returns, leaving a dangling
pointer in sony_device_list. Can this lead to a use-after-free the next time
any Sony device is probed and the list is traversed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807052328.1140=
4-1-fanwu01@zju.edu.cn?part=3D1
