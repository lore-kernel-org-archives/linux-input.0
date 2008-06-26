From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]fix race between disconnect and open in usbtouch
Date: Thu, 26 Jun 2008 16:35:01 +0200
Message-ID: <200806261635.03051.oliver@neukum.org>
References: <200806261532.06544.oliver@neukum.org> <200806261549.28084.oliver@neukum.org> <20080626143010.GA17001@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:45116 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758113AbYFZOed (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jun 2008 10:34:33 -0400
In-Reply-To: <20080626143010.GA17001@anvil.corenet.prv>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>, daniel.ritz@gmx.ch, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Donnerstag 26 Juni 2008 16:30:11 schrieb Dmitry Torokhov:
> > > I think you can just remove that usb_kill_urb() call since
> > > usbtouch_close() has already called it by that time.
> > 
> > Are you sure?
> 
> Yes, calling dev->close for opened devices as part of unregister is done
> by the input core.

OK, thanks.

	Regards
		Oliver

