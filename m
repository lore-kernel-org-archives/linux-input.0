From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC 04/36]  [Driver][Qualcomm 1070][EC_KB] Adding new qci keyboard
 driver
Date: Mon, 26 Jul 2010 16:46:10 +0530
Message-ID: <4C4D6E7A.3080903@codeaurora.org>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com> <1280133045-25945-4-git-send-email-wayne.lin@quantatw.com> <20100726085507.GB27151@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21366 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab0GZLQR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 07:16:17 -0400
In-Reply-To: <20100726085507.GB27151@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wayne Lin <00601wayne@gmail.com>, linux-input@vger.kernel.org, wayne <wayne.lin@quantatw.com>

Hi Dmitry,

On 7/26/2010 2:25 PM, Dmitry Torokhov wrote:
> On Mon, Jul 26, 2010 at 04:30:13PM +0800, Wayne Lin wrote:
>> From: wayne <wayne.lin@quantatw.com>
>>
> 
> - Change log?
> - run through checkpatch.pl
> - Get rid of debug printks (or convert to dev_dbg)?
> - use dev_XXX instrad of pr_xxx when you have device? Get rig
> - I have seen lots of time people trying to call input_free_device
>   after calling input_unregister_device (which is forbidden,
>   input_unregister_device is sufficient alone) but you are the first to
>   call free _before_ unregister.
> - No need to initialize keymap with zeroes (NOKEYS)
> - threaded IRQ
> - copy keymap into device and set keycode, keycodemax, keycodesize so
>   that keymap can be adjusted from userspace
> - why do you export input device?
> 
> I dont think you tried applying this patch... At least I do not have
> qci_kbd.c in my tree so it would not apply.
> 

I think whole series needs a refresh as you had mentioned in the another email. No
point in reviewing this series, because Wayne needs to post only driver part here,
if he has some mach-msm bits, then they should go through Daniel Walker.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
