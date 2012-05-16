From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: allocate event circular buffer separately
Date: Wed, 16 May 2012 12:40:19 -0700
Message-ID: <20120516194018.GB15920@core.coreip.homeip.net>
References: <1337085984-5811-1-git-send-email-mika.kuoppala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59456 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756036Ab2EPTk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 May 2012 15:40:28 -0400
Received: by dady13 with SMTP id y13so1409891dad.19
        for <linux-input@vger.kernel.org>; Wed, 16 May 2012 12:40:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337085984-5811-1-git-send-email-mika.kuoppala@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Kuoppala <mika.kuoppala@nokia.com>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

Hi Mika,

On Tue, May 15, 2012 at 03:46:24PM +0300, Mika Kuoppala wrote:
> If struct evdev_client is added to the already power of two
> buffer allocation and the buffer is large, for multitouch devices,
> the allocation will spill over into the the next page.
> Alloc buffer separately instead of binding it to evdev_client struct
> to avoid multipage kmalloc.

Not counting the event buffer, size of evdev_client is fairly small
(under 100 bytes?) so I wonder how often this split actually helps (i.e.
buffer and client each are less than page size but combined are more).

Thanks.

-- 
Dmitry
