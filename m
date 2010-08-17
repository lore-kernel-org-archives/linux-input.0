From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Tue, 17 Aug 2010 11:05:48 -0700
Message-ID: <BC741E3E-377E-45BF-80E1-A60F4E0FDFC9@gmail.com>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org> <20100813024912.GA2661@core.coreip.homeip.net> <4C65BF99.9030601@codeaurora.org> <201008131754.49488.dmitry.torokhov@gmail.com> <4C6AC393.8000109@codeaurora.org>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35525 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059Ab0HQSG2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 14:06:28 -0400
In-Reply-To: <4C6AC393.8000109@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>, Trilok Soni <tsoni@codeaurora.org>

Hi Neil,

On Aug 17, 2010, at 10:14 AM, Neil Leeder <nleeder@codeaurora.org>  
wrote:

> On 8/13/2010 8:54 PM, Dmitry Torokhov wrote:
>> Also it is not a simple coincidence that to enable device you send  
>> 0xf4
>> to it (which is PSMOUSE_CMD_ENABLE - standard PS/2 command). This  
>> tends
>> to suggest that interface is not actually hidden and that the device
>> (touchpad) could be replaced with other kinds of devices.
>>
>> Anyway, please try the driver (you  may need to hardcode the IRQ  
>> trigger
>> type for now) and see if psmouse is able to talk to the touchpad.  
>> If it
>> is then serio is the proper solution.
>
> Dmitri,
> I fixed one line in the wpce775x_serio driver which looked like a  
> typo - hope I got that right:
>
>    for (i = 0; i < count; i++)
> -        serio_interrupt(ps2if->serio, ps2if->data_in[1], 0);
> +        serio_interrupt(ps2if->serio, ps2if->data_in[i], 0);
>    }
>

Yep, that was a typo.

> I tried running with psmouse but it didn't work. The touchpad was  
> never detected as a synaptics touchpad. I looked at the dataflow  
> from the device and it wasn't responding to the commands that  
> synaptics_detect() was sending it. It eventually showed up as an  
> unknown logitech mouse.


That suggests that the device responds to at least basic PS/2 queries.

> I can see data being passed through the serio driver but the  
> logitech driver can't process it.
>

What about loading psmouse module with proto=bare?

Could you also dump the data received from touchpad during probing?


-- 
Dmitry

