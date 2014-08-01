From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] input: Add ROHM BU21023/24 Dual touch support resistive
 touchscreens
Date: Fri, 1 Aug 2014 19:32:12 +0900
Message-ID: <20140801193212.e653345051df0127c09a92f3@linux-mips.org>
References: <20140731195434.d141b39f3920686485c64191@linux-mips.org>
	<20140731171655.GA5631@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-sg1501.iij4u.or.jp ([210.130.239.6]:58431 "EHLO
	mo-sg.iij4u.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaHAKc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Aug 2014 06:32:28 -0400
In-Reply-To: <20140731171655.GA5631@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yuasa@linux-mips.org, linux-input@vger.kernel.org

Hi Dmitry,

On Thu, 31 Jul 2014 10:16:55 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Yuichi,
> 
> On Thu, Jul 31, 2014 at 07:54:34PM +0900, Yoichi Yuasa wrote:
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> 
> I few high-level comments:
> 
> - please get rid of polling - it is not useful in production mode;
> - switch to threaded interrupts so that you do not need to manage
>   workqueue/work/timers;
> - new drivers should use MT-B protocol with proper contact tracking. If device
>   does not do good job at tracking contacts you can use input's core matching
> algorithm (input_mt_assign_slots).
> - please provide ST emulation as well (input_mt_report_pointer_emulation).
> - the way you requesting firmware in probe path means you need to build
>   firmware image into kernel or be careful how you pack it to avoid timeouts on
>   boot. Since the device properties are not changing you might want to postpone
>   that until somebody tries to open the device.
> - please add error handling for IO operations.
> - managed resources simplify the code.

Thank you for your comments.
I'll try to update.

Thanks,

Yoichi

