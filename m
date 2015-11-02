From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Mon, 2 Nov 2015 14:14:19 -0800
Message-ID: <5637E03B.5010804@synaptics.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150723171041.GA14941@mail.corp.redhat.com>
 <CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:58232 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752716AbbKBWOU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 17:14:20 -0500
In-Reply-To: <CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 10/31/2015 01:41 PM, Linus Walleij wrote:
> On Thu, Jul 23, 2015 at 7:10 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>
>> Dmitry, the Sony guys are currently working on upstreaming their work.
>> Their Xperia are using a Synaptics I2C touchscreen. They are able to
>> boot with an upstream kernel a lot of parts now, and they will
>> eventually need the upstream touch controller.
> I have a Synaptics touchscreen thing since 2010 waiting in
> drivers/staging/ste_rmi4.
>
> Is there *anything* I can do to help further this?
>
> It just seems like a massive body of code that doesn't get the
> right love, Benjamin have you considered just merging this into
> drivers/staging so it is simple for everyone to participate, or are there
> infrastructural blockers?
>
> Yours,
> Linus Walleij

I have been continuing to work on the synaptics-rmi4 driver and was just 
trying to figure out what the next step should be. I recently uploaded 
my changes here https://github.com/aduggan/linux. I've held off on 
posting more patches to the list since there are previous patches still 
outstanding and I didn't want to inundate the list. But, at this point I 
think I would appreciate someone volunteering to review it. I can post 
some or all of it to the list if that's the best place for that to happen.

I've added support for newer devices (Function 12), connected it up to 
hid-rmi to support HID touchpads, and reworked the SPI transport driver. 
I'm able to get basic support for touch working for a variety of devices 
RMI4 over I2C on a Nexus 4, RMI4 over SPI on a Nexus 9, and RMI4 over 
HID on various touchpads. With Benjamin's SMBus work it won't take much 
to also support SMBus touchpads.

I think the biggest blocker right now is just the fact that it is a 
large body of code and there hasn't been enough continuous activity to 
on it. So whenever a new patch is posted, reviewers have to go through 
the time consuming process of relearning the code. But, there are a lot 
of RMI4 devices out there without an upstreamed driver so I think it is 
worth doing.

Andrew
