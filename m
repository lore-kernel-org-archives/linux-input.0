From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [RESEND PATCH v4 1/4] mfd: syscon: Set name of regmap_config
Date: Mon, 12 Mar 2018 17:47:14 +0800
Message-ID: <5AA64CA2.1080309@rock-chips.com>
References: <20180309084351.32009-1-jeffy.chen@rock-chips.com> <20180309084351.32009-2-jeffy.chen@rock-chips.com> <20180312091214.f6dwq6q3eqqblfnf@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312091214.f6dwq6q3eqqblfnf@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, alexandre.belloni@bootlin.com, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Emil Renner Berthing <kernel@esmil.dk>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.>
List-Id: linux-input@vger.kernel.org

Hi Lee,

On 03/12/2018 05:12 PM, Lee Jones wrote:
> On Fri, 09 Mar 2018, Jeffy Chen wrote:
>
>> >We are now allowing to register debugfs without a valid device, and not
>> >having a valid name will end up using "dummy*" to create debugfs dir.
>> >
>> >Signed-off-by: Jeffy Chen<jeffy.chen@rock-chips.com>
>> >---
>> >
>> >Changes in v4: None
>> >Changes in v3:
>> >Modify commit message.
>> >
>> >  drivers/mfd/syscon.c | 1 +
>> >  1 file changed, 1 insertion(+)
> Is this the RESEND I requested?  I can still only see this patch.
>
oops, sorry, i was using patman, and i force it to CC everyone in the 
cover letter's CC list, but that doesn't contain your mail address..i'll 
try another way :)
