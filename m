From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] Input: twl6040-vibra: fix child-node lookup
Date: Mon, 13 Nov 2017 15:19:32 +0100
Message-ID: <20171113141932.GV11226@localhost>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111154339.16875-2-johan@kernel.org>
 <e2d4212c-cb75-d98a-caa1-b1d7b2f165f2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2d4212c-cb75-d98a-caa1-b1d7b2f165f2@ti.com>
Sender: stable-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 13, 2017 at 04:10:52PM +0200, Peter Ujfalusi wrote:

> On 2017-11-11 17:43, Johan Hovold wrote:
> > Fix child-node lookup during probe, which ended up searching the whole
> > device tree depth-first starting at parent rather than just matching on
> > its children.
> > 
> > Later sanity checks on node properties (which would likely be missing)
> > should prevent this from causing much trouble however, especially as the
> > original premature free of the parent node has already been fixed
> > separately (but that "fix" was apparently never backported to stable).
> > 
> > Fixes: e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")
> > Fixes: c52c545ead97 ("Input: twl6040-vibra - fix DT node memory management")
> > Cc: stable <stable@vger.kernel.org>     # 3.6
> 
> Note that of_get_child_by_name() is not present in 3.6, this was the
> reason the original implementation was using of_find_node_by_name()

Ah, ok. So the lookup would have needed to be open-coded using
for_each_child_of_node() back then, or if anyone wants to backport any
of these fixes to before v3.7.

Thanks,
Johan
