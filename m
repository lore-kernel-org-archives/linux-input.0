From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Tue, 9 Feb 2010 20:23:34 +0800
Message-ID: <f17812d71002090423j4f02225av24e5af0227e0809d@mail.gmail.com>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
	<20100208180625.GB1469@ucw.cz> <f17812d71002081715w485b33bbx3f67afb86c6d8ee1@mail.gmail.com>
	<20100209090918.GA12642@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:48627 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab0BIMX4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 07:23:56 -0500
Received: by pzk17 with SMTP id 17so309447pzk.4
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2010 04:23:54 -0800 (PST)
In-Reply-To: <20100209090918.GA12642@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tue, Feb 9, 2010 at 5:09 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Feb 09, 2010 at 09:15:38AM +0800, Eric Miao wrote:
>> On Tue, Feb 9, 2010 at 2:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > On Thu 2010-02-04 16:45:41, Eric Miao wrote:
>> >> commit 31cec413e534520111716802833675f53ac99b0b
>> >> Author: Eric Miao <eric.y.miao@gmail.com>
>> >> Date: =C2=A0 Thu Feb 4 16:41:28 2010 -0800
>> >>
>> >> =C2=A0 =C2=A0 input: schedule corgi_ssp and corgi_ts to be remove=
d
>> >>
>> >> =C2=A0 =C2=A0 Cc: Richard Purdie <rpurdie@rpsys.net>
>> >> =C2=A0 =C2=A0 Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> >
>> > ACK.
>> >
>>
>> Thanks, guys.
>>
>> Dmitry, I'm hoping these two patches will go through your tree pleas=
e?
>
> I have it in next, do you want it in .33 instead?
>

No. -next is good, thanks man.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
