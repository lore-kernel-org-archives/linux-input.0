Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794322930;
	b=uz6ZetfCuAReQEUy9kVuhOAEu2G5J2ADGbMY3RzjVXhEyZYYpSsO8nqLwkEqVDDp0tac
	 52oVtwyWlH8vkaMdvP0bf5nwFgOgrX2DcO9s6CTzFLaVn292dssd6sWUL5tULuGLZOxfa
	 JXFmVoYdKHwzN4pK51rDwqfbVzmYjIgnoPAeoHpPalQAAYuNbMUqWeQveI1IleSqX9egm
	 kjdT4xoUDTLO4/FCABEMVI4IWnlE5UMskQRsNGEsDMRo+zwZsZiQGp7D6JTL84MzMKkdw
	 0UwlsVSkCpBCeWHRRxlvgLNzmkIwftsJi7inuVxYWpuN0P2Fes2MpBrar2nl1qTOdsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322930;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:
	 MIME-Version:User-Agent:X-ZohoMailClient;
	bh=YGXeCKEd7KljuLVnW/YTZx2YwnHQN1kvggrL0pA/UuU=;
	b=lAPEj9OftslOgCujeFlQeGtPF5X7VABfqDnoydEe90ub2Nuuo/GkR8oSbTL7pK3hI7P5
	 ftqk1aC9G/fl9ja9/D2aCtthCegU/I5Ejo1k7xbsTj9Og9HZhrOI9+fUhycwN0ORrm5/V
	 5ptCEQbwAjrTaIfd9tcEVS5xVCmUNYqPU6/iNUNDn1980ADgCxpLW6kYmUdHD0SURDEgR
	 Vqgg5ogE3tgDhaLaSqOyecgg9SB2aLTvaCir8LCo2Rc/HQcNc+W6hdG1r54mLhGMdmgxl
	 7hOCB8xo35x1P4/86o/i0XVdAR2FFe7vF11NzxtVUGJPQbmJ4V+BCswqOOo9QX/i+Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=K7bd9KQ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CC606A325;
	Tue, 10 Nov 2026 15:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E9CC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=K7bd9KQ+
ARC-Seal: i=1; a=rsa-sha256; t=1794322904; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mc3e6j1dqQjSm4IDC4CdjbyZSyPjNEIBTt58c8v/VciLRC0cw49W0VWlIh8xsPOPKYWPNOjTr4fHnaWiIKBrYetpAh6IU1b2GFyFHPDcXVhhz4o2wyLQCOiHew87AJYtf98+e0BeamEF4KJApU1R6YXPbzGUSwR61I5zyjEX+Gk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794322904; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YGXeCKEd7KljuLVnW/YTZx2YwnHQN1kvggrL0pA/UuU=; 
	b=Y+ckj40YkHnclBtz5O8AH/n/Tjcwj3NRyUvwAIhT5Nxye1Mc7y8MYkmjGADE3os85pGYcyuMiLIC00o9HUcKdmzfGBBJPEjSpspT5xretUme7/A9G/ONoHpyI+QqBv6inPfftybGUz2lknf2zPcbxGHzau34TS4wQh184OZpLYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=K7bd9KQ+8YrVzfIWGdzn/Y+JtHcPM5HCdqxarEewcGdXgjB0ymjrt3FJfCraOUee2VygBJzyydD7Vv/rZzRQptiNe5MY0vtynnxtBfKdn1YtVctKmpZCy1H8iXg9o24j3F0vqEJFrW8MLnDBntmB6wVa//fKWKkNr32ooiwJhsi5KoDnK1V+H8q8UV5GKgE/dorqxUcROHE+s1Hg8PC4dBh5b06uHeowifKzQIzZf4prITla1e6JsOHOyqMwbD7eObNzUv4pq3acgtQoDsJrHUBGXrn8yfzDlwdLGn1U7qhYYUKYVXPZRzqr1YHRBNKJhtS6WUEhjyrccuS+Sw+z6g==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=YGXeCKEd7KljuLVnW/YTZx2YwnHQN1kvggrL0pA/UuU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794322901580143.9951405414024;
	Tue, 10 Nov 2026 07:01:41 -0800 (PST)
Message-ID: <71ecff766a91670d509b1286efd995b71efc21f4.camel@rong.moe>
Subject: Re: [PATCH RFC 0/2] Keyboard lighting for the Lenovo Legion Pro 7
 Gen 10
From: Rong Zhang <i@rong.moe>
To: ciro.pedrini@gmail.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, Ike Panhc
 <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt
	 <aer@tuxedocomputers.com>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:56:24 +0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Evolution 3.62.1-3 
X-ZohoMailClient: External

Hi Ciro,

Thanks for working on this.

On Mon, 2026-11-09 at 22:50 +0000, Ciro Pedrini via B4 Relay wrote:
> The keyboard and chassis lighting of the Lenovo Legion Pro 7 16IAX10H
> (2025) has no Linux support today: on my unit nothing ever lit, because
> the keyboard controller's brightness was 0 from the factory and nothing o=
n
> Linux exposes it. This series makes it a regular keyboard backlight.
>=20
> The lighting is two USB HID devices:
>=20
> - 048d:c197, the ITE 8258 keyboard controller: the built-in keyboard,
>   plus a vendor protocol on feature report 0x07 (960 bytes) with a
>   hardware brightness (0..9, stored), the controller's own effects
>   (stored profiles), and a switch that hands the LEDs to the LampArray
>   below (also stored). Fn+Up/Down/Space are handled by the controller,
>   which reports the result on a vendor input report.

