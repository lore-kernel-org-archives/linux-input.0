From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add ROHM BU21023/24 Dual touch support resistive
 touchscreens
Date: Thu, 31 Jul 2014 10:16:55 -0700
Message-ID: <20140731171655.GA5631@core.coreip.homeip.net>
References: <20140731195434.d141b39f3920686485c64191@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:52948 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaGaRQ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 13:16:58 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so3864316pdb.3
        for <linux-input@vger.kernel.org>; Thu, 31 Jul 2014 10:16:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140731195434.d141b39f3920686485c64191@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-input@vger.kernel.org

Hi Yuichi,

On Thu, Jul 31, 2014 at 07:54:34PM +0900, Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>

I few high-level comments:

- please get rid of polling - it is not useful in production mode;
- switch to threaded interrupts so that you do not need to manage
  workqueue/work/timers;
- new drivers should use MT-B protocol with proper contact tracking. If device
  does not do good job at tracking contacts you can use input's core matching
algorithm (input_mt_assign_slots).
- please provide ST emulation as well (input_mt_report_pointer_emulation).
- the way you requesting firmware in probe path means you need to build
  firmware image into kernel or be careful how you pack it to avoid timeouts on
  boot. Since the device properties are not changing you might want to postpone
  that until somebody tries to open the device.
- please add error handling for IO operations.
- managed resources simplify the code.

Thanks.

-- 
Dmitry
