From: Phil Turmel <philip-xiX+HWoRdKcdnm+yROfE0A@public.gmane.org>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Tue, 21 Sep 2010 10:42:10 -0400
Message-ID: <4C98C442.8030305@turmel.org>
References: <Pine.LNX.4.44L0.1009211013460.1644-100000@iolanthe.rowland.org> <alpine.LNX.2.00.1009211638450.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1009211638450.26813-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mat <jackdachef-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guillaume Chazarain <guichaz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Bombe <aeb-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gabriel C <nix.or.die-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Heinz Diehl <htd-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 09/21/2010 10:40 AM, Jiri Kosina wrote:
> On Tue, 21 Sep 2010, Alan Stern wrote:
> 
>> On Tue, 21 Sep 2010, Jiri Kosina wrote:
>>
>>> I have just found out that it's actually CONFIG_USB_DYNAMIC_MINORS which 
>>> makes the difference. When unset, the problem doesn't trigger, and 
>>> usb_find_interface() always returns the proper interface. When 
>>> CONFIG_USB_DYNAMIC_MINORS is being used, the oops happen.
>>>
>>> I'll look into that.
>>
>> Apparently the problem is that intf->minors doesn't get initialized 
>> properly.  This patch should fix it.  Everybody, please try it out.
>>
>> Alan Stern
>>
>>
>> Index: usb-2.6/drivers/usb/core/file.c
>> ===================================================================
>> --- usb-2.6.orig/drivers/usb/core/file.c
>> +++ usb-2.6/drivers/usb/core/file.c
>> @@ -159,9 +159,9 @@ void usb_major_cleanup(void)
>>  int usb_register_dev(struct usb_interface *intf,
>>  		     struct usb_class_driver *class_driver)
>>  {
>> -	int retval = -EINVAL;
>> +	int retval;
>>  	int minor_base = class_driver->minor_base;
>> -	int minor = 0;
>> +	int minor;
>>  	char name[20];
>>  	char *temp;
>>  
>> @@ -173,12 +173,17 @@ int usb_register_dev(struct usb_interfac
>>  	 */
>>  	minor_base = 0;
>>  #endif
>> -	intf->minor = -1;
>> -
>> -	dbg ("looking for a minor, starting at %d", minor_base);
>>  
>>  	if (class_driver->fops == NULL)
>> -		goto exit;
>> +		return -EINVAL;
>> +	if (intf->minor >= 0)
>> +		return -EADDRINUSE;
>> +
>> +	retval = init_usb_class();
>> +	if (retval)
>> +		return retval;
>> +
>> +	dev_dbg(&intf->dev, "looking for a minor, starting at %d", minor_base);
>>  
>>  	down_write(&minor_rwsem);
>>  	for (minor = minor_base; minor < MAX_USB_MINORS; ++minor) {
>> @@ -186,20 +191,12 @@ int usb_register_dev(struct usb_interfac
>>  			continue;
>>  
>>  		usb_minors[minor] = class_driver->fops;
>> -
>> -		retval = 0;
>> +		intf->minor = minor;
>>  		break;
>>  	}
>>  	up_write(&minor_rwsem);
>> -
>> -	if (retval)
>> -		goto exit;
>> -
>> -	retval = init_usb_class();
>> -	if (retval)
>> -		goto exit;
>> -
>> -	intf->minor = minor;
>> +	if (intf->minor < 0)
>> +		return -EXFULL;
>>  
>>  	/* create a usb class device for this usb interface */
>>  	snprintf(name, sizeof(name), class_driver->name, minor - minor_base);
>> @@ -212,12 +209,12 @@ int usb_register_dev(struct usb_interfac
>>  				      MKDEV(USB_MAJOR, minor), class_driver,
>>  				      "%s", temp);
>>  	if (IS_ERR(intf->usb_dev)) {
>> +		retval = PTR_ERR(intf->usb_dev);
>>  		down_write(&minor_rwsem);
>> -		usb_minors[intf->minor] = NULL;
>> +		usb_minors[minor] = NULL;
>> +		intf->minor = -1;
>>  		up_write(&minor_rwsem);
>> -		retval = PTR_ERR(intf->usb_dev);
>>  	}
>> -exit:
>>  	return retval;
>>  }
>>  EXPORT_SYMBOL_GPL(usb_register_dev);
>> Index: usb-2.6/drivers/usb/core/message.c
>> ===================================================================
>> --- usb-2.6.orig/drivers/usb/core/message.c
>> +++ usb-2.6/drivers/usb/core/message.c
>> @@ -1803,6 +1803,7 @@ free_interfaces:
>>  		intf->dev.groups = usb_interface_groups;
>>  		intf->dev.dma_mask = dev->dev.dma_mask;
>>  		INIT_WORK(&intf->reset_ws, __usb_queue_reset_device);
>> +		intf->minor = -1;
>>  		device_initialize(&intf->dev);
>>  		dev_set_name(&intf->dev, "%d-%s:%d.%d",
>>  			dev->bus->busnum, dev->devpath,
> 
> [ adding Heinz to CC ]
> 
> If USB core would guarantee the initialization of intf->minor to -1, that 
> would be of course nicer than having to do it myself in the driver (which 
> is exactly what my previous patch has been doing).
> 
> So everyone please test Alan's patch rather than mine, as it is more 
> general.
> 

For what it's worth, I just finished testing yours, and it works just fine.  I'll try Alan's now.

Phil
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
