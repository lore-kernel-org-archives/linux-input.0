From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: [BUG] object: is not initialized, yet kobject_put() is being   called
Date: Thu, 12 Aug 2010 07:26:45 -0400
Message-ID: <4C63DA75.303@signal11.us>
References: <20100810210941.GA7938@fritha.org> <20100810223215.GA1609@arch.tripp.de> <alpine.LNX.2.00.1008121108540.2702@pobox.suse.cz> <20100812091659.GA1591@arch.tripp.de> <alpine.LNX.2.00.1008121148100.2702@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1008121148100.2702-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Markus Trippelsdorf <markus-xp2qqqlHh3xzoYq+O6RWwA@public.gmane.org>, Heinz Diehl <htd-iEI8Y0CNJBYdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 08/12/2010 07:18 AM, Jiri Kosina wrote:
> On Thu, 12 Aug 2010, Markus Trippelsdorf wrote:
>
>    
>> On Thu, Aug 12, 2010 at 11:11:50AM +0200, Jiri Kosina wrote:
>>      
>>> Guys, could you please send me your .config with which you are
>>> experiencing the problem, so that I can try to reproduce it with it?
>>>        
>> Attached.
>>      
> So I had to add support for HW of mine (SATA_VIA, PATA_VIA, disabled the
> radeon firmware stuff, and, most importantly, enabled UHCI, which is what
> is on machine I am using now for testing), and disconnect-connect cycle
> works nicely:
>
> usb 3-2: USB disconnect, address 3
> usb 3-2: new low speed USB device using uhci_hcd and address 4
> input: mouse USB mouse with wheel as /devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.0/input/input6
> generic-usb 0003:05B8:3091.0004: input,hidraw0: USB HID v1.10 Mouse [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input0
> input: mouse USB mouse with wheel as /devices/pci0000:00/0000:00:10.1/usb3/3-2/3-2:1.1/input/input7
> generic-usb 0003:05B8:3091.0005: input,hidraw1: USB HID v1.10 Keyboard [mouse USB mouse with wheel] on usb-0000:00:10.1-2/input1
>
> so still no BUG from kobject refcounting, and the hidraw numbers are the
> same. The major difference seems to be that I am using UHCI and you have
> your HID devices connected through OHCI, is that correct?
>
> Alan, does the system you are seeing this bug on also have HID devices
> connected through OHCI?
>
>    
Hi Jiri,

Yes, I'm OHCI as well.

Alan.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
