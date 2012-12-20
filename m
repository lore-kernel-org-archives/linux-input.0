From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] RFC: input: Extend matrix-keypad device tree binding
Date: Thu, 20 Dec 2012 13:41:47 -0800
Message-ID: <CAPnjgZ0baa73BEJ8VGW=OMGSe0k=FCz4wnCwv95R8VcGUmoRww@mail.gmail.com>
References: <1356035039-21653-1-git-send-email-sjg@chromium.org>
	<20121220211323.GA24981@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:32844 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2LTVlr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 16:41:47 -0500
Received: by mail-oa0-f43.google.com with SMTP id k1so3933380oag.2
        for <linux-input@vger.kernel.org>; Thu, 20 Dec 2012 13:41:47 -0800 (PST)
In-Reply-To: <20121220211323.GA24981@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Roland Stigge <stigge@antcom.de>, linux-doc@vger.kernel.org, Vincent Palatin <vpalatin@chromium.org>, Wolfram Sang <w.sang@pengutronix.de>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Luigi Semenzato <semenzato@chromium.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>

Hi Dmitry,

On Thu, Dec 20, 2012 at 1:13 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Simon,
>
> On Thu, Dec 20, 2012 at 12:23:58PM -0800, Simon Glass wrote:
>>
>> For the key repeat feature, we need to set this after the input device
>> is registered. So we would need to add a matrix_keypad_setup_input() or
>> similar to be called by the driver after input_register_device(). I am
>> less keen on that idea, and less again on the alternative of perhaps
>> matrix_keypad_register_device() which does input_register_device() and
>> then sets up the key repeat. Thoughts?
>
> No, we already have default rate and delay. Unless you can prove that
> random firmware writer's idea of appropriate delay and rate is better
> then current default - for everyone - and then can successfully argue
> that that obviously best delay/rate combo should not replace the current
> one but stay only in DT bindings, let's keep relying on users adjusting
> their own preferences from respective desktop environments/console/etc.

Seems reasonable. My only comment on this is that the device tree
comes from kernel, not firmware. This lets us configure an embedded
system easily (where the user may not have access to repeat rate
preferences).

Grant are you OK with me just dropping the repeat settings, and
keeping the other two? If so I will respin the patch.

Regards,
Simon

>
> Thanks.
>
> --
> Dmitry
