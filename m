From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 08:32:45 +0200
Message-ID: <201110120832.45938.oliver@neukum.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com> <201110111309.21132.oliver@neukum.org> <20111011204250.GA14186@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:39041 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1JLGc1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 02:32:27 -0400
In-Reply-To: <20111011204250.GA14186@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, dtor@mail.ru

Am Dienstag, 11. Oktober 2011, 22:42:50 schrieb Matthew Garrett:
> On Tue, Oct 11, 2011 at 01:09:21PM +0200, Oliver Neukum wrote:
> > Am Dienstag, 11. Oktober 2011, 13:04:21 schrieb Henrik Rydberg:
> > > Problem: the hid keyboard driver refuses to suspend while a key is
> > > pressed, which is fine per se, but there is no indication presented to the power layer,
> > > resulting in a failed suspend and (due to complex reasons it seems) disabled autosuspend.
> > 
> > That is a bug. Autosuspend at a later date should happen.
> 
> Yeah, there's definitely something broken here. If I hold down a key on 
> a USB keyboard for more than two seconds then it attempts to suspend but 
> fails. Releasing the key triggers another usb_mark_busy() but the core 
> never tries to suspend it again. What /does/ trigger a second attempt at 
> suspend is toggling an LED on and then off.

It seems to me that rpm_suspend() in drivers/base/power has already called
pm_runtime_cancel_pending(dev) unconditionally before calling rpm_callback()
And afterwards the timer is not restarted.

	Regards
		Oliver
