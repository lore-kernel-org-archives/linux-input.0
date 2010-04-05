From: Todd Fischer <todd.fischer@ridgerun.com>
Subject: [PATCH 0/2]-V2 Add touch screen input driver for TPS6507x family of multi-function chips.
Date: Mon,  5 Apr 2010 17:53:11 -0600
Message-ID: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fischerfamily.org ([71.216.156.246]:24915 "EHLO gw"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757013Ab0DEXwU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Apr 2010 19:52:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, sameo@linux.intel.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, todd.fischer@ridgerun.com


This is the second posting of the TPS6507x touch screen driver. I have
incorporated Kevin Hilman's request to split the board specific changes
into a separate patch.

The TPS6507x family of Texas Instruments power management ICs (pmic)
are multi-function chips that include voltage regulation and touch
screen controller capabilities.  This patch adds a touch screen
input driver for the TPS6507x pmic.  There was an existing regulator
driver.  Before the touch screen driver can be added, a multi-function
device (MFD) driver was needed and the regulator driver modified to
use the MDF driver.  Patches for these changes have been posted and
reviewed.  The TPS6507x touch screen driver applies cleanly to the
MFD GIT repo after the above referenced patches are applied.  If I
should use a different approach, please let me know.

The TPS6507x pmic supports interrupting on touch detection.
Unfortuntaly, the hardware used for driver development didn't have
the interrupt signal properly connected.  When TPS6507x pmic interrupt
capable hardware is in hand, another patch will be posted adding
interrupt support.
