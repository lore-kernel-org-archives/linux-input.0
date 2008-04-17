From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ati_remote2 loadable keymap support
Date: Thu, 17 Apr 2008 15:00:23 -0400
Message-ID: <20080417144328.ZZRA012@mailhub.coreip.homeip.net>
References: <200804051930.10574.linux@dadeos.co.uk> <20080408201826.GG16619@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:2028 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbYDQTAa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Apr 2008 15:00:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1221266ugc.16
        for <linux-input@vger.kernel.org>; Thu, 17 Apr 2008 12:00:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080408201826.GG16619@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Syrj?l? <syrjala@sci.fi>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Tue, Apr 08, 2008 at 11:18:26PM +0300, Ville Syrj?l? wrote:
> On Sat, Apr 05, 2008 at 07:30:10PM +0100, Peter Stokes wrote:
> > +	u8  hwcode;
> > +	u16 keycode[ARRAY_SIZE(ati_remote2_modes)];
> > +} ati_remote2_keycodes[] = {
> > +/*	 hwcode   AUX1             AUX2             AUX3             AUX4             PC                */
> 
> checkpatch.pl doesn't like these long lines.
> 

In this case screw checkpatch, sometimes longer lines are better than
the alternative.

Peter, is an updated patch addressing other Ville's concerns coming?

-- 
Dmitry
