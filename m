From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Proper representation of button touch (as opposed to button
 press)
Date: Tue, 6 Mar 2012 09:17:42 +0100
Message-ID: <20120306081742.GA26292@polaris.bitmath.org>
References: <CANRwn3SzkR9uDgOTXMgrwY_hJSNdatygnoqXMgVi8G9E2_QDeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:60686 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab2CFIQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Mar 2012 03:16:39 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id A5886EAAC0
	for <linux-input@vger.kernel.org>; Tue,  6 Mar 2012 09:16:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANRwn3SzkR9uDgOTXMgrwY_hJSNdatygnoqXMgVi8G9E2_QDeA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Jason,

> Since "touched" is a natural and distinct button state, it makes sense
> (to me at least) to have EV_KEY define it as an additional legal
> value.

I think it is natural to represent a touched button as an additional
button state, as you say. The question is rather how it should be
incorporated in a backwards-compatible fashion.

Can existing key events be modified to incorporate such a value
without older programs getting confused? Probably not. Can we
duplicate all key values to provided a "touched" version? Maybe. At
least such a scheme would be backwards compatible. If the keys are
added as they become used, it could be sensible. It would also help if
the event properties could be augmented to reflect the touch
property. A new event type would cover it, for instance.

Thanks,
Henrik
