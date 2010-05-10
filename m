From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Mon, 10 May 2010 17:27:30 -0400
Message-ID: <AANLkTinp6wpCTgvq2Vqj4GZRcsM8-vdOm4oI6MMKaedj@mail.gmail.com>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<1273488154-2993-1-git-send-email-os@emlix.com> <20100510142225.4bf215ef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100510142225.4bf215ef.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>
List-Id: linux-input@vger.kernel.org

On Mon, May 10, 2010 at 17:22, Andrew Morton wrote:
> On Mon, 10 May 2010 12:42:34 +0200 "Oskar Schirmer" wrote:
>> With dma based spi transmission, data corruption
>> is observed occasionally. With dma buffers located
>> right next to msg and xfer fields, cache lines
>> correctly flushed in preparation for dma usage
>> may be polluted again when writing to fields
>> in the same cache line.
>>
>> Make sure cache fields used with dma do not
>> share cache lines with fields changed during
>> dma handling. As both fields are part of a
>> struct that is allocated via kzalloc, thus
>> cache aligned, moving the fields to the 1st
>> position and insert padding for alignment
>> does the job.
>
> This sounds odd. =C2=A0Doesn't it imply that some code somewhere is m=
issing
> some DMA synchronisation actions?

i think it's kind of dumb and induces this sort of bug
semi-frequently, but it is what the current DMA API requires (see like
Documentation/spi/spi-summary)
-mike
