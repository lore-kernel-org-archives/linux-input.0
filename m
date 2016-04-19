From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] input: twl6040-vibra: add handler to unregister
 input if module is removed
Date: Tue, 19 Apr 2016 00:57:05 -0700
Message-ID: <20160419075705.GA13933@dtor-ws>
References: <cover.1461009340.git.hns@goldelico.com>
 <89f53877b821049c789256dd1b0c0b1dbb604de9.1461009340.git.hns@goldelico.com>
 <20160418211257.GA1006@dtor-ws>
 <E0529B06-0584-49B9-976A-368875810385@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E0529B06-0584-49B9-976A-368875810385@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 19, 2016 at 09:33:10AM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 18.04.2016 um 23:12 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > On Mon, Apr 18, 2016 at 09:55:38PM +0200, H. Nikolaus Schaller wrote:
> >> commit 1f9e1470ab34 ("Input: twl6040-vibra - use devm functions")
> >> 
> >> converted everything to devm but we still need to call
> >> input_unregister_device(info->input_dev)
> > 
> > No, this is not needed, because devm-managed input devices will be
> > unregistered automatically.
> 
> Well, it would, if the current driver would use devm for registration. But it appears not to do it that way (line 375):
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/input/misc/twl6040-vibra.c?id=refs/tags/v4.6-rc4#n375
> 
> So we either have to fix line 375 or add the proposed explicit unregister call.
> 
> Research shows me that you did propose devm_input_register_device() some years ago but this API was never included:
> 
> https://lkml.org/lkml/2012/10/29/855

That's because we have what I mentioned in _OR_ portion of that email:

/**
 * devm_input_allocate_device - allocate managed input device
 * @dev: device owning the input device being created
 *
 * Returns prepared struct input_dev or %NULL.
 *
 * Managed input devices do not need to be explicitly unregistered or
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * freed as it will be done automatically when owner device unbinds from
 * its driver (or binding fails). Once managed input device is allocated,
 * it is ready to be set up and registered in the same fashion as regular
 * input device. There are no special devm_input_device_[un]register()
 * variants, regular ones work with both managed and unmanaged devices,
 * should you need them. In most cases however, managed input device need
 * not be explicitly unregistered or freed.
 *
 * NOTE: the owner device is set up as parent of input device and users
 * should not override it.
 */

Thanks.

-- 
Dmitry
