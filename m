From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/7] USBHID: don't recover device if suspend fails in
 system sleep
Date: Fri, 8 Mar 2013 07:48:33 +0800
Message-ID: <20130307234833.GA11730@kroah.com>
References: <1362672924-22975-1-git-send-email-ming.lei@canonical.com>
 <1362672924-22975-4-git-send-email-ming.lei@canonical.com>
 <alpine.LNX.2.00.1303080013210.19460@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58565 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220Ab3CGXsG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Mar 2013 18:48:06 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so835673pad.39
        for <linux-input@vger.kernel.org>; Thu, 07 Mar 2013 15:48:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1303080013210.19460@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Ming Lei <ming.lei@canonical.com>, "David S. Miller" <davem@davemloft.net>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 08, 2013 at 12:16:08AM +0100, Jiri Kosina wrote:
> On Fri, 8 Mar 2013, Ming Lei wrote:
> 
> > If suspend callback fails in system sleep context, usb core will
> > ignore the failure and let the system sleep go ahead further, so this
> > patch doesn't recover device under this situation, otherwise
> > may cause resume() confused.
> > 
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Signed-off-by: Ming Lei <ming.lei@canonical.com>
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> I guess this will go through USB tree as a series ...

Yes, I can take this, thanks for the ack.

greg k-h
