From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Thu, 13 Oct 2011 08:47:33 +0200
Message-ID: <201110130847.33353.oliver@neukum.org>
References: <20111012135439.GA25266@srcf.ucam.org> <201110121638.38747.oliver@neukum.org> <20111012185003.GB10397@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54410 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab1JMGrM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 02:47:12 -0400
In-Reply-To: <20111012185003.GB10397@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Am Mittwoch, 12. Oktober 2011, 20:50:03 schrieb Henrik Rydberg:
> On Wed, Oct 12, 2011 at 04:38:38PM +0200, Oliver Neukum wrote:
> > Am Mittwoch, 12. Oktober 2011, 16:26:21 schrieb Matthew Garrett:
> > > Sorry, yes, you're right. In that case it's probably working for me 
> > > because the keyboard is another interface on the same device, so the 
> > > wakeup bit is being set from there.
> > 
> > Very good. A mystery is solved. Indeed you may have found
> > a deficiency in the USB spec.
> 
> Glad you sorted this out. So we can really only treat a device as one
> (auto)power unit, due to remote wakeup being requested at the device level,
> rather than at the interface level.

Yes, when in doubt we must request it, even at the cost of unnecessary wakeups.
This also means that only Matthew's latest patch is correct. We cannot depend
on the usbhid always be loaded and requesting remote wakeups.

	Regards
		Oliver
