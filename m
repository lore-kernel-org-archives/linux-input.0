From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] input: driver for USB VoIP phones with CM109 chipset #2
Date: Sat, 26 Jul 2008 20:45:21 +0200
Message-ID: <200807262045.22722.oliver@neukum.org>
References: <200806271424.50425.oliver@neukum.org> <20080725141420.GA29395@anvil.corenet.prv> <488B48F7.5060002@db.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:55653 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbYGZSod (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2008 14:44:33 -0400
In-Reply-To: <488B48F7.5060002@db.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Am Samstag 26 Juli 2008 17:55:35 schrieb Alfred E. Heggestad:
> Jul 26 17:32:33 io kernel: hald-addon-keyb[23629]: segfault at 6f6f6c5f ip b7e9855b sp bf9d89dc error 4 in libc-2.6.1.so[b7e28000+144000]
> Jul 26 17:32:43 io kernel: cm109: cm109_urb_ctl_callback: usb_submit_urb (urb_irq) failed -22
> Jul 26 17:33:21 io last message repeated 6 times
> Jul 26 17:34:28 io last message repeated 17 times

This should not happen. Please provide more context. If possible
recompile your kernel with CONFIG_USB_DEBUG.

	Regards
		Oliver

