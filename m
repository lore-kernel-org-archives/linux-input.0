From: Oliver Neukum <oneukum@suse.de>
Subject: Re: possible missing error handling in hidraw
Date: Fri, 27 Apr 2012 11:26:54 +0200
Message-ID: <201204271126.55061.oneukum@suse.de>
References: <201204251512.16482.oneukum@suse.de> <AE90C24D6B3A694183C094C60CF0A2F602C54D49@saturn3.aculab.com> <alpine.LNX.2.00.1204270946490.1856@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46780 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759804Ab2D0KjL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Apr 2012 06:39:11 -0400
In-Reply-To: <alpine.LNX.2.00.1204270946490.1856@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: James Woodcock <James.Woodcock@aculab.com>, linux-input@vger.kernel.org

Am Freitag, 27. April 2012, 09:47:55 schrieb Jiri Kosina:
> -void hidraw_report_event(struct hid_device *hid, u8 *data, int len)
> +int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  {
>         struct hidraw *dev = hid->hidraw;
>         struct hidraw_list *list;
> +       int ret = 0;
>  
>         list_for_each_entry(list, &dev->list, node) {
> -               list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC);
> +               if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
> +                       ret = -ENOMEM;
> +                       break;
> +               }
>                 list->buffer[list->head].len = len;
>                 list->head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
>                 kill_fasync(&list->fasync, SIGIO, POLL_IN);
>         }
>  
>         wake_up_interruptible(&dev->wait);
> +       return ret;
>  }

Then I have to ask why not simply copy the rest of the entries?

	Regards
		Oliver
