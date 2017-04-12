From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] xen,input: add xen-kbdfront module parameter for
 setting resolution
Date: Wed, 12 Apr 2017 08:16:41 -0700
Message-ID: <20170412151641.GA6297@dtor-ws>
References: <20170411123037.31733-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34179 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbdDLPQp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 11:16:45 -0400
Content-Disposition: inline
In-Reply-To: <20170411123037.31733-1-jgross@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, boris.ostrovsky@oracle.com, andr2000@gmail.com

Hi Juergen,

On Tue, Apr 11, 2017 at 02:30:37PM +0200, Juergen Gross wrote:
> Add a parameter for setting the resolution of xen-kbdfront in order to
> be able to cope with a (virtual) frame buffer of arbitrary resolution.
> 
> While at it remove the pointless second reading of parameters from
> Xenstore in the device connection phase: all parameters are available
> during device probing already and that is where they should be read.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V3: - merged the two patches
>     - read Xenstore parameters during probing of the device only

I guess 2 module parameters are not big deal, but could you tell me why
you can't always have them specified in Xenstore?

Also, I still think you are going in the wrong direction here. Can your
framebuffer size change after booting the guest? If it can, you have to
reconcile the new size and the coordinates reported by the pointing
device, and I think guest should be doing it. If you look, for example,
at vmmouse driver, they do not try to match coordinates it reports to
the screen.

Thanks.

-- 
Dmitry
