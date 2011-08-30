From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux raw serio driver 32 byte maximum
Date: Tue, 30 Aug 2011 15:50:18 -0700
Message-ID: <20110830225017.GA2405@core.coreip.homeip.net>
References: <4E5D5D55.5060207@drewtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41999 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab1H3WuY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Aug 2011 18:50:24 -0400
Received: by pzk37 with SMTP id 37so234230pzk.1
        for <linux-input@vger.kernel.org>; Tue, 30 Aug 2011 15:50:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E5D5D55.5060207@drewtech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joey Oravec <joravec@drewtech.com>
Cc: linux-input@vger.kernel.org

Hi Joey,

On Tue, Aug 30, 2011 at 05:59:49PM -0400, Joey Oravec wrote:
> Dmitry -
> 
> In serio_raw.c function serio_raw_write() there's a check:
> 
> if (count > 32)
>    count = 32;
> 
> which coerces any call to write a maximum of 32 bytes. Do you know
> why this limitation is in the code? Characters get written
> one-by-one to the tty layer so I don't understand why it's there.

The driver was trying to mimic behavior of 2.4 psaux device as close as
possible so 32 bytes limit came from there. Besides I think it is a good
idea to not allow one process hog serio port for too long...

> 
> I'm not sure which section of the manpage defines write for a serial
> port. In the ordinary case I expected this function to keep
> transmitting until complete or an error occurs. If O_NONBLOCK was
> specified then I might expect EAGAIN. Right now my calling code
> doesn't expect a successful partial write. Do you think this module
> is doing the right thing? Can you comment on what the caller must
> expect?

I think you should handle partial writes. Even if driver honored
O_NONBLOCK you could get a partial write and not necessarily EAGAIN.

May I ask you what you are using serio_raw for?

Thanks.

-- 
Dmitry
