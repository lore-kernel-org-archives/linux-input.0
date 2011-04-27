From: Valdis.Kletnieks@vt.edu
Subject: Re: Wonkiness with keyboard adapter - not sure if it's in USB or input systems
Date: Tue, 26 Apr 2011 20:17:51 -0400
Message-ID: <6382.1303863471@localhost>
References: <Pine.LNX.4.44L0.1104261453300.2035-100000@iolanthe.rowland.org> <23191.1303845136@localhost>
            <alpine.LNX.2.00.1104262319240.12035@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1303863471_6090P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:33659 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1D0ASI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Apr 2011 20:18:08 -0400
In-Reply-To: Your message of "Tue, 26 Apr 2011 23:29:42 +0200."
             <alpine.LNX.2.00.1104262319240.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

--==_Exmh_1303863471_6090P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Apr 2011 23:29:42 +0200, Jiri Kosina said:
> On Tue, 26 Apr 2011, Valdis.Kletnieks@vt.edu wrote:
>
> > > > Bus 001 Device 006: ID 0e8f:0020 GreenAsia Inc. USB to PS/2 Adapter
> >
> > > Have you tried testing the adapter by plugging it in after the system
> > > is running?
> >
> > It works fine at the Grub screen.
> >
> > It *doesn't* work for the kernel when it initially starts up, even though a few
> > seconds ago the hardware worked just fine.
> >
> > It *does* work after I've unplugged/replugged it - I've tested both the USB
> > side and the PS2 side, in either case it starts working.

> It seems like the BIOS handover of the USB input device doesn't work
> properly.
>
> The way things usually work in such situations -- BIOS is able to
> understand USB input devices in a very basic mode (hidp) and translate the
> events into PS/2-looking events, so that things like grub (which don't
> understand USB HID) are able to see keyboard events -- BIOS presents those
> as PS/2 devices.
>
> Once kernel is booted, it takes over devices in this 'legacy' mode from
> BIOS, and initializes them properly as USB input devices.
>
> Seems like this process is broken on your system. Could you please try to
> disable legacy USB emulation in your BIOS, and see if the problem
> persists? (it will make USB keyboard unavailable in grub).

Possible datapoint - the USB handoff can't be *totally* broken on the laptop,
because it handled another Microsoft Natural keyboard with a USB on it just
fine, so it's something specific to the GreenAsia adapter.

I disabled legacy USB emulation, and as expected, the keyboard wasn't available
to grub.  It was *also* unavailable to the initrd until I did the 'disc/reconnect' thing,
at which point it started working.  (Sorry, don't have the dmesg from that
one, can get it tomorrow (Wed) morning if you want.  And any advice on
additional debugging I can turn on to help would be accepted too).



--==_Exmh_1303863471_6090P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNt2CvcC3lWbTT17ARAlcDAKDG6bNRFGWc+GC2owPq50oKnIYp1gCgiciP
C9+k9VSKRPB+RAA4ERQESU0=
=o0x6
-----END PGP SIGNATURE-----

--==_Exmh_1303863471_6090P--

