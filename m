From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] TWL4030 keypad: keypad lock / unlock
Date: Tue, 10 Nov 2009 13:43:30 +0000
Message-ID: <20091110134329.GB30911@sirena.org.uk>
References: <1257841448-12757-1-git-send-email-samu.p.onkalo@nokia.com> <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:33915 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbZKJNn0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 08:43:26 -0500
Content-Disposition: inline
In-Reply-To: <1257841448-12757-2-git-send-email-samu.p.onkalo@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Tue, Nov 10, 2009 at 10:24:08AM +0200, Samu Onkalo wrote:
> Sysfs interface for disabling and enabling keypad HW and
> PM management functions added to twl4030 keypad driver.

Might be nice to have the longer explanation in your cover letter in the
patch description...

> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>

Shouldn't this be done via the existing device wakeup API?  That also
presents a sysfs control (power/wakeup IIRC).  The driver calls
device_init_wakeup() to flag support for this at startup then checks
device_may_wakeup() when suspending and configures the hardware
appropriately.
