From: David Brownell <david-b@pacbell.net>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driver  forbutton/scrollwhell/slider/touchpad
Date: Wed, 2 Sep 2009 01:41:13 -0700
Message-ID: <200909020141.13810.david-b@pacbell.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <200909012131.27471.david-b@pacbell.net> <3c17e3570909020051lfec50ecr77796655d75e12ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.gq1.yahoo.com ([67.195.14.39]:23647 "HELO
	smtp109.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752172AbZIBIlM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Sep 2009 04:41:12 -0400
In-Reply-To: <3c17e3570909020051lfec50ecr77796655d75e12ca@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: "Song, Barry" <Barry.Song@analog.com>, Mike Frysinger <vapier.adi@gmail.com>, dtor@mail.ru, dmitry.torokhov@gmail.com, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Wednesday 02 September 2009, Barry Song wrote:
> David,
> I am really surprised the kmalloc memory can keep DMA-safe.

Then you need to internalize more of the docs on the DMA
calls ... :)

Notably see in Documentation/DMA-mapping.txt the section up top
where it describes what memory can be used for DMA, and very
explicitly states stack data is not appropriate.  


> Check the 
> code, no matter spi_write_then_read and spi_init, they only get memory
> by a simple
> kmalloc(SPI_BUFSIZ, GFP_KERNEL);
> I can't find map_single or dma coherent operations at all. So did I
> lose something?

When the SPI master controller driver uses DMA and the caller
doesn't set up mappings, that controller driver does the DMA
mapping operations.  That's what those code paths rely on.

You're writing code sitting a layer above that driver for the
SPI master controller.  Your code won't know whether DMA will
be used or not, so your code must either (a) use DMA-safe buffers
in the first place, or else (b) use spi_write_then_read() which
provides a small bounce buffer.  A non-option is (c) write your
code so it breaks on controllers that use DMA.

- Dave


> Thanks
> Barry
> 
> On 9/2/09, David Brownell <david-b@pacbell.net> wrote:
> > On Tuesday 01 September 2009, Song, Barry wrote:
> >> >> +       spi_message_add_tail(&t, &m);
> >> >> +       ret = spi_sync(spi, &m);
> >> >
> >> >cant you use spi_write_then_read() ?  dont let the u8* prototype scare
> >> >you, it should work with writing 16bits and then reading 16bits.
> >>
> >> I have never been scared by any u8* or something else. I only prefer
> >> to use raw spi API, which can show the bottom level timing and SPI
> >> bus feature better.
> >
> > In this case spi_write_then_read() is required, since
> > your tx and rx buffers are on the stack and hence not
> > DMA-safe.
> >
> 
> 


