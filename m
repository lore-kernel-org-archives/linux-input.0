From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: A question about touchscreen absmax value
Date: Mon, 16 Nov 2009 09:12:03 -0800
Message-ID: <20091116171202.GC24026@core.coreip.homeip.net>
References: <4B00B08E.2030905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:43793 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZKPRMG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2009 12:12:06 -0500
Received: by pzk1 with SMTP id 1so2916143pzk.33
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2009 09:12:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B00B08E.2030905@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

Hi Joonyoung,

On Mon, Nov 16, 2009 at 10:53:18AM +0900, Joonyoung Shim wrote:
> Hi, all.
> 
> I have a question about touchscreen resolution. My touchscreen device
> can report the position from 0 to 1023 of x and y coordinates, so i
> setted the absmax of input device to 1023. BTW, i only can get from 0 to 
> 479 x position and to 799 y position because the LCD resolution of the
> target is 480 x 800. I wonder which value is setted to the absmax - 479
> and 799 or 1023.

I believe driver should, by default, set absmin and absmax to match the
limits of the hardware/protocol. In your case it would be 1023. The
driver may choose to accept additional infromation from platform data, if
present, you can also adjust absmin/absmax etc via ioctl durng the
bootup sequence.

Hope this helps.

-- 
Dmitry
