From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 0/4] hid-multitouch: a first step towards multitouch unification
Date: Fri, 10 Dec 2010 15:33:18 +0100
Message-ID: <AANLkTi=-sn9ZrNtUsduKC09zeDDvDUHV17rQBk4mG0h_@mail.gmail.com>
References: <20101013222811.6EC0B95210@smtp.lii-enac.fr>
	<E8092693-D2F3-4544-A18E-C7F5DCD8507A@enac.fr>
	<alpine.LNX.2.00.1012101507590.15140@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f172.google.com ([209.85.214.172]:41346 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0LJOdT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 09:33:19 -0500
Received: by iwn40 with SMTP id 40so5379686iwn.3
        for <linux-input@vger.kernel.org>; Fri, 10 Dec 2010 06:33:19 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1012101507590.15140@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, rydberg@euromail.se, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, tissoire@lii-enac.fr

Hi Jiri,

Sorry for the delay, but it took me some time to be fully ready
(administrative work....).
As St=E9phane mentioned in a previous mail, I joined his lab to work on
multitouch. The top of my TODO list is to continue this work on
hid-multitouch.
I will take into account Henrik's comment as soon as possible and send
a new patch set the next week I hope.

Cheers,
Benjamin

On Fri, Dec 10, 2010 at 3:08 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 14 Oct 2010, St=E9phane Chatty wrote:
>
>>
>> Le 14 oct. 10 =E0 00:28, Stephane Chatty a =E9crit :
>>
>> >
>> > St=E9phane Chatty (4):
>> > =A0hid-multitouch: support for PixCir-based panels in a generic co=
de structure
>> > =A0hid-multitouch: migrated support for Cando panels
>> > =A0hid-multitouch: added support for Cypress TrueTouch panels
>> > =A0hid-multitouch: migrated support for MosArt panels
>>
>> I forgot to mention that:
>> - I am looking for testers for Quanta panels
>> - I have code that works for the GeneralTouch panels found in some r=
ecent
>> tablets. But these panels appear to have the exact same device ID as
>> previously existing single touch panels, with a different protocol. =
I am
>> working on a solution to discriminate the two types of panels.
>
> [ adding Bejnamin to CC ]
>
> Hi guys,
>
> Henrik had quite a few reasonable comments to this patchset, and then
> there was a long silence :)
>
> Is there any respin going to happen?
>
> Thanks!
>
> --
> Jiri Kosina
> SUSE Labs, Novell Inc.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
