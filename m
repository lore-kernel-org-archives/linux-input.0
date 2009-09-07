From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 03/03] [INPUT][KEYBOARD] Add new keypad driver for s3c
	series SoCs
Date: Mon, 7 Sep 2009 15:59:41 +0900
Message-ID: <9c9fda240909062359s1629f7a4p65717ad07dcc22ca@mail.gmail.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
	 <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
	 <20090907062658.GS3962@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:65246 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbZIGG7l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 02:59:41 -0400
Received: by vws33 with SMTP id 33so1653606vws.33
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2009 23:59:43 -0700 (PDT)
In-Reply-To: <20090907062658.GS3962@prithivi.gnumonks.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?EUC-KR?B?seiw5sDPL0FQsLO538bAL0UzL7vvvLrA/MDa?= <ki0351.kim@samsung.com>, =?EUC-KR?B?seixucH4L0FQsLO538bAL0U1L7vvvLrA/MDa?= <kgene.kim@samsung.com>

2009/9/7 Harald Welte <laforge@gnumonks.org>:
> Dear all,
>
> On Mon, Sep 07, 2009 at 12:25:14PM +0900, Kyungmin Park wrote:
>> > +static const unsigned char s3c_keycode[] =3D {
>> > + =A0 =A0 =A0 1, 2, KEY_1, KEY_Q, KEY_A, 6, 7, KEY_LEFT,
>> > + =A0 =A0 =A0 9, 10, KEY_2, KEY_W, KEY_S, KEY_Z, KEY_RIGHT, 16,
>> > + =A0 =A0 =A0 17, 18, KEY_3, KEY_E, KEY_D, KEY_X, 23, KEY_UP,
>> > + =A0 =A0 =A0 25, 26, KEY_4, KEY_R, KEY_F, KEY_C, 31, 32,
>> > + =A0 =A0 =A0 33, KEY_O, KEY_5, KEY_T, KEY_G, KEY_V, KEY_DOWN, KEY=
_BACKSPACE,
>> > + =A0 =A0 =A0 KEY_P, KEY_0, KEY_6, KEY_Y, KEY_H, KEY_SPACE, 47, 48=
,
>> > + =A0 =A0 =A0 KEY_M, KEY_L, KEY_7, KEY_U, KEY_J, KEY_N, 55, KEY_EN=
TER,
>> > + =A0 =A0 =A0 KEY_LEFTSHIFT, KEY_9, KEY_8, KEY_I, KEY_K, KEY_B, 63=
, KEY_COMMA,
>> > +};
>>
>> Why do you use fixed keycode? Dose it provided from board specific
>> platform? and If we want to use only 3 * 3 keypad then how do you
>> handle this one?
>
> As Jinsung mailed, the keymap can always be reconfigured from userspa=
ce.
>
> Whether or not the board specific code wants to set a different defau=
lt keymap
> is probably a matter of taste. =A0omap-kbd has it, pxa27x_kbd also ha=
s it. =A0So
> yes, there is some reason to align with what they are doing.

Right it's a matter of taste. but I can't see the provided default key
maps. these got the keymap from platform instead of driver itself.

Even though userspace can re-configure it. why give a burden to the
application programmer. In most case board got fixed keymap and
changed based on some scenarios.

