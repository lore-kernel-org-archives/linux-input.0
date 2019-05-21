From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH v2 0/4] Input: mpr121-polled: Add polled driver for
 MPR121
Date: Tue, 21 May 2019 08:51:17 +0200
Message-ID: <ef172b24-cd27-5bb0-d8b1-718f835d0647@ysoft.com>
References: <1558098773-47416-1-git-send-email-michal.vokac@ysoft.com>
 <20190521053705.GI183429@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521053705.GI183429@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On 21. 05. 19 7:37, Dmitry Torokhov wrote:
> Hi Michal,
> 
> On Fri, May 17, 2019 at 03:12:49PM +0200, Michal Vokáč wrote:
>> Hi,
>>
>> I have to deal with a situation where we have a custom i.MX6 based
>> platform in production that uses the MPR121 touchkey controller.
>> Unfortunately the chip is connected using only the I2C interface.
>> The interrupt line is not used. Back in 2015 (Linux v3.14), my
>> colleague modded the existing mpr121_touchkey.c driver to use polling
>> instead of interrupt.
>>
>> For quite some time yet I am in a process of updating the product from
>> the ancient Freescale v3.14 kernel to the latest mainline and pushing
>> any needed changes upstream. The DT files for our imx6dl-yapp4 platform
>> already made it into v5.1-rc.
>>
>> I rebased and updated our mpr121 patch to the latest mainline.
>> It is created as a separate driver, similarly to gpio_keys_polled.
>>
>> The I2C device is quite susceptible to ESD. An ESD test quite often
>> causes reset of the chip or some register randomly changes its value.
>> The [PATCH 3/4] adds a write-through register cache. With the cache
>> this state can be detected and the device can be re-initialied.
>>
>> The main question is: Is there any chance that such a polled driver
>> could be accepted? Is it correct to implement it as a separate driver
>> or should it be done as an option in the existing driver? I can not
>> really imagine how I would do that though..
>>
>> There are also certain worries that the MPR121 chip may no longer be
>> available in nonspecifically distant future. In case of EOL I will need
>> to add a polled driver for an other touchkey chip. May it be already
>> in mainline or a completely new one.
> 
> I think that my addition of input_polled_dev was ultimately a wrong
> thing to do. I am looking into enabling polling mode for regular input
> devices as we then can enable polling mode in existing drivers.

OK, that sounds good. Especially when one needs to switch from one chip
to another that is already in tree, the need for a whole new polling
driver is eliminated.

I am still quite a novice in all kernel areas as I literally jump from
one subsystem to another to fix issues related to our platform. Anyway,
do you see any opportunity to help with that work?

> As far as gpio-keys vs gpio-key-polled, I feel that the capabilities of
> polling driver is sufficiently different from interrupt-driven one, so
> we will likely keep them separate.

OK, understand.

Thank you,
Michal