IMHO, the support for 048d:c197 is the only thing you should include in
the series.
>=20
> - 048d:c193 interface 1, a standard HID LampArray: 319 lamps (keys, front
>   strip, rear vents, lid logo) with positions and key usages. It shows
>   nothing until the controller hands the LEDs over, its colours are scale=
d
>   by the controller's brightness, and after resume from S3 the kernel
>   resets it and it comes back in autonomous mode.

IOW, do not add a device-specific driver when it could be handled by a
generic one, i.e., the ongoing hid-lamparray series. While you can
rewrite your series to make it work with hid-lamparray, it would be much
easier to review and accept your series when it has no dependence on a
ongoing work.

Let's take it step by step, and submit a driver for 048d:c197 first. As
far as I understood, the driver should be able to handle "hardware
brightness (0..9, stored), the controller's own effects (stored
profiles)," and "Fn+Up/Down/Space" by its own. (Please correct me if I
misunderstood your words.)

I am also working on a independent hid-lamparray implementation that is
far more generic than=C2=A0Aaron and Werner's series. It still needs some
polishing and depends on another series of mime [1]. I've mentioned some
details of my implementation there.

[1]: https://msgid.link/20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe

>=20
> Patch 1 makes ideapad-laptop ignore the EC's copies of those three
> hotkeys, which reach userspace as KEY_UNKNOWN today.
>=20
> Patch 2 adds hid-lenovo-legion, binding both devices: one multicolor LED
> (<name>:rgb:kbd_backlight) whose brightness is the controller's, with
> brightness_hw_changed from the hotkeys, and whose colour goes to every
> lamp. lighting_mode selects "firmware" (default: the controller's effects=
;
> the driver leaves the LEDs alone, so a userspace tool can drive the
> LampArray over hidraw) or "color". Per-key control stays in userspace.
>=20
> This is an RFC because of its shape:
>=20

I am not going to review PATCH 2, unless your next revision no longer
adds a device-specific driver for 048d:c193.

>  one driver spanning two USB devices,
> paired by their USB bus.=C2=A0
>=20

But I did have a glance at PATCH 2, things could easily go wrong when you
invent your own mechanism to bind things. And it's not scalable anyway.

Please use the component framework (not in your next revision, it should
only add support for 048d:c197).

> Is that acceptable, or would you rather have it
> differently, e.g. a vendor hook in the generic LampArray helper that Aaro=
n
> and Werner are working on ("HID: generic: add LampArray support", v7),
> which on this machine would register a kbd_backlight that does nothing
> visible? The two patches touch two subsystems; I'm happy to split them.
>=20
> Tested on the 16IAX10H (83F5, BIOS Q7CN77WW, Spanish ISO keyboard) with
> 7.2, as modules: brightness from sysfs and KDE, the hotkeys' OSD, colours
> on every zone, suspend/resume in both modes, a userspace LampArray client
> in "firmware" mode, unbinding back to hid-generic. The series is based on
> v7.4-rc2 and builds there with W=3D1.
>=20
> I worked out the protocol from the device itself (usbmon captures, the
> LampArray's attributes) and from analysing the vendor's Windows software
> for interoperability. The patches were prepared with Claude Code (Claude
> Opus 5.5), see the Assisted-by tags; I reviewed and tested them.
> checkpatch reports those tags (non-standard signature, no email address),
> and a MAINTAINERS hint for the new files that patch 2 already adds.
>=20
> To: Mark Pearson <mpearson-lenovo@squebb.ca>
> To: Derek J. Clark <derekjohn.clark@gmail.com>
> To: Rong Zhang <i@rong.moe>
> To: Ike Panhc <ikepanhc@gmail.com>
> To: Hans de Goede <hansg@kernel.org>
> To: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> To: Jiri Kosina <jikos@kernel.org>
> To: Benjamin Tissoires <bentiss@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-input@vger.kernel.org
>=20
> ---
> Ciro Pedrini (2):
>       platform/x86: ideapad-laptop: Ignore keyboard backlight hotkeys
>       HID: lenovo-legion: Add keyboard lighting driver for Legion Gen 10
>=20
>  .../testing/sysfs-class-led-driver-lenovo-legion   |  20 +
>  MAINTAINERS                                        |   2 +
>  drivers/hid/Kconfig                                |  13 +
>  drivers/hid/Makefile                               |   1 +
>  drivers/hid/hid-ids.h                              |   2 +
>  drivers/hid/hid-lenovo-legion.c                    | 662 +++++++++++++++=
++++++
>  drivers/platform/x86/lenovo/ideapad-laptop.c       |   4 +
>  7 files changed, 704 insertions(+)
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261109-legion-lighting-rfc-dc32165df52d
>=20
> Best regards,
