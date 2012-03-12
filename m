From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 4/5] HID: autoload hid-multitouch as needed
Date: Mon, 12 Mar 2012 17:18:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203121715250.18356@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-5-git-send-email-benjamin.tissoires@gmail.com>  <alpine.LNX.2.00.1203072234550.29034@pobox.suse.cz>  <20120308105737.GA11201@polaris.bitmath.org>
 <6E17845C-6F9F-4CB6-AA5D-DEEDCD2089E8@enac.fr>  <20120308113009.GA11416@polaris.bitmath.org>  <E18D154F-E02F-4DF9-8749-7F9EF92792CB@enac.fr> <20120308122303.GA11989@polaris.bitmath.org> <2189FE61-4D55-4729-BBCE-C4880A7EAB2F@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2189FE61-4D55-4729-BBCE-C4880A7EAB2F@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Henrik Rydberg <rydberg@euromail.se>, "benjamin.tissoires Tissoires" <benjamin.tissoires@gmail.com>, =?ISO-8859-15?Q?Fabien_ANDR=C9?= <fabien.andre@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, USB list <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 8 Mar 2012, St=E9phane Chatty wrote:

> >> I had the feeling that the current hid code was somehow trying to =
be
> >> universal, thus making the point moot, and figured that we would
> >> need to reintegrate hid-multitouch into hid-core at some
> >> point. You're suggesting another, more distributed option, in whic=
h
> >> new categories of HID devices appear from time to time and are
> >> handled in new modules, right? Sounds interesting to me, I'd like =
to
> >> hear what the original designers of the hid module think of it.
> >=20
> > Me too. Reading through the module code, it really seems to put
> > userland in charge, only providing sufficient information to be abl=
e
> > to load the right modules. If this was fully possible in hid, at le=
ast
> > one of the special blacklists would disappear. One would also be ab=
le
> > to split the current hid-input into several different drivers, for
> > instance, gaining some clarity in addition to memory savings.
>=20
> This would be a radical change from the current hid code that tends t=
o=20
> restrict "true hid" to a limited range of HID usages and to reject th=
e=20
> rest (cf the IS_INPUT_APPLICATION that caused us some difficulties th=
ree=20
> years ago). But this definitely would make sense to me. Jiri, Dmitry,=
=20
> what do you think?

=46rankly, I'd personally love IS_INPUT_APPLICATION() to die, it's just=
=20
horribly ugly and doesn't scale with rapidly growing number of HID devi=
ces=20
appearing every day (with multitouch definitely being the most active=20
group).

So restructuring a HID core in a way that makes the whole process much=20
more generic and offloads the responsibility into modaliases seems like=
 a=20
proper way to go for me.

I'll be thinking about it a little bit more in the upcoming days, other=
=20
ideas are of course very welcome.

Thanks everybody for initiating this discussion,

--=20
Jiri Kosina
SUSE Labs
