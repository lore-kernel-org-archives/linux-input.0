From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio_raw - signal EFAULT even if read/write
 partially succeeds
Date: Mon, 30 Apr 2012 14:54:37 -0700
Message-ID: <20120430215437.GA7625@core.coreip.homeip.net>
References: <20120430064450.GA29212@core.coreip.homeip.net>
 <20120430111223.4941a9f0@pyramind.ukuu.org.uk>
 <20120430163442.GA2316@core.coreip.homeip.net>
 <20120430222603.7a92b5de@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41545 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab2D3Vyp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 17:54:45 -0400
Received: by pbbrp8 with SMTP id rp8so3720550pbb.19
        for <linux-input@vger.kernel.org>; Mon, 30 Apr 2012 14:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120430222603.7a92b5de@pyramind.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Che-Liang Chiou <clchiou@chromium.org>, David Herrmann <dh.herrmann@googlemail.com>

On Mon, Apr 30, 2012 at 10:26:03PM +0100, Alan Cox wrote:
> > If a read() is interrupted by a signal after it has successfully read
> > some data, it shall return the number of bytes read."
> 
> Fair point - I guess technically EFAULT is not a signal. I still think
> its a better behaviour to not lose bytes but objection withdrawn.

I generally agree (with other errors that are not due to faulty
application implementation). But I think signalling EFAULT is more
beneficial than partial read, because it will let application know
earlier that it uses incorrcet buffers. If we were to return patrtial
success apllication would simply retry the read and would never even
know that there is a problem.

Another is practical consideration in serio_raw - we take bytes out of
the queue and then attempt to put_user(). If it faults and we decide to
return partial success we need to put the byte we just fecthed back into
the queue. Or we can see if memory can be accessed before fetching the
byte. In both cases we make the driver more complex for benefit of
faulty applications.

Thanks.

-- 
Dmitry
