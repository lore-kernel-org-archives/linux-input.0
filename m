From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v6] Cypress PS/2 Trackpad driver
Date: Mon, 10 Dec 2012 18:13:59 +0100
Message-ID: <20121210171359.GA881@polaris.bitmath.org>
References: <1354846216-19707-1-git-send-email-kamal@canonical.com>
 <20121208125405.GA3183@polaris.bitmath.org>
 <1354986225.2795.107.camel@fourier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:44366 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab2LJRL2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Dec 2012 12:11:28 -0500
Content-Disposition: inline
In-Reply-To: <1354986225.2795.107.camel@fourier>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dudley Du <dudl@cypress.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>

> > > +config MOUSE_PS2_CYPRESS
> > > +       bool "Cypress PS/2 mouse protocol extension" if EXPERT
> > 
> > Why EXPERT here?
> > 
> > > +       default y
> > 
> > Should it really be default y here?
> 
> 
> This config entry (with phrases "if EXPERT" and "default y") was simply
> cloned from similar devices (e.g. SYNAPTICS, ALPS, LIFEBOOK).
> 
> If your preference is that CYPRESS should be disabled by default, I'll
> omit those phrases.  Please advise.

Dmitry, which default do you prefer here?

Henrik
