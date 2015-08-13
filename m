From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property
Date: Fri, 14 Aug 2015 00:31:09 +0300
Message-ID: <10744920.2768uXkYtL@avalon>
References: <1436180132-26190-1-git-send-email-geert+renesas@glider.be> <20150813000537.GD5221@verge.net.au> <CAMuHMdV0fqjJSjmYqP0uFa0x5ydc1iztu4za1Ufu7OMdhC29Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdV0fqjJSjmYqP0uFa0x5ydc1iztu4za1Ufu7OMdhC29Ug@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thursday 13 August 2015 11:26:32 Geert Uytterhoeven wrote:
> On Thu, Aug 13, 2015 at 2:05 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jul 08, 2015 at 09:51:49AM +0900, Simon Horman wrote:
> >> On Tue, Jul 07, 2015 at 09:56:29AM +0300, Laurent Pinchart wrote:
> >>> On Tuesday 07 July 2015 09:26:21 Simon Horman wrote:
> >>>> On Mon, Jul 06, 2015 at 04:29:33PM +0300, Laurent Pinchart wrote:
> >>>>> On Monday 06 July 2015 12:55:32 Geert Uytterhoeven wrote:
> >>>>>> Replace the deprecated generic "adi,adxl34x" compatible value by
> >>>>>> the adxl345-specific "adi,adxl345" value, cfr. commit
> >>>>>> e465bf6fc55d5ce2 ("DT:
> >>>>>> i2c: Deprecate adi,adxl34x compatible string").
> >>>>>> 
> >>>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>>> 
> >>>>> Acked-by: Laurent Pinchart
> >>>>> <laurent.pinchart+renesas@ideasonboard.com>
> >>>>> 
> >>>>>> ---
> >>>>>> Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF
> >>>>>> match support"), which is in v4.2-rc1.
> >>>>>> 
> >>>>>> This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific
> >>>>>> compatible property".
> >>>> 
> >>>> It appears to me that this will cause a regression when booting old
> >>>> kernels with new dts blobs. For that reason think we should consider
> >>>> v1 of this change coupled with a schedule to remove use of the
> >>>> deprecated compat string.
> >>> 
> >>> That's the forward compatibility that Geert mentioned, is that really
> >>> an issue, especially on this board ?
> >> 
> >> I think it would be best to provide backwards compatibility unless there
> >> is a compelling reason not to.
> > 
> > I would like to revisit this discussion with a view to getting some
> > version of this patch queued up (yes I know I pushed back on it earlier in
> > this thread).
>
> I'm fine with applying v1.

And I'm quite unsurprisingly not, as I've asked for a v2.

The "adi,adxl34x" compatible string is deprecated. That means we still support 
it in the driver for device trees that haven't been updated, but it shouldn't 
be used forward by new device trees. That's why the device tree sources 
contained in the kernel shouldn't use it, especially given that they often 
serve as references for device trees shipped out of tree.

-- 
Regards,

Laurent Pinchart

