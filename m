From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: Re: Input: tca8418-keypad: Incorrect values in a driver
Date: Mon, 20 Apr 2015 18:11:33 +0200
Message-ID: <55352535.3030505@free-electrons.com>
References: <C63F243273B7A346BDF1A19060D79D6343D68D@DFLE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C63F243273B7A346BDF1A19060D79D6343D68D@DFLE10.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Valdez, Jonathan" <j.valdez@ti.com>
Cc: dmitry.torokhov@gmail.com, kyle.manna@fuel7.com, hns@goldelico.com, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Jonathan,

Thank you for reporting this issue!

On 03/30/2015 06:41 PM, Valdez, Jonathan wrote:
>
> Hello,
>
> =20
>
> I=92ve been supporting the TCA8418 and have been pointed to your
> document by a few customers
> (http://lxr.free-electrons.com/source/drivers/input/keyboard/tca8418_=
keypad.c)
>
> =20
>
> =20
>
> The problem I am seeing is that you are writing a 1 to
> REG_DEBOUNCE_DIS1/2/3, which actually disables column debouncing. A 0
> enables it. This is easily fixed, but I wanted to bring this to your
> attention.
>
> =20
>
> Please see page 19 of the TCA8418 datasheet, where the registers are
> debounce_DIS(able) registers. A 0 keeps debouncing enabled. By defaul=
t
> debounce is enabled.
>
> =20
>
> Best regards,
>
> Jonathan Valdez
>
> System Connectivity Applications
>

I'm not the maintainer of this code though, just showing the source cod=
e
on our LXR webste. I'm CCing the guys in charge.

Cheers,

Michael.

--=20
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
