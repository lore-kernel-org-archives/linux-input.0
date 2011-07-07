From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3 v2] input : wacom - Cleanup a return value for the
 old Bamboo
Date: Wed, 6 Jul 2011 22:19:54 -0700
Message-ID: <20110707051954.GB7658@core.coreip.homeip.net>
References: <1309908360-18866-1-git-send-email-pinglinux@gmail.com>
 <CAGzDe_Ya8sFhr=h04vhtGqisbHKf7OFA+n=XVGuFo_tf2NVkWA@mail.gmail.com>
 <20110706055209.GA30776@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48948 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1GGFUA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 01:20:00 -0400
Received: by iyb12 with SMTP id 12so563696iyb.19
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2011 22:20:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110706055209.GA30776@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Jul 06, 2011 at 07:52:09AM +0200, Henrik Rydberg wrote:
> On Tue, Jul 05, 2011 at 09:34:08PM -0500, Chris Bagwell wrote:
> > On Tue, Jul 5, 2011 at 6:26 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > > The old code may call input_sync without sending any other events.
> > > Although the sync event will be ignored in the userland, eliminating
> > > unnecessary kernel events is the right way to go.
> > 
> > Aligns the code block with previous case statement as well.
> > 
> > Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> 
> The sync will not even reach userland, but the patch wont hurt. For
> all patches in the set:
> 
>     Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
> 
> Thanks Ping, thanks Chris.
> 

Applied all 4, thanks everyone.

-- 
Dmitry
