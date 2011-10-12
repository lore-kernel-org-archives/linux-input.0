From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 18:56:32 +0200
Message-ID: <201110121856.32444.oliver@neukum.org>
References: <201110121637.22442.oliver@neukum.org> <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org> <20111012161651.GA28601@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:52624 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab1JLQ4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 12:56:13 -0400
In-Reply-To: <20111012161651.GA28601@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

Am Mittwoch, 12. Oktober 2011, 18:16:51 schrieb Matthew Garrett:
> On Wed, Oct 12, 2011 at 11:28:06AM -0400, Alan Stern wrote:
> 
> > Well, if the usage counter is 0 then you wouldn't want to call
> > usb_put_interface_async().  On the other hand, if the usage counter is
> > 0 then by definition the device isn't in use, so you shouldn't need to
> > fail an autosuspend request -- not unless it races with an I/O event.
> 
> Yeah. Plausibly the model we have in hid is wrong at the moment - rather 
> than set flags that block suspend, it might make more sense to take 
> references. It'd complicate things a little, in that we'd have to take 
> more care in terms of keeping track of the state.

I am afraid references are very hard to take there because it needs to be done
in interrupt.

	Regards
		Oliver
