From: thatslyude@gmail.com
Subject: Re: [PATCH 3/3] Input: synaptics-rmi4 - log when we create a guest
 serio port
Date: Fri, 19 Jan 2018 13:10:18 -0500
Message-ID: <1516385418.2814.5.camel@gmail.com>
References: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
         <20180119004955.247190-4-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36538 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755968AbeASSKU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 13:10:20 -0500
In-Reply-To: <20180119004955.247190-4-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2018-01-18 at 16:49 -0800, Dmitry Torokhov wrote:
> To ease analyzing boot behavior from logs, let's log when we are about to
> register the pass-through serio port.
> 
> Also, let's drop "Synaptics" prefix from the port name, as RMI4 is good
> enough indicator already, and having the prefix means that the name does
> not fit into serio->name field. While at it move from hard-coded seio->phys
> to one mentioning the sensor ID (such as "rmi4-00.fn03/serio0").
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/rmi4/rmi_f03.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index 7ccbb370a9a81..88822196d6b72 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -184,14 +184,15 @@ static int rmi_f03_register_pt(struct f03_data *f03)
>  	serio->close = rmi_f03_pt_close;
>  	serio->port_data = f03;
>  
> -	strlcpy(serio->name, "Synaptics RMI4 PS/2 pass-through",
> -		sizeof(serio->name));
> -	strlcpy(serio->phys, "synaptics-rmi4-pt/serio1",
> -		sizeof(serio->phys));
> +	strlcpy(serio->name, "RMI4 PS/2 pass-through", sizeof(serio-
> >name));
> +	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0",
> +		 dev_name(&f03->fn->dev));
>  	serio->dev.parent = &f03->fn->dev;
>  
>  	f03->serio = serio;
>  
> +	printk(KERN_INFO "serio: %s port at %s\n",
> +		serio->name, dev_name(&f03->fn->dev));
>  	serio_register_port(serio);
>  
>  	return 0;
