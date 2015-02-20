From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Fri, 20 Feb 2015 15:40:38 -0600
Message-ID: <54E7A9D6.8060506@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>	<201502202024.20741@pali>	<54E79167.6070701@dell.com>	<201502202141.16017@pali>	<54E7A567.5030501@dell.com> <CAN+gG=F6TyoOb=nNeBAsdh7RrEUWoeJtznTY4YNmr3UGxQ1Hjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from AUSXIPPS310.us.dell.com ([143.166.148.211]:20247 "EHLO
	ausxipps310.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbBTVu2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 16:50:28 -0500
In-Reply-To: <CAN+gG=F6TyoOb=nNeBAsdh7RrEUWoeJtznTY4YNmr3UGxQ1Hjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>


On 02/20/2015 03:31 PM, Benjamin Tissoires wrote:
>
> What is most likely happening is that the synaptics driver switches
> the touchpad into the i2c/hid protocol. And yes Synaptics told us that
> only a reset re-enables the touchpad in the PS/2 mode.
> Kernels 3.11 and later know how to deal with this mode (through
> hid-rmi), so we should not see these problems in the future unless
> hid-rmi is not compiled in the running kernel.
>
> Fortunately, we can deal with the Dell/Synaptics touchpads, the Lenovo
> ones are using SMBus, and we have never been able to talk to the
> devices with SMBus :(
>
> Cheers,
> Benjamin
Ah, yeah that makes more sense to me.  And actually the newer touchpads like the one in the XPS 13 (2015) are microsoft precision touchpads.  They don't even bother with hid-rmi.  When in I2C mode the hid-multitouch and i2c-hid driver handle them sufficiently sans a patch that just hit linux-input to fix a problem introduced in 3.19 (and 3.18.3).

For clarities sake:
The touchpad in the XPS 13 (2015) will run in I2C or PS2 modes. When_OSI of Windows 2013 is recognized it will be put into I2C mode.  I know that the current kernel does recognize Windows 2013 _OSI so by default the touchpad will be in I2C mode with a new kernel.  Unfortunately this also puts the sound card into I2S mode which is not yet supported by Linux.  This is being worked out separately, but currently we are recommending that customers use acpi_osi="!Windows 2013" to use the touchpad in PS2 and soundcard in HDA modes.

Obviously this patch isn't applicable when running the touchpad is running in I2C mode.
