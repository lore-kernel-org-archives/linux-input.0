From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] USB: input: powermate: fix oops with malicious USB
 descriptors
Date: Mon, 14 Mar 2016 09:15:48 -0700
Message-ID: <20160314161548.GA2585@kroah.com>
References: <1457964773-29512-1-git-send-email-jwboyer@fedoraproject.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39492 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcCNQPt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 12:15:49 -0400
Content-Disposition: inline
In-Reply-To: <1457964773-29512-1-git-send-email-jwboyer@fedoraproject.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>

On Mon, Mar 14, 2016 at 10:12:53AM -0400, Josh Boyer wrote:
> The powermate driver expects at least one valid USB endpoint in its
> probe function.  If given malicious descriptors that specify 0 for
> the number of endpoints, it will crash.  Validate the number of
> endpoints on the interface before using them.
> 
> The full report for this issue can be found here:
> http://seclists.org/bugtraq/2016/Mar/85
> 
> Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> ---
>  drivers/input/misc/powermate.c | 3 +++
>  1 file changed, 3 insertions(+)

I'll queue these up after 4.6-rc1 is out as the merge window is closed
right now, but we might want to think about a better way to handle this
type of thing in the USB core.  A way to keep from having to add checks
like this for every single driver, when the driver shouldn't even really
have their probe function called unless their expected endpoints are
going to be there.

I'll think about that over the next few weeks...

thanks,

greg k-h
