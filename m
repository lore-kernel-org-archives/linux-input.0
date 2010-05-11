From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Tue, 11 May 2010 16:10:31 -0400
Message-ID: <AANLkTimt-eRCt_HTq7OUwzG1dgRuzJHk1tlgOcq4ocL7@mail.gmail.com>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<20100510142225.4bf215ef.akpm@linux-foundation.org> <20100511060547.GA9644@core.coreip.homeip.net>
	<AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
	<20100511062110.GB9644@core.coreip.homeip.net> <AANLkTiktu7N5IXknkkJ9D5L4z5plhuGvD45IVqJm9zG1@mail.gmail.com>
	<20100511063309.GC9644@core.coreip.homeip.net> <y2k84144f021005102342m18bce930g53599c9112565f78@mail.gmail.com>
	<AANLkTinV79HZqS1cktHDsTsHDel-0Nti_Uk4i7mGaRiK@mail.gmail.com>
	<1273608441.15067.1002.camel@calx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58643 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757662Ab0EKUKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 16:10:52 -0400
In-Reply-To: <1273608441.15067.1002.camel@calx>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>

On Tue, May 11, 2010 at 16:07, Matt Mackall wrote:
> On Tue, 2010-05-11 at 16:03 -0400, Mike Frysinger wrote:
>> On Tue, May 11, 2010 at 02:42, Pekka Enberg wrote:
>> > On Tue, May 11, 2010 at 9:33 AM, Dmitry Torokhov wrote:
>> >>> what guarantee exactly do you have for that statement ?
>> >>
>> >> The data is kmalloced, kmalloc aligns on cacheline boundary AFAIK=
 which
>> >> means that next kmalloc data chunk will not share "our" cacheline=
=2E
>> >
>> > No, there are no such guarantees. kmalloc() aligns on
>> > ARCH_KMALLOC_MINALIGN or ARCH_SLAB_MINALIGN depending on which is
>> > bigger but beyond that, there are no guarantees. You can, of cours=
e,
>> > use kmem_cache_create() with SLAB_HWCACHE_ALIGN to align on cachel=
ine
>> > boundary.
>>
>> so how is this to be addressed in general ? =C2=A0this is a problem =
for any
>> device that does SPI transactions, and having every driver create it=
s
>> own kmem cache isnt the answer.
>>
>> do people need to kmalloc() like 2x the desired size and manually
>> align it themselves ? =C2=A0declaring alignments on struct members d=
oesnt
>> matter if the base of the struct isnt aligned. =C2=A0seems like we n=
eed a
>> new GFP flag that says we need a cache aligned pointer so we can giv=
e
>> that to kmalloc() and such.
>
> Make your own slab cache with the alignment flag set, as Pekka alread=
y
> mentioned.

and like i said, that doesnt sound like a reasonable solution when
every single SPI driver (over 100 atm) out there is affected
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
