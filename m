From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Update Elantech touchpad driver to v5 for
	kernel 2.6.27-rc5-mm1
Date: Fri, 19 Sep 2008 00:17:27 -0400
Message-ID: <20080919041727.GB7594@core.corenet.prv>
References: <20080914032344.GA16228@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:14613 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbYISERi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Sep 2008 00:17:38 -0400
Received: by wr-out-0506.google.com with SMTP id 69so90718wri.5
        for <linux-input@vger.kernel.org>; Thu, 18 Sep 2008 21:17:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080914032344.GA16228@adopmeer.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arjan,

On Sun, Sep 14, 2008 at 05:23:44AM +0200, Arjan Opmeer wrote:
> 
> From: Arjan Opmeer <arjan@opmeer.net>
> 
> Update the Elantech touchpad driver to v5
> 
> - Put the Elantech entry last in the psmouse_protocols[] list as it is also
>   the last one in the psmouse_type enum.
> - Remove support for relative mode. The driver now always uses the touchpad
>   in absolute mode.
> - Add support for the new Elantech touchpad model as found in the EeePC that
>   uses a new protocol.
> 

Could you tell me if issues with pressure reporting mentioned in
bugzilla #8781 have been resolved? I am about to put the driver in my
tree and need to know if I can enable it unconditionally or need to
mark it experimental.

Thanks!

-- 
Dmitry
