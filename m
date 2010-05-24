From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lost events in older kernels
Date: Mon, 24 May 2010 10:48:13 -0700
Message-ID: <201005241048.13707.dmitry.torokhov@gmail.com>
References: <4BF7825F.2030405@seas.upenn.edu> <4BF88EA2.3040402@seas.upenn.edu> <4BF8EAE9.3050504@euromail.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62401 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758185Ab0EXRsh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 May 2010 13:48:37 -0400
Received: by pxi18 with SMTP id 18so1551857pxi.19
        for <linux-input@vger.kernel.org>; Mon, 24 May 2010 10:48:37 -0700 (PDT)
In-Reply-To: <4BF8EAE9.3050504@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>

On Sunday 23 May 2010 01:44:25 am Henrik Rydberg wrote:
> Rafi Rubin wrote:
> [...]
> 
> > Um, turns out I missed input_init_abs_bypass(void) in my backport, and
> > for some reason get a bit of corruption ;)
> > 
> > Sorry for the false alarm.
> 
> If your code executed without bypassing event filtering, it would only mean
> less events were sent,

Right, and that would look like some events (multitouch ones) were dropped,
whereas they were simply filtered out. 

> which would not void the argument. If you have
> updated numbers, it would be very interesting to see them.

Yes, we still need to think about [re]sizing event queue, especially for
multi-touch devices.

-- 
Dmitry
