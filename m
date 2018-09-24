From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Date: Mon, 24 Sep 2018 13:20:20 +0300
Message-ID: <20180924102020.GJ11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <CACRpkdZtM4G=4r3m6vLTms9MJFkdiOdPFucebO-Z0Kh-3ws3+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZtM4G=4r3m6vLTms9MJFkdiOdPFucebO-Z0Kh-3ws3+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Input <linux-input@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Linus,

On Fri, Sep 21, 2018 at 08:36:53AM -0700, Linus Walleij wrote:
> On Thu, Sep 20, 2018 at 6:53 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> 
> > The child nodes will change the purpose of the build-in property
> > support. Originally the goal was just to support adding of build-in
> > device properties to real firmware nodes, but things have changed
> > quite a bit from that. These child nodes are purely tied to the
> > build-in device property support, so we should be talking about adding
> > pset type child nodes to pset type parent nodes in the API:
> > fwnode_pset_add_child_node(), or something like that.
> >
> > I'm sorry to be a bit of pain in the butt with this. The build-in
> > property support is a hack, it always was. A useful hack, but hack
> > nevertheless. That means we need to be extra careful when expanding
> > it, like here.
> 
> I dunno how we got to here, what I tried to solve and Dmitry tries
> to make more general is converting old boardfiles to use fwnode, because
> I initially tried to just support gpio descriptors from board files.

I understand that, but what I'm trying to say is that the solution for
the child nodes is not generic enough. I'll try to explain below.

> If boardfiles is what you mean with "build-in property support" I don't
> know, it predates both device tree and ACPI and any other hardware
> descriptions on the ARM architecture, from the perspective of these
> systems things are fine and the hardware description languages
> are the novelty...

Rafael talked about "build-in properties" at one point, and I just
started using that expression after that, but it's probable not the
best term to describe this thing.

But please note that we are not talking about only static information
with these property sets. They can be populated dynamically as well,
so this kind of extensions must consider and support that. On top of
board files we need to consider things like glue and probing drivers
and even buses in some cases.

> But I guess you know because you worked with OMAP :)
> 
> So there is something I don't understand here.

Sorry for the poor choice of words on my behalf. I guess I'm not
explaining my point properly. Let me try again.

So I'm seeing a case that this solution does not seem to be able to
support, but ultimately it will need to do so: with USB ports we are
going to need to be able to assign a device to the child nodes that
represent those ports.

To be honest, normally I would not care about that, and I would simply
wait for this to go into mainline, and then propose a modification to
it so it can also support that other case.

However, this time I feel that we should not do that. The solution for
the child nodes should be implemented so that it can support all the
known cases from the beginning. The reason for that is because I fear
that we'll end up having a pile of ad-hoc style solutions, each
solving an individual problem, and a whole lot of duplicated stuff for
these property sets. In the end we will have spaghetti with meatballs
that nobody is able fully understand nor handle. And I really see a
strong possibility for that to happen here.


Thanks,

-- 
heikki