>
>> > +struct s3c_keypad {
>> > + =A0 =A0 =A0 struct s3c_platform_keypad *pdata;
>> > + =A0 =A0 =A0 unsigned char keycodes[ARRAY_SIZE(s3c_keycode)];
>>
>> We don't need full keycode array here. It should be allocated with
>> required size.
>
> I think this is really an implementation detail up to the author. =A0=
Having
> a static array with the maximum size (8*8 =3D=3D 64) is not a big was=
te of
> memory, if you can on the other hand save some code complexity for dy=
namic
> kmalloc()/kfree() and the associated error paths.

With this approaches, it will be increased at s5pc110 since it
provides 14 * 8 matrix. whatever I only used 3 * 3.

>
>> Why do you use timer. As other input drivers how about to use workqu=
eue?
>
> Sorry, what exactly do you mean? =A0I see many (if not all) other key=
pad drivers
> also using a timer.

Right it's my taste. In my experience timer method is hide some bug at
the omap keypad drivers development.

>
>> > +static int s3c_keypad_open(struct input_dev *dev)
>> > +{
>> > + =A0 =A0 =A0 struct s3c_keypad *keypad =3D input_get_drvdata(dev)=
;
>> > + =A0 =A0 =A0 u32 cfg;
>> > +
>> > + =A0 =A0 =A0 clk_enable(keypad->clk);
>> > +
>> > + =A0 =A0 =A0 /* init keypad h/w block */
>> > + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFCON);
>> > + =A0 =A0 =A0 cfg &=3D ~S3C_KEYIF_CON_MASK_ALL;
>> > + =A0 =A0 =A0 cfg |=3D (S3C_KEYIF_INT_F_EN | S3C_KEYIF_INT_R_EN |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S3C_KEYIF_DF_EN | S3=
C_KEYIF_FC_EN);
>> > + =A0 =A0 =A0 writel(cfg, keypad->regs + S3C_KEYIFCON);
>> > +
>> > + =A0 =A0 =A0 cfg =3D readl(keypad->regs + S3C_KEYIFFC);
>> > + =A0 =A0 =A0 cfg |=3D 0x1;
>>
>> What's the meaning of '0x1'?
>
> I agree. Jinsung: The 0x1 should not be a number but a #define from
> the register definition.
>
>> > + =A0 =A0 =A0 if (keypad->timer_enabled) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&keypad->timer, keypad->ti=
mer.expires);
>> > + =A0 =A0 =A0 } else {
>>
>> useless curly braces
>
> That's what I said, too. =A0However, the kernel CodingStyle document =
explicitly
> states that if there is an 'else' block with multiple lines, the firs=
t block
> should also have curly braces. =A0 Despite this, I have not seen it m=
uch in use.
>
>> > + =A0 =A0 =A0 keypad->pdata =3D pdata;
>> > + =A0 =A0 =A0 memcpy(keypad->keycodes, s3c_keycode, sizeof(keypad-=
>keycodes));
>>
>> memcpy??? if you don't modify s3c_keycode. just assign it.
>
> keypad->keycodes is a pointer to the keycode array in the s3c private=
 data
> structure. =A0This memory can be changed from userspace by using the =
keypad
> set/get ioctl's (e.g. 'loadkeys' command).
>
> s3c_keycode is a const array of the default keymap that is loaded dur=
ing boot.
> right now there is only one 6410 specific default keymap, but as you =
suggested
> there should probably be a platform_data (board specific) default key=
map.
>
> In any case, I personally believe the memcpy to memory that is owned =
by
> the driver is a good idea, since userspace can modify it.
>
>> Finally, We did duplicated works. We already implement the keypad dr=
iver for
>> s5pc100 & s5pc110. but we use workqueue structure instead of timer.
>
> This is why System LSI and DMC Lab should coordinate more on what the=
y work.
>
> System LSI's kernel tree is on git.kernel.org and updated every night=
, so you
> (or other interested parties) can stay up-to-date with what is happen=
ing. =A0If
> you base your work on top of System LSI's tree, you would always foll=
ow their
> work. =A0System LSI's tree is what is scheduled to be submitted to ma=
inline.

Even though it's working at Samsung SoCs. but it's not mean it fits
the mainline kernel.
It's based on SMDK board and focused on SMDK.
I mean it's not generic. Some codes are hard-coded and don't call
proper frameworks APIs. especially clocks

>
>> I will post the our works.
>
> I'm not sure if two different Samsung departments posting competing d=
rivers to
> the mainline mailing lists will really help. =A0You need to define wh=
ich group
> will be the 'master' inside Samsung (the logical choice would be Syst=
em LSI).

It's simple. give a choice to customers if there are two versions. you
think it's some duplicated works
it's better to others.

I don't hope just push their codes to mainline with these discussion.

Thank you,
Kyungmin Park

>
> You should then submit your code / modifications as patches to that m=
aster
> tree, and System LSI is submitting it mainline.
>
> The same should be the case for other departments who work on Samsung=
 SoC
> related kernel code..
>
> Regards,
> --
> - Harald Welte <laforge@gnumonks.org> =A0 =A0 =A0 =A0 =A0 http://lafo=
rge.gnumonks.org/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> "Privacy in residential applications is a desirable marketing option.=
"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ETSI EN 300 175-7 Ch. A6)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
