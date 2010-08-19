From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Thu, 19 Aug 2010 18:19:10 -0400
Message-ID: <4C6DADDE.7030107@codeaurora.org>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org> <20100813024912.GA2661@core.coreip.homeip.net> <4C65BF99.9030601@codeaurora.org> <201008131754.49488.dmitry.torokhov@gmail.com> <4C6AC393.8000109@codeaurora.org> <BC741E3E-377E-45BF-80E1-A60F4E0FDFC9@gmail.com> <4C6C52DE.4040700@codeaurora.org> <20100819053311.GE5832@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100819053311.GE5832@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stepan Moskovchenko <stepanm@codeaurora.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>, Trilok Soni <tsoni@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 8/19/2010 1:33 AM, Dmitry Torokhov wrote:
> On Wed, Aug 18, 2010 at 05:38:38PM -0400, Neil Leeder wrote:
>> Using proto=bare gets around the GETINFO failure, but doesn't help
>> with the more important GETID failure.
>
> Does it help if you change write() to transmit (and read) 1 byte at a time?
>

Thanks for the suggestions. Nothing I change seems able to get a 
consistent valid response to GETID. I think this is the first time 
anyone has written anything other than 0xF4 to the firmware in the EC 
and it's just not passing through the other PS/2 commands and responses 
reliably.

> One way would be to look for PSMOUSE_CMD_ENABLE/PSMOUSE_CMD_DISABLE
> (0xf4/0xf5) in ->write() method to switch between 1 and 3-byte transfers.

If I force my way past GETID and set the receive length to 3 based on 
seeing F4/F5 being written then the touchpad does work. However the 
serio driver is now a touchpad-specific driver rather than a generic 
PS/2 one.  I have a keyboard on the same device. I'm not sure if it will 
work with serio, but if so it will probably have its own requirements 
for the length of data sent on responses, probably not 3.

BTW, using 1 as the receive length for commands has its own problems as 
some commands require more than one byte response (GETID, GETINFO). I 
can work around it, but it's not particularly clean and getting further 
away from a generic driver.

At this point I'm thinking that the interface is close to being able to 
work with serio/psmouse, but just not close enough. The unreliability of 
responding to basic commands as well as the length of data problems 
indicates some custom driver is going to be needed. That could either be 
Quanta's original touchpad driver I posted, or a modification of your 
serio driver. I'd lean towards not having a serio driver which includes 
workarounds for a specific device, but I'd appreciate hearing your opinion.

Thanks.
--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
