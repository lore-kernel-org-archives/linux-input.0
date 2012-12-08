From: Kamal Mostafa <kamal@canonical.com>
Subject: Re: [PATCH v6] Cypress PS/2 Trackpad driver
Date: Sat, 08 Dec 2012 09:03:45 -0800
Message-ID: <1354986225.2795.107.camel@fourier>
References: <1354846216-19707-1-git-send-email-kamal@canonical.com>
	 <20121208125405.GA3183@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47586 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964947Ab2LHRDo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Dec 2012 12:03:44 -0500
In-Reply-To: <20121208125405.GA3183@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dudley Du <dudl@cypress.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>

Hi Henrik-

On Sat, 2012-12-08 at 13:54 +0100, Henrik Rydberg wrote:
>  [...]
> > --- a/drivers/input/mouse/Kconfig
> > +++ b/drivers/input/mouse/Kconfig
> > @@ -68,6 +68,16 @@ config MOUSE_PS2_SYNAPTICS
> >  
> >  	  If unsure, say Y.
> >  
> > +config MOUSE_PS2_CYPRESS
> > +       bool "Cypress PS/2 mouse protocol extension" if EXPERT
> 
> Why EXPERT here?
> 
> > +       default y
> 
> Should it really be default y here?


This config entry (with phrases "if EXPERT" and "default y") was simply
cloned from similar devices (e.g. SYNAPTICS, ALPS, LIFEBOOK).

If your preference is that CYPRESS should be disabled by default, I'll
omit those phrases.  Please advise.


> > +			case 0:	return(4);
> 
> No parenthesis on return.


I'll fix that.


>     Reviewed-by: Henrik Rydberg <rydberg@euromail.se>


Thanks!

 -Kamal


