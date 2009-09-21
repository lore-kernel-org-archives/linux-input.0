From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]fix usbhid using GFP_KERNEL in interrupt
Date: Mon, 21 Sep 2009 22:37:18 +0200
Message-ID: <200909212237.19281.oliver@neukum.org>
References: <200909212225.48513.oliver@neukum.org> <4AB7E331.8050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:42773 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbZIUUfi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2009 16:35:38 -0400
In-Reply-To: <4AB7E331.8050209@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henk Martijn <h.h.martijn@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>

Am Montag, 21. September 2009 22:33:53 schrieb Henk Martijn:
> Oliver Neukum wrote:
> > hid:usbhid: fix wrong use of GFP_KERNEL
> >
> > hid_input_report() must be told it is called in interrupt context
> >
> > Signed-off-by: Oliver Neukum <oliver@neukum.org>
> >
> > Hi Jiri, Greg,
> >
> > this should go into the current tree and the stable tree.
>
> Stable? Interestingly I did not have any problems with 2.6.31......

OK, Greg, hold your fire. Jiri is this necessary in stable?

	Regards
		Oliver

