From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] rotary_encoder: fix relative axis support
Date: Mon, 5 Oct 2009 22:05:58 -0700
Message-ID: <20091006050558.GB27881@core.coreip.homeip.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901D42CBE@mi8nycmail19.Mi8.com> <20091001092548.GH9361@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:64745 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbZJFFGl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2009 01:06:41 -0400
Received: by ewy17 with SMTP id 17so3529224ewy.39
        for <linux-input@vger.kernel.org>; Mon, 05 Oct 2009 22:06:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091001092548.GH9361@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, linux-input@vger.kernel.org

On Thu, Oct 01, 2009 at 11:25:48AM +0200, Daniel Mack wrote:
> On Wed, Sep 30, 2009 at 08:33:26PM -0400, H Hartley Sweeten wrote:
> > When the rotart_encoder driver is used to report relative axis
> > information the "steps" in the platform data could be missing
> > since it's not relevant.
> > 
> > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Daniel Mack <daniel@caiaq.de>
> 
> Acked-by: Daniel Mack <daniel@caiaq.de>
> 

Applied, thanks.

-- 
Dmitry
