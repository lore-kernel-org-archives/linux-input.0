From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 00/10] Input: synaptics-rmi4: Synaptics RMI4 Driver
Date: Fri, 11 Mar 2016 10:05:21 -0800
Message-ID: <20160311180521.GA13175@dtor-ws>
References: <1455142982-10008-1-git-send-email-aduggan@synaptics.com>
 <CACRpkdaE91ncWccG9_dsOiC40j9mFpm7A=S_mpeHmP-vjSVjMQ@mail.gmail.com>
 <56BE200F.5040602@synaptics.com>
 <20160303171138.GH22340@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34843 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbcCKSFZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 13:05:25 -0500
Content-Disposition: inline
In-Reply-To: <20160303171138.GH22340@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Rob Herring <robh@kernel.org>

On Thu, Mar 03, 2016 at 06:11:38PM +0100, Benjamin Tissoires wrote:
> On Feb 12 2016 or thereabouts, Andrew Duggan wrote:
> > On 02/12/2016 04:54 AM, Linus Walleij wrote:
> > >On Wed, Feb 10, 2016 at 11:23 PM, Andrew Duggan <aduggan@synaptics.com> wrote:
> > >
> > >>This is the v5 patch series which fixes the issues identified by kbuild
> > >>and coccinelle in the previous patch series. These include:
> > >>
> > >>- Using ARRAY_SIZE instead of a custom macro to calculate the size of the
> > >>   function handler array.
> > >>- Remove setting the .owner field for the driver in rmi_i2c and rmi_spi
> > >>   since the i2c-core and spi set that field.
> > >>- Fix if statment in rmi_f30 which was testing has_led twice instead of
> > >>   testing has_gpio.
> > >Works like a charm.
> > >Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Thanks for testing. At this point except for the touchscreen binding rename
> > fix needed in patch 5, all of the outstanding issues have been addressed. If
> > the rest of the patch series is acceptable, then I can do a final v6 respin
> > which fixes the binding and also removes the HID patch. But, if more work
> > needs to be done on the patch series I can wait to do the respin. Dmitry,
> > what do you think of the patch series at this point?
> 
> Dmitry, ping on this one...
> 
> I'd like to see the series in 4.6, and we are getting closer of the
> merge window. Could we get some of your time on this?

I adjusted the binding on patch 5 (to read -x-mm and y-mm) and applied
the first 9 leaving the HID out for now.

Thanks.

-- 
Dmitry
