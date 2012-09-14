From: Bernhard Seibold <mail@bernhard-seibold.de>
Subject: Re: [PATCH] HID: lenovo-tpkbd: Fix memory leak in tpkbd_remove_tp()
Date: Fri, 14 Sep 2012 11:35:27 +0200
Message-ID: <20120914113527.02666021@bernhard-seibold.de>
References: <1347513912.3319.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mcp.e404.de ([78.47.239.181]:47235 "EHLO mcp.e404.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232Ab2INJnJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 05:43:09 -0400
In-Reply-To: <1347513912.3319.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Thu, 13 Sep 2012 13:25:12 +0800
Axel Lin <axel.lin@gmail.com> wrote:

> We need to kfree names for led_mute and led_micmute in
> tpkbd_remove_tp().
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Bernhard Seibold <mail@bernhard-seibold.de>

> ---
>  drivers/hid/hid-lenovo-tpkbd.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-lenovo-tpkbd.c
> b/drivers/hid/hid-lenovo-tpkbd.c index 77d2df0..60c4e1e 100644
> --- a/drivers/hid/hid-lenovo-tpkbd.c
> +++ b/drivers/hid/hid-lenovo-tpkbd.c
> @@ -519,6 +519,8 @@ static void tpkbd_remove_tp(struct hid_device
> *hdev) led_classdev_unregister(&data_pointer->led_mute);
>  
>  	hid_set_drvdata(hdev, NULL);
> +	kfree(data_pointer->led_micmute.name);
> +	kfree(data_pointer->led_mute.name);
>  	kfree(data_pointer);
>  }
>  

