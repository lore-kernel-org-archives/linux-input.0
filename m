From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: hid-rmi: configuration automatically changed after suspend/resume
Date: Mon, 6 Jul 2015 16:47:57 -0700
Message-ID: <559B13AD.50103@synaptics.com>
References: <1463383.73UKVcFjqX@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:47378 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756874AbbGFXr7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 19:47:59 -0400
In-Reply-To: <1463383.73UKVcFjqX@xps13>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz

Hi Gabriele,

On 07/06/2015 03:20 AM, Gabriele Mazzotta wrote:
> Hi,
>
> I recently noticed that there's a minor issue with hid-rmi.c. After a
> suspend/resume cycle the f11 control register is set to the default
> configuration, thus undoing the changes performed on init.

This is because i2c_hid does a reset of the touchpad during resume. 
Power cycles or resets will clear the changes to the control registers. 
There isn't a way to make these changes persistent without changing the 
firmware.

> I made some changes to the driver to prevent this from happening: the
> configuration is saved on suspend and restored upon resume. This seemed
> the simplest thing to do, but I encountered a small problem.

I haven't been able to successfully complete reads which I perform in 
the suspend callback. They end up timing out waiting for the response. 
Maybe this is only an issue on certain platforms if this is working for you.

>
> I'm saving and writing the whole register since the kernel can't know
> what userspace tools might have done. According to a comment in the
> sources, some firmwares split the control register, so blindly copying
> and writing 20 sequential bytes as I'm doing could be a problem.

Since reading from the suspend callback doesn't seem to be reliable on 
all platforms, I think it would  be better to store the values of the 
control registers on init. The driver can update the stored values and 
write that back to the device on init and after coming out of resume. 
This will overwrite any changes done by userspace tools. But, if it is 
important enough to have a F11 control register change persist over 
suspend / resume then it should probably be implemented in the hid-rmi 
anyway.

> Is there a way to recognize those firmwares? Or even better, is there a
> way to prevent the firmware from restoring the default configuration?

This bug can be worked around by only reading a max of 16 bytes at a 
time. So to read all 20 you can just read 16, then add 16 to the address 
and read the remaining 4. Also, the size of the control registers 
depends on the configuration so it could be more or less then 20. Did 
you have a particular register that you want to change which isn't 
currently in hid-rmi?

> PS: I didn't check if the same happens with other registers, but I
> suspenct it does.
>
> Thanks,
> Gabriele

In the meantime I have another patch to post related to suspend / 
resume. I'm going to go ahead and post that now to avoid conflicts.

Andrew
