From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH RFC 1/3] sound: ac97: Add GPIO manipulation hooks
Date: Tue, 15 Jun 2010 18:13:49 +0200
Message-ID: <AANLkTikWxbCu69QOk7f5wtJTLouCA1vCwA3htfEcs503@mail.gmail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
	<1276617347-3522-2-git-send-email-manuel.lauss@googlemail.com>
	<20100615160253.GK14510@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58461 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab0FOQNx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 12:13:53 -0400
In-Reply-To: <20100615160253.GK14510@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@vger.kernel.org, linux-input@vger.kernel.org, Takasi Iwai <tiwai@suse.de>

On Tue, Jun 15, 2010 at 6:02 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jun 15, 2010 at 05:55:45PM +0200, Manuel Lauss wrote:
>> Add callbacks to struct snd_ac97 to set and retrieve ac97 codec
>> GPIO status.
>
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>
> CCing in Takashi since this is generic AC'97 stuff.
>
>> ---
>> =A0include/sound/ac97_codec.h | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
>> index 4940045..db3aee1 100644
>> --- a/include/sound/ac97_codec.h
>> +++ b/include/sound/ac97_codec.h
>> @@ -437,6 +437,8 @@ struct snd_ac97_bus_ops {
>> =A0 =A0 =A0 unsigned short (*read) (struct snd_ac97 *ac97, unsigned =
short reg);
>> =A0 =A0 =A0 void (*wait) (struct snd_ac97 *ac97);
>> =A0 =A0 =A0 void (*init) (struct snd_ac97 *ac97);
>> + =A0 =A0 void (*setgpio) (struct snd_ac97 *ac97, unsigned short gpi=
o);
>> + =A0 =A0 unsigned short (*getgpio) (struct snd_ac97 *ac97);
>> =A0};
>>
>> =A0struct snd_ac97_bus {
>> --
>> 1.7.1
>>
>
> So, I'd kind of expect some sort of interaction with gpiolib somewher=
e
> if we do support GPIOs (I know the WM97xx custom stuff doesn't curren=
tly
> use GPIOs but...).

If I ever get access to the testhardware again, I'll implement it in
the wm97xx core.

        Manuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
