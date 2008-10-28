From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to
	corruption)
Date: Wed, 29 Oct 2008 02:08:36 +0800
Message-ID: <1225217316.4017.7.camel@yangyi-dev>
References: <200810271042.37365.oliver@neukum.org>
	 <1225211162.4017.1.camel@yangyi-dev> <200810280947.16006.oliver@neukum.org>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48964 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbYJ1KI5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2008 06:08:57 -0400
In-Reply-To: <200810280947.16006.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2008-10-28 at 01:47 -0700, Oliver Neukum wrote:
> Am Dienstag, 28. Oktober 2008 17:26:02 schrieb Yi Yang:
> > > This uses the USB busy mechanism for aggessive autosuspend of USB
> > > HID devices. It autosuspends all opened devices supporting remote wakeup
> > > after a timeout unless
> > > 
> > > - output is being done to the device
> > > - a key is being held down (remote wakeup isn't triggered upon key release)
> > > - LED(s) are lit
> > Why we shouldn't autosuspend it if it has LED lit?
> 
> If you suspend LEDs go dark. You'd hit e.g. caps lock, the LED would go
> bright and two seconds later dark. That's no good.
we can set longer intervel to aviod it to autosuspend in short interval.

I don't think lighting LED is one reason we can't autosuspend, display
is a good example for this, the system will suspend to ram or hibernate
if the user leaves very long although display is bright.
> 
> 	Regards
> 		Oliver

