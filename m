From: Alan Jenkins <alan.christopher.jenkins-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: issues with unknown/new alias
Date: Thu, 13 Sep 2012 09:27:17 +0100
Message-ID: <505198E5.6000101@gmail.com>
References: <50518A75.4030608@codemercs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50518A75.4030608-xuEmVypu8QqakBO8gow8eQ@public.gmane.org>
Sender: linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Jung <jung-xuEmVypu8QqakBO8gow8eQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 13/09/12 08:25, Christoph Jung wrote:
> Hello,
>
> I am from the company "Code Mercenaries GmbH" from Germany. We have 
> some USB HID devices wich work with Linux.
> Since kernel version 2.6 our default products will be included in the 
> kernel.
>
> Devicedetails
> VendorID: 0x07C0
> ProductIDs: 0x1500, 0x1501, 0x1511, 0x1512, 0x1503
> Devicename: iowarrior
>
> Now we have some new custom product IDs but this two new devices get 
> no node in dev/usb/ , but I can find the with "lsusb".
> If I run "modinfo iowarrior" there will be 5 alias (with the default 
> pIDs) .
>
> The two new pIDs are: 0x158A, 0x158B
>
> I have not much experiance with linux (I work with Ubuntu 12.04).
Same OS and version, but I have no /dev/usb/ directory at all.  My guess 
is your problem isn't about modules.  I do have /dev/input/ though :).

What are you saying; does it not work?  If it has standard buttons 
(mouse/keyboard equiv), do they work under X?

Check out "ls-input" and "input-events" (apt-get install input-utils).  
"evtest" is similar, maybe slightly friendlier (apt-get install evtest).

You can check that your module has bound to the device by inspecting /sys/.

                  v-- try replacing usbhid with "iowarrior"

$ ls /sys/module/usbhid/drivers/usb:*/

3-2:1.0  bind  module  new_id  remove_id  uevent  unbind

^-- USB address of my standard device (mouse)


You could also see the device nodes created by udev, if you run "udevadm 
monitor --property" and plug the device in.  It's very verbose, but the 
last event should probably show DEVNAME=/dev/input/eventNN (and 
SUBSYSTEM=input near the end).

> What have be done to get the device nodes to work with them?
> Have I add some rules? Or have I edit the iowarrior.ko?

I don't think you need to add custom udev rules.

Alan
