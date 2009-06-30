From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: min/max and actual values on absolute axes
Date: Mon, 29 Jun 2009 21:53:54 -0700
Message-ID: <20090630045354.GG10652@dtor-d630.eng.vmware.com>
References: <20090629234258.GA30771@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:61474 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZF3Exz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2009 00:53:55 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1182514rvb.5
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 21:53:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090629234258.GA30771@dingo.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org

Hi Peter,

On Tue, Jun 30, 2009 at 09:42:58AM +1000, Peter Hutterer wrote:
> Hi guys,
> 
> A question regarding min/max values on absolute axes of input devices. I
> have a few bugreports related to the synaptics driver and the trigger for
> the bug are coordinates outside the min/max range.
> 
> Example evtest output: http://bugs.freedesktop.org/attachment.cgi?id=27229
> 
>  Event type 3 (Absolute)
>     Event code 0 (X)
>       Value   6044
>       Min     1472
>       Max     5472
>     Event code 1 (Y)
>       Value   1261
>       Min     1408
>       Max     4448
> 
> 
> From Documentation/input/input-programming:
> "This setting would be appropriate for a joystick X axis, with the minimum of
> 0, maximum of 255 (which the joystick *must* be able to reach, no problem if
> it sometimes reports more, but it must be able to always reach the min and
> max values), [...]"
> 
> Do I read this correct that min/max is intended as guideline only and cannot
> be relied on for actual coordinate boundaries?
> 

That is correct. Input core does not perform any "snapping" of the
reported coordinates to the min/max boundaries, these values are
advisory only.

-- 
Dmitry
