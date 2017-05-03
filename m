From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Silead DMI driver
Date: Wed, 3 May 2017 10:19:53 +0200
Message-ID: <20170503101953.3b03ccf2@endymion>
References: <20170424132356.044ae04f@endymion>
        <1493034496.24567.163.camel@linux.intel.com>
        <20170425121939.7dbdfeed@endymion>
        <20170427211322.GA29261@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751601AbdECIT4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 3 May 2017 04:19:56 -0400
In-Reply-To: <20170427211322.GA29261@fury>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Darren,

On Thu, 27 Apr 2017 14:13:22 -0700, Darren Hart wrote:
> On Tue, Apr 25, 2017 at 12:19:39PM +0200, Jean Delvare wrote:
> > Thanks for the pointer Andy. OK, I can understand the argument of
> > Dmitry that platform-specific quirks do not belong to the device
> > drivers, even though in practice I'm not sure the cost of having a
> > separate platform driver for the purpose is always worth it - depends
> > on how "popular" the device is, I suppose.
> > 
> > But still, this can't justify non-modular platform code that will run
> > on every X86 system out there. Any piece of platform-specific quirks,
> > we should be able to build as a module, otherwise it simply doesn't
> > scale. PCI quirks and such are enough pain already without inventing
> > more flavors of bloat :-(
> 
> Jean makes a good point. I would insist on this if the Kconfig default was y or
> if distros were likely to enable this by default. However, this is for the still
> very rare x86 tablet and is likely to only be enabled for those systems which
> require it.

The problem is that there is no clear line of what hardware openSUSE
kernels should support or not. I don't know if other general purpose
Linux distributions have made any statement on the matter, but we have
not. As a matter of fact, the person in charge of deciding what to do
with new kernel drivers did enable both Silead touchscreen options in
our standard i386 and x86_64 kernels.

There are also people working on getting openSUSE to run on odd
hardware such as the GPD Win, and we have ARM kernels running on
embedded platforms. As X86-based embedded platforms are getting
popular, what sense would it make to support everything from X86
servers to embedded ARM but rule out X86 tablets? Especially when
hybrid laptop/tablet designs are becoming more popular as well. The
same touchscreen device used for pure tablets may be used for hybrid
models tomorrow.

This is one of the reasons why modular drivers are a must. If we enable
them when we shouldn't have, the cost stays low. Of course it would be
better if we could just enable what we really need, but in practice
this is terribly hard to achieve. This is also the reason why I am
actively promoting the mentioning of intended target hardware on new
drivers, to limit the risks of us enabling drivers on kernels that
don't need it.

> (...)
> While the default for Kconfig is n if not explicitly set to m or y, perhaps
> "default n" should be added to TOUCHSCREEN_SILEAD and SILEAD_DMI to make it more
> explicit. I don't know if there is an official preference on "default n"
> statements or not.

I wondered before as well. But given that n is the default default, and
an explicit default is not listed by "make config" nor "make
menuconfig", I can't see the value of "default n". It makes no
difference for the user. In fact my never-ending project list has a
point "Kconfig: kill all default n and add a test to checkpatch so they
don't come back". Chances that I get to that one before retirement are
low though.

I am not convinced that a default value for a device driver makes any
sense in the first place. If you don't need support for the device, you
don't enable the driver, period. I can't see how a default answer can
be relevant. In this specific case, the default answer should be n if
not building a kernel for tablets. But would become y if building a
kernel for tablets. What reason would there be to favor one scenario
over the other?

I believe default values are only useful for driver feature options,
general kernel configuration options, or automatic selection of hidden
options.

-- 
Jean Delvare
SUSE L3 Support
