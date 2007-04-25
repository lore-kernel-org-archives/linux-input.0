From: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Enabling/disabling input events.
Date: Wed, 25 Apr 2007 13:24:54 -0400
Message-ID: <20070425172454.GD4831@aehallh.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6487841955927329432=="
Return-path: <devel-bounces@laptop.org>
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Mime-version: 1.0
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@ATREY.KARLIN.MFF.CUNI.CZ, devel@laptop.org
List-Id: linux-input@vger.kernel.org


--===============6487841955927329432==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The current trend is for events like power buttons and lid switches to
be handled through the input subsystem.

This leaves an odd hole for cases where you wish to set the hardware
behavior of these buttons, specificly on the OLPC we have several events
that signal through the input system, which are capable of waking the
system from suspend mode.  This is not always desirable, so the
hardware leaves us a way to disable the button/switch completely, but at
the moment there is no clean kernel interface for this.

This leaves the choices of adding a separate way to control things which
are delivered by the input system, which seems somewhat silly, or adding
support to the input system for enabling/disabling specific events from
an input device.

The latter seems more useful in the long run, but it leaves the question
of how to do it.

Between a few of us, we see a few possible ways to do it off the top of
our heads:

 - Adding controls somewhere off in /sys/class/input. (How do we handle
   notification of changes?)
 - Adding some ioctls to evdev. (Again, notification of changes?)
 - Writing events from userspace for these events, with odd values.
   (Ugly, easily confuses clients listening to those events who don't
   know what the odd values mean.)
 - Adding something like a EV_CTRL type, with CTRL_ENABLE_EVENT and
   CTRL_DISABLE_EVENT events, encoding the 16bit types and codes of the
   event we're enabling/disabling in the 32bit value. (How do we check
   the current value?  Doesn't fit the existing event model.)

All of these have ups and downs, and there are probably ways we have not
thought of.

So, our basic question is should this go through the input system, and
if so how should we go about implementing it?

Thank you.
Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<Upholder> Seen on the back of a T-Shirt: "I am a bomb technician.  If you see
           me running, try to keep up."

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGL47mRFMAi+ZaeAERAkbtAJ9xMJ17MgWxNZ6uCyZLyEGebCK7cwCcC0Eb
VX/QLmFH8hB2JEi/Y4PqceU=
=0rU9
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============6487841955927329432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Devel mailing list
Devel@laptop.org
http://mailman.laptop.org/mailman/listinfo/devel

--===============6487841955927329432==--
