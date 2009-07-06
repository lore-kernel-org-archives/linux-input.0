From: Justin Madru <jdm64-u1xxEuL7cY4AvxtiuMwx3w@public.gmane.org>
Subject: Re: 2.6.30-rc1: touchpad disabled on hibernation
Date: Mon, 06 Jul 2009 16:55:17 -0700
Message-ID: <4A528EE5.5090901@gawab.com>
References: <4A438BA7.9010800@tuffmail.co.uk> <8db1092f0906251016l5ac85bfdpbac841b939cfac2a@mail.gmail.com> <4A43B1FC.7060609@tuffmail.co.uk> <200907070040.14796.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200907070040.14796.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, Maciej Rutecki <maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday 25 June 2009, Alan Jenkins wrote:
>   
>> Maciej Rutecki wrote:
>>     
>>> 2009/6/25 Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>:
>>>   
>>>       
>>>> The synaptics touchpad on my EeePC 701 dies on hibernation.  2.6.30 was
>>>> fine, and it doesn't happen on suspend to ram either.  There are no
>>>> obvious error messages, but maybe this boot message is relevant:
>>>>
>>>> Platform driver 'i8042' needs updating, please use dev_pm_ops
>>>>
>>>>     
>>>>         
>>> Similar on s2disk, HP/Compaq notebook. Try reload psmouse module. I
>>> reported it, but nobody answer.
>>>   
>>>       
>> That works, thanks.
>>     
>
> Alan, Maciej, can you both try the patch at
> http://patchwork.kernel.org/patch/34075/, please?
>
> Rafael
>
>   
I've been having the same issue (laptop touchpad not working after resume).
Your patch seams to fix the problem. I no longer have to reload the 
psmouse module after resume.

$ modinfo psmouse

filename:      
/lib/modules/2.6.31-rc2-git/kernel/drivers/input/mouse/psmouse.ko
license:        GPL
description:  PS/2 mouse driver
author:         Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
alias:            serio:ty05pr*id*ex*
alias:            serio:ty01pr*id*ex*
depends:
vermagic:     2.6.31-rc2-git SMP preempt mod_unload modversions PENTIUM4 
4KSTACKS
parm:           proto:Highest protocol extension to probe (bare, imps, 
exps, any). Useful for KVM switches. (proto_abbrev)
parm:           resolution:Resolution, in dpi. (uint)
parm:           rate:Report rate, in reports per second. (uint)
parm:           smartscroll:Logitech Smartscroll autorepeat, 1 = enabled 
(default), 0 = disabled. (bool)
parm:           resetafter:Reset device after so many bad packets (0 = 
never). (uint)
parm:           resync_time:How long can mouse stay idle before forcing 
resync (in seconds, 0 = never). (uint)

Justin Madru
