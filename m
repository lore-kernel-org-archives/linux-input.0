From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: wm97xx-core - add retries to
 wm97xx_read_aux_adc
Date: Sun, 5 Sep 2010 22:51:34 -0700
Message-ID: <20100906055134.GH17212@core.coreip.homeip.net>
References: <1283519614-14963-1-git-send-email-emillbrandt@dekaresearch.com>
 <20100903132509.GD8381@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64794 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab0IFFvj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Sep 2010 01:51:39 -0400
Received: by pwi3 with SMTP id 3so996091pwi.19
        for <linux-input@vger.kernel.org>; Sun, 05 Sep 2010 22:51:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100903132509.GD8381@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eric Millbrandt <emillbrandt@dekaresearch.com>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-input@vger.kernel.org

On Fri, Sep 03, 2010 at 02:25:09PM +0100, Mark Brown wrote:
> On Fri, Sep 03, 2010 at 09:13:34AM -0400, Eric Millbrandt wrote:
> > Add logic to wm97xx_read_aux_adc() to retry reading the adc if the
> > sample failed.  This could occur if the previous sample was still in
> > the return register or the sample timed-out.  Also avoid a pathologic
> > failure mode by disabling the digitizer and returning -EBUSY after 5
> > retries.
> > 
> > Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> 
> Good stuff - thanks!
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied to next, thanks.

-- 
Dmitry
