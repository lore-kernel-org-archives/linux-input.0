Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350241F7D8
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329578; cv=none; b=I4BD/udAldMYlTWN6Er5tkwNXlnqHPWoEFrF9i/RVGc8wdLlUC7dxKy9BloWK9WI+R7Qf7y5Q/GiJ9lcKR2v95X59AmPuaulmSkRvdCtNFGdSMKcHLRiqw3wEzLcsSLn7ZZ/jcDUqeV/r47tljlzCPCLolmIcllehip209KIhes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329578; c=relaxed/simple;
	bh=OR0jDkq0K9pevq1rAwCftolpwA5OctbmYgIFyZ7HlJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TsBe4UGxWEidlYboMSI2SROOYFMvBb5MpYCBaRSsvRcIE0XVN0oJLdIh7tb4s2JtcLdxONab+sgGxo3veQoGpWKE4lvrhl+bvhv+7Nnxg48oqMwD7JcWHoUFQ7XE5UlJJnDFMwzAra8gH3adWHDw4fwH05owY1pw5XloRkMIgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4cMlUsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4cMlUsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C591F000E9;
	Mon,  6 Jul 2026 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329573;
	bh=6g7qSeV4UWpUgtBfZvv9BWZAAyrVr+RtmGOABIH1alE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b4cMlUsIriLSEDONH5XNgZ0tiQhDIuFAIS7NgxRLw34z8xjY1mB8DWbW4J4/i8l81
	 dk1flQQuk0BSU8qd0RBbcA5ugD9Ba8dqsGN/gK8s5eua3oJE5kjNhzblNqVMqhKDBJ
	 DB4eixamUOn1WE9sg/LTq9tZeFBnDX3Eo8yYmfGr0N08STUPvo+NBYWl8pfCEu7g5h
	 RAvvjx5PcsVBd4JW6nhNPM40GM5Vb2gaB09awuTAvczFIvOwkea+S0tsZVK+QvLLqL
	 JvIxuPjdKOjwTAvI0gWeAhvCk3OOB4UTEWgC5au1T63NzmtNff3Y071HanTg+BcBCA
	 upybBiXPEz1Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2200: validate input report length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260706090932.75673-1-pengpeng@iscas.ac.cn>
References: <20260706090932.75673-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:19:33 +0000
Message-Id: <20260706091933.A1C591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A raw event arriving immediately after `hid_hw_open` will cause a =
NULL pointer dereference because driver data and synchronization primitives=
 are not yet initialized.
- [High] Concurrent calls to `mcp_cmd_read_all` can lead to corrupted state=
, lost wakeups, and data races because `wait_in_report` and shared response=
 fields are not protected by locks during command execution.
- [High] The GPIO chip is managed via devres and unregistered after the HID=
 hardware is stopped, leading to potential use-after-free or invalid hardwa=
re accesses.
--

commit d11b6ebfc1ea2a8baf37113e30af821787d261be
Author: Pengpeng <pengpeng@iscas.ac.cn>
Subject: HID: mcp2200: validate input report length

This commit updates mcp2200_raw_event() to validate that the command byte
and response fields are present in the HID input report before accessing
them. It rejects truncated reports instead of reading past the end of the
payload.

> diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
> index dafdd5b4a0797..d2f45892dc22a 100644
> --- a/drivers/hid/hid-mcp2200.c
> +++ b/drivers/hid/hid-mcp2200.c
> @@ -299,8 +299,19 @@ static int mcp2200_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>  	struct mcp2200 *mcp =3D hid_get_drvdata(hdev);
>  	struct mcp_read_all_resp *all_resp;
> =20
> +	if (size < 1) {
> +		mcp->status =3D -EINVAL;

[Severity: High]
This is a pre-existing issue, but is it possible for an interrupt to fire
immediately after hid_hw_open() in mcp2200_probe() and trigger a NULL
pointer dereference here?

If mcp2200_raw_event() is called before hid_set_drvdata() and lock
initialization complete:

drivers/hid/hid-mcp2200.c:mcp2200_probe() {
        ...
        ret =3D hid_hw_open(hdev);
        ...
        mutex_init(&mcp->lock);
        init_completion(&mcp->wait_in_report);
        hid_set_drvdata(hdev, mcp);
        ...
}

Could mcp be NULL here, leading to a crash when accessing mcp->status?

> +		complete(&mcp->wait_in_report);
> +		return 0;
> +	}
> +
>  	switch (data[0]) {
>  	case READ_ALL:
> +		if (size < sizeof(*all_resp)) {
> +			mcp->status =3D -EINVAL;
> +			break;
> +		}
> +
>  		all_resp =3D (struct mcp_read_all_resp *) data;
>  		mcp->status =3D 0;
>  		mcp->gpio_inval =3D all_resp->io_port_val_bmap;

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent calls to
mcp_cmd_read_all() lead to corrupted state or lost wakeups?

In mcp_cmd_read_all(), the mutex is released before waiting for the
response:

drivers/hid/hid-mcp2200.c:mcp_cmd_read_all() {
        ...
        mutex_unlock(&mcp->lock);
        t =3D wait_for_completion_timeout(&mcp->wait_in_report, ...);
        ...
}

Does modifying mcp->status and mcp->gpio_inval locklessly here in
mcp2200_raw_event() create a data race if multiple threads are reading or
writing GPIO state concurrently?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does using devres for the GPIO chip
create a use-after-free risk during device removal?

In mcp2200_probe(), the chip is registered with devres:

drivers/hid/hid-mcp2200.c:mcp2200_probe() {
        ...
        ret =3D devm_gpiochip_add_data(&hdev->dev, &mcp->gc, mcp);
        ...
}

Then in mcp2200_remove(), the hardware is stopped before the chip is
unregistered:

drivers/hid/hid-mcp2200.c:mcp2200_remove() {
        ...
        hid_hw_close(hdev);
        hid_hw_stop(hdev);
        ...
}

Could a user-space process continue interacting with the GPIO device while
the USB device is physically removed, causing invalid hardware accesses
before devres cleans up the GPIO chip?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706090932.7567=
3-1-pengpeng@iscas.ac.cn?part=3D1
