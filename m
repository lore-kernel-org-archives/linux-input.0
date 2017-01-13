From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Thu, 12 Jan 2017 22:22:03 -0800
Message-ID: <20170113062203.GD22630@dtor-ws>
References: <20170110121718.2992211-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110121718.2992211-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Arnd,

On Tue, Jan 10, 2017 at 01:16:58PM +0100, Arnd Bergmann wrote:
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
> 
> Fixes: c5e8848fc98e ("Input: synaptics-rmi4 - add support for F03")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/rmi4/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 30cc627a4f45..ad945b25722c 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -40,7 +40,7 @@ config RMI4_SMB
>  	  called rmi_smbus.
>  
>  config RMI4_F03
> -        bool "RMI4 Function 03 (PS2 Guest)"
> +        tristate "RMI4 Function 03 (PS2 Guest)"
>          depends on RMI4_CORE && SERIO
>          help
>            Say Y here if you want to add support for RMI4 function 03.
> -- 
> 2.9.0
> 

As it was explained townthread we can't [currently] make functions
modules, in the meantime I have d7ddad0acc4add42567f7879b116a0b9eea31860
that should fix this issue (and I just sent pull request for it).

Thanks.

-- 
Dmitry
