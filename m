From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/2]-V2 Add touch screen input driver for TPS6507x
 family of multi-function chips.
Date: Wed, 7 Apr 2010 10:46:45 +0200
Message-ID: <20100407084644.GB2962@sortiz.org>
References: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga12.intel.com ([143.182.124.36]:27157 "EHLO
	azsmga102.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753057Ab0DGIqK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 04:46:10 -0400
Content-Disposition: inline
In-Reply-To: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Fischer <todd.fischer@ridgerun.com>
Cc: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com

Hi Todd, hi Kevin,

On Mon, Apr 05, 2010 at 05:53:11PM -0600, Todd Fischer wrote:
> 
> This is the second posting of the TPS6507x touch screen driver. I have
> incorporated Kevin Hilman's request to split the board specific changes
> into a separate patch.
> 
> The TPS6507x family of Texas Instruments power management ICs (pmic)
> are multi-function chips that include voltage regulation and touch
> screen controller capabilities.  This patch adds a touch screen
> input driver for the TPS6507x pmic.  There was an existing regulator
> driver.  Before the touch screen driver can be added, a multi-function
> device (MFD) driver was needed and the regulator driver modified to
> use the MDF driver.  Patches for these changes have been posted and
> reviewed.  The TPS6507x touch screen driver applies cleanly to the
> MFD GIT repo after the above referenced patches are applied.  If I
> should use a different approach, please let me know.
> 
> The TPS6507x pmic supports interrupting on touch detection.
> Unfortuntaly, the hardware used for driver development didn't have
> the interrupt signal properly connected.  When TPS6507x pmic interrupt
> capable hardware is in hand, another patch will be posted adding
> interrupt support.
I've applied patch #1 of this patchset. Kevin, would you please take patch #2?

Cheers,
Samuel.


-- 
Intel Open Source Technology Centre
http://oss.intel.com/
