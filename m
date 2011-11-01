From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Tue, 1 Nov 2011 02:31:54 +0200
Message-ID: <CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:32774 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab1KAAbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Oct 2011 20:31:55 -0400
Received: by qyk4 with SMTP id 4so4472375qyk.19
        for <linux-input@vger.kernel.org>; Mon, 31 Oct 2011 17:31:54 -0700 (PDT)
In-Reply-To: <20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

Hello Antonio,

Thank you so much for your reply!
Unfortunately within the mbox there are no attachments, so I cannot
proceed and patch my bluez.

In the mean while I would like first to see it work with plain USB,
which should be much simpler, no?
If you connect the device to the USB port, does it work? Do yo see
activity when you do cat /dev/input/js0?

At Windows the following[1] drivers are working correctly in USB and
bluetooth....

Thanks!
Alon.

[1] http://www.motioninjoy.com/download

On Tue, Nov 1, 2011 at 2:18 AM, Antonio Ospite <ospite@studenti.unina.i=
t> wrote:
> On Tue, 1 Nov 2011 01:04:37 +0200
> Alon Bar-Lev <alon.barlev@gmail.com> wrote:
>
>> Hello,
>>
>> I feel uncomfortable, as people reports that it does work...
>> Bluetooth pairing is not working and almost no documentation of
>> bluez-4 success....
>> So I thought starting in USB will be easier....
>>
>> I am using linux-3.1.0
>> When doing cat /dev/input/js0 or cat /dev/input/event15 or usbhid-du=
mp
>> I get no activity.
>>
>> Can anyone please help? or acknowledge that it actually work?
>> Can I provide more information?
>
> Hi Alon, we were tracking the progress on:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D40812
>
> but bugzilla on kernel.org is still down.
>
> The current situation is that it is working but patches needs to be
> applied to BlueZ, I copied the mails from the bugzilla reports here i=
n
> this file:
>
> http://ao2.it/tmp/sixaxis_discussion_kernel.org_bugzilla.mbox
>
> where you will find instructions on how to make the Sixaxis work over
> BT.
>
> Keep in mind that the file is under /tmp on my server, so it will go
> away eventually.
>
> Ah you could help pushing linux-bluetooth people to review my changes
> and eventually apply them so we can have official support for
> Sixaxis/DS3 in BlueZ.
>
> Thanks,
> =C2=A0 Antonio
>
> --
> Antonio Ospite
> http://ao2.it
>
> PGP public key ID: 0x4553B001
>
> A: Because it messes up the order in which people normally read text.
> =C2=A0 See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
