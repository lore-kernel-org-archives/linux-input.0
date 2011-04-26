From: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org
Subject: Re: Wonkiness with keyboard adapter - not sure if it's in USB or input systems
Date: Tue, 26 Apr 2011 15:12:16 -0400
Message-ID: <23191.1303845136@localhost>
References: <Pine.LNX.4.44L0.1104261453300.2035-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1303845136_5095P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Your message of "Tue, 26 Apr 2011 14:55:57 EDT."
             <Pine.LNX.4.44L0.1104261453300.2035-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--==_Exmh_1303845136_5095P
Content-Type: text/plain; charset=us-ascii

On Tue, 26 Apr 2011 14:55:57 EDT, Alan Stern said:
> On Tue, 26 Apr 2011 Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org wrote:

> > Bus 001 Device 006: ID 0e8f:0020 GreenAsia Inc. USB to PS/2 Adapter

> Have you tried testing the adapter by plugging it in after the system 
> is running?

It works fine at the Grub screen.

It *doesn't* work for the kernel when it initially starts up, even though a few
seconds ago the hardware worked just fine.

It *does* work after I've unplugged/replugged it - I've tested both the USB
side and the PS2 side, in either case it starts working.

I'm not sure what difference "plug it in after it's running" and "unplug/
replug" will have. I suppose I could test that, but I'm suspecting the results
will be "it works fine after plugging it in once the kernel is up".


--==_Exmh_1303845136_5095P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNtxkQcC3lWbTT17ARAhOxAKCT3S9UY9IRkLRocak5M5Y16ZwvOACgrvij
I9nkCLDCmulzJDMafWyQe7k=
=eOQ1
-----END PGP SIGNATURE-----

--==_Exmh_1303845136_5095P--

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
