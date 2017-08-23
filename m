From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/xen-kbdfront: Enable auto repeat for xen keyboard
 frontend driver
Date: Wed, 23 Aug 2017 11:36:48 -0700
Message-ID: <20170823183648.GA37905@dtor-ws>
References: <20170823181026.8084-1-lyan@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33109 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932396AbdHWSgw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 14:36:52 -0400
Content-Disposition: inline
In-Reply-To: <20170823181026.8084-1-lyan@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liang Yan <lyan@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Liang,

On Wed, Aug 23, 2017 at 02:10:26PM -0400, Liang Yan wrote:
> Long pressed key could not show right in XEN vncviewer after tigervnc
> client changed the way how to send repeat keys, from "Down Up Down Up
> ..." to "Down Down ... Up". By enable EV_REP bit here, XEN keyboard
> device will trigger default auto repeat process from input subsystem,
> and make auto repeat keys work correctly.

I almost applied it, but then I started to wonder: enabling autorepeat
in guest kernel means that autorepeat settings might differ between the
VNC client and the guest. Maybe the better fix would be to actually
assume that backend/client does not send duplicate events, but
autorepeat events, and do the following in xenkbd_handle_key_event():

static void xenkbd_handle_key_event(struct xenkbd_info *info,
				    struct xenkbd_key *key)
{
	struct input_dev *dev;
	int value = key->pressed;

	if (test_bit(key->keycode, info->ptr->keybit)) {
		dev = info->ptr;
	} else if (test_bit(key->keycode, info->kbd->keybit)) {
		dev = info->kbd;
		/* See if the key is already pressed */
		if (test_bit(key->keycode, info->kbd->key))
			value = 2; /* Report autorepeat */
	} else {
		pr_warn("unhandled keycode 0x%x\n", key->keycode);
		return;
	}

	input_event(dev, EV_KEY, key->keycode, value);
	input_sync(dev);
}

Thanks.

> 
> Signed-off-by: Liang Yan <lyan@suse.com>
> ---
>  drivers/input/misc/xen-kbdfront.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index fa130e7b734c..0dce9830e2f4 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -248,6 +248,7 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  	kbd->id.product = 0xffff;
>  
>  	__set_bit(EV_KEY, kbd->evbit);
> +	__set_bit(EV_REP, kbd->evbit);
>  	for (i = KEY_ESC; i < KEY_UNKNOWN; i++)
>  		__set_bit(i, kbd->keybit);
>  	for (i = KEY_OK; i < KEY_MAX; i++)
> -- 
> 2.14.1
> 

-- 
Dmitry
