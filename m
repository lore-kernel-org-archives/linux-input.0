From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] HID: i2c-hid: Only disable irq wake if it was successfully
 enabled during suspend
Date: Tue, 28 Jul 2015 12:55:47 -0700
Message-ID: <55B7DE43.9090008@synaptics.com>
References: <1438042086-9827-1-git-send-email-aduggan@synaptics.com> <20150728113337.GD11956@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:49216 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751924AbbG1Tzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 15:55:54 -0400
In-Reply-To: <20150728113337.GD11956@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On 07/28/2015 04:33 AM, Mika Westerberg wrote:
> On Mon, Jul 27, 2015 at 05:08:06PM -0700, Andrew Duggan wrote:
>> On at least one platform the kernel prints a warning on resume saying
>> "Unbalanced IRQ 37 wake disable". This is because enable_irq_wake in the
>> suspend function is failing. This patch checks to see if the call to
>> enable_irq_wake succeeded before calling disable_irq_wake.
> While this looks okay, I'm wondering if this can also be fixed from the
> irq chip side by setting IRQCHIP_SKIP_SET_WAKE to .flags, given that the
> driver does not provide such function?

Yes, setting IRQCHIP_SKIP_SET_WAKE does fix the problem. After looking 
into it a bit more it turns out commit 5613570 already fixed the issue. 
My test system was running an older kernel which didn't include it. 
Applying 5613570 fixed this particular issue. Thanks for pointing that 
out, now I have a better understanding of why enable_irq_wake was 
failing in this instance.

For this patch, I think it is still a good idea to check the return code 
of enable_irq_wake. In theory, an irqchip which does have a irq_set_wake 
callback set could return an error. I can update the commit comment, add 
a warning, and submit a v2.

Thanks,
Andrew
