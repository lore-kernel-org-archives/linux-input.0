From: Rantanplan <rantanplanlechien@free.fr>
Subject: Re: [PATCH 3/3] HID: deletion of unused code in hid-magicmouse.
Date: Tue, 09 Mar 2010 13:00:41 +0100
Message-ID: <4B963869.2010801@free.fr>
References: <1268065277-30129-1-git-send-email-tissoire@cena.fr> <1268065277-30129-2-git-send-email-tissoire@cena.fr> <1268065277-30129-3-git-send-email-tissoire@cena.fr> <1268065277-30129-4-git-send-email-tissoire@cena.fr> <1268065277-30129-5-git-send-email-tissoire@cena.fr> <4B95255B.5010900@cena.fr> <alpine.LNX.2.00.1003081730170.17799@pobox.suse.cz> <4B952C77.3080505@cena.fr> <87sk8a36f4.fsf@troilus.org> <4B956358.80608@tls.cena.fr> <alpine.LNX.2.00.1003090056020.17799@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:47901 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab0CIMAw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 07:00:52 -0500
In-Reply-To: <alpine.LNX.2.00.1003090056020.17799@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <tissoire@tls.cena.fr>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Stephane Chatty <chatty@enac.fr>

My apologies for the inconvenience. After some thought I finally=20
realized that the smtp server at work did not send any of the mail to=20
the people outside its domain, i.e. everybody except me...

Michael already reviewed the patch (I send them to the mailing list onl=
y=20
in order not to spam your inboxes, mistake number 2) and send his=20
comments, so I will resend the patch after including his notes. However=
,=20
as Michael said, the patches are a little bit heavy faced to the proble=
m=20
tackled.
That's why I will answer to its mail instead of creating two threads.

Cheers,
Benjamin

Le 09/03/2010 00:56, Jiri Kosina a =E9crit :
> On Mon, 8 Mar 2010, Benjamin Tissoires wrote:
>
>> Sorry about that, I'm beginning in sending patch for the kernel. I t=
ried to
>> use the git send-email command, but I saw after that the command jus=
t send
>> email to the people I added, but not the mailing list. To be sure to=
 (re)send
>> the last patch, I attached it to be sure to send it "correctly", but=
 not
>> according to the recommended practice.
>>
>> I will resend the whole patch list to the mailing list.
>>
>> The patch you told was not intended to be self-consistant but a fina=
l cleanup
>> after the two patches I tried to send before. I splitted them like t=
hat in
>> order to keep them human readable as git tried to intrelace the addi=
tions and
>> removals, even if they were not related together.
>
> Hi Benjamin,
>
> well, I don't have the 1/3 and 2/3 patches anywhere in my mailboxes
> either ... so please resend those as well.
>
> Thanks,
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
