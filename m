From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] fix y2038 problem in input_event
Date: Mon, 2 Nov 2015 17:43:04 -0800
Message-ID: <20151103014304.GA32018@dtor-ws>
References: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34350 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbKCBnH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 20:43:07 -0500
Received: by padec8 with SMTP id ec8so2855955pad.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 17:43:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1446471339-25464-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: WEN Pingbo <pingbo.wen@linaro.org>
Cc: linux-input@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de

Hi Wen,

On Mon, Nov 02, 2015 at 09:35:36PM +0800, WEN Pingbo wrote:
> Before this, I have discussed this problem with Arnd. And Arnd have
> an idea that by converting timeval to long / long in input_event, so that
> input_event structure size will be unchanged, and timeval structure will
> removed entirely. But we also need to avoid using CLOCK_REALTIME in
> userland, to keep the new input_event structure y2038 safe.
> 
> The input_event will only support monotonic time in Arnd's idea. And
> we still need to add wall time support for old 32-bit binary. 
> 
> Those patches try to keep original input capacity, and resolve y2038
> problem in input_event radically.
> 
> struct input_event is only used between kernel and userspace
> communication (except uinput). So that we can replace input_event
> with input_event64 in kernel entirely, and add a conversion in
> input_event_from/to_user() to keep compatible with old 32-bits binary.
> 
> userland can switch to input_event64, which is y2038 safe, via ioctl.

If we are forcing userspace to change the protocol I'd rather explore
whether we need to transmit the timestamp in each and every event. I
would much rather drop it and instead introduce new event code for
timestamp (we already have MSC_TIMESTAMP for hardware-generated
timestamps, maybe we can introduce new ones for kernel-generated
timestamps).

Thanks.

-- 
Dmitry
