From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sa1111ps2 - remove special sa1111 mmio accessors
Date: Tue, 26 Sep 2017 09:48:19 -0700
Message-ID: <20170926164819.GA14833@dtor-ws>
References: <E1dwqel-000418-51@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:49986 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966239AbdIZQsW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 12:48:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id l188so5816167pfc.6
        for <linux-input@vger.kernel.org>; Tue, 26 Sep 2017 09:48:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1dwqel-000418-51@rmk-PC.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-input@vger.kernel.org

On Tue, Sep 26, 2017 at 03:16:15PM +0100, Russell King wrote:
> Remove the special SA1111 MMIO accessors from the SA1111 PS/2 driver
> as their definition will be removed shortly.  The SA1111 accessors are
> barrierless, so use the _relaxed variants.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Russell,

Do you want me to take this patch or would you rather take it through
your tree so removal of the accessors is not stalled by whole release
cycle? Or there are few more drivers that also need to go through the
pipeline so that is not a concern?

Thanks.

-- 
Dmitry
