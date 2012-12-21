From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] RFC: input: Extend matrix-keypad device tree binding
Date: Fri, 21 Dec 2012 10:47:52 -0600
Message-ID: <50D492B8.9030205@gmail.com>
References: <1356035039-21653-1-git-send-email-sjg@chromium.org> <20121220211323.GA24981@core.coreip.homeip.net> <CAPnjgZ0baa73BEJ8VGW=OMGSe0k=FCz4wnCwv95R8VcGUmoRww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPnjgZ0baa73BEJ8VGW=OMGSe0k=FCz4wnCwv95R8VcGUmoRww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Roland Stigge <stigge@antcom.de>, Vincent Palatin <vpalatin@chromium.org>, linux-doc@vger.kernel.org, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Luigi Semenzato <semenzato@chromium.org>, Rob Herring <rob.herring@calxeda.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-input@vger.kernel.org

On 12/20/2012 03:41 PM, Simon Glass wrote:
> Hi Dmitry,
> 
> On Thu, Dec 20, 2012 at 1:13 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> Hi Simon,
>>
>> On Thu, Dec 20, 2012 at 12:23:58PM -0800, Simon Glass wrote:
>>>
>>> For the key repeat feature, we need to set this after the input device
>>> is registered. So we would need to add a matrix_keypad_setup_input() or
>>> similar to be called by the driver after input_register_device(). I am
>>> less keen on that idea, and less again on the alternative of perhaps
>>> matrix_keypad_register_device() which does input_register_device() and
>>> then sets up the key repeat. Thoughts?
>>
>> No, we already have default rate and delay. Unless you can prove that
>> random firmware writer's idea of appropriate delay and rate is better
>> then current default - for everyone - and then can successfully argue
>> that that obviously best delay/rate combo should not replace the current
>> one but stay only in DT bindings, let's keep relying on users adjusting
>> their own preferences from respective desktop environments/console/etc.
> 
> Seems reasonable. My only comment on this is that the device tree
> comes from kernel, not firmware. This lets us configure an embedded
> system easily (where the user may not have access to repeat rate
> preferences).

Maybe for your case, but in general the DT is not tied to the kernel.

> Grant are you OK with me just dropping the repeat settings, and
> keeping the other two? If so I will respin the patch.
> 

One comment is these properties are already defined for omap. You should
delete them from omap-keypad.txt and refer to this.

Rob

> Regards,
> Simon
> 
>>
>> Thanks.
>>
>> --
>> Dmitry
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
