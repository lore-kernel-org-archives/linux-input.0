From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Sun, 12 Nov 2017 13:12:35 +0100
Message-ID: <20171112121235.GO11226@localhost>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111175059.lwfhw2wdhlj5yxhc@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171111175059.lwfhw2wdhlj5yxhc@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

[ +CC: Lee, Rob and device-tree list ]

On Sat, Nov 11, 2017 at 09:50:59AM -0800, Dmitry Torokhov wrote:
> On Sat, Nov 11, 2017 at 04:43:37PM +0100, Johan Hovold wrote:
> > A helper purported to look up a child node based on its name was using
> > the wrong of-helper and ended up prematurely freeing the parent of-node
> > while searching the whole device tree depth-first starting at the parent
> > node.
> 
> Ugh, this all is pretty ugly business. Can we teach MFD to allow
> specifying firmware node to be attached to the platform devices it
> creates in mfd_add_device() so that the leaf drivers simply call
> device_property_read_XXX() on their own device and not be bothered with
> weird OF refcount issues or what node they need to locate and parse?

Yeah, that may have helped. You can actually specify a compatible string
in struct mfd_cell today which does make mfd_add_device() associate a
matching child node.

Some best practice regarding how to deal with MFD and device tree would
be good to determine and document too. For example, when should
of_platform_populate() be used in favour of mfd_add_device()?
And how best to deal with sibling nodes, which is part of the problem
here (I think the mfd should have provided a flag rather than having
subdrivers deal with sibling nodes, for example).

That said, driver authors using the wrong of-helper could possibly have
been avoided by amending the kernel docs (I'll do that as a follow up),
but once these incorrect usages get in, only review can prevent them
from being reproduced through copy-paste coding.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
