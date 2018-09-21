From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes for
 legacy boards
Date: Fri, 21 Sep 2018 08:36:53 -0700
Message-ID: <CACRpkdZtM4G=4r3m6vLTms9MJFkdiOdPFucebO-Z0Kh-3ws3+g@mail.gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com> <20180920135348.GF11965@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920135348.GF11965@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Input <linux-input@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 20, 2018 at 6:53 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> The child nodes will change the purpose of the build-in property
> support. Originally the goal was just to support adding of build-in
> device properties to real firmware nodes, but things have changed
> quite a bit from that. These child nodes are purely tied to the
> build-in device property support, so we should be talking about adding
> pset type child nodes to pset type parent nodes in the API:
> fwnode_pset_add_child_node(), or something like that.
>
> I'm sorry to be a bit of pain in the butt with this. The build-in
> property support is a hack, it always was. A useful hack, but hack
> nevertheless. That means we need to be extra careful when expanding
> it, like here.

I dunno how we got to here, what I tried to solve and Dmitry tries
to make more general is converting old boardfiles to use fwnode, because
I initially tried to just support gpio descriptors from board files.

If boardfiles is what you mean with "build-in property support" I don't
know, it predates both device tree and ACPI and any other hardware
descriptions on the ARM architecture, from the perspective of these
systems things are fine and the hardware description languages
are the novelty...

But I guess you know because you worked with OMAP :)

So there is something I don't understand here.

Yours,
Linus Walleij
