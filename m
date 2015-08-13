From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific
 compatible property
Date: Thu, 13 Aug 2015 11:26:32 +0200
Message-ID: <CAMuHMdV0fqjJSjmYqP0uFa0x5ydc1iztu4za1Ufu7OMdhC29Ug@mail.gmail.com>
References: <1436180132-26190-1-git-send-email-geert+renesas@glider.be>
	<15966074.zDS67FO48r@avalon>
	<20150707002621.GD13326@verge.net.au>
	<9389528.5qtaECVqX7@avalon>
	<20150708005148.GA28100@verge.net.au>
	<20150813000537.GD5221@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150813000537.GD5221@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Simon,

On Thu, Aug 13, 2015 at 2:05 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jul 08, 2015 at 09:51:49AM +0900, Simon Horman wrote:
>> On Tue, Jul 07, 2015 at 09:56:29AM +0300, Laurent Pinchart wrote:
>> > On Tuesday 07 July 2015 09:26:21 Simon Horman wrote:
>> > > On Mon, Jul 06, 2015 at 04:29:33PM +0300, Laurent Pinchart wrote:
>> > > > On Monday 06 July 2015 12:55:32 Geert Uytterhoeven wrote:
>> > > > > Replace the deprecated generic "adi,adxl34x" compatible value by the
>> > > > > adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
>> > > > > i2c: Deprecate adi,adxl34x compatible string").
>> > > > >
>> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > > >
>> > > > Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> > > >
>> > > > > ---
>> > > > > Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
>> > > > > support"), which is in v4.2-rc1.
>> > > > >
>> > > > > This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
>> > > > > property".
>> > >
>> > > It appears to me that this will cause a regression when booting old kernels
>> > > with new dts blobs. For that reason think we should consider v1
>> > > of this change coupled with a schedule to remove use of the deprecated
>> > > compat string.
>> >
>> > That's the forward compatibility that Geert mentioned, is that really an
>> > issue, especially on this board ?
>>
>> I think it would be best to provide backwards compatibility unless there
>> is a compelling reason not to.
>
> I would like to revisit this discussion with a view to getting some version
> of this patch queued up (yes I know I pushed back on it earlier in this thread).

I'm fine with applying v1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
