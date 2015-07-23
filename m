From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Thu, 23 Jul 2015 13:10:41 -0400
Message-ID: <20150723171041.GA14941@mail.corp.redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56498 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977AbbGWRKo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 13:10:44 -0400
Content-Disposition: inline
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 23 2015 or thereabouts, Benjamin Tissoires wrote:
> Hi Dmitry,
> 
> As mentioned in the thread on linux-i2c[1], I am making good progress on the
> RMI4 SMBus implementation [2].
> I am still missing the PS/2 pass-through function but I have an intern (Chandler,
> CC-ed) working on that. Also, I believe forcepads could used RMI4 but we will
> have to implement the ForcePad feature first :)
> 
> Instead of waiting for both the i2c SMBus feature to be validated and the driver
> to be feature equivalent (greater actually because it tracks 5 fingers instead
> of 1 and a half), I am sending those first fixes to you for the branch
> synaptics-rmi4.
> 
> Andrew, Christopher, I am not 100% sure regarding the Signed-off and acked-by
> for the implementation of function 30 and the SMBus transport layer in my tree
> (I smashed a bunch of commits so the result differs from what you saw last time).
> Could you validate this?
> 
> Cheers,
> Benjamin

Dmitry, the Sony guys are currently working on upstreaming their work.
Their Xperia are using a Synaptics I2C touchscreen. They are able to
boot with an upstream kernel a lot of parts now, and they will
eventually need the upstream touch controller.

So, can you consider merging these patches in your synaptics-rmi4 branch
so they have the same features we are working on?

Right now we will be missing for them the device tree implementation in
rmi_i2c.c, but that is something we can work around.

Thanks and sorry for being pushing.

Cheers,
Benjamin

> 
> 
> [1] http://www.spinics.net/lists/linux-i2c/msg20241.html
> [2] https://github.com/bentiss/linux branch synaptics-rmi4-smbus-v4.1-15-06-23
> 
> Benjamin Tissoires (11):
>   Input: synaptics-rmi4 - embed the function modules in rmi_core
>   Input: synaptics-rmi4 - add a common input device in rmi_driver
>   Input: synaptics-rmi4 - explicitly request polling when needed
>   Input: synaptics-rmi4 - prevent oopses when irq arrives while the
>     device is not bound
>   Input: synaptics-rmi4 - call rmi_driver_process_config_requests in
>     enable_sensor
>   Input: synaptics-rmi4 - add a reset callback
>   Input: synaptics-rmi4 - f11: fix bitmap irq check
>   Input: synaptics-rmi4 - f11: use the unified input node if available
>   Input: synaptics-rmi4 - f11: clean up rmi_f11_finger_handler
>   Input: synaptics-rmi4 - f11: allow the top software button property to
>     be set
>   Input: synaptics-rmi4 - f11: add support for kernel tracking
> 
>  drivers/input/rmi4/Kconfig      |   5 +-
>  drivers/input/rmi4/Makefile     |   2 +-
>  drivers/input/rmi4/rmi_bus.c    |  11 +-
>  drivers/input/rmi4/rmi_bus.h    |   1 +
>  drivers/input/rmi4/rmi_driver.c | 146 +++++++++++++++-------
>  drivers/input/rmi4/rmi_driver.h |  17 +++
>  drivers/input/rmi4/rmi_f01.c    |   7 ++
>  drivers/input/rmi4/rmi_f11.c    | 262 ++++++++++++++++++++++++++--------------
>  include/linux/rmi.h             |  22 +++-
>  9 files changed, 326 insertions(+), 147 deletions(-)
> 
> -- 
> 2.4.3
> 
