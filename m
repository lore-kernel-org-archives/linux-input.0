From: Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.28-rc4-mmotm1110 shift-lock oddness
Date: Mon, 17 Nov 2008 21:36:11 -0500
Message-ID: <18584.1226975771@turing-police.cc.vt.edu>
References: <5397.1226959015@turing-police.cc.vt.edu> <20081117162350.82b2806b.akpm@linux-foundation.org>
            <alpine.LRH.1.10.0811180125150.3104@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1226975771_3596P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752770AbYKRChH@vger.kernel.org>
In-Reply-To: Your message of "Tue, 18 Nov 2008 01:26:51 +0100."
             <alpine.LRH.1.10.0811180125150.3104@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
List-Id: linux-input@vger.kernel.org

--==_Exmh_1226975771_3596P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <18571.1226975763.1@turing-police.cc.vt.edu>

On Tue, 18 Nov 2008 01:26:51 +0100, Jiri Kosina said:

> First, we'd need a little bit more information about the hardware in 
> question, I guess.

Dell Latitude D820 laptop, with a USB-connected Microsoft Natural keyboard. I
don't think it's the USB subsystem going *completely* bonkers, as the
USB-connected trackball mouse functions just fine when this happens...

> What laptop is that, please? Is the keyboard PS/2-connected or 
> USB-connected? Could you obtain evtest output from the buggy cases please?

Hmm.. Got a pointer to a usable copy? The best I could find googling for
'linux evtest' was:

https://svn.openwrt.org/openwrt/packages/utils/event_test/src/evtest.c

which wants a /dev/inputN - all I have is /dev/input/ and entries under that
for the laptop's onboard mousepad and the trackball mouse, no keyboard entry.

Hmm part two:

% zgrep EVDEV /proc/config.gz 
# CONFIG_INPUT_EVDEV is not set

Should I be looking at rebuilding the kernel with this =m?



--==_Exmh_1226975771_3596P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFJIiobcC3lWbTT17ARAoF3AKDWEWC4gQ3o6lAtJWZjtlgf/H7PoACeO9ii
+jOKsVSxWbSp8Bqc+FqissQ=
=Ctug
-----END PGP SIGNATURE-----

--==_Exmh_1226975771_3596P--
