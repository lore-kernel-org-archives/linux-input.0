From: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH] Input: synaptics-rmi4: Support regulator supplies
Date: Thu, 5 May 2016 13:55:32 -0700
Message-ID: <572BB344.6030100@synaptics.com>
References: <1459357049-5608-1-git-send-email-bjorn.andersson@linaro.org>
 <20160331181905.GJ39098@dtor-ws> <20160331191421.GC8929@tuxbot>
 <56FDD345.20605@synaptics.com> <20160421223755.GB3202@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160421223755.GB3202@tuxbot>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Christopher Heiny <cheiny-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Bjorn,

On 04/21/2016 03:37 PM, Bjorn Andersson wrote:
> On Thu 31 Mar 18:47 PDT 2016, Andrew Duggan wrote:
>
>> On 03/31/2016 12:14 PM, Bjorn Andersson wrote:
>>> On Thu 31 Mar 11:19 PDT 2016, Dmitry Torokhov wrote:
>>>
>>>> Hi Bjorn,
>>>>
>>>> On Wed, Mar 30, 2016 at 09:57:29AM -0700, Bjorn Andersson wrote:
>>>>> From: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
>>>>>
>>>>> Support the two supplies - vdd and vio - to make it possible to control
>>>>> power to the Synaptics chip.
>>>>>
>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>> ---
>>>>>   .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  7 ++++
>>>>>   drivers/input/rmi4/rmi_i2c.c                       | 45 ++++++++++++++++++++++
>>>> Would not we need pretty much the same changes for SPI devices? Can this
>>>> be done in core?
>>>>
>>> Yes, I believe it needs the exact same steps.
>>>
>>> I did a initial quick hack on v1 of the patchset and back then it was
>>> possible, when I rebased it a few weeks back I kept ending up in getting
>>> interrupts with the power off.
>>>
>>> Looking at the code this is likely because in the resume paths the IRQ
>>> is enabled before we jump to rmi_driver_resume(), so putting this in the
>>> core I ended up calling rmi_process_interrupt_requests() before powering
>>> up the chip.
>> Actually, I don't think the irq needs to be enabled before calling
>> rmi_driver_resume(). Typically, the functions are just reading and writing
>> to registers and do not need to handle interrupts. We could probably call to
>> rmi_driver_resume() before enabling the irq. I can double check that there
>> are not any exceptions to this.
>>
> I finally got back to giving this a spin.
>
> The problem is that we register the transport device with the driver,
> which triggers the rmi_driver probe() which resolves the resources. We
> then continue on and call rmi_i2c_init_irq() which will (implicitly)
> enable the irq. So if the rmi_driver probe() does not finish in a serial
> fashion we will enable interrupts before we have fully initialized the
> core.
>
> I don't know if this causes other issues, but with the required delay
> after enabling the regulators we always get an interrupt before the
> rmi_driver probe() function is finished.

I have not observed any issues related to timing, but it looks like on 
the systems which I have tested on rmi_driver() seems to be completing 
synchronously before the init_irq() call. I was making the assumption 
that rmi_driver() would have completed by the time 
rmi_register_transport_device() returned. But, based on your description 
and looking into the base driver code I see that the probe can be 
deferred and that assumption isn't always true.

>> I have also considered adding a power callback to the core so that the
>> transport drivers can set the power independently of suspend and resume. One
>> example would be to shut off power to a touchpad if a mouse is connected. If
>> we do need to have the irq enabled before calling rmi_driver_resume() we
>> could still move regulator support to the core and call the power callback
>> from the transport drivers.
>>
> I see no (sane) way of waiting for the rmi_driver to finish probeing;
> there could be cases where it's powered by a regulator (or reset gpio)
> that is not yet probed. EPROBE_DEFER will handle this, but we can't wait
> for it in the transport driver.

Do we need to wait for rmi_driver to finish probing? What about setting 
a flag at the end of rmi_driver_probe() which 
rmi_process_interrupt_requests() can check before processing interrupts. 
If rmi_driver hasn't finished probing it could just return.

>
> I therefor think these physical resources should be handled in the
> context of the transport layer, to make sure we don't have temporal
> dependencies to the other layers.

I'm fine with enabling the regulators in the transport driver's probe 
function before calling rmi_register_transport_device() to make sure the 
device is powered on. What about exporting common functions from 
rmi_driver.c which implement common regulator functionality which can 
then be called by the transports? To avoid duplication between rmi_i2c 
and rmi_spi.

> Or we should not have the rmi_driver as a separate device driver at all
> - it could be a "library" that runs in the context of the transport
> device.

I would have to look into this further to understand the impact on the 
bus architecture of merging the physical and transport drivers. But, I 
don't think this particular issue warrants such a change. But, if having 
them as separate devices does cause a lot of other problems, it  might 
be possible to merge them.

Andrew

> Regards,
> Bjorn

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
