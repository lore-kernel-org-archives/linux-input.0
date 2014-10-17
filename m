From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add keyboard input assist hid usages
Date: Fri, 17 Oct 2014 16:59:37 -0700
Message-ID: <20141017235937.GB22238@dtor-ws>
References: <1413590019-1829-1-git-send-email-ogay@logitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:59521 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaJQX7l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2014 19:59:41 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so1607613pdi.33
        for <linux-input@vger.kernel.org>; Fri, 17 Oct 2014 16:59:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413590019-1829-1-git-send-email-ogay@logitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mathieu Meisser <mmeisser@logitech.com>

On Sat, Oct 18, 2014 at 01:53:39AM +0200, Olivier Gay wrote:
> Add keyboard input assist controls usages from approved
> hid usage table request HUTTR42:
> http://www.usb.org/developers/hidpage/HUTRR42c.pdf
> 
> Signed-off-by: Olivier Gay <ogay@logitech.com>
> ---
> 
> Hi all,
> 
> this patch adds some currently missing hid usages to the
> hid system.

Who is going to be using these codes? Do we have userspace consumers?

Thanks.

-- 
Dmitry
