From: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH] HID: hiddev: fix returned errno code in hiddev_connect()
Date: Wed, 30 Sep 2015 11:05:36 +0100
Message-ID: <560BB3F0.9050307@osg.samsung.com>
References: <1443606749-6028-1-git-send-email-luisbg@osg.samsung.com> <560BB1CA.8090300@osg.samsung.com> <20150930100408.GA5576@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150930100408.GA5576@sudip-pc>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 30/09/15 11:04, Sudip Mukherjee wrote:
> On Wed, Sep 30, 2015 at 10:56:26AM +0100, Luis de Bethencourt wrote:
>> On 30/09/15 10:52, Luis de Bethencourt wrote:
>>> The driver is using -1 instead of the -ENOMEM defined macro to specify
>>> that a buffer allocation failed. Since the error number is propagated,
>>> the caller will get a -EPERM which is the wrong error condition.
>>>
>>> Also, the smatch tool complains with the following warning:
>>> hiddev_connect() warn: returning -1 instead of -ENOMEM is sloppy
>>>
>>> Signed-off-by: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
>>> ---
>>>  drivers/hid/usbhid/hiddev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
>>> index 2f1ddca..c5290ff 100644
>>> --- a/drivers/hid/usbhid/hiddev.c
>>> +++ b/drivers/hid/usbhid/hiddev.c
>>> @@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
>>>  	}
>>>  
>>>  	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
>>> -		return -1;
>>> +		return -ENOMEM;
>>>  
>>>  	init_waitqueue_head(&hiddev->wait);
>>>  	INIT_LIST_HEAD(&hiddev->list);
>>>
>>
>> Hello,
>>
>> I got an "Undelivered Mail Returned to Sender" from Jiri Kosina's
>> jikos-XVmvHMARGATQT0dZR+AlfA@public.gmane.org email address. This email is listed multiple times
>> in the MAINTAINERS file, does he have a new address to update this
>> file?
> Its jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> 
> regards
> sudip
> 

Hi Sudip,

*facepalm* My mistake, yes.

Sorry,
Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
