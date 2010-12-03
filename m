From: Valentine Barshak <vbarshak-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] USB: USBHID: Fix race between disconnect and hiddev_ioctl
Date: Sat, 04 Dec 2010 02:31:59 +0300
Message-ID: <4CF97DEF.7020403@mvista.com>
References: <20101203172746.GA31045@mvista.com> <20101203231611.GB22969@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101203231611.GB22969-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, Dec 03, 2010 at 08:27:46PM +0300, Valentine Barshak wrote:
>   
>> A USB HID device can be disconnected at any time.
>> If this happens right before or while hiddev_ioctl is in progress,
>> the hiddev_ioctl tries to access invalid hiddev->hid pointer.
>> When the hid device is disconnected, the hiddev_disconnect()
>> ends up with a call to hid_device_release() which frees
>> hid_device, but doesn't set the hiddev->hid pointer to NULL.
>> If the deallocated memory region has been re-used by the kernel,
>> this can cause a crash or memory corruption.
>>
>> Since disconnect can happen at any time, we can't initialize
>> struct hid_device *hid = hiddev->hid at the beginning of ioctl
>> and then use it.
>>
>> This change checks hiddev->exist flag while holding
>> the existancelock and uses hid_device only if it exists.
>>     
>
> Why didn't you take the lock and check hiddev->exist at the beginning of
> ioctl handler instead of pushing it down into individual command
> handlers? I guess it would slow down HIDIOCGVERSION but I think we could
> pay this price for code that is more clear ;)
>
>   
Well, some of the commands were already using the lock, while a couple 
of them doesn't seem to need it.
I've just added locking to the other commands that needed it. I guess I 
didn't want to rework the whole stuff
in order not to forget to unlock and return.
But I agree, the code would look a bit cleaner though if did as you say.

Thanks,
Val.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
