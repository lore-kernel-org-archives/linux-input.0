From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC ebeam PATCH v3 2/2] input: misc: New USB eBeam input driver.
Date: Mon, 6 Aug 2012 14:43:59 -0700
Message-ID: <20120806214359.GB30355@kroah.com>
References: <1344288104-20731-1-git-send-email-yann.cantin@laposte.net>
 <1344288104-20731-3-git-send-email-yann.cantin@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38343 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511Ab2HFVoD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Aug 2012 17:44:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so3157355pbb.19
        for <linux-input@vger.kernel.org>; Mon, 06 Aug 2012 14:44:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1344288104-20731-3-git-send-email-yann.cantin@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yann Cantin <yann.cantin@laposte.net>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Mon, Aug 06, 2012 at 11:21:44PM +0200, Yann Cantin wrote:
> 
> Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
> ---
>  drivers/input/misc/ebeam.c |  764 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 764 insertions(+)
>  create mode 100644 drivers/input/misc/ebeam.c

What adds this file to the build?

greg k-h
