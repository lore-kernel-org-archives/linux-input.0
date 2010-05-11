From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Tue, 11 May 2010 17:11:17 -0400
Message-ID: <AANLkTinDNTHZKV6MtJT1bLAFQS4v26PmiafX63UZ2LWj@mail.gmail.com>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<y2k84144f021005102342m18bce930g53599c9112565f78@mail.gmail.com>
	<AANLkTinV79HZqS1cktHDsTsHDel-0Nti_Uk4i7mGaRiK@mail.gmail.com>
	<1273608441.15067.1002.camel@calx> <AANLkTimt-eRCt_HTq7OUwzG1dgRuzJHk1tlgOcq4ocL7@mail.gmail.com>
	<alpine.DEB.2.00.1005111520260.1500@router.home> <AANLkTilEfZLWYxPmCQ1KHIvUGIF_8Qchali66wHNf2gB@mail.gmail.com>
	<alpine.DEB.2.00.1005111544330.8388@router.home> <AANLkTimzxrZyQAfocTwIt5zCVyXP7bReKOvP4K7m8epO@mail.gmail.com>
	<4BE9C58E.4070204@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:45610 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0EKVLh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 17:11:37 -0400
In-Reply-To: <4BE9C58E.4070204@cs.helsinki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Lameter <cl@linux.com>, Matt Mackall <mpm@selenic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>

On Tue, May 11, 2010 at 17:01, Pekka Enberg wrote:
> Mike Frysinger wrote:
>> On Tue, May 11, 2010 at 16:46, Christoph Lameter wrote:
>>> On Tue, 11 May 2010, Mike Frysinger wrote:
>>>>> DMA. If the arch can only DMA into cacheline aligned objects then=
 the
>>>>> correct method is to force kmalloc alignment to cacheline size.
>>>>
>>>> these are SPI drivers and are usable on any arch that supports a S=
PI
>>>> bus (which is pretty much every arch). =C2=A0forget about "embedde=
d"
>>>> arches.
>>>>
>>>> the issue here is simple: a SPI driver (AD7877) needs to do a rece=
ive
>>>> SPI transfer into a DMA safe buffer. =C2=A0what is the exact API t=
o
>>>> dynamically allocate memory for the structure with this buffer
>>>> embedded in it such that the start of the structure is cached alig=
ned
>>>> ? =C2=A0creating a dedicated kmem cache may work, but it isnt a sc=
alable
>>>> solution if every SPI driver needs to create its own cache.
>>>
>>> kmalloc returns a pointer to a DMA safe buffer. There is no require=
ment
>>> on
>>> the x86 hardware that the DMA buffers have to be cache aligned.
>>> Cachelines
>>> will be invalidated as needed.
>>
>> so this guarantee is made by the kmalloc() API ? =C2=A0and for arche=
s where
>> the cacheline invalidation is handled in software rather than
>> hardware, they must declare a min alignment value for kmalloc to be =
at
>> least as big as their cache alignment ?
>>
>> does the phrase "DMA safe buffer" imply cache alignment ?
>
> Yes, you should be able to DMA into kmalloc'd memory. IIRC the block =
or the
> SCSI layer depends on that.

we can DMA into it just fine, it's just that if the small DMA buffer
shares a cacheline with some polled state data (like in current AD7877
driver) instead of getting its own, the core may pull back in stale
data before the DMA finishes.  so we're looking for something that
guarantees both cacheline alignment (when applicable, so this doesnt
apply to x86 apparently) and DMA-safe dynamic memory.

so if Dmitry's original statement:
The data is kmalloced, kmalloc aligns on cacheline boundary AFAIK
which means that next kmalloc data chunk will not share "our"
cacheline.

was revised to say:
The data is kmalloced, kmalloc aligns on cacheline boundary (when the
arch lacks hardware cacheline invalidation between the core and dma
channels) which means that next kmalloc data chunk will not share
"our" cacheline.

and this revised statement is correct, then Dmitry's revised fix
should be sufficient.  and i guess we should update the spi-summary
document with these tips so we dont have to hash this out again.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
