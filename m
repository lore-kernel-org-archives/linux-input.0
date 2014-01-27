From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] USB: input: gtco.c: fix usb_dev leak
Date: Sun, 26 Jan 2014 22:54:16 -0800
Message-ID: <20140127065416.GA11945@core.coreip.homeip.net>
References: <1390087466-9898-1-git-send-email-khoroshilov@ispras.ru>
 <20140121195957.GB29615@core.coreip.homeip.net>
 <52E5FD48.7040208@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:42260 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaA0GyT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jan 2014 01:54:19 -0500
Content-Disposition: inline
In-Reply-To: <52E5FD48.7040208@ispras.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

Hi Alexey,

On Mon, Jan 27, 2014 at 10:31:36AM +0400, Alexey Khoroshilov wrote:
> On 21.01.2014 23:59, Dmitry Torokhov wrote:
> > On Sun, Jan 19, 2014 at 03:24:26AM +0400, Alexey Khoroshilov wrote:
> >> There is usb_get_dev() in gtco_probe(), but there is no usb_put_dev()
> >> anywhere in the driver.
> >>
> >> The patch adds usb_get_dev() to failure handling code of gtco_probe()
> >> and to gtco_disconnect(().
> > Hmm, I think gtco should simply not use usb_get_dev() in the first
> > place.
> >
> > Thanks.
> Dear Dmitry,
> 
> Could you please clarify why usb_get_dev() not needed here?
> We store reference to usb_dev in gtco structure, so we should refcount it.
> What is wrong in this reasoning?

The lifetime of gtco structure is already directly tied to lifetime of
usb_dev: when destroying usb_dev driver core will call remove() function
of currently bound driver (in our case gtco) which will destroy gtco
memory.

Taking additional reference is not needed here.

Hope this helps.

-- 
Dmitry
