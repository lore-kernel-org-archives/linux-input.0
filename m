From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 09:05:44 -0700
Message-ID: <20111011160544.GC10286@core.coreip.homeip.net>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <20111010224431.GA2377@polaris.bitmath.org>
 <20111011001102.GA28157@srcf.ucam.org>
 <201110110610.12999.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40492 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883Ab1JKQFv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 12:05:51 -0400
Received: by pzk1 with SMTP id 1so19206255pzk.1
        for <linux-input@vger.kernel.org>; Tue, 11 Oct 2011 09:05:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201110110610.12999.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Tue, Oct 11, 2011 at 06:10:12AM +0200, Oliver Neukum wrote:
> Am Dienstag, 11. Oktober 2011, 02:11:03 schrieb Matthew Garrett:
> 
> > Ah, right, sorry - I wasn't trying to use the device after it had been 
> > closed. In an ideal world we'd really want to be able to indicate that 
> > we don't want a remote wakeup in that situation. Otherwise, the patch 
> > looks good. Thank you!
> 
> It looks like we had exactly that capability until
> 48826626263d4a61d06fd8c5805da31f925aefa0
> removed it.
> 

Hmm, reading Alan's comment I can see why wakeup might be beneficial
when system is in the sleep state, but while it is running and there is
no driver or driver wants to disable wakeups I think we should
accommodate it.

Thanks.

-- 
Dmitry
