From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 2/4] HID: magicmouse: properly account for scroll
 movement in state
Date: Wed, 16 Jun 2010 11:03:08 -0400
Message-ID: <1276700588.11355.8.camel@cndougla>
References: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>
	 <1275488908-23624-3-git-send-email-chase.douglas@canonical.com>
	 <8739wvel0d.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:41531 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab0FPPDL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 11:03:11 -0400
In-Reply-To: <8739wvel0d.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Michael Poole <mdpoole@troilus.org>

On Wed, 2010-06-09 at 21:25 -0400, Michael Poole wrote:
> Chase Douglas writes:
> 
> > Before this change, sequential scroll events would take a variable
> > amount of movement due to incorrect accounting. This change ensures all
> > scroll movements require a deterministic touch movement for an action to
> > occur.
> >
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> 
> My apologies for the delay in reviewing this one.  I understand now, and
> agree it's the right thing to do here.
> 
> Acked-by: Michael Poole <mdpoole@troilus.org>
> 
> (For the rest of the list, I acked the other three patches in this
> series via private email earlier.)
> 
> Michael Poole

Jiri,

What's the status on the rest of these patches that need to be added in?

Thanks,

-- Chase

