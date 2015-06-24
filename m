From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 01/11] Input: synaptics-rmi4 - embed the function
 modules in rmi_core
Date: Wed, 24 Jun 2015 11:51:05 +0200
Message-ID: <1435139465.4528.64.camel@tiscali.nl>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1435087050-11444-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lb2-smtp-cloud3.xs4all.net ([194.109.24.26]:45749 "EHLO
	lb2-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940AbbFXJvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 05:51:09 -0400
In-Reply-To: <1435087050-11444-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-06-23 at 15:17 -0400, Benjamin Tissoires wrote:
>  drivers/input/rmi4/Kconfig      |  5 +----
>  drivers/input/rmi4/Makefile     |  2 +-
>  drivers/input/rmi4/rmi_bus.c    | 11 ++++++++++-
>  drivers/input/rmi4/rmi_driver.h |  8 ++++++++
>  drivers/input/rmi4/rmi_f11.c    | 10 +++++++++-
>  5 files changed, 29 insertions(+), 7 deletions(-)

(These files are neither in v4.1 nor in current linux-next. I have no
idea which tree this is for.)

> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
 
>  config RMI4_F11
> -	tristate "RMI4 Function 11 (2D pointing)"
> +	bool "RMI4 Function 11 (2D pointing)"
>  	depends on RMI4_CORE
>  	help
>  	  Say Y here if you want to add support for RMI4 function 
> 11.

(Upgrading to Fedora 22 gave me evolution 3.16. And evolution now
somehow manages to screw up replies to long lines in patches!)

> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -1537,7 +1537,15 @@ static struct rmi_function_handler 
> rmi_f11_handler = {
>  	.attention	= rmi_f11_attention,
>  };
>  
> -module_rmi_driver(rmi_f11_handler);
> +int __init rmi_register_f11_handler(void)
> +{
> +	return rmi_register_function_handler(&rmi_f11_handler);
> +}
> +
> +void rmi_unregister_f11_handler(void)
> +{
> +	rmi_unregister_function_handler(&rmi_f11_handler);
> +}
>  
>  MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
>  MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com");

You can remove these macros too. And whatever module specific code or
macros there still might be left in this file.

Thanks,


Paul Bolle
