From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] USB: driver for CM109 chipset
Date: Sat, 21 Jul 2007 10:16:30 +0200
Message-ID: <20070721081630.GA28400@suse.cz>
References: <467FC7E5.7050901@db.org> <d120d5000706250729s3f0e8325n8e4eb9f5982d858c@mail.gmail.com> <20070702153707.GA27958@suse.cz> <d120d5000707120747m264d6b87x670bd478103e804c@mail.gmail.com> <20070712152532.GB9459@suse.cz> <d120d5000707120922m3c821ed8ia827dab20ad599f5@mail.gmail.com> <20070712223808.GD8858@suse.cz> <d120d5000707201214k7a036a5ckb86bd2a4d41c1a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000707201214k7a036a5ckb86bd2a4d41c1a32@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Fri, Jul 20, 2007 at 03:14:14PM -0400, Dmitry Torokhov wrote:
> On 7/12/07, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >On Thu, Jul 12, 2007 at 12:22:10PM -0400, Dmitry Torokhov wrote:
> >
> >> >> Hmm, they use KEY_0 through KEY_9 now.
> >> >
> >> >Which results in the phone sending '=E9+=EC=B9=E8=F8=BE=FD=E1=ED' i=
nstead of
> >> >'0123456789'
> >> >on a Czech keyboard, which is definitely not what's intended. Simil=
arly
> >> >for many other European keyboards.
> >> >
> >>
> >> Hmm, I uttely confused. Why when atkbd emits KEY_0 it you get 0 in t=
he
> >> shell (don't you?) but different result with phone keypad?
> >
> >No, on a Czech keyboard you don't. You press KEY_0, you get '=E9'. The
> >French layout gives sililar results. (For '0' you need to press
> >KEY_SHIFT KEY_0.)
>=20
> Oh, I completely forgot that there are keyboards that have numbers on
> upper register. I think I used such keymap on Yamaha MSX2 in high
> school... 20 years ago..?
>=20
> But the keypad only works wif you have NumLock on right?

Yes. But the remote doesn't have a NumLock LED or key, right? Then, if
X had per-device lockstate, there wouldn't be a problem. But I fear the
lockstate and shiftstate is completely shared, like on the console.

--=20
Vojtech Pavlik
Director SuSE Labs
