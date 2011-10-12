From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 18:26:31 +0100
Message-ID: <20111012172631.GA29762@srcf.ucam.org>
References: <20111012165905.GA29313@srcf.ucam.org>
 <Pine.LNX.4.44L0.1110121323090.2093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49156 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab1JLR0f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 13:26:35 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1110121323090.2093-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, Oct 12, 2011 at 01:24:42PM -0400, Alan Stern wrote:
> On Wed, 12 Oct 2011, Matthew Garrett wrote:
> > True. That makes things rather more awkward.
> 
> What about the second idea I mentioned?  If autosuspend fails with
> -EBUSY or -EAGAIN, usbcore could schedule another autosuspend attempt.

Yeah, that sounds better.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
