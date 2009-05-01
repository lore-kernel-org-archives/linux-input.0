From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] appletouch: fix DMA to/from stack buffer
Date: Fri, 1 May 2009 06:36:36 -0700
Message-ID: <200905010636.36778.dmitry.torokhov@gmail.com>
References: <20090428015844.GA16190@hash.localnet> <1240908294.19534.2.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:55877 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751539AbZEANgh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 1 May 2009 09:36:37 -0400
Content-Disposition: inline
In-Reply-To: <1240908294.19534.2.camel@johannes.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bob Copeland <me@bobcopeland.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 28, 2009 at 10:44:54AM +0200, Johannes Berg wrote:
> On Mon, 2009-04-27 at 21:58 -0400, Bob Copeland wrote:
> > CONFIG_DMA_API_DEBUG spotted an instance of appletouch using
> > an array on the stack as a DMA buffer for certain hardware.
> > Change it to use a kmalloc()ed buffer instead.
> > 
> > This fixes the following error:
> 
> > Signed-off-by: Bob Copeland <me@bobcopeland.com>
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Interestingly, I first thought the GFP_KERNEL is wrong due to
> atp_reinit, but the GFP_ATOMIC in that is wrong instead :)
> 

Applied to 'for-linus' branch, thank you.

-- 
Dmitry

