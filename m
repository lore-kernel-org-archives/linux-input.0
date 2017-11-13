From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] Input: twl6040-vibra: fix child-node lookup
Date: Mon, 13 Nov 2017 15:46:37 +0100
Message-ID: <20171113144637.GW11226@localhost>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111154339.16875-2-johan@kernel.org>
 <e2d4212c-cb75-d98a-caa1-b1d7b2f165f2@ti.com>
 <20171113141932.GV11226@localhost>
 <94DB4354-C943-47B1-8D5A-A6AB615F2B9C@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <94DB4354-C943-47B1-8D5A-A6AB615F2B9C@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 13, 2017 at 03:39:48PM +0100, H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 13.11.2017 um 15:19 schrieb Johan Hovold <johan@kernel.org>:
> > 
> > On Mon, Nov 13, 2017 at 04:10:52PM +0200, Peter Ujfalusi wrote:
> > 
> >> On 2017-11-11 17:43, Johan Hovold wrote:
> >>> Fix child-node lookup during probe, which ended up searching the whole
> >>> device tree depth-first starting at parent rather than just matching on
> >>> its children.
> >>> 
> >>> Later sanity checks on node properties (which would likely be missing)
> >>> should prevent this from causing much trouble however, especially as the
> >>> original premature free of the parent node has already been fixed
> >>> separately (but that "fix" was apparently never backported to stable).
> >>> 
> >>> Fixes: e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")
> >>> Fixes: c52c545ead97 ("Input: twl6040-vibra - fix DT node memory management")
> >>> Cc: stable <stable@vger.kernel.org>     # 3.6
> >> 
> >> Note that of_get_child_by_name() is not present in 3.6, this was the
> >> reason the original implementation was using of_find_node_by_name()
> > 
> > Ah, ok. So the lookup would have needed to be open-coded using
> > for_each_child_of_node() back then, or if anyone wants to backport any
> > of these fixes to before v3.7.
> 
> Just let me note that intensive DT support of OMAP4&5/ARM based boards didn't
> start before ca. v3.13. So it is very unlikely that anyone is running a twl6040
> based board with older kernels. It is different for twl4030/omap3 which was
> used by several devices (N900, Pandora, GTA04) back in 2.6. So I don't
> see a reason to backport this change to any kernel older than 3.16.

Right, and we don't really have any active stable trees going that far
back either (possibly with the exception of 3.2, but those guys are on
their own ;) ).

Thanks,
Johan
