From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/2] input: rotary-encoder: add support for half-period encoders
Date: Mon, 23 May 2011 00:42:31 +0200
Message-ID: <BANLkTimCdrYf6Fee44hDN2vykwVrAroVJQ@mail.gmail.com>
References: <1302027313-27130-1-git-send-email-jhovold@gmail.com>
	<20110510190516.GB436@localhost>
	<BANLkTikgRm7hBZJYXQWSOdQwYyi4=aNDcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33951 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab1EVWmc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 May 2011 18:42:32 -0400
Received: by pzk9 with SMTP id 9so2354855pzk.19
        for <linux-input@vger.kernel.org>; Sun, 22 May 2011 15:42:32 -0700 (PDT)
In-Reply-To: <BANLkTikgRm7hBZJYXQWSOdQwYyi4=aNDcg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sun, May 22, 2011 at 11:29 PM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Johan,
>
> On Tue, May 10, 2011 at 9:05 PM, Johan Hovold <jhovold@gmail.com> wrote:
>> Hi Dmitry,
>>
>> On Tue, Apr 05, 2011 at 08:15:11PM +0200, Johan Hovold wrote:
>>> These patches add support for rotary-encoders which have two stable
>>> states per input signal period.
>>
>> Is there any chance to get these into 2.6.40? I haven't received any
>> feedback from you so I thought I'd send a reminder.
>
> Very sorry for the long delay.
>
> I was finally able to test your patches with real hardware, and they
> seem to work alright. So I have no problem with them being accepted
> any time soon, but I don't know if they will still make it to 2.6.40.

Btw, that also means you can have my

Acked-by: Daniel Mack <zonque@gmail.com>

for both patches.

Daniel
