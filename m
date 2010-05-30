From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
Date: Sun, 30 May 2010 05:51:51 +0100
Message-ID: <20100530045151.GE4720@trinity.fluff.org>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com> <201005300542.37715.marek.vasut@gmail.com> <AANLkTilt_-UAZGZepwtIYM7HRuPsX7gsW_ppLZD1_bZq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilt_-UAZGZepwtIYM7HRuPsX7gsW_ppLZD1_bZq@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On Sun, May 30, 2010 at 01:46:03PM +0900, Jassi Brar wrote:
> On Sun, May 30, 2010 at 12:42 PM, Marek Vasut <marek.vasut@gmail.com>=
 wrote:
> > Dne Ne 30. kv??tna 2010 05:06:20 Joonyoung Shim napsal(a):
> >> +struct samsung_kp_platdata {
> >> + =A0 =A0 const struct matrix_keymap_data *keymap_data;
> >> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0rows;
> >> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0cols;
> >> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0rep;
> >
> > I don't know, maybe using uint32_t here? On ARM, it doesn't matter =
so far as int
> > will be always 32bit, but maybe we should just type the variables w=
ell ?
>=20
> I thought int was 32bits on all archs

No, the C standard doesn't make any guarantees about the size of types,
it is up to the implementation of the compiler. If I rember correctly
the only guarantee in the lanugage definition is that char->short->int-=
>long
be that the next up the line be at-least as a  big as the one before.

=46or this, unsigned int should be fine. unsigned short would probably =
be
fine too. I'm not going to worry too much about this.
=20
--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
