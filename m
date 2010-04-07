From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2]-V2 Add touch screen input driver for TPS6507x family of multi-function chips.
Date: Wed, 07 Apr 2010 09:10:06 -0700
Message-ID: <874ojnfdlt.fsf@deeprootsystems.com>
References: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
	<20100407084644.GB2962@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47985 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430Ab0DGQKL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 12:10:11 -0400
Received: by pva18 with SMTP id 18so788046pva.19
        for <linux-input@vger.kernel.org>; Wed, 07 Apr 2010 09:10:10 -0700 (PDT)
In-Reply-To: <20100407084644.GB2962@sortiz.org> (Samuel Ortiz's message of "Wed\, 7 Apr 2010 10\:46\:45 +0200")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, davinci-linux-open-source@linux.davincidsp.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org

Samuel Ortiz <sameo@linux.intel.com> writes:

> Hi Todd, hi Kevin,
>
> On Mon, Apr 05, 2010 at 05:53:11PM -0600, Todd Fischer wrote:
>> 
>> This is the second posting of the TPS6507x touch screen driver. I have
>> incorporated Kevin Hilman's request to split the board specific changes
>> into a separate patch.
>> 
>> The TPS6507x family of Texas Instruments power management ICs (pmic)
>> are multi-function chips that include voltage regulation and touch
>> screen controller capabilities.  This patch adds a touch screen
>> input driver for the TPS6507x pmic.  There was an existing regulator
>> driver.  Before the touch screen driver can be added, a multi-function
>> device (MFD) driver was needed and the regulator driver modified to
>> use the MDF driver.  Patches for these changes have been posted and
>> reviewed.  The TPS6507x touch screen driver applies cleanly to the
>> MFD GIT repo after the above referenced patches are applied.  If I
>> should use a different approach, please let me know.
>> 
>> The TPS6507x pmic supports interrupting on touch detection.
>> Unfortuntaly, the hardware used for driver development didn't have
>> the interrupt signal properly connected.  When TPS6507x pmic interrupt
>> capable hardware is in hand, another patch will be posted adding
>> interrupt support.
>
> I've applied patch #1 of this patchset. Kevin, would you please take patch #2?

Thanks.  Yes, patch #2 will be queued for linux-next and 2.6.35.

Kevin

