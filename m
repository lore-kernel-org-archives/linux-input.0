From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 1/5] ARM: SAMSUNG: Add keypad device support
Date: Sun, 30 May 2010 14:04:39 +0900
Message-ID: <AANLkTimJyc8E_D_-95eeVFwOVXwJKM5xKCCW-7gkNWrU@mail.gmail.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<201005300542.37715.marek.vasut@gmail.com>
	<AANLkTilt_-UAZGZepwtIYM7HRuPsX7gsW_ppLZD1_bZq@mail.gmail.com>
	<20100530045151.GE4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20100530045151.GE4720@trinity.fluff.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On Sun, May 30, 2010 at 1:51 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, May 30, 2010 at 01:46:03PM +0900, Jassi Brar wrote:
>> On Sun, May 30, 2010 at 12:42 PM, Marek Vasut <marek.vasut@gmail.com=
> wrote:
>> > Dne Ne 30. kv??tna 2010 05:06:20 Joonyoung Shim napsal(a):
>> >> +struct samsung_kp_platdata {
>> >> + =C2=A0 =C2=A0 const struct matrix_keymap_data *keymap_data;
>> >> + =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0rows;
>> >> + =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0cols;
>> >> + =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0rep;
>> >
>> > I don't know, maybe using uint32_t here? On ARM, it doesn't matter=
 so far as int
>> > will be always 32bit, but maybe we should just type the variables =
well ?
>>
>> I thought int was 32bits on all archs
>
> No, the C standard doesn't make any guarantees about the size of type=
s,
> it is up to the implementation of the compiler. If I rember correctly
> the only guarantee in the lanugage definition is that char->short->in=
t->long
> be that the next up the line be at-least as a =C2=A0big as the one be=
fore.
I believe on most implementations, if not all, sizeof char, short and
int are resp
1, 2 and 4 bytes. whereas long denotes the native capacity of the arch.
