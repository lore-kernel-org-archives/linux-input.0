From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Mon, 13 Nov 2017 09:11:44 +0000
Message-ID: <20171113091144.5oz77shbu4oupoy7@dell>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111175059.lwfhw2wdhlj5yxhc@dtor-ws>
 <20171112121235.GO11226@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171112121235.GO11226@localhost>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Marek Belisko <marek@goldelico.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 12 Nov 2017, Johan Hovold wrote:

> [ +CC: Lee, Rob and device-tree list ]
> 
> On Sat, Nov 11, 2017 at 09:50:59AM -0800, Dmitry Torokhov wrote:
> > On Sat, Nov 11, 2017 at 04:43:37PM +0100, Johan Hovold wrote:
> > > A helper purported to look up a child node based on its name was using
> > > the wrong of-helper and ended up prematurely freeing the parent of-node
> > > while searching the whole device tree depth-first starting at the parent
> > > node.
> > 
> > Ugh, this all is pretty ugly business. Can we teach MFD to allow
> > specifying firmware node to be attached to the platform devices it
> > creates in mfd_add_device() so that the leaf drivers simply call
> > device_property_read_XXX() on their own device and not be bothered with
> > weird OF refcount issues or what node they need to locate and parse?

If a child compatible is provided, we already set the child's
of_node.  It's then up to the driver (set) author(s) to use it in the
correct manner. 

> Yeah, that may have helped. You can actually specify a compatible string
> in struct mfd_cell today which does make mfd_add_device() associate a
> matching child node.
> 
> Some best practice regarding how to deal with MFD and device tree would
> be good to determine and document too. For example, when should
> of_platform_populate() be used in favour of mfd_add_device()?

When the device supports DT and its entire hierarchical layout, along
with all of its attributes can be expressed in DT.

> And how best to deal with sibling nodes, which is part of the problem
> here (I think the mfd should have provided a flag rather than having
> subdrivers deal with sibling nodes, for example).

I disagree.  The only properties the MFD (parent) driver is interested
in is ones which are shared across multiple child devices.
*Everything* which pertains to only a single child device should be
handled by its accompanying driver. 

> That said, driver authors using the wrong of-helper could possibly have
> been avoided by amending the kernel docs (I'll do that as a follow up),
> but once these incorrect usages get in, only review can prevent them
> from being reproduced through copy-paste coding.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
