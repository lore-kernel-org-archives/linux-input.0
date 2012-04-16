From: George Pantalos <gpantalos@gmail.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Tue, 17 Apr 2012 01:21:45 +0300
Message-ID: <2024920.Dutyu6QMZV@vaio>
References: <1364401.K99JIOKFyb@vaio> <1492453.bjpWEAk9kj@vaio> <20120416212407.GE3959@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37361 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2DPWTu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Apr 2012 18:19:50 -0400
Received: by wejx9 with SMTP id x9so3655017wej.19
        for <linux-input@vger.kernel.org>; Mon, 16 Apr 2012 15:19:49 -0700 (PDT)
In-Reply-To: <20120416212407.GE3959@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org

On Monday 16 of April 2012 16:24:07 Seth Forshee wrote:
> If the latency really is noticible when you stash the ST points, here's
> what I'd suggest trying instead. Stash away the last set of MT data you
> saw and repeat it with each of the next two ST coordinates. I suspect
> that will probably work well enough, and will allow every ST point to
> still be reported. And it should significantly simplify the code as
> well.

I will try to do that, thanks.

> If you see the sync bit set, it's _always_ the first fragment of the MT
> data, so you shoule _always_ reset the position. Why should past data
> have any effect on this decision?

I have noticed that the sync bit can at times be set in the second packet of 
the sequence. Couldn't this reset the position to priv->multi_packet=0 when 
in fact we are in priv->multi_packet=1  position?
I have also thought about "if((packet[6] & 0x40) && (priv->multi_packet == 
0))" so that sync is not lost. 
 
> This doesn't really re-sync the position, and the sync bit is sufficient
> for this purpose anyway. I'd propose that if you really think checking
> multi_data[4] is beneficial, use it only for validating the MT packet
> before parsing it.

OK, I have tried that before, thanks for the suggestion.

> Even if you use a separate case here you need to update the other
> BTN_TOOL keys. The 1 to 0 transition is needed for userspace to know
> that the situation has changed. Failing to report any value is not the
> same as reporting a value of 0.
