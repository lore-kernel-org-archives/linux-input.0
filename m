Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930206;
	b=cWPvrFRUYiqCNmWCZkceTqGznpH7hmDzxzkehnBHH1jM6ARdyjCGxkLZfN2KChZQftTZ
	 0LGxCuSv96/TdB4/Hb0P5yjTVUC5NboeNghe/a8rH5HIyK+VxqN+OpDmvRu1bHHCKdfSG
	 5Mxy83O/Zc5qRvwi1wrCmNteCbwiqzi0+7VJ1daxXfUTJyLtWbu/dbzsgjEpfys0sz+o9
	 0jhOKN80XGzh0XlTUuBipi1t1RqFuf6V/zHuzlaA5szcfEPrtwX8JF9yLR82CIsnfJJfX
	 eniIm+sQDSaluGbGrZIGEhijKsSKPp8d9/bFCJL2e62rxRL/9tIw6v/kwIgwVqRpbSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930206;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ubE/T2qAVlSFntO8n7TbmGDG+R57KQROV5j6R32lu0g=;
	b=wH7IcHSyfYXIL96WpMpXGGjBQDIZZs+hSwX7qh78jRAtDFGDbN8UbwX1Jdrut/V04Cv7
	 w71zKjnSjkQ/QQoEbMSSSkxHzjWAEAhMMJo0y9I2CkVZnKf2IsxAf4zTU+jeKrchTQEo3
	 xrrLOqMKl4PYaG+cIgjlt6n4XUxfkrGJBoX/fzivoZmbiP15LEkBZhtBTw8QPs5ZnfvFz
	 z5XMS7b+YL0bGxEvONuJQSDpbo9Tr5PYam0H1eXRmlBfFETGNuE3weM+wLFXFpy2jg4iz
	 kyXY7HUob8dNdpqVYKuq9cYyBQMHHVjmYBaj3YPaX0xHCa/Y8mSzHYWlMiNG3vi/exg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WykDVrOk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C015606A328
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 01:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WykDVrOk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C494F1F008A3;
	Fri,  6 Nov 2026 01:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930206;
	bh=ubE/T2qAVlSFntO8n7TbmGDG+R57KQROV5j6R32lu0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WykDVrOkTt0+wTW09kdFNJsoAUjbAQBH3STL99JYEWET9qvv244TIsG0ib7gdG8eD
	 h4Hx4rMYZm80EIoAhDekWz0/9BmknKUAyPNPbFKbwzNvuq9bARdL+F7X88ShaqJd4W
	 wKDK52YUwR/9Gd/tSkeO/jRkMPPP4t8vRorro12ednw3ilJxSouc1Vfw13TCCAdLBi
	 yOkLuxpKvaCwXMw8vtuGwRyrkNfR+jGoMQsxaqhjkGYDPl0TvNb8Tk7vm6lld2dRWW
	 Ia6FavYD0hsSpomqrmNhnPj8pA5p+8vBbUluWkYFWSN+BtRokampam1nQk8E2M1nl1
	 OE+k2iyUfRLBQ==
Message-ID: <sashiko-outbox-200553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xen-kbdfront - bound the backend-supplied
 keycode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guo Zihao" <guozh23@xiaopeng.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261106014957.4130059-1-guozh23@xiaopeng.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 01:56:45 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Input: xen-kbdfront - double-fetch of keycode in xenkbd_handle_key=
_event()
--

commit b7a9474ab37fe06db55378df5e31d80df12a42ed
Author: Guo Zihao <guozh23@xiaopeng.com>

Input: xen-kbdfront - bound the backend-supplied keycode

This commit adds a bounds check against KEY_MAX in xenkbd_handle_key_event()
to prevent out-of-bounds bitmap reads in test_bit() when a backend supplies
an invalid keycode via the shared ring page.

> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-k=
bdfront.c
> index 6471d836f6fe6..e9092a7889261 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -92,6 +92,11 @@ static void xenkbd_handle_key_event(struct xenkbd_info=
 *info,
>  	struct input_dev *dev;
>  	int value =3D key->pressed;
> =20
> +	if (key->keycode >=3D KEY_MAX) {
> +		pr_warn("unhandled keycode 0x%x\n", key->keycode);
> +		return;
> +	}
> +
>  	if (test_bit(key->keycode, info->ptr->keybit)) {
>  		dev =3D info->ptr;
>  	} else if (test_bit(key->keycode, info->kbd->keybit)) {

[Severity: High]
Can a backend bypass this bounds check by modifying key->keycode in the
shared ring page between the KEY_MAX check and the subsequent test_bit() and
input_event() calls?

In xenkbd_connect_backend(), info->page is granted with read-write foreign
access to the backend domain:

	ret =3D gnttab_grant_foreign_access(dev->otherend_id,
	                                  virt_to_gfn(info->page), 0);

And input_handler() -> xenkbd_handle_event() -> xenkbd_handle_key_event()
passes a pointer directly into that shared ring page:

	for (cons =3D page->in_cons; cons !=3D prod; cons++)
		xenkbd_handle_event(info, &XENKBD_IN_RING_REF(page, cons));

Because key->keycode is not read once into a local variable with READ_ONCE()
before validating it against KEY_MAX, the subsequent test_bit() calls on
info->ptr->keybit, info->kbd->keybit, and info->kbd->key (as well as
input_event()) can re-read key->keycode from shared memory after a
concurrent backend write and still read past the bitmaps.

Should key->keycode be snapshotted into a local variable via READ_ONCE()
before performing the check and bitmap lookups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106014957.4130=
059-1-guozh23@xiaopeng.com?part=3D1
