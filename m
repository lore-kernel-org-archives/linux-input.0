Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3A30F55F
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020224; cv=none; b=gShcLXEsHUcIMptA+simgWLOeHU+rzxMC/23dhxaGGAJGaSVbiqo6pKc7AkBYxsFOgmnKCDbD19AjG8ZuYCjj0qXzpIZ9uN6sMtqHWLuSvyfNRd36e6u8HJR3Ax5/Oi1XdQtj4PY9gnLkEx5e5b1gS/mizK3hZNRTMHsCs+Dg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020224; c=relaxed/simple;
	bh=5a2HJnWV4/zZ5WlvbGGTsDelk4GV7U/dzXIVzHWsChU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ojfqsvEKoafdDoI8iur0fwyGoSd3GcYC4uEidHELPRmRgRDk5vYpwGyGosbA20lH3TmfA8v+jnp67bSA+m1lHTwqE3kqQK9LXxytaYaGqYZe+qpMuFhUX6oQRrwFhTw9mhXZ6O63sprb+stgZWMcdupjJIKbYEOaEkL4jcNiS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWmyAYCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWmyAYCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54081F000E9;
	Fri, 29 May 2026 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780020223;
	bh=PZfDUjReAQw+s62tqigcnxRzUmR59c5IvjPOgP8Hm9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWmyAYCjWU34maqBLQcKSiVAHpjCI0SS72FV+nXo43qkI6Gl86Ql6RhkqCgvxDw6E
	 D/IbEqnkAT0z6KBVDLeyIweusGeF93A91irROstOUJ6iwzcTTUCYQf8TJQ5AMzR95m
	 tXGiCsRNkO53Ji6If+pV4p8JWMdz4dJGdijDgqc0JNs2q0kSZwv3cRN4unrqF/eKlc
	 KsSf+SQ/jZf8dlLrbYmdBmEn/bO3dueTFQ4yQv2OWUyThitu0IHRY1hZWtM/cn3hxd
	 WuhnrBlHJwR1PqolWTHQjAyaRg0/1BM3S1tRCsZnOfsw6nK+VILKA1CPe7wcML0rqM
	 lQmigfYuCW7Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: tca8418_keypad - enable overflow mode per
 datasheet (SCPS215G)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhian Liang" <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260529013900.43854-1-liangzhan5dev@gmail.com>
References: <20260529013900.43854-1-liangzhan5dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 02:03:42 +0000
Message-Id: <20260529020342.D54081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver does not sufficiently validate the hardware keycode, al=
lowing a malformed I2C read to cause an out-of-bounds array access.
- [High] The keypad FIFO read loop lacks an upper iteration bound, risking =
an infinite loop if the I2C bus fails silently.
--

commit c17e8cb1a67b8fa0dfa772dc4d63c35917e63ccb
Author: Zhian Liang <liangzhan5dev@gmail.com>

Input: tca8418_keypad - enable overflow mode per datasheet (SCPS215G)

This commit sets the OVR_FLOW_M bit alongside OVR_FLOW_IEN in the
configuration register. This ensures the overflow interrupt is properly
generated, preventing FIFO overflow events from being silently lost.

> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyb=
oard/tca8418_keypad.c
> index 68c0afafee7bf..b124e576feca4 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -254,7 +254,7 @@ static int tca8418_configure(struct tca8418_keypad *k=
eypad_data,
>  		return error;
> =20
>  	error =3D tca8418_write_byte(keypad_data, REG_CFG,
> -				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_KE_IEN);
> +				CFG_INT_CFG | CFG_OVR_FLOW_IEN | CFG_OVR_FLOW_M | CFG_KE_IEN);
> =20
>  	return error;
>  }

While reviewing this, I noticed a couple of potential issues in the same
file.

drivers/input/keyboard/tca8418_keypad.c:tca8418_read_keypad() {
	[ ... ]
	do {
		error =3D tca8418_read_byte(keypad_data, REG_KEY_EVENT_A, &reg);
		if (error < 0) {
			dev_err(&keypad_data->client->dev,
				"unable to read REG_KEY_EVENT_A\n");
			break;
		}

		/* Assume that key code 0 signifies empty FIFO */
		if (reg <=3D 0)
			break;
	[ ... ]

[Severity: High]
This is a pre-existing issue, but does this loop risk running infinitely if
the I2C bus fails silently?

If the I2C bus gets stuck high, it may return 0xFF. Because reg is an
unsigned u8, the condition reg <=3D 0 evaluates to false for 0xFF (255).

The loop would never terminate, stalling the threaded IRQ handler
indefinitely.

	[ ... ]
		row =3D code / TCA8418_MAX_COLS;
		col =3D code % TCA8418_MAX_COLS;

		row =3D (col) ? row : row - 1;
		col =3D (col) ? col - 1 : TCA8418_MAX_COLS - 1;

		code =3D MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
		input_event(input, EV_MSC, MSC_SCAN, code);
		input_report_key(input, keymap[code], state);
	[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but does the driver sufficiently
validate the hardware keycode to prevent an out-of-bounds array access?

If the I2C bus returns 0xFF, code is calculated as 127. The index
calculations yield row =3D 12 and col =3D 6, resulting in code =3D 198.

Since the keymap array allocated for this device has a maximum of 128
elements, this results in an out-of-bounds memory read on keymap[198].

Similarly, a malformed value of 0x80 results in row =3D -1, col =3D 9, and
code =3D 249, causing the same out-of-bounds access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529013900.4385=
4-1-liangzhan5dev@gmail.com?part=3D1
