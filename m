From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH] HID: Documentation for hidraw
Date: Fri, 18 Jun 2010 09:37:57 -0400
Message-ID: <4C1B76B5.10806@signal11.us>
References: <1276832283-12084-1-git-send-email-alan@signal11.us> <20100618115738.c3dfb81b.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20100618115738.c3dfb81b.ospite@studenti.unina.it>
Sender: linux-doc-owner@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 06/18/2010 05:57 AM, Antonio Ospite wrote:
>
> Maybe both hidraw.txt and hiddev.txt can be moved to
> Documentation/hid/?
>
>    
Antonio,

You and Jiri seem to have the same idea on this one. Sounds good to me.
>> +
>> +HIDIOCGRAWNAME(len): Get Raw Name
>> +This ioctl returns a string containing the vendor and product strings of
>> +the device.  The returned string is Unicode, UTF-8 encoded.
>> +
>>      
> Is the encoding specified in the HID spec?
>    
USB returns strings to the host as Unicode, UTF16LE encoded. The kernel 
converts them to UTF-8. See usb_string() in drivers/usb/core/message.c.

>
> Just a very minimal remark, maybe the code should follow the kernel
> coding style (early return on error, no braces for one line conditional
> blocks) even if it is a userspace application. Being it in the
> kernel Documentation I assume people reading it would be used to kernel
> style more.
>
>    
Good point. I'll run the style check on it and fix it up.

Alan.

