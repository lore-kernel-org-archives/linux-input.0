From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] Emit TOUCH with DOUBLETAP for single touch
Date: Tue, 13 Apr 2010 15:27:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004131526300.8345@pobox.suse.cz>
References: <1270850306-4949-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37464 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806Ab0DMN1I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 09:27:08 -0400
In-Reply-To: <1270850306-4949-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr

On Fri, 9 Apr 2010, Rafi Rubin wrote:

> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
> 
> I squelched TipSwitch in a recent patch which resulted in the loss
> of Touch events for single touch firmwares.  This patch just puts Touch back
> in for single touch, and bundles it with DoubleTap (like the multitouch code).
> The two events are used to convey the same message to different drivers.

Thanks Rafi. This should probably still be .34 material, right?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
