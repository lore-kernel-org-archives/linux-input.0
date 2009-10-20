From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REPOST] [PATCH] Add support for OQO 01+ multimedia keys (fwd)
Date: Mon, 19 Oct 2009 18:38:59 -0700
Message-ID: <20091020013859.GD24370@core.coreip.homeip.net>
References: <alpine.DEB.1.10.0906302300290.9420@woodchuck.wormnet.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f197.google.com ([209.85.222.197]:33967 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758164AbZJTBjB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 21:39:01 -0400
Received: by pzk35 with SMTP id 35so3958693pzk.22
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2009 18:39:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0906302300290.9420@woodchuck.wormnet.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jamie@lentin.co.uk>
Cc: linux-input@vger.kernel.org

Hi Jamie,

On Tue, Jun 30, 2009 at 11:06:49PM +0100, Jamie Lentin wrote:
> Apologies for reposting, but it'd be nice to get something along these  
> lines merged.  If there's suggestions of other things I could try, or  
> you'd prefer a patch to make the "up" and "down" keycodes auto-release,  
> please let me know.
>

I am sorry, I completely missed your patch and just now was going
through my inbox and saw it...

Could you please tell me if OQO has external PS/2 port? And also if you
could give me the raw data stream from these keys (reported with
i8042.debug) that would be grand. Plus, who is the keyboard identified
in dmesg? Is it "AT Translated Set 2" or 'AT Raw set 2"?

Thanks!

-- 
Dmitry
