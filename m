From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] Input: ti_am335x_tsc - Mark IRQ as wakeup capable
Date: Tue, 17 May 2016 15:44:13 +0530
Message-ID: <573AEEF5.2040700@ti.com>
References: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
 <1463397984-15766-2-git-send-email-vigneshr@ti.com>
 <20160516194621.GF12752@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160516194621.GF12752@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 05/17/2016 01:16 AM, Dmitry Torokhov wrote:
> On Mon, May 16, 2016 at 04:56:22PM +0530, Vignesh R wrote:
>> On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
>> IRQ as wakeup capable, so that device irq is not disabled during system
>> suspend.
> 
> I would love for platform core to do this for us, like I2C core does.

Ok, I will replicate the same in input_register_device() for input core.

-- 
Regards
Vignesh
