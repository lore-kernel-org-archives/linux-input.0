From: Cruz Julian Bishop <cruzjbishop@gmail.com>
Subject: Re: Why Cypress does not upstream its trackpad driver?
Date: Mon, 12 Nov 2012 20:57:58 +1000
Message-ID: <50A0D636.9060804@gmail.com>
References: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com> <C825ADB6BE8AC2468577BFFCE7DF5B8A1F080FA111@VMBX133.ihostexchange.net> <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com> <2208882.BvOrfBvj6F@dtor-d630.eng.vmware.com> <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42123 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab2KLK6H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 05:58:07 -0500
In-Reply-To: <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Solda <dso@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Troy Abercrombia <ta@cypress.com>, Kamal Mostafa <kamal@canonical.com>, =?ISO-8859-9?Q?Ozan_=C7a=F0layan?= <ozancag@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, customercare <customercare@cypress.com>, "mario_limonciello@dell.com" <mario_limonciello@dell.com>

On 08/11/12 10:26, David Solda wrote:
> Dmitry, all,
>
> To clarify my comment.  Our protocol utilizes 8 bytes which are neede=
d in our driver.  In order for the Linux system to accept 8 bytes of da=
ta, the Linux psmouse system driver is required to be modified.  Withou=
t this modification, the driver that you are referring to will not work=
 correctly.  The psmouse system driver change that would be required is=
 the item that would be rejected.

In this case, would a solution that involves submitting two separate=20
patches be suitable?

=46or example, an initial patch set to psmouse that allows an arbitrary=
=20
number of bytes be
  (accepted? used?), while keeping a default value to allow the other=20
old drivers to keep working,
and then another patch set with the new driver utilizing the first patc=
h=20
set?

Sorry if this doesn't make any sense - I've been working with generics=20
and abstract class structure
in Java for the last few weeks, and forget what parts are possible in C=
=20
and which parts are not.

Keep up the good work. Even if it's a driver that needs a change, it's=20
still an open-source driver! Be happy :)

>
> I appreciate your comments and of course, if the driver could be upst=
reamed, it would (we already have I2C drivers updstreamed for Chrome sy=
stems), but there is a difference here.
>
> I will again look into the possibility of what you are requesting, ho=
wever, the changes are extremely low if not zero that it will be accept=
ed.
>
> Dave
>
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, November 07, 2012 4:16 PM
> To: David Solda
> Cc: Troy Abercrombia; Kamal Mostafa; Ozan =C7a=F0layan; linux-kernel@=
vger.kernel.org; linux-input@vger.kernel.org; customercare; mario_limon=
ciello@dell.com
> Subject: Re: Why Cypress does not upstream its trackpad driver?
>
> Hi David,
>
> On Wednesday, November 07, 2012 06:30:11 PM David Solda wrote:
>> Kamal,
>>
>> My name is Dave Solda and I would be happy to answer any other
>> questions that you have. Troy's response is correct however as in
>> order to support the default Linux mouse class, our firmware would
>> also have to be modified to do so, which cannot be done in system. O=
ur
>> packet protocol maxes out at an 8 byte packet, which requires a chan=
ge
>> to the Linux standard in this case.
> I am unable to parse this... I do not believe anyone asks you to chan=
ge your firmware and if your protocol needs 8 bytes to transmit device =
state - that's fine.
>
>> Our goal in working with canonical was to provide something on Linux
>> that would support multi-touch and not only have default single fing=
er
>> movement supported.
>> If I am mistaken and he Linux kernel would accept this, then we can
>> proceed to upstream, however all indications we have is that this
>> patch would be rejected.  If you (or others on from the locus alias)
>> have any inputs, I would be happy to receive them.
> This really depends on whether the changes to the psmouse framework m=
ake sense or not. Please start submitting patches for review/discussion=
 and we can go from there.
>
> Thanks.
>
> --
> Dmitry
>
> This message and any attachments may contain Cypress (or its subsidia=
ries) confidential information. If it has been received in error, pleas=
e advise the sender and immediately delete this message.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
