From: Oliver Neukum <oliver@neukum.org>
Subject: Re: usbhid control queue full, due to stuck control request
Date: Fri, 12 Feb 2010 08:35:36 +0100
Message-ID: <201002120835.36908.oliver@neukum.org>
References: <20100206172051.GA22311@spacedout.fries.net> <alpine.LRH.2.00.1002111617290.16183@twin.jikos.cz> <20100212004910.GD22311@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:38688 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0BLHfh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Feb 2010 02:35:37 -0500
In-Reply-To: <20100212004910.GD22311@spacedout.fries.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Fries <david@fries.net>
Cc: Jiri Kosina <jkosina@suse.cz>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Am Freitag, 12. Februar 2010 01:49:10 schrieb David Fries:
> Oliver Neukum, this is based on your patch, do you agree with the
> changes?

I do agree.

> One possible problem with this fix is it drops the stalled URB
> transfer.  That might pose a problem for one shot messages, possibly
> hid_ctrl and hid_irq_out could resubmit the same urb when -ECONNRESET
> is received, assuming the message content wasn't the reason it
> timedout in the first place.

That is a big assumption. Realistically, if the hardware needs over 5s
to answer the hardware is buggy. We are working around that. It is best
to get not too fancy, unless testing shows that we need to.

	Regards
		Oliver
