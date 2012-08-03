From: Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: Re: [RFC ebeam PATCH v2 3/3] input: misc: New USB eBeam input driver.
Date: Fri, 03 Aug 2012 17:30:48 +0200
Message-ID: <501BEEA8.4060702@laposte.net>
References: <1343912397-18353-1-git-send-email-yann.cantin@laposte.net> <1343912397-18353-4-git-send-email-yann.cantin@laposte.net> <alpine.LRH.2.00.1208031424250.15211@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LRH.2.00.1208031424250.15211-1ReQVI26iDCaZKY3DrU6dA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

>> +#include <linux/hid.h>
> 
> As this driver is not a HID bus driver, why do you need this include?

Cinder, removed

>> +#define DRIVER_VERSION	"v0.7"
> 
> I don't think we need to be tracking driver versions for newly submitted 
> drivers, git is much better at tracking changes.

Old habit, removed.

>> +	u16			 X, Y;		/* raw coordinates	     */
>> +	int			 x, y;		/* computed coordinates      */
> 
> X,x being different fields seems confusing to me. How about, let's say, x, 
> raw_x?

Done.
 
>> +DEVICE_H_ATTR(1);
>> +DEVICE_H_ATTR(2);
>> +DEVICE_H_ATTR(3);
>> +DEVICE_H_ATTR(4);
>> +DEVICE_H_ATTR(5);
>> +DEVICE_H_ATTR(6);
>> +DEVICE_H_ATTR(7);
>> +DEVICE_H_ATTR(8);
>> +DEVICE_H_ATTR(9);
> 
> You are adding a number of sysfs files. If they are really necessary, 
> you'll probably need to document those in Documentation/ABI.

Will do, in testing i suppose.

BTW : The driver need lot of parameters to be passed from user-space calibration
tool. The best way to do it isn't decided yet : one sysfs file per parameter, or
one sysfs file for all, with a big sscanf parsing. Any idea ?

>> +		strlcat(ebeam->name, ")", sizeof(ebeam->name));
> 
> I'd suggest checking the length, making sure that you don't overflow the 
> ->name buffer.

Something like this ? :

if (strlcat(ebeam->name, ")", sizeof(ebeam->name))>=sizeof(ebeam->name)) {
	// overflowed, closing ) anyway
	ebeam->name[sizeof(ebeam->name)-2] = ')';

Thanks.
-- 
Yann Cantin
A4FEB47F
--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
