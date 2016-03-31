From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] tablet: remove private copy to USB device
Date: Thu, 31 Mar 2016 11:02:32 -0700
Message-ID: <20160331180232.GF39098@dtor-ws>
References: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34328 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbcCaSCf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2016 14:02:35 -0400
Content-Disposition: inline
In-Reply-To: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Mar 22, 2016 at 04:04:53PM +0100, Oliver Neukum wrote:
> We now have a macro to easily get to the USB device from the interface.
> So we are cleaning up all drivers to not store a private pointer.

Applied all 4, thank you.

> 
> Oliver Neukum (4):
>   acecad: stop saving struct usb_device
>   aiptek: stop saving struct usb_device
>   gtco: stop saving struct usb_device
>   kbtab: stop saving struct usb_device
> 
>  drivers/input/tablet/acecad.c | 12 ++++++------
>  drivers/input/tablet/aiptek.c | 18 +++++++++---------
>  drivers/input/tablet/gtco.c   | 24 ++++++++++++------------
>  drivers/input/tablet/kbtab.c  |  8 ++++----
>  4 files changed, 31 insertions(+), 31 deletions(-)
> 
> -- 
> 2.1.4
> 

-- 
Dmitry
