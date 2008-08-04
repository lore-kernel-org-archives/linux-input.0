From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] input: driver for USB VoIP phones with CM109 chipset #2
Date: Tue, 5 Aug 2008 00:08:48 +0200
Message-ID: <200808050008.48846.oliver@neukum.org>
References: <200806271424.50425.oliver@neukum.org> <200808041356.57928.oliver@neukum.org> <489767D3.6070408@db.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:53599 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbYHDWIw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Aug 2008 18:08:52 -0400
In-Reply-To: <489767D3.6070408@db.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Am Montag 04 August 2008 22:34:27 schrieb Alfred E. Heggestad:
> > 
> > Looks like urb_irq is not properly initialised. Is there really nothing in the syslog?
> > Please print out urb->interval
> > 
> 
> urb->interval == 32
> 
> I added some more debugging in the driver, and after the module is loaded,
> I press "TAB" in a shell to force Bell/Buzzer.

Can you printk the interval and the dev pointer in 
cm109_urb_irq_callback?

	Regards
		Oliver
