From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Tue, 10 Jan 2017 16:39:43 -0800
Message-ID: <e0f66d88-1651-206e-ba13-a3229b9725d7@synaptics.com>
References: <20170110121718.2992211-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:20305 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750784AbdAKAjo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Jan 2017 19:39:44 -0500
In-Reply-To: <20170110121718.2992211-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>

On 01/10/2017 04:16 AM, Arnd Bergmann wrote:
> If CONFIG_INPUT=m, we get a build error for the rmi4-f03 driver,
> added in linux-4.10:
>
> drivers/input/built-in.o: In function `rmi_f03_attention':
> rmi_f03.c:(.text+0xcfe0): undefined reference to `serio_interrupt'
> rmi_f03.c:(.text+0xd055): undefined reference to `serio_interrupt'
> drivers/input/built-in.o: In function `rmi_f03_remove':
> rmi_f03.c:(.text+0xd115): undefined reference to `serio_unregister_port'
> drivers/input/built-in.o: In function `rmi_f03_probe':
> rmi_f03.c:(.text+0xd209): undefined reference to `__serio_register_port'
>
> If we make the driver itself a 'tristate' instead of 'bool' symbol,
> Kconfig ensures that it can only be a loadable module in this case,
> which avoids the problem.

Unfortunately, the RMI4 driver does not support building the function 
drivers as modules. If F03 is built as a module it will not be loaded by 
the core. If we want f03 to be part of a module then rmi_core needs to 
be built as a module. We should remove the module macros currently in 
rmi_f03.c.

I was able to get a similar build error by setting CONFIG_RMI_CORE=y and 
CONFIG_SERIO=m. Was CONFIG_RMI_CORE=y set when you encountered this 
error? If so I think we should figure out a way to have Kconfig set 
CONFIG_RMI_CORE=m if serio is built as a module.

Andrew

> Fixes: c5e8848fc98e ("Input: synaptics-rmi4 - add support for F03")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/input/rmi4/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 30cc627a4f45..ad945b25722c 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -40,7 +40,7 @@ config RMI4_SMB
>   	  called rmi_smbus.
>   
>   config RMI4_F03
> -        bool "RMI4 Function 03 (PS2 Guest)"
> +        tristate "RMI4 Function 03 (PS2 Guest)"
>           depends on RMI4_CORE && SERIO
>           help
>             Say Y here if you want to add support for RMI4 function 03.


