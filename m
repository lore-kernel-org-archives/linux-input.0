From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] Input: twl6040-vibra: fix child-node lookup
Date: Mon, 13 Nov 2017 10:16:29 +0100
Message-ID: <20171113091629.GQ11226@localhost>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111154339.16875-2-johan@kernel.org>
 <91A591C4-D6BD-462D-B81E-224DB268EDDB@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <91A591C4-D6BD-462D-B81E-224DB268EDDB@goldelico.com>
Sender: stable-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 13, 2017 at 08:30:53AM +0100, H. Nikolaus Schaller wrote:
> Hi Johan,
> 
> > Am 11.11.2017 um 16:43 schrieb Johan Hovold <johan@kernel.org>:
> > 
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
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: H. Nikolaus Schaller <hns@goldelico.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Tested-By: H. Nikolaus Schaller <hns@goldelico.com>	(on Pyra OMAP5 hardware)
> 
> I also tested your twl4030-vibra patch on GTA04.
> 
> No regressions observed.

Thanks for testing.

Johan
