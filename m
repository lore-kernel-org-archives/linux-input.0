From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: Turn Sony motion controller into RGB led
Date: Thu, 09 Apr 2015 20:33:23 -0400
Message-ID: <55271A53.6080505@gmail.com>
References: <20150314191917.GA3680@amd> <alpine.LNX.2.00.1503161354310.25438@pobox.suse.cz> <20150316130547.GA20976@amd> <20150409212536.GA1440@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36340 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbbDJAdi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Apr 2015 20:33:38 -0400
In-Reply-To: <20150409212536.GA1440@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Jiri Kosina <jkosina@suse.cz>
Cc: vojtech@suse.cz, mike-@cinci.rr.com, jslaby@suse.cz, dave@thedillows.org, colin.leitner@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On 4/9/2015 17:25, Pavel Machek wrote:
> Hi!
>
> I did not yet figure out how to get sensor data from the controller,
> but it works rather well as a RGB led.

Hi Pavel,

 From what I've read, the motion controller only sends sensor data when 
connected via bluetooth.
Otherwise it should be in report 1 with the buttons and other data.

Jiri already covered many of the issues, so just a couple of comments on 
top of what he already wrote:

>   
> -static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
> +static int motion_set_leds(struct hid_device *hdev, u8 r, u8 g, u8 b)
> +{
> +	int ret;
> +	struct motion_leds *buf = kzalloc(sizeof(struct motion_leds), GFP_KERNEL);

The other devices allocate this buffer up front and store it in 
output_report_dmabuf in the sony_sc struct
to avoid hitting the allocator every time an output report is sent. No 
reason why the motion controller can't
do the same.  Add an entry in sony_allocate_output_report() and it will 
be automatically freed when the
device is removed.

> +
> +	if (sizeof(struct motion_leds) != 7) {
> +		printk("Struct has bad size\n");
> +	}
> +

On the printk usage in general: the rest of the driver uses 
hid_info/hid_err to automatically format the output
string with the driver/device information when printing log messages.  
Use these instead of printk for consistency.
A lot of them should be removed anyways since they look like debugging 
leftovers.

If you can send a version without all of the unrelated underscore 
changes I'll help clean it up.  I don't own one of these controllers
though, so I can't help test the functionality.
