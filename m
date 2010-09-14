From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: Synaptics i2c touchscreen driver
Date: Tue, 14 Sep 2010 12:58:38 +0530
Message-ID: <4C8F2426.8040301@codeaurora.org>
References: <27F9C60D11D683428E133F85D2BB4A530450B63EDD@dlee03.ent.ti.com> <7B4B50AC280A5E45A42CD2D364A3CE2F3A6BE70F9B@USW-EX2K7-1.synaptics-inc.local> <20100914005046.GA27540@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:34724 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0INH2m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Sep 2010 03:28:42 -0400
In-Reply-To: <20100914005046.GA27540@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: William Manson <WManson@synaptics.com>, "'Arce, Abraham'" <x0066660@ti.com>, Greg KH <gregkh@suse.de>, Christopher Heiny <Cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry, William,

On 9/14/2010 6:20 AM, Dmitry Torokhov wrote:
> Hi William,
> 
> On Mon, Sep 13, 2010 at 05:26:15PM -0700, William Manson wrote:
>> Hi Abraham -
>>
>> Yes - the TM1217 is an RMI4 based module [I just got an email from a
>> f/w engineer confirming it is indeed RMI4].
>>
>> We are currently working on submitting a new patch for our RMI4 based
>> driver to add some functionality based on Dmitry Torokhov's request
>> that we implement an RMI bus architecture. This is kind of a large
>> change and we had hoped our current submission for our RMI4 driver
>> would be added to the Kernel.org under a branch where every developer
>> could access it and then we could add in the RMI bus architecture in a
>> later patch. So it will take a while till we can make a new patch but
>> I have no problem if you want to try the existing patch out.
> 
> I have committed the latest version of the patch Christopher sent (sans
> defconfig and gta01 platform changes that do not really belong there) to
> synaptics-rmi4 branch of my tree on kernel.org. I branched it off 2.6.35
> release so it should be reasonably usable.

Why don't you submit to drivers/staging instead of creating branch at Dmitry's GIT tree?

You can probably attract more developers and you don't need to rebase to latest kernel 
everytime.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
