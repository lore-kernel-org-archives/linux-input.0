From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Mon, 18 Nov 2013 00:53:25 +0100
Message-ID: <8249378.0C4gn7PafG@sven-desktop>
References: <1384021557-24106-1-git-send-email-sven@narfation.org> <20131117232559.d2791ac2c278f56630aa41a7@studenti.unina.it> <5434362.OvDlhOjSJd@sven-edge>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7333550.gu8kLjU0n9"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42113 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3KQXx2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 18:53:28 -0500
In-Reply-To: <5434362.OvDlhOjSJd@sven-edge>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


--nextPart7333550.gu8kLjU0n9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 18 November 2013 00:12:14 Sven Eckelmann wrote:
> > Also please make sure that setting the rumble does not change the LEDs
> > status if there is any set: HID output report 1 is used for both LEDs
> > and rumble. In the bluez plugin[1] I plan on setting LEDs from userspace
> > to match the joystick number, just as the PS3 does, it would be strange
> > for the user if a rumble event would reset the LEDs status.
> 
> I never used the LEDs and therefore cannot say anything about it (I don't
> have a specification for the used command format). Maybe I can try to play
> with them next week.
> 
> But you're patch has some comments in set_leds. Do I correctly interpret the
> byte 10 in leds_report as "only make changes to following LEDs"? So setting
> it to 1 would make the command not change the LEDs at all?

Ok, just tried it and it seems this byte is really for the LEDs. But 
unfortunately, it is enabling/disabling the LEDs completely and not the 
configuration.

And sending less bytes just lets everything fail.

Kind regards,
	Sven
--nextPart7333550.gu8kLjU0n9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSiVb2AAoJEF2HCgfBJntGHlsP/21omIfnj1hDsBaCbqtSMiPy
ayoDoSydQiBlorH+2C3XvK+IBAYDFPb6kckZdWXPk4fBIKNrP0iS4GMaIEWSAGAu
UC4+sOdtCeej1JnTu4pXK59yG7Wa5UBUBvVr62T7eEw1UF7M/l29CbmwC3TC/noB
e12bQIm/eC+xIhWSOwRBKTNetLMcULfVigiIeH50BPkd4T+6BMyw0W/T1GwpFJTX
5tmfOB/tJokdDWaJbAD7WZPA3AE6WT94tMCKODOU4T/bZ7eoNyrdNUtVqX7lWj8P
TYlUHdGsMh7dLgF6jvA7fUZataPXqH8sQusZvWAnWE2RPE8yv9CZ/iRNKfSuFx0T
Ujqo+FCvahwuE7FzSU54m2A288zZIz7bAq3820Hp6ngaxdrSwM9/GEV/95rLw9c/
zLOSnyG8P7/IKoGsC2IS/3J8oJ/DT76rVe43FUVG1FEtpm8zmLhlT/Jj+DBn/fg7
W5pC0xV0Y7xSHRcYLjK6Brf1zzDiGnQWUq53MvmjFO8UxMNyRi/3pH+CcKKrGObe
vnm5z8694Xd5Qak3tEdLX81dvt09RmMPzY/vYqFGOAY7C530qZ5gYCpBCBm11vkf
FmUtwk4YTAiNPg74Nabcgrlth5J+OWvGS55nx94KD8MtL3B5RHEg3AuQDXAEnj9h
3ROcYWdHAGUhMB57LCOv
=pZ2P
-----END PGP SIGNATURE-----

--nextPart7333550.gu8kLjU0n9--

