From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation hooks
Date: Wed, 16 Jun 2010 10:00:19 +0200
Message-ID: <AANLkTik3PHoo-1Is-yrzzTRjeH9G7v8LUgqxBzgVRQDi@mail.gmail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
	<1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
	<20100615160253.GK14510@rakim.wolfsonmicro.main>
	<s5h1vc7o1i3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33288 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab0FPIAU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 04:00:20 -0400
In-Reply-To: <s5h1vc7o1i3.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jun 16, 2010 at 9:55 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > =A0include/sound/ac97_codec.h | =A0 =A02 ++
>> > =A01 files changed, 2 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec=
=2Eh
>> > index 4940045..db3aee1 100644
>> > --- a/include/sound/ac97_codec.h
>> > +++ b/include/sound/ac97_codec.h
>> > @@ -437,6 +437,8 @@ struct snd_ac97_bus_ops {
>> > =A0 =A0 unsigned short (*read) (struct snd_ac97 *ac97, unsigned sh=
ort reg);
>> > =A0 =A0 void (*wait) (struct snd_ac97 *ac97);
>> > =A0 =A0 void (*init) (struct snd_ac97 *ac97);
>> > + =A0 void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpio)=
;
>> > + =A0 unsigned short (*getgpio) (struct snd_ac97 *ac97);
>
> Can this be handled simply in read/write callbacks in the controller
> side? =A0In callbacks, you can check whether reg =3D=3D AC97_GPIO_STA=
TUS and
> handle differently for such an access.

Interesting Idea, and as a bonus requires no changes to the wm97xx code=
=2E

Thank you!
      Manuel Lauss
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
