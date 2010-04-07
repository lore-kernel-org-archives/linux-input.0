From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 00/15] ir-core: Several improvements to allow adding
 LIRC and decoder plugins
Date: Wed, 7 Apr 2010 11:32:05 +0200
Message-ID: <20100407093205.GB3029@hardeman.nu>
References: <20100401145632.5631756f@pedra>
 <t2z9e4733911004011844pd155bbe8g13e4cbcc1a5bf1f6@mail.gmail.com>
 <20100402102011.GA6947@hardeman.nu>
 <p2ube3a4a1004051349y11e3004bk1c71e3ab38d3f669@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:52589 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab0DGJcJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 05:32:09 -0400
Content-Disposition: inline
In-Reply-To: <p2ube3a4a1004051349y11e3004bk1c71e3ab38d3f669@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-input@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Mon, Apr 05, 2010 at 04:49:10PM -0400, Jarod Wilson wrote:
> On Fri, Apr 2, 2010 at 6:20 AM, David H=E4rdeman <david@hardeman.nu> =
wrote:
> > Porting the msmce driver to rc-core will be high on my list of
> > priorities once I've done some more changes to the API.
>=20
> Very cool. Though note that the latest lirc_mceusb is quite heavily
> modified from what Jon had initially ported, and I still have a few
> outstanding enhancements to make, such as auto-detecting xmit mask to
> eliminate the crude inverted mask list and support for the mce IR
> keyboard/mouse, though that'll probably be trivial once RC5 and RC6
> in-kernel decoders are in place. I'd intended to start with porting
> the imon driver I'm working on over to this new infra (onboard
> hardware decoder, should be rather easy to port), and then hop over t=
o
> the mceusb driver, but if you beat me to it, I've got no problem with
> you doing it instead. :)

I'd be happy with you doing it, you seem to know the hardware better=20
than me. The mceusb driver I'm using right now with ir-core is based on=
=20
Jon's driver which is in turn based on a version of lirc_mceusb which i=
s=20
quite old by now. My version of the driver is basically just random bit=
s=20
and pieces thrown together, enough to get pulse/space durations flowing=
=20
through ir-core so that I can test the decoders, but not much more - so=
=20
it's not something I'd even consider useful as a starting point :)

Note however that you won't be able to actually port the mceusb driver=20
over until ir-core is taught to use durations (first version of the=20
patch is at [1], second version still brewing but I still need to=20
convince Mauro though).

[1] http://www.spinics.net/lists/linux-input/msg07859.html

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
