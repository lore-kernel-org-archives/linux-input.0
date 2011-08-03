From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH 1/4] Revert to anonymous 'type A' MT protocol for touch
Date: Wed, 3 Aug 2011 12:31:46 +0800
Message-ID: <CACrgxGD5Q9-oc+A7hRn0q_A+5gzb23HFZ8B-z5_0p2n5QioD1Q@mail.gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
 <20110707213506.GA20310@core.coreip.homeip.net> <CAPz4a6Cf+rM17qKVDf7mZrYYv4Dzse4w1wVZaWgrSzb8yppk4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47735 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab1HCEg4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 00:36:56 -0400
Received: by vxh35 with SMTP id 35so352563vxh.19
        for <linux-input@vger.kernel.org>; Tue, 02 Aug 2011 21:36:55 -0700 (PDT)
In-Reply-To: <CAPz4a6Cf+rM17qKVDf7mZrYYv4Dzse4w1wVZaWgrSzb8yppk4A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dima Zavin <dima@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>

Hi Dima,

Could you tell when will android support protocol B ?

I'm using android honeycomb mr2 release, I found it not support Protoco=
l B yet.

Best regards,
Zhang Jiejing



2011/7/8 Dima Zavin <dima@android.com>:
> Agreed. The next version will correctly use protocol B. When I briefl=
y
> (too briefly clearly :-( ) looked at the original patches, I thought
> they were driver bug fixes. If it's just workarounds for stuff androi=
d
> doesn't do, then we should fix our framework.
>
> Jason, do any of these patches fix actual driver bugs or make the
> driver more robust?
>
> --Dima
>
> On Thu, Jul 7, 2011 at 2:35 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Jul 07, 2011 at 02:04:57PM -0700, Jason Gerecke wrote:
>>> Android (at least up to Gingerbread) does not understand the 'B' pr=
otocol
>>> first made available in 2.6.36. As a workaround until this is fixed=
, we
>>> drop back to using the 'A' protocol.
>>>
>>
>> Well, fix Android then. Same goes for patches 2 & 3.
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
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
