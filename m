From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for device-tree platform data
Date: Mon, 04 Jul 2011 10:52:55 +0400
Message-ID: <94bc67c6-6a34-43f0-b88f-8a4278115730@email.android.com>
References: <1308823455-14446-1-git-send-email-david@protonic.nl> <1308823455-14446-2-git-send-email-david@protonic.nl> <BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com> <20110623133908.5c85eb3c@lxorguk.ukuu.org.uk> <BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com> <20110623180121.GA14950@core.coreip.homeip.net> <20110704082939.6da4aaeb@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65079 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1GDGxP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 02:53:15 -0400
Received: by iwn6 with SMTP id 6so4226640iwn.19
        for <linux-input@vger.kernel.org>; Sun, 03 Jul 2011 23:53:15 -0700 (PDT)
In-Reply-To: <20110704082939.6da4aaeb@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

David Jander <david.jander@protonic.nl> wrote:

>On Thu, 23 Jun 2011 11:01:22 -0700
>Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> On Thu, Jun 23, 2011 at 07:25:37AM -0600, Grant Likely wrote:
>> > On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox
><alan@lxorguk.ukuu.org.uk> wrote:
>> > >> > + =C2=A0 =C2=A0 =C2=A0 - gpios: OF devcie-tree gpio specifica=
tin.
>> > >> > + =C2=A0 =C2=A0 =C2=A0 - label: Descriptive name of the key.
>> > >> > + =C2=A0 =C2=A0 =C2=A0 - linux,code: Keycode to emit.
>> > >>
>> > >> The fact that this is the Linux internal keycode definitions
>still
>> > >> makes me nervous. =C2=A0Is there no existing standard for keyco=
des
>emitted
>> > >> by keyboard devices?
>> > >
>> > > There is but no standard lookup table. For Intel MID we do a
>translation
>> > > between Linux key names in the firmware and keycodes but there
>isn't a
>> > > generic helper for it.
>> >=20
>> > I suppose the Linux keycodes are exported out to userspace, and ar=
e
>> > therefore an ABI which will not change.  Okay.
>>=20
>> Right, keycodes form ABI that will not change.
>>=20
>> Another option would be to use codes from HID usage tables but then
>> they would have to be translated to Linux ones.
>
>Dmitry, will you accept this patch also?
>Until now, part 2/2 is in your tree, thanks for that, but I'd like to
>know if
>this part (1/2) will also be accepted?
>

Yes, I will since there was no more discussion about hid codes and I do=
 believe that using linux definitions is fine.


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
