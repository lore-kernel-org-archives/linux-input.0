From: Marek Vasut <marex@denx.de>
Subject: Re: Kernel touch Kconfig consult
Date: Sun, 23 Jun 2019 12:43:47 +0200
Message-ID: <b1ab79bd-e72a-a782-a293-c32f1c09cce9@denx.de>
References: <1560509239.24963.25.camel@mbjsdccf07>
 <20190623070249.GD204275@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623070249.GD204275@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "luhua.xu" <luhua.xu@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Nick Dyer <nick.dyer@itdev.co.uk>, Richard Leitner <richard.leitner@skidata.com>, Martin Kepplinger <martink@posteo.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, weiqi.fu@mediatek.com, wsd_upstream@mediatek.com
List-Id: linux-input@vger.kernel.org

On 6/23/19 9:02 AM, Dmitry Torokhov wrote:
> Hi,
> 
> On Fri, Jun 14, 2019 at 06:47:19AM -0400, luhua.xu wrote:
>> Hi Dmitry,Rob,Marek, Nick,Richard,Martin,
>>
>> In our  customer support experience, many smartphone have two or three
>> touch vendor mixture , and customer use one load to support all touches.
>> For easy to config touch driver  we use kernel config like this down
>> below,
>>  
>> We change the config type from 'bool' to 'string'.
>>  
>> config TOUCHSCREEN_MTK_TOUCH
>>   string "Touch IC name for Mediatek package"
>>   help
>>     Set touch IC name if you have touch panel.
>>     To compile this dirver for used touch IC.
>>  
>>
>> And we config touch driver like this：
>> CONFIG_TOUCHSCREEN_MTK_TOUCH="GT9886 GT1151 TD4320"
>>  
>> I only use one config to support  3 touches, while we have to use 3
>> config to support 3  touch drivers if we set the config as 'bool'.
>>
>> So can I use Kconfig like this?
>> I do look forward to receiving your reply at your convenience .
>>
> 
> I really do not see why having a sting is easier to have than 3 bools,
> especially if they pertain to different touch controllers. You must also
> have some custom processing of the config above as I am pretty sure our
> standard build tools would not work for it.

I might be missing something obvious, but isn't DT something you want to
use on your ARM device to describe the hardware , instead of hard-coding
it into the kernel configuration ?

I recently worked with MT6797 (the Gemini PDA SoC), and the vendorkernel
does exactly this, it's a spectacular display of ifdeffery and Kconfig
chaos, so I suspect this is where the idea of putting stuff into Kconfig
comes from.

-- 
Best regards,
Marek Vasut
