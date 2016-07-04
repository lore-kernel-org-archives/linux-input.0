From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v2 1/8] Input: synaptics-rmi4: Increment the refcount of
 the transport dev's of_node
Date: Mon, 4 Jul 2016 15:11:25 +0100
Message-ID: <7b938ff8-1e60-5ff1-4f86-7035f1252828@itdev.co.uk>
References: <1466813877-15737-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:34866 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbcGDOLi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2016 10:11:38 -0400
In-Reply-To: <1466813877-15737-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>

On 25/06/2016 01:17, Andrew Duggan wrote:
> Increment the refcount for the transport device's of_node before calling
> of_find_node_by_name(). Since of_find_node_by_name() assumes the refcount
> was incremented by the caller and calls of_node_put() when it is done.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
>  drivers/input/rmi4/rmi_bus.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index b368b05..55b5336 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -157,11 +157,12 @@ static int rmi_function_match(struct device *dev, struct device_driver *drv)
>  static void rmi_function_of_probe(struct rmi_function *fn)
>  {
>  	char of_name[9];
> +	struct device_node *node = fn->rmi_dev->xport->dev->of_node;
>  
>  	snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
>  		fn->fd.function_number);
> -	fn->dev.of_node = of_find_node_by_name(
> -				fn->rmi_dev->xport->dev->of_node, of_name);
> +	of_node_get(node);
> +	fn->dev.of_node = of_find_node_by_name(node, of_name);

Could this be changed to of_get_child_by_name() (which doesn't call
of_node_put) instead of doing the refcount hack?

>  }
>  #else
>  static inline void rmi_function_of_probe(struct rmi_function *fn)
> 
