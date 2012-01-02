From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Input: mpu3050: add of_match table for device-tree
 probing
Date: Mon, 2 Jan 2012 01:42:43 -0700
Message-ID: <20120102084243.GH18381@ponder.secretlab.ca>
References: <1324607992-2919-1-git-send-email-olof@lixom.net>
 <20111223092246.GA7120@core.coreip.homeip.net>
 <CAOesGMiGJmc6FhsDcsmROUgoLD4eDFKK=LE7yYjkJn1O7oiL8Q@mail.gmail.com>
 <4EF9ED4E.6000408@gmail.com>
 <CAOesGMjDUYqP3iFzBz06sxyhjMGD4Znxvps4JxCxky56Hxy-PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48604 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab2ABImq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jan 2012 03:42:46 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so28963977iae.19
        for <linux-input@vger.kernel.org>; Mon, 02 Jan 2012 00:42:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOesGMjDUYqP3iFzBz06sxyhjMGD4Znxvps4JxCxky56Hxy-PQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Dec 27, 2011 at 09:14:31AM -0800, Olof Johansson wrote:
> On Tue, Dec 27, 2011 at 8:07 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On 12/23/2011 09:58 AM, Olof Johansson wrote:
> >> Hi,
> >>
> >> On Fri, Dec 23, 2011 at 1:22 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >>> Hi Olof,
> >>>
> >>> On Thu, Dec 22, 2011 at 06:39:52PM -0800, Olof Johansson wrote:
> >>>> Adding invn,mpu3050 as the initial id.
> >>>>
> >>>
> >>> I believe you also need to add this to
> >>> Documentation/devicetree/bindings/input/
> >>
> >> For simple i2c devices that only have a name, address and possibly an
> >> interrupt, there's no need to document a binding (it hasn't been done
> >> in the past for the vast majority of those devices).
> >
> > But then how do you find out if there is a existing binding for a device
> > without searching in the kernel source tree?
> 
> That's a silly question, since today that is exactly what you do to
> find out, since the Documentation/devicetree isn't the canonical
> location for _all_ bindings anyway -- some are in ePAPR, some are in
> the old IEEE1275 docs, and some are based on whatever the vendor that
> first introduced the device chose (Apple, and some other vendors,
> mostly PowerPC ones).

I would like to keep a list of new bindings though, but I agree with the
argument that a lot of bindings don't need a separate file with a whole
bunch of meaningless boilerplate.

g.

