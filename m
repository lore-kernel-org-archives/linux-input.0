From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Can I expect in-kernel decoding to work out of box?
Date: Tue, 27 Jul 2010 21:29:30 -0400
Message-ID: <AANLkTi=493LW6ZBURCtyeSYPoX=xfz6n6z77Lw=a2C9D@mail.gmail.com>
References: <1280269990.21278.15.camel@maxim-laptop>
	<1280273550.32216.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:53418 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab0G1B3a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 21:29:30 -0400
Received: by pxi14 with SMTP id 14so701146pxi.19
        for <linux-input@vger.kernel.org>; Tue, 27 Jul 2010 18:29:30 -0700 (PDT)
In-Reply-To: <1280273550.32216.4.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Jarod Wilson <jarod@wilsonet.com>, linux-input <linux-input@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Tue, Jul 27, 2010 at 7:32 PM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Wed, 2010-07-28 at 01:33 +0300, Maxim Levitsky wrote:
>> Hi,
>>
>> I ported my ene driver to in-kernel decoding.
>> It isn't yet ready to be released, but in few days it will be.
>>
>> Now, knowing about wonders of in-kernel decoding, I try to use it, but
>> it just doesn't work.
>>
>> Mind you that lircd works with this remote.
>> (I attach my lircd.conf)
>>
>> Here is the output of mode2 for a single keypress:

    8850     4350      525     1575      525     1575
     525      450      525      450      525      450
     525      450      525     1575      525      450
     525     1575      525      450      525     1575
     525      450      525      450      525     1575
     525      450      525      450      525    23625

That decodes as:
1100 0010 1010 0100

In the NEC protocol the second word is supposed to be the inverse of
the first word and it isn't. The timing is too short for NEC protocol
too.

Valid NEC...
1100 0011 1010 0101

Maybe JVC protocol but it is longer than normal.

The JVC decoder was unable to get started decoding it.  I don't think
the JVC decoder has been tested much. Take a look at it and see why it
couldn't get out of state 0.


>
> Just want to add that I tested it with many different modes of my
> remotes, and all but one fail (one mode is detected as NEC).
>
> Don't get me wrong.
> Although I opposed to idea of in-kernel decoding, lately I began to
> think that this isn't such a bad idea.
> Especially if number of users for whom it will work out of box.
>
> So, I am very disappointed.
>
> Best regards,
> Maxim Levitsky
>
>



-- 
Jon Smirl
jonsmirl@gmail.com
