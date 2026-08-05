Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B95279DC3
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924648; cv=none; b=YQskVz53F5OO1l0uJYgO7jkz9iQh45N655Gk9Sq7IOt92Iwa/188xL+UpZ02vNa/wMamSyufuQQKwsWGEIj5iEQ2rcV04Vr8tNFMETsuOFtVIdbUpnME71JWVCjOCJRugI2NIzIvN6uUnSr8UDaa+BshWoKe9FLc5H0XqA+ehzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924648; c=relaxed/simple;
	bh=Q3bufG+ATPBWuQ9+bVsEm1I3tyIeQoiagKoomxe758Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J/Fw6LaxNgM5ol4jvjjx+Bzz8eSTDbsptBto6KFIQx9MlDrgtLuC1V1xdBPmhVXgJ+57XgIGp2q8TyWL++GaZ0X6qGHOi19yAyhxjaG5PO/Jlne0fn5VVXuX6DgbbEQIUlgJgf+l9WuTJs0o8VpbIauTkTBKw1cw69VoIm9V7jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQAwKNCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQAwKNCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D225D1F000E9;
	Wed,  5 Aug 2026 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924647;
	bh=S0645beApcwe8JUaChT35V5xaAuwiAmEMvxVs/r3usY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iQAwKNCzh/TxJxMti4dNmFDbmotl0CIkjvP7viBEruTO5FPuvoOvaBGdeXBAkz4uc
	 k3bO6CGsiyLccpcL19+dt03C47loUvS0vnGnKwslI3JKLcbvNN1VklAfWr6aAN3AvJ
	 50kX2a+6Jg1Kg84YBzdp+wnL3twfUqR36HlVrkWyFj2PkmTpbUtOsESHC5rhuEy4nQ
	 Rt/Fe9jz9Wp7Y2Z4G7j+ICESiSVk8tp4w+8jH3uRE1KPUy8VVU5Q/SOVZ76o/dFCvf
	 tD3aofE6at3rJEPzS0r+QQK9IZm+9vpqBKVZM5h2quTfjhX25t9tLRynEAx9pBdKaS
	 5aD5EZ9ehUavw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] Input: xpad - add out-of-bounds checks for
 xpadone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin@kroah.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260805-xpadone_length_checks-v2-1-f3e925e0280b@kroah.com>
References: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
 <20260805-xpadone_length_checks-v2-1-f3e925e0280b@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 10:10:45 +0000
Message-Id: <20260805101046.D225D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The xpadone_process_packet function processes GIP_CMD_ANNOUNCE pac=
kets by directly calling xpad_start_input() from within the atomic xpad_irq=
_in URB completion handler, causing a kernel panic due to blocking operatio=
ns.
--

--- Patch [1]: [PATCH v2 1/3] Input: xpad - add out-of-bounds checks for xp=
adone ---
commit d812a96c06a9e629fcf6e5c81511be2d91b754b4
Author: Griffin Kroah-Hartman <griffin@kroah.com>

Input: xpad - add out-of-bounds checks for xpadone
   =20
This commit adds size checks for the "len" variable in xpadone_process_pack=
et().
It prevents out-of-bounds accesses to the "data" buffer by ensuring the pac=
ket
length is sufficient for various commands.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..9ce792503b3a4 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -1079,9 +1087,13 @@ static void xpadone_process_packet(struct usb_xpad=
 *xpad, u16 cmd, unsigned char
>  					 error);
>  		}

[Severity: High]
This is a pre-existing issue, but does calling xpad_start_input() here cause
a deadlock or scheduling while atomic bug?

In the preceding GIP_CMD_ANNOUNCE block (shown partially in the context abo=
ve),
xpad_start_input() is called from xpadone_process_packet():

drivers/input/joystick/xpad.c:xpadone_process_packet() {
    ...
    } else if (data[0] =3D=3D GIP_CMD_ANNOUNCE) {
        ...
        error =3D xpad_start_input(xpad);
    ...
}

Since xpadone_process_packet() is called from the atomic URB completion han=
dler
(xpad_irq_in), wouldn't this execution context be atomic?

Looking at xpad_start_input(), it uses GFP_KERNEL and can call usb_kill_urb=
()
on xpad->irq_in if xpad_start_xbox_one() fails:

drivers/input/joystick/xpad.c:xpad_start_input() {
    if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
        return -EIO;

    if (xpad->xtype =3D=3D XTYPE_XBOXONE) {
        error =3D xpad_start_xbox_one(xpad);
        if (error) {
            usb_kill_urb(xpad->irq_in);
            return error;
        }
    }
    ...
}

Could the GFP_KERNEL allocation cause scheduling while atomic? Also, if an =
error
occurs, wouldn't usb_kill_urb(xpad->irq_in) wait on the very URB handler th=
at is
currently executing, leading to a deadlock?

>  	} else if (data[0] =3D=3D GIP_CMD_INPUT) { /* The main valid packet typ=
e for inputs */
> +		if (len < 18)
> +			return;
>  		/* menu/view buttons */
>  		input_report_key(dev, BTN_START,  data[4] & BIT(2));
>  		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-xpadone_le=
ngth_checks-v2-0-f3e925e0280b@kroah.com?part=3D1
