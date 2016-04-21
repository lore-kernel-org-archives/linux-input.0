From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] Input: synaptics-rmi4: Support regulator supplies
Date: Thu, 21 Apr 2016 15:37:55 -0700
Message-ID: <20160421223755.GB3202@tuxbot>
References: <1459357049-5608-1-git-send-email-bjorn.andersson@linaro.org>
 <20160331181905.GJ39098@dtor-ws>
 <20160331191421.GC8929@tuxbot>
 <56FDD345.20605@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56FDD345.20605@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>
List-Id: linux-input@vger.kernel.org

On Thu 31 Mar 18:47 PDT 2016, Andrew Duggan wrote:

> On 03/31/2016 12:14 PM, Bjorn Andersson wrote:
> >On Thu 31 Mar 11:19 PDT 2016, Dmitry Torokhov wrote:
> >
> >>Hi Bjorn,
> >>
> >>On Wed, Mar 30, 2016 at 09:57:29AM -0700, Bjorn Andersson wrote:
> >>>From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> >>>
> >>>Support the two supplies - vdd and vio - to make it possible to control
> >>>power to the Synaptics chip.
> >>>
> >>>Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> >>>Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>---
> >>>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  7 ++++
> >>>  drivers/input/rmi4/rmi_i2c.c                       | 45 ++++++++++++++++++++++
> >>Would not we need pretty much the same changes for SPI devices? Can this
> >>be done in core?
> >>
> >Yes, I believe it needs the exact same steps.
> >
> >I did a initial quick hack on v1 of the patchset and back then it was
> >possible, when I rebased it a few weeks back I kept ending up in getting
> >interrupts with the power off.
> >
> >Looking at the code this is likely because in the resume paths the IRQ
> >is enabled before we jump to rmi_driver_resume(), so putting this in the
> >core I ended up calling rmi_process_interrupt_requests() before powering
> >up the chip.
> 
> Actually, I don't think the irq needs to be enabled before calling
> rmi_driver_resume(). Typically, the functions are just reading and writing
> to registers and do not need to handle interrupts. We could probably call to
> rmi_driver_resume() before enabling the irq. I can double check that there
> are not any exceptions to this.
> 

I finally got back to giving this a spin.

The problem is that we register the transport device with the driver,
which triggers the rmi_driver probe() which resolves the resources. We
then continue on and call rmi_i2c_init_irq() which will (implicitly)
enable the irq. So if the rmi_driver probe() does not finish in a serial
fashion we will enable interrupts before we have fully initialized the
core.

I don't know if this causes other issues, but with the required delay
after enabling the regulators we always get an interrupt before the
rmi_driver probe() function is finished.

> I have also considered adding a power callback to the core so that the
> transport drivers can set the power independently of suspend and resume. One
> example would be to shut off power to a touchpad if a mouse is connected. If
> we do need to have the irq enabled before calling rmi_driver_resume() we
> could still move regulator support to the core and call the power callback
> from the transport drivers.
> 

I see no (sane) way of waiting for the rmi_driver to finish probeing;
there could be cases where it's powered by a regulator (or reset gpio)
that is not yet probed. EPROBE_DEFER will handle this, but we can't wait
for it in the transport driver.


I therefor think these physical resources should be handled in the
context of the transport layer, to make sure we don't have temporal
dependencies to the other layers.

Or we should not have the rmi_driver as a separate device driver at all
- it could be a "library" that runs in the context of the transport
device.

Regards,
Bjorn
