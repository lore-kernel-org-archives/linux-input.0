From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Tue, 07 Mar 2017 13:51:10 +0200
Message-ID: <1488887470.20145.108.camel@linux.intel.com>
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
         <1488553076.20145.79.camel@linux.intel.com>
         <3be3837a-a57c-e6bf-538b-e135c1b37ff0@redhat.com>
         <1488554609.20145.81.camel@linux.intel.com>
         <693ce7b3-99e9-eb60-b164-50b27294a239@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752039AbdCGLzt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Mar 2017 06:55:49 -0500
In-Reply-To: <693ce7b3-99e9-eb60-b164-50b27294a239@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Mon, 2017-03-06 at 10:31 +0100, Hans de Goede wrote:
> Hi,
> 
> On 03-03-17 16:23, Andy Shevchenko wrote:
> > On Fri, 2017-03-03 at 16:19 +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 03-03-17 15:57, Andy Shevchenko wrote:
> > > > On Thu, 2017-03-02 at 16:34 +0100, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 02-03-17 12:38, Andy Shevchenko wrote:
> > > > > > On Thu, 2017-02-23 at 15:19 +0100, Hans de Goede wrote:
> > > > > > > On 22-02-17 16:52, Andy Shevchenko wrote:
> > > > > > > > On Sun, 2017-02-12 at 11:40 +0100, Hans de Goede wrote:
> > > > > > > > > On 10-02-17 12:52, Hans de Goede wrote:
> > > > > > > > > > On 02-02-17 14:12, Mika Westerberg wrote:
> > > > > > > > > > > On Thu, Feb 02, 2017 at 01:50:58PM +0100, Hans de
> > > > > > > > > > > Goede
> > > > > > > > > > > wrote:
> > > > > Forcing the addition of a connection-id table to all those
> > > > > drivers not only is needless churn / boilerplate, but also
> > > > > gives
> > > > > the
> > > > > false impression that we actually have more info (a valid
> > > > > connection
> > > > > id) then we really have.
> > > > 
> > > > Again, we have no idea what exactly we get if we call
> > > > gpiod_get_index(..., NULL, index); in case of ACPI. It would
> > > > work
> > > > *if
> > > > and only if* we assume that all versions of the same device on
> > > > all
> > > > possible platforms will have *very same* mapping.
> > > > 
> > > > I have heard it's already not true. Check the commit
> > > > 89ab37b489d1
> > > > ("Bluetooth: hci_bcm: Add support for BCM2E95 and BCM2E96").
> > 
> > Any comment / remark on this?
> 
> Looking at that commit, the indxex order is consistent for a single
> device HID/CID but at some point in time the decided to change
> the order for newer HIDs which sucks from a driver pov, but is
> less bad then it could have been (they could have different orders
> for the same HID and we would need to fallback to dmi quirks).
> 

> But I fail to see how this is really relevant for this discussion.

My point is that the chaos with connection ID vs. label will not be
simple suppressed by adding a parameter to API. In some cases it
wouldn't be enough.

> > > > 2) using labels different to connection ID sounds not okay for
> > > > debugging
> > > > purposes (I dunno why we have this done for
> > > > fwnode_get_gpiod_child()
> > > > in
> > > > the first place);
> > > 
> > > Right, which is why the _label variants would not allow a
> > > connection_id
> > > at all using an _label variants implies connection_id == NULL.
> > > 
> > > And using a variant with connection_id argument implies label
> > >   = connection_id.
> > > 
> > > > 3) additionally different labels will not play good in _DSD
> > > > enabled
> > > > case, since we must use connection ID there (we believe firmware
> > > > until
> > > > otherwise is proven).
> > > 
> > > Again, gpios would have a connection_id OR a label, so in
> > > _DSD case only a connection_id.
> > > 
> > > > 4) if some firmwares have different indexes for the same device
> > > > we
> > > > will
> > > > need to have device ID (PCI ID, ... or alike) to _CRS index
> > > > mapping
> > > > anyway in the code.
> > > 
> > > This problem will exist independent of which solution we choose.
> > 
> > Yes.
> > 
> > > > > > 
> > > > > > Mika, Linus, I would really appreciate your input to the
> > > > > > topic:
> > > > > > opinions, critique, ideas, etc.
> > > > > 
> > > > > So my opinion on this is that I prefer the add a label field
> > > > > idea
> > > > > over
> > > > > the everything must have either a connection-id in ACPI or a
> > > > > connection-id-table in the driver.
> > > > 
> > > > As a ultimate workaround it would work, in long-term prospective
> > > > it's
> > > > not a solution.
> > > I believe that this will work fine even in the long run, better
> > > then
> > 
> > See above about bluetooth case.
> > 
> > > forcible adding fake _DSD tables everywhere, see above.
> > 
> > Why are they fake?
> 
> Because they are not coming from the firmware,

They actually are. The problem here is that older firmwares and ACPI
specification lack of naming GPIO resources. So, this information is
complimentary to the existing GPIO resources. It's not fake.

>  as said I believe it
> is better to clearly differentiate between the no-connection-id (so we
> use indexes) and the firmware provides connection-ids cases.

Indexes without label is error prone approach. Sorry, I'm not going to
vote for them. This is explained in the patches I have: we never know
what we get by index. The mapping makes it robust.

It was clearly my mistake to even think in this direction.

> I believe this is better for 2 reasons:
> 
> 1) Cleaner (and less) code for drivers which need to use indexes

Yes and no. Cleaner, indeed, but less code does not always mean less
error prone, more robust, etc.

> 2) It is easier to debug things if it is clear at all levels if we
> are dealing with indexes or connection ids

And my point that adding labels along with connection IDs is a hiding of
a huge abuse of at least ACPI case! It will not get rid of the chaos we
have. And it will make API more confusing.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
