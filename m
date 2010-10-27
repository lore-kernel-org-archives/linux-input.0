From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] evdev: discard oldest event on buffer overflow
Date: Wed, 27 Oct 2010 16:57:04 -0700
Message-ID: <20101027235704.GA12179@core.coreip.homeip.net>
References: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53703 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522Ab0J0X5N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 19:57:13 -0400
Received: by gwj21 with SMTP id 21so872678gwj.19
        for <linux-input@vger.kernel.org>; Wed, 27 Oct 2010 16:57:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288199398-7198-1-git-send-email-bgat@billgatliff.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 27, 2010 at 12:09:58PM -0500, Bill Gatliff wrote:
> On a buffer overflow, the head and tail pointers collide.
> This makes the buffer suddenly look empty, rather than
> full, which may confuse applications.
> 
> This patch moves the tail pointer up one event on a buffer
> overflow, which "consumes" the oldest event in the buffer
> to make room for the incoming event.  Thus, although data
> is lost due to the overflow (which is unavoidable), the
> data that remains is both recent and still time-ordered.
> 

It does not really matter... You are losing part of the hardware state
regardless so the packet is invalid anyway. What would probably make
more sense is to ignore all events up until next packet boundary
(EV_SYN/SYN_REPORT) so userspace would get most up-to-date _full_ packet
(when it catches up).

Thanks.

-- 
Dmitry
