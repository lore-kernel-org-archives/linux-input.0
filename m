From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] USB: driver for CM109 chipset
Date: Thu, 12 Jul 2007 17:25:32 +0200
Message-ID: <20070712152532.GB9459@suse.cz>
References: <467FC7E5.7050901@db.org> <d120d5000706250729s3f0e8325n8e4eb9f5982d858c@mail.gmail.com> <20070702153707.GA27958@suse.cz> <d120d5000707120747m264d6b87x670bd478103e804c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000707120747m264d6b87x670bd478103e804c@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thu, Jul 12, 2007 at 10:47:22AM -0400, Dmitry Torokhov wrote:
> On 7/2/07, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Mon, Jun 25, 2007 at 10:29:13AM -0400, Dmitry Torokhov wrote:
> >> Hi Alfred,
> >>
> >> On 6/25/07, Alfred E. Heggestad <aeh@db.org> wrote:
> >> >From: Alfred E. Heggestad <aeh@db.org>
> >> >
> >> >This driver adds support for USB VoIP phones using the CM109 chipse=
t,
> >> >such as the KIP-1000. Keypad is scanned and events are reported to
> >> >the input subsystem. The buzzer can be activated by sending SND_TON=
E
> >> >or SND_BELL to the input device.
> >> >The driver has been tested with linux 2.6.21.3 on i386 and AMD64,
> >> >and linux 2.6.21.1 on Broadcom BCM3302 (MIPS, OpenWRT Project)
> >> >The current patch applies cleanly and is tested on linux 2.6.22-rc4
> >> >More testing and code review is welcome..
> >> >
> >>
> >> Thank you for your patch. I have couple of comments:
> >>
> >> - "input_dev->cdev.dev =3D &intf->dev;" should be "input_dev->dev.pa=
rent
> >> =3D &intf->dev;"
> >> - do not access input->private directly; use input_set_drvdata() and
> >> input_get_drvdata() helpers.
> >> - error handling for input_register_device();
> >> - I guess we need KEY_POUNDSIGN because I don't like that business
> >> with key_shift + key_3 (I did not like it in yealink either...)
> >
> >Probably a KEY_KPPOUND. We should be sending the keypad keys on phones=
.
> >
>=20
> Hmm, they use KEY_0 through KEY_9 now.=20

Which results in the phone sending '=E9+=EC=B9=E8=F8=BE=FD=E1=ED' instead=
 of '0123456789'
on a Czech keyboard, which is definitely not what's intended. Similarly
for many other European keyboards.

> I wonder how userspace would do
> if we changed these to KEY_KP0..KEY_KP9.

I think the userspace is using X keysyms in this case anyway, so it
should just work.

> Do you think I could reuse 84 for KEY_KPPOUND? KEY_103RD wasn't that
> popular I think...

I'll have to figure out where does KEY_103RD come from. I believe it was
defined as a key similar to KEY_102ND on specific national keyboards.
Brazil springs to mind, but I might be completely wrong. If it's not in
use today, we might as well kill it and reuse the code.

> I also wonder if we should just expand KEY_MAX to 1023 and add all the
> telephony codes (and pretty much the rest of HUT) so we have unique
> events for different things...

I don't think that it'd be a huge problem to expand KEY_MAX. I'm not
entirely convinced we want to have a different event code for every
different key numbered '5'.

--=20
Vojtech Pavlik
Director SuSE Labs
