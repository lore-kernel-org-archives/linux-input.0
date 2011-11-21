From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Saving kernel module parameters settings
Date: Mon, 21 Nov 2011 09:30:36 -0800
Message-ID: <20111121173036.GB2362@core.coreip.homeip.net>
References: <4ECA20F4.5040503@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40743 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab1KURam (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 12:30:42 -0500
Received: by iage36 with SMTP id e36so7559888iag.19
        for <linux-input@vger.kernel.org>; Mon, 21 Nov 2011 09:30:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4ECA20F4.5040503@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Mon, Nov 21, 2011 at 09:59:16AM +0000, Nuno Santos wrote:
> Hi,
> 
> Is there any mechanism to save kernel module parameters/settings in
> a persistent way?
> 

If kernel module is built-in then you'd have to adjust kernel command
line. If module is built as a loadable module then you can stick needed
settings in a file in /etc/modprobe.d/

Depending on the parameters (i.e. if they programmed to take effect
immediately - as opposed to, for example, only during new device
binding) you can have a program adjust them after you boot.

Thanks.

-- 
Dmitry
