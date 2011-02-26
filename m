From: Alan Ott <alan@signal11.us>
Subject: Re: Linux Hidraw changes
Date: Sat, 26 Feb 2011 07:37:22 -0700
Message-ID: <EED069DB-48CF-47A6-9149-3A379DD37E27@signal11.us>
References: <AANLkTikty3-oYoaycnkNYbro-Eak-pB+woR6D4FSkhMa@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:42185 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab1BZOhV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Feb 2011 09:37:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 3240B1CCABF4
	for <linux-input@vger.kernel.org>; Sat, 26 Feb 2011 09:37:20 -0500 (EST)
In-Reply-To: <AANLkTikty3-oYoaycnkNYbro-Eak-pB+woR6D4FSkhMa@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carl Lindqvist <lulebo@gmail.com>
Cc: linux-input@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>


On Feb 25, 2011, at 3:26 AM, Carl Lindqvist wrote:

> Hello Alan!
>
> My name is Carl, and I am working on a project which uses a purpose  
> built USB-device from X-Keys. To change the states of the LEDs on  
> the device I write to it using hidraw. I noticed that you are the  
> one who has been changing the way hidraw behaves in the kernel, and  
> I was wondering if you had the time to answer a few questions.
>
> Writing to the hidraw device works like a charm using ubuntu 10.10  
> with the 2.6.35-23 kernel. However, my system uses hardware that  
> doesn't play very nice with anything above 2.6.34 at the moment.  
> When using this older kernel, I can't manage to write to the hidraw  
> device. Nothing I try works. I noticed that there were changed to  
> hidraw, and you seem to be the expert.
>

I'm far from the expert :)

> I simply use the "write(fd, buf, length)" to send the data, and it  
> works great in 2.6.35, but just produces a write failed message on  
> older kernels. Do you know if it is possible to write to the device  
> in some other way? Or do I need the newer kernel for that?
>
> I am sorry to botheryou directly, but I figured you were the best  
> person to ask.


Typically this type of thing should go to the linux-input mailing  
list, I cc'd them.

The HID support from HIDRAW was kind of basic in older kernels and  
didn't support all the behaviors in the HID spec. For example, on  
older kernels output reports would only be sent on the control  
endpoint, but in newer kernels, the behavior is more compliant with  
the USB HID spec, sending data on an interrupt OUT endpoint if one is  
available.[1]

This breaks devices which expect the Output reports to come on the OUT  
endpoint (instead of the control endpoint).

Try applying [1] [2] and [3] to your older kernel and see how it goes.  
That should make it work, but there are also some race condition fixes  
( [4] [5] [6]) which should also be applied.

Alan.

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a8ab5d58b0238b8199cc699b8dff7c5e1da24138
[2] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=29129a98e6fc892d63bf7b8efcb458a258fe1683
[3] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c29771c2d8ceb907ed45eb8c7fc0450308140aca

[4] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d20d5ffab92f00188f360c44c791a5ffb988247c
[5] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e42dee9a99a3ecd32b5c027e8f7411fb5bc11eb6
[6] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=cb174681a9ececa6702f114b85bdf82144b6a5af

