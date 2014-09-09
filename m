From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH RESEND v3] input: Add ROHM BU21023/24 Dual touch support
 resistive touchscreens
Date: Tue, 9 Sep 2014 18:40:11 +0900
Message-ID: <20140909184011.aceeccef44cfb15828c84d6e@linux-mips.org>
References: <20140828114536.a28f06bcd8a7ada3a912e3bc@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-sg1500.iij4u.or.jp ([210.130.239.5]:51279 "EHLO
	mo-sg.iij4u.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbaIIJk0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Sep 2014 05:40:26 -0400
In-Reply-To: <20140828114536.a28f06bcd8a7ada3a912e3bc@linux-mips.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yuasa@linux-mips.org, linux-input@vger.kernel.org

Hi Dmitry,

I updated the driver according to your comments. 
Furthermore, is there any comment? 

Thanks,

Yoichi

On Thu, 28 Aug 2014 11:45:36 +0900
Yoichi Yuasa <yuasa@linux-mips.org> wrote:

> v3 Changes:
> - fix multi touch slots initialization
> - fix set_bit BTN_TOUCH
> - remove input_unregister_device()
> - switch to __set_bit()
> 
> v2 Changes:
> - remove polling mode
> - switch to threaded interrupt
> - switch to managed resources
> - use MT-B protocol with input_mt_assign_slots
> - provide ST emulation
> - firmware load and device initialization are shifted at opening the device
> - add error handling for IO operations
> 
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  drivers/input/touchscreen/Kconfig        |   11 +
>  drivers/input/touchscreen/Makefile       |    1 +
>  drivers/input/touchscreen/rohm_bu21023.c |  931 ++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/rohm_bu21023.h |  258 +++++++++
>  4 files changed, 1201 insertions(+)
> 
