From: Oliver Neukum <oneukum@suse.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
Date: Tue, 13 Aug 2019 10:14:54 +0200
Message-ID: <1565684094.7043.3.camel@suse.com>
References: <CAAeHK+z-uCr-bWu9uVDynU2S=wCrtxRbuA-Cut=h5zYuYcS-Cw@mail.gmail.com>
         <20190813042649.888-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813042649.888-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>, syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
Cc: gustavo@embeddedor.com, Jiri Slaby <jirislaby@gmail.com>, andreyknvl@google.com, syzkaller-bugs@googlegroups.com, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Dienstag, den 13.08.2019, 12:26 +0800 schrieb Hillf Danton:
> [respin with the mess in Cc list cleaned up]

> Followup of commit e3e14de50dff ("HID: fix start/stop cycle in usbhid driver")
> 
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1214,6 +1214,8 @@ static void usbhid_stop(struct hid_devic
>  
>  	hid->claimed = 0;
>  
> +	if (!usbhid->urbin) /* freeing buffers only once */
> +		return;
>  	usb_free_urb(usbhid->urbin);
>  	usb_free_urb(usbhid->urbctrl);
>  	usb_free_urb(usbhid->urbout);

This looks rather suspicious. Why is stop() called multiple times?
Do we have a refcounting issue? If not, what controls locking?

	Regards
		Oliver
