From: Padfoot <padfoot@exemail.com.au>
Subject: Re: PROBLEM: Kernel version 3.2.1 usb touchscreen device not recognised
 [UDEV? USBINPUT? HOOK]
Date: Sat, 21 Jan 2012 07:13:58 +1100
Message-ID: <4F19CB06.6040801@exemail.com.au>
References: <4F192242.1070909@exemail.com.au> <20120120160210.GA21565@kroah.com>
Reply-To: padfoot@exemail.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120120160210.GA21565@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 21/01/12 03:02, Greg KH wrote:
> On Fri, Jan 20, 2012 at 07:13:54PM +1100, Padfoot wrote:
>> Upgrade from kernel 3.1.9 to 3.2.1 eGalax usb touchscreen device is
>> no longer recognised.
>>
>> Device is an Acer Iconia Tab w501 with inbuilt touchscreen. Screen
>> is a pci device but is connected on boot as a usb input device.
>> Issue appears to be with either UDEV or USBINPUT boot hook failing
>> to recognise the device as can be seen in the dmesg.3.2.1
>> attachment.
>>
>> Downgrading to kernel 3.1.9 corrects the issue.
> Can you run 'git bisect' between 3.1.0 and 3.2.0 to find the problem
> commit here?
>
> Also, you might want to cc: the linux-input developers, they can help
> you out much better than the general list can.
>
> greg k-h
>
Hi Greg,

I am not a kernel dev, nor have I ever compiled a kernel, so I don't 
think I am able to help with a git bisect to locate the offending 
commit. I am just a regular user running pre-compiled packages on my 
Arch Linux distro. But, of course I am happy to assist wherever I can.

Cheers.
Lachlan
