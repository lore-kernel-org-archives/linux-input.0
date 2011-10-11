From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 01:11:03 +0100
Message-ID: <20111011001102.GA28157@srcf.ucam.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <20111010210534.GA2223@polaris.bitmath.org>
 <20111010211231.GA26359@srcf.ucam.org>
 <20111010224431.GA2377@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45353 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1JKALG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 20:11:06 -0400
Content-Disposition: inline
In-Reply-To: <20111010224431.GA2377@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

On Tue, Oct 11, 2011 at 12:44:31AM +0200, Henrik Rydberg wrote:
> On Mon, Oct 10, 2011 at 10:12:31PM +0100, Matthew Garrett wrote:
> > Is this with the patch I sent for usbhid earlier applied? Right now the 
> > keyboard will fail to suspend after system suspend, which will keep the 
> > entire composite device awake. I'm looking into your other issue now.
> 
> Ahh, yes, the suspend failure was due to the keyboard interface,
> thanks. The loop-on-closed is still present, though (as expected,
> since there is no usb_mark_last_busy() call).

Ah, right, sorry - I wasn't trying to use the device after it had been 
closed. In an ideal world we'd really want to be able to indicate that 
we don't want a remote wakeup in that situation. Otherwise, the patch 
looks good. Thank you!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
