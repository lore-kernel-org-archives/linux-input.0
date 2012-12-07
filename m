From: Kamal Mostafa <kamal@canonical.com>
Subject: Re: [PATCH v5 2/3] input: Cypress PS/2 Trackpad psmouse driver
Date: Thu, 06 Dec 2012 18:09:04 -0800
Message-ID: <1354846144.2795.76.camel@fourier>
References: <1354752976-27257-1-git-send-email-kamal@canonical.com>
	 <1354752976-27257-3-git-send-email-kamal@canonical.com>
	 <20121206080850.GC25921@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121206080850.GC25921@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Dudley Du <dudl@cypress.com>, David Solda <dso@cypress.com>, Troy Abercrombia <ta@cypress.com>, Kyle Fazzari <git@status.e4ward.com>, Mario Limonciello <mario_limonciello@dell.com>, Tim Gardner <tim.gardner@canonical.com>, Herton Krzesinski <herton.krzesinski@canonical.com>
List-Id: linux-input@vger.kernel.org

On Thu, 2012-12-06 at 00:08 -0800, Dmitry Torokhov wrote:
> [...]


Hi Dmitry-

Thanks again for your review.  The forthcoming PATCH v6 addresses all of
your requests, except for:

> > +	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
> 
> I do not think it should be marked INPUT_PROP_BUTTONPAD if it has
> physical buttons...

This device (my particular Cypress Trackpad unit anyway) does not have
physical buttons.  The pad is clickable; I think it is a standard
"buttonpad" device.



And just FYI, this issue has been addressed but to answer your question:

> > +
> > +	if (cytp->mode & CYTP_BIT_ABS_MASK) {
> 
> It can't be anything else, can it?

It can: in the case when the mode hasn't been set at all yet (during
detect and reconnect).  I cleaned up the logic of this routine
(cypress_validate_byte) and added explanatory comments.


 -Kamal
