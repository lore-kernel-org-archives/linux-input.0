From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Fri, 03 Mar 2017 16:57:56 +0200
Message-ID: <1488553076.20145.79.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
         <20170122222015.GA31009@dtor-ws>
         <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
         <20170201174257.GE40045@dtor-ws> <20170202104130.GJ2053@lahna.fi.intel.com>
         <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
         <20170202121018.GN2053@lahna.fi.intel.com>
         <20170202123206.GP2053@lahna.fi.intel.com>
         <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
         <20170202131251.GQ2053@lahna.fi.intel.com>
         <ca2868cf-8c7f-5cdc-e773-ff326dd0cdc6@redhat.com>
         <3f433773-27ba-8d07-3209-6df71d6d4b33@redhat.com>
         <1487778778.20145.22.camel@linux.intel.com>
         <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
         <1488454727.20145.71.camel@linux.intel.com>
         <e4dfd35b-cf7f-93bb-fb88-fb8d412d922a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20402 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751563AbdCCPD5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 3 Mar 2017 10:03:57 -0500
In-Reply-To: <e4dfd35b-cf7f-93bb-fb88-fb8d412d922a@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Thu, 2017-03-02 at 16:34 +0100, Hans de Goede wrote:
> Hi,
> 
> On 02-03-17 12:38, Andy Shevchenko wrote:
> > On Thu, 2017-02-23 at 15:19 +0100, Hans de Goede wrote:
> > > On 22-02-17 16:52, Andy Shevchenko wrote:
> > > > On Sun, 2017-02-12 at 11:40 +0100, Hans de Goede wrote:
> > > > > On 10-02-17 12:52, Hans de Goede wrote:
> > > > > > On 02-02-17 14:12, Mika Westerberg wrote:
> > > > > > > On Thu, Feb 02, 2017 at 01:50:58PM +0100, Hans de Goede
> > > > > > > wrote:

> > Now, since we have _DSD and specification for mapping GPIO resources
> > to
> > names (connection IDs!) we should *not* allow drivers to put
> > anything
> > they want there.
> > 
> > It means that any driver that is supposed to be used on ACPI-based
> > platfroms with *or* without _DSD should provide a mapping table for
> > the
> > latter case.
> > 
> > Other solution is to extend GPIO API to have almost all same set of
> > calls with an additional field "label" as it was recently done for
> > fwnode_get_gpiod_child() (whatever its name nowadays). I don't think
> > this is best (though allows less intrusion to the existing drivers)
> > way
> > because (see above) an heavy abuse in the kernel of connection ID
> > meaning for ACPI-enabled platforms.
> 
> Hmm, I actually like the label vs connection-id distinction there
> are many ACPI device "bindings" where we simply get an index into
> the ACPI resource table for the device as only way to get the right
> gpio. 

Yeah, and we will be screwed if the index matrix is changed per device
ID / board.

> Forcing the addition of a connection-id table to all those
> drivers not only is needless churn / boilerplate, but also gives the
> false impression that we actually have more info (a valid connection
> id) then we really have.

Again, we have no idea what exactly we get if we call
gpiod_get_index(..., NULL, index); in case of ACPI. It would work *if
and only if* we assume that all versions of the same device on all
possible platforms will have *very same* mapping.

I have heard it's already not true. Check the commit 89ab37b489d1
("Bluetooth: hci_bcm: Add support for BCM2E95 and BCM2E96").

> So my vote goes to adding a label field, and passing NULL as
> connection id in these drivers, rather then adding a fake connection-
> id
> table.

There are also few concerns:

1) it would be often passed the same string as connection ID and label
(okay, meaning we need like two functions per each in current API,
something like gpiod_get_*label(dev, con_id, ..., label);
and gpiod_get_label_nocid(dev, ..., label); besides the former ones);

2) using labels different to connection ID sounds not okay for debugging
purposes (I dunno why we have this done for fwnode_get_gpiod_child() in
the first place);

3) additionally different labels will not play good in _DSD enabled
case, since we must use connection ID there (we believe firmware until
otherwise is proven).

4) if some firmwares have different indexes for the same device we will
need to have device ID (PCI ID, ... or alike) to _CRS index mapping
anyway in the code.

> > > TL;DR: this approach seems like a lot of extra work / churn and
> > > boilerplate code in drivers for no gain.
> > 
> > Yes, because of current *abuse* of connection ID field in ACPI case.
> > 
> > > Can't we please just simply keep the fallback as-is when a driver
> > > calls gpiod_get_index rather then gpiod_get ? That seems like a
> > > lot simpler and cleaner solution to me.
> > 
> > No. We can't.
> > 
> > This is explained by documentation addon in:
> > 
> > https://bitbucket.org/andy-shev/linux/commits/27f4d31dcf7997613dfb0d
> > b1df
> > 4182673826646c
> > 
> > (with flag removed approach)
> > https://bitbucket.org/andy-shev/linux/commits/ab99ade0bab99983f63bf1
> > 7093
> > dacccd30e349cc
> > 
> > and in commit message
> > 
> > https://bitbucket.org/andy-shev/linux/commits/3a50bf0c17df18df6758a3
> > a139
> > 0075613daee56f
> > 
> > > *) Or maybe even a flag that it is the index which should be
> > > looked at
> > > and not the name, but that may break some existing users
> > 
> > Mika, Linus, I would really appreciate your input to the topic:
> > opinions, critique, ideas, etc.
> 
> So my opinion on this is that I prefer the add a label field idea over
> the everything must have either a connection-id in ACPI or a
> connection-id-table in the driver.

As a ultimate workaround it would work, in long-term prospective it's
not a solution.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
