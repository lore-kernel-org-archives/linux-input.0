From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 17:59:05 +0100
Message-ID: <20111012165905.GA29313@srcf.ucam.org>
References: <201110121637.22442.oliver@neukum.org>
 <Pine.LNX.4.44L0.1110121101420.2093-100000@iolanthe.rowland.org>
 <20111012161651.GA28601@srcf.ucam.org>
 <201110121856.32444.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45454 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1JLQ7H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 12:59:07 -0400
Content-Disposition: inline
In-Reply-To: <201110121856.32444.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

On Wed, Oct 12, 2011 at 06:56:32PM +0200, Oliver Neukum wrote:
> Am Mittwoch, 12. Oktober 2011, 18:16:51 schrieb Matthew Garrett:
> > Yeah. Plausibly the model we have in hid is wrong at the moment - rather 
> > than set flags that block suspend, it might make more sense to take 
> > references. It'd complicate things a little, in that we'd have to take 
> > more care in terms of keeping track of the state.
> 
> I am afraid references are very hard to take there because it needs to be done
> in interrupt.

True. That makes things rather more awkward.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
