From: "James Woodcock" <James.Woodcock@ACULAB.COM>
Subject: RE: possible missing error handling in hidraw
Date: Fri, 27 Apr 2012 08:36:22 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F602C54D49@saturn3.aculab.com>
References: <201204251512.16482.oneukum@suse.de> <alpine.LNX.2.00.1204270055310.1856@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:35660 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752029Ab2D0Hg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Apr 2012 03:36:28 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 09076-05 for <linux-input@vger.kernel.org>;
 Fri, 27 Apr 2012 08:36:24 +0100 (BST)
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LNX.2.00.1204270055310.1856@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org

> From: linux-input-owner@vger.kernel.org 
> [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Jiri Kosina

> -void hidraw_report_event(struct hid_device *hid, u8 *data, int len)
> +int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
>  {
>  	struct hidraw *dev = hid->hidraw;
>  	struct hidraw_list *list;
> +	int ret = 0;
>  
>  	list_for_each_entry(list, &dev->list, node) {
> -		list->buffer[list->head].value = kmemdup(data, len,
GFP_ATOMIC);
> +		if (!(list->buffer[list->head].value = kmemdup(data,
len, GFP_ATOMIC))) {
> +			ret = -ENOMEM;
> +			break;
> +		}
>  		list->buffer[list->head].len = len;
>  		list->head = (list->head + 1) & (HIDRAW_BUFFER_SIZE -
1);
>  		kill_fasync(&list->fasync, SIGIO, POLL_IN);
>  	}
>  
>  	wake_up_interruptible(&dev->wait);
> +	return ret;
>  }
> 

What happens if there is more than 1 element in the list and kmemdup
fails
halfway through the list?  Will the allocated memory leak the next time
hirdaw_report_event() is called?

James


