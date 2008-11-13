From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Thu, 13 Nov 2008 15:31:50 +0100
Message-ID: <20081113143149.GW3810@one.firstfloor.org>
References: <20081111003117.GA10904@basil.nowhere.org> <alpine.LNX.1.10.0811121529240.32143@jikos.suse.cz> <20081113113223.GT3810@one.firstfloor.org> <491C1DFF.6000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <491C1DFF.6000509-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 13, 2008 at 01:30:55PM +0100, Jiri Slaby wrote:
> Andi Kleen napsal(a):
> > Which information do you need exactly out of /sys/bus/usb/devices? 
> 
> You misread the path, it's one file in /proc. (Make sure usbfs is mounted

There was nothing there, so I checked sysfs.

> there.)

With the power switch connected I have:

...
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04b4 ProdID=fd11 Rev= 1.01
S:  Manufacturer=Gembird Electronics
S:  Product=Gembird Silver Shield PM
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=150mA
I:* If#= 0 Alt= 0 #EPs= 0 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid

...

-Andi
-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
