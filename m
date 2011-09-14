From: "M. Edward (Ed) Borasky" <znmeb@borasky-research.net>
Subject: Re: [PATCH 0/2] Better support old elantech v2 hardware
Date: Tue, 13 Sep 2011 21:32:57 -0700
Message-ID: <CAPmDpsko06VSua1Xyw6mjH1arEtKfO3fyt16jqiQfuQh4aSkHA@mail.gmail.com>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
	<4E6FCC0C.3050001@gmail.com>
	<87vcsv94c8.fsf@emc.com.tw>
Reply-To: znmeb@borasky-research.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39866 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1INEdA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 00:33:00 -0400
Received: by yie30 with SMTP id 30so1112646yie.19
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 21:32:59 -0700 (PDT)
In-Reply-To: <87vcsv94c8.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I just got an Asus U46E-BAL5 and the touchpad is showing up in
openSUSE Linux 11.4 as a PS/2 mouse. I think this patch set might fix
that issue - how can I get the patches to try it?

On Tue, Sep 13, 2011 at 8:43 PM, JJ Ding <jj_ding@emc.com.tw> wrote:
> On Tue, 13 Sep 2011 16:33:00 -0500, Chase Douglas <chasedouglas@gmail=
=2Ecom> wrote:
>> On 09/13/2011 01:15 AM, JJ Ding wrote:
>> > Hi everyone,
>> >
>> > Thanks to Richard Sch=C3=BCtz's bug report, I did some more resear=
ch on elantech
>> > v2 hardware. I asked our Windows driver team and firmware team abo=
ut the
>> > _ancient histroy_ of the dark old days ;-) These two patches are t=
he results.
>> >
>> > Hopefully with these 2 we can support v2 hardware as good as Windo=
ws does.
>>
>> I just want to say: Thank you so much for all this! The Linux commun=
ity
>> is often ignored by vendors, and then if we aren't ignored they only=
 put
>> the effort into making the latest stuff work. Personally, I greatly
>> appreciate what you have contributed.
>>
>> Thanks again!
>>
>> -- Chase
>
> Thank you, Chase, it's nice to hear this from you.
>
> I've been a long time Linux user, so I do understand the frustration
> when having a device working OK on Windows, but just can't get Linux =
to
> support it ;)
>
> I am happy to have a chance to contribute, even just a little bit.
>
> jj
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
http://twitter.com/znmeb=C2=A0http://borasky-research.net

"A mathematician is a device for turning coffee into theorems." -- Paul=
 Erd=C5=91s
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
