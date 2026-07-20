Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A4393DE0
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528785; cv=none; b=ubwv0mrKkhtirR7bbATZmlgUMnF61UYNcSEpJ2AE8TWBX0KC0lWOQ5H1gUQ+NrBD+M6A7fWEhU6qfoPjdgUSD5Zt1hcROZcKU5Om0d1Ui1mXzsLI0TGrIZH5ytT4XWWblAa7dxvG7d+2lFuG1i3gEqE0BKGpmOIR3iF/3Y2svFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528785; c=relaxed/simple;
	bh=9cDB6wO80wJennuVrP1wLShE8B03TAYbFgbWgzNFA1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/avwc/9Fs/gcnqj4Sl6MOL1Eu3k1AEAQYUFYRgZU93NDs9vtS369XUQmtFbCWFeAxarpafV1G5P0Hy654z37hXErHrUtohLnkZqNQq036uo2AkzjaKiAhM3AMBf97UyJ9JMPvclEVcZ5BOaAFQZZSrPESGRAv1vC47s22WOPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gksJIYeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gksJIYeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069C01F000E9;
	Mon, 20 Jul 2026 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784528782;
	bh=8r6Z+Em1Sb42eBToyoV8hcm76HeJ0ZjJ+VnpaxN8fak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gksJIYeXgj/A80XrXw07C3YcYa2x3vbh6X5xhLRy5oNssKz4A70pVOSSBeoz5qYIL
	 UNCGoPNtq73FCiy1iQ9AW6Ar68w3VPVHpikU/unHpbGtJ99PanXZygMfO/hjqCCyqH
	 2IvBm7o6T+7/XjvrKm2Dd8YiKTG3lCcOjRWZ28suTjuAXJ7tpPwZD5kudRwobZq9Ik
	 60wsdidIgdOMvxL0lY8WoS4KO1s/HCHENKgGnI6nvrsx2G1qWtxT/SAjiZVx+DK9ND
	 ocOBQAqQsYAxWF2F6EKB7EccGyjnwD+pbs5D1FAefrBBvxFEaQCPuXheysX6YRt9Pb
	 WJreaoiM9Ymkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: byd - synchronize timer deletion before
 freeing private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720061259.1601281-1-lilinmao@kylinos.cn>
References: <20260720033030.1580891-1-lilinmao@kylinos.cn>
 <20260720061259.1601281-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:26:21 +0000
Message-Id: <20260720062622.069C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of the protocol handler `byd_process_byte()` =
during or after `byd_disconnect()` can lead to a Use-After-Free or NULL poi=
nter dereference of the driver's private data.
--

--- Patch [1]: [PATCH v2] Input: byd - synchronize timer deletion before fr=
eeing private data ---
commit e08a94a088b6cedd4010692fa9ab4cd3e5287e71
Author: Linmao Li <lilinmao@kylinos.cn>

    Input: byd - synchronize timer deletion before freeing private data
   =20
    byd_disconnect() uses timer_delete() before freeing the driver's private
    data.  This does not wait for a running byd_clear_touch() callback, whi=
ch
    dereferences the private data and its psmouse pointer.  A callback raci=
ng
    with disconnect can therefore access the private data after it has been
    freed.  The timer can also still be re-armed by byd_process_byte() while
    the disconnect is in progress.
   =20
    Use timer_shutdown_sync() before freeing the private data: it waits for
    a running callback and turns any later re-arm attempt into a no-op.

> diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
> index f5770a3af2f12..5fc3c629590ae 100644
> --- a/drivers/input/mouse/byd.c
> +++ b/drivers/input/mouse/byd.c
> @@ -423,7 +423,7 @@ static void byd_disconnect(struct psmouse *psmouse)
>  	struct byd_data *priv =3D psmouse->private;
> =20
>  	if (priv) {
> -		timer_delete(&priv->timer);
> +		timer_shutdown_sync(&priv->timer);
>  		kfree(psmouse->private);
                ^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
This is a pre-existing issue, but could this free lead to a use-after-free
or null pointer dereference if a hardware interrupt occurs concurrently?

During disconnect, the psmouse core sets the software state to
PSMOUSE_CMD_MODE in psmouse_disconnect(), which still allows the interrupt
handler to process incoming bytes.

If a full packet is received, the protocol handler byd_process_byte() is
called and unconditionally dereferences psmouse->private, which may have
just been freed or set to NULL:

drivers/input/mouse/byd.c:byd_process_byte() {
    struct byd_data *priv =3D psmouse->private;
    ...
    switch (pkt[3]) {
    case BYD_PACKET_ABSOLUTE:
        if (!priv->touch) {
    ...
}

Should the state be set to PSMOUSE_IGNORE or the RX queue otherwise paused
before we free the private data here?

>  		psmouse->private =3D NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720061259.1601=
281-1-lilinmao@kylinos.cn?part=3D1
