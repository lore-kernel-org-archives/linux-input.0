From: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Wed, 25 Apr 2007 16:06:51 -0400
Message-ID: <20070425200650.GE4831@aehallh.com>
References: <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz> <1176330232.27324.7.camel@johannes.berg> <200704122125.l3CLP9aQ005277@wezen.cs.pdx.edu> <1176446418.7052.54.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <1176446418.7052.54.camel@johannes.berg>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Barton C Massey <bart@cs.pdx.edu>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>
List-Id: linux-input@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 13, 2007 at 08:40:18AM +0200, Johannes Berg wrote:
> On Thu, 2007-04-12 at 14:25 -0700, Barton C Massey wrote:
> 
> > > I unfortunately don't have the hardware in question to test with. This X 
> > > configuration is of course perfectly valid.
> 
> I copied it straight out of the manpage so I'd hope so :>
> 
> > Give me a day or so to check all this out.  I don't think
> > looking at the X behavior is too useful: too many place that
> > the direction can be swapped.  Instead, look which way the
> > bits coming directly out of evdev point.
> 
> I can do that (early next week), but I don't have any other devices to
> test with. Can provide a dump.
> 
> > IIRC I set things
> > up so that positive X was the same as on other evdev
> > devices.  Is the supplied X config swapping the X axis with
> > this line?
> > 
> >   > >         Option      "evBits"            "+1-2"
> 
> No idea! I just copied it out of the manpage from evdev(4)

As the xf86-input-evdev maintainer, I can tell you quite firmly that the
answer is a solid no.

However I can also tell you that I may infact have the behavior
backwards in the driver. :)

Yell, scream, and shout if that's the case.

Zephaniah E. Hull.


-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

If I have trouble installing Linux, something is wrong. Very wrong.
  -- Linus Torvalds on l-k.

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGL7TaRFMAi+ZaeAERAvrAAJ9SbwKUwtHslgyE2aUESD1diHt4yQCg3p1i
XqAtCSNKgyqhk2OzuppMbOQ=
=F7/i
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
