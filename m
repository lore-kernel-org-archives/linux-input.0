From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] USB: driver for CM109 chipset
Date: Fri, 13 Jul 2007 00:38:08 +0200
Message-ID: <20070712223808.GD8858@suse.cz>
References: <467FC7E5.7050901@db.org> <d120d5000706250729s3f0e8325n8e4eb9f5982d858c@mail.gmail.com> <20070702153707.GA27958@suse.cz> <d120d5000707120747m264d6b87x670bd478103e804c@mail.gmail.com> <20070712152532.GB9459@suse.cz> <d120d5000707120922m3c821ed8ia827dab20ad599f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000707120922m3c821ed8ia827dab20ad599f5@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thu, Jul 12, 2007 at 12:22:10PM -0400, Dmitry Torokhov wrote:

> >> Hmm, they use KEY_0 through KEY_9 now.
> >
> >Which results in the phone sending '=E9+=EC=B9=E8=F8=BE=FD=E1=ED' inst=
ead of=20
> >'0123456789'
> >on a Czech keyboard, which is definitely not what's intended. Similarl=
y
> >for many other European keyboards.
> >
>=20
> Hmm, I uttely confused. Why when atkbd emits KEY_0 it you get 0 in the
> shell (don't you?) but different result with phone keypad?

No, on a Czech keyboard you don't. You press KEY_0, you get '=E9'. The
French layout gives sililar results. (For '0' you need to press
KEY_SHIFT KEY_0.)

> >I'll have to figure out where does KEY_103RD come from. I believe it w=
as
> >defined as a key similar to KEY_102ND on specific national keyboards.
> >Brazil springs to mind, but I might be completely wrong. If it's not i=
n
> >use today, we might as well kill it and reuse the code.
>=20
> You had it in the beginning but it was removed around 2.6.2 so 84 is
> free at the moment.

OK then.

> >I don't think that it'd be a huge problem to expand KEY_MAX. I'm not
> >entirely convinced we want to have a different event code for every
> >different key numbered '5'.
>=20
> But they are different as in people expect different actions when they
> press 5 on the keyboard, keypad, remote control and phone, don't they?

Maybe yes. If they had a input device from hell combining all this
functionality into one, they'd likely still want to differentiate
between the keys.

> Well, maybe not... I can argue both ways I guess... It's more like
> people may not want input from certain devices be used by certain
> programs (like they don't like RC cause numbers to be printed in the
> shell).=20

But people like the fact that the 'voip' phone devices type regular keys
into the voip client programs, because that's what the programs expect,
the keys typed on a regular keyboard ...

You can't win in all cases.

> So far they used grabbing on the devices but I don't think
> this is sustainable in the long run.

They likely want per-device keymaps. This would also allow to have two
keyboards, with different language layouts, connected at the same time.
I know a number of people asked how to do that in the past.

--=20
Vojtech Pavlik
Director SuSE Labs
