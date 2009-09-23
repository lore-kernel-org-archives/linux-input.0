From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Current git: no keyboard when booting in verbose mode
Date: Wed, 23 Sep 2009 09:44:27 -0700
Message-ID: <20090923164426.GB13435@core.coreip.homeip.net>
References: <6041d2000909221754n2ee1982xe08f938a35358c00@mail.gmail.com> <alpine.LRH.2.00.0909231108100.27145@twin.jikos.cz> <6041d2000909230516g60bad387r3613927ae0d8f5a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:51073 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZIWQob (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 12:44:31 -0400
Content-Disposition: inline
In-Reply-To: <6041d2000909230516g60bad387r3613927ae0d8f5a7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Sep 23, 2009 at 08:16:02AM -0400, Marc Dionne wrote:
> On Wed, Sep 23, 2009 at 5:09 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> >
> > [ adding some CCs ]
> >
> > On Tue, 22 Sep 2009, Marc Dionne wrote:
> >
> >> I'm having issues with the current kernel in git, and wondering if=
 this
> >> will ring a bell for anyone. The main symptom is that on most boot=
s the
> >> keyboard is not detected - the system gets to the console login pr=
ompt
> >> but input is not recognized. =A0Sometimes (rarely) the keyboard wi=
ll be ok
> >> at the console, but the keyboard and mouse are non functional once=
 in X.
> >
> > Are both keyboard and mouse in question PS/2?
>=20
> No - keyboard is PS/2 but the mouse is USB.
>=20
> >> - On a failed boot with no keyboard, this line is missing from dme=
sg:
> >> =A0 =A0 AT Translated Set 2 keyboard as /devices/platform/i8042/se=
rio0/input/input2
> >
> > Could you please provide output from kernel booted with 'i8042.debu=
g' from
> > the failing case?
>=20
> Attached are the dmesg output for a successful boot (with "quiet") an=
d
> a failed one.  I see that the i8042.debug output is quite different
> for the 2 cases.
>=20

Hmm, nothing obvious jumps at me... Just keyboard not responding at all
in the bad case. Any chance of bisecting? Maybe check before first inpu=
t
merge and after?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
