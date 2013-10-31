From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev: Fall back to vmalloc for client event
 buffer
Date: Thu, 31 Oct 2013 00:26:06 -0700
Message-ID: <20131031072606.GA14057@core.coreip.homeip.net>
References: <1381151213-32690-1-git-send-email-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:51597 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab3JaH0J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Oct 2013 03:26:09 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so977636pbb.39
        for <linux-input@vger.kernel.org>; Thu, 31 Oct 2013 00:26:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381151213-32690-1-git-send-email-daniels@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Stone <daniel@fooishbar.org>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Mon, Oct 07, 2013 at 02:06:53PM +0100, Daniel Stone wrote:
> evdev always tries to allocate the event buffer for clients using
> kzalloc rather than vmalloc, presumably to avoid mapping overhead where
> possible.  However, drivers like bcm5974, which claims support for
> reporting 16 fingers simultaneously, can have an extraordinarily large
> buffer.  The resultant contiguous order-4 allocation attempt fails due
> to fragmentation, and the device is thus unusable until reboot.
> 
> Try kzalloc if we can to avoid the mapping overhead, but if that fails,
> fall back to vzalloc.
> 
> Signed-off-by: Daniel Stone <daniels@collabora.com>

Applied, thank you Daniel.

-- 
Dmitry
