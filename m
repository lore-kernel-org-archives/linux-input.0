From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: Re: edt-ft5x06 question
Date: Sat, 18 Nov 2017 22:16:56 +0100
Message-ID: <BCAF451A-FFA6-46CD-B511-33F89293DA77@micronovasrl.com>
References: <49b16b2c-772d-b9d6-993a-063c41e46200@micronovasrl.com> <2352100a-db85-e469-95b1-02d9180aba41@lucaceresoli.net> <1510946031.15053.30.camel@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:36490 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763454AbdKRVRC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 16:17:02 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 6F6EDB00713
        for <linux-input@vger.kernel.org>; Sat, 18 Nov 2017 22:17:00 +0100 (CET)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2tTHyIQhZ7LY for <linux-input@vger.kernel.org>;
        Sat, 18 Nov 2017 22:17:00 +0100 (CET)
Content-Language: it
In-Reply-To: <1510946031.15053.30.camel@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>
Cc: linux-input@vger.kernel.org

Hi Simon,

Il 17/11/2017 20:13, Simon Budig ha scritto:
> [Trimming down the CC list a bit...]

Thanks

> Hi all.
>> On Fri, 2017-11-17 at 18:16 +0100, Luca Ceresoli wrote:
>> What about all the other registers? The datasheet lists a few dozen,
>> not only 0x80. Are they implemented in the panel you are working on?
>>=20
>>> The point is that datasheet seems to be official by Focaltech,
>>> like if they deliver that IC with a standard FW inside.
>>> I can't find a way to safely probe if it's a standard FW or from
>>> EDT M09
>>> or M06.
>>=20
>> Since everything is based on the programmed firmware, and there's no
>> "standard" way to detect firmware version, every firmware detection
>> is
>> bound to be a hack. But there's no better way I'm afraid. Thus device
>> tree seems the only reliable way...
>>=20
>> However, did you check registers FIRMID, FT5201ID (CTPM Vendor ID)
>> and ID_G_LIB_VERSION_H/L? According to their name they might hold
>> interesting info.
> When I tried to read them from a solomon/goldentek display/touch I did
> get unreliable data, i.e. I got different values when I had a power
> cycle inbetween the startups.
> Basically the firwmare did not implement these registers on the i2c
> registers and I believe I got whatever happened to sit in the RAM at
> that point. And that was the point where I gave up on trying to
> determine the vendor and product, unless I knew where to look for it
> (mainly the EDT family of touches).
> And that dubiousness extended to the other registers. At some point I
> had arbitrary register access via sysfs, but I did not actually bother
> to determine if they had any effect or provided useful values.
> Trying to communicate with representatives from Solomon Goldentek (in
> this case) proved to be incredibly frustrating, because they did not
> even understand what I was asking for. You don't get a datasheet
> describing the actual firmware in the chip, it always is the same
> focaltec datasheet that seems to consist of a lot of wishful thinking.
> Sometimes you get a linux driver that might even implement a firmware
> update method, but the quality of the code typically is not that great.
> Fortunately the "Generic" method implemented in the patch I referred to
> earlier seems to work reasonably well for the Displays I have at hand.
> You can configure the max. resolution via devicetree and that gets you
> 95% of the way.
> I would not mind additional properties in the devicetree for certain
> quirks of specific devices (but encoding the vendor of the touch seems
> beyond the point to me).

What seems clear to me is that datasheet I=E2=80=99ve pointed out is the bas=
ic firmware by focaltech.
And it=E2=80=99s compatible with M09 style.
But...

> As for frequent recalibration I am not so
> sure, but then I've not yet seen a touch device where this has to be
> done.

We=E2=80=99ve experienced this in every product we have done and we sell.
At this time there are 3k pcs out with recalibration on 3 different machines=
, that otherwise did not work properly.
I mean touch behind 4mm of glass or plexiglass.

At this point, since I need all the other registers only because of that, I w=
ould proceed on writing a different driver specific for focaltech standard f=
irmware as their official datasheet states.

Something like ft-ft5x.c, without making edt-ft5x.c more complicated, in fac=
t what I suggest is specific to focaltech standard firmware only and is not a=
pplicable to edt or other specific firmware.

What do you think?

Regards

> (for the records: the "M12" series from EDT is based on a different IC,
> but their firmware implements a M09-style protocol with a few
> additions, mainly to identify the panel.)
> Bye,
>         Simon


--=20
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale =E2=82=AC 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

