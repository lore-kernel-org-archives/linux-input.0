From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 21:42:50 +0100
Message-ID: <20111011204250.GA14186@srcf.ucam.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <201110110610.12999.oliver@neukum.org>
 <20111011110421.GA21008@polaris.bitmath.org>
 <201110111309.21132.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43838 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab1JKUm5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 16:42:57 -0400
Content-Disposition: inline
In-Reply-To: <201110111309.21132.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, dtor@mail.ru

On Tue, Oct 11, 2011 at 01:09:21PM +0200, Oliver Neukum wrote:
> Am Dienstag, 11. Oktober 2011, 13:04:21 schrieb Henrik Rydberg:
> > Problem: the hid keyboard driver refuses to suspend while a key is
> > pressed, which is fine per se, but there is no indication presented to the power layer,
> > resulting in a failed suspend and (due to complex reasons it seems) disabled autosuspend.
> 
> That is a bug. Autosuspend at a later date should happen.

Yeah, there's definitely something broken here. If I hold down a key on 
a USB keyboard for more than two seconds then it attempts to suspend but 
fails. Releasing the key triggers another usb_mark_busy() but the core 
never tries to suspend it again. What /does/ trigger a second attempt at 
suspend is toggling an LED on and then off.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
