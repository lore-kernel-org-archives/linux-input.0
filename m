From: Arjan Opmeer <arjan@opmeer.net>
Subject: Re: [PATCH] input: elantech.c provide a workaround for jumpy
	cursor on firmware 2.34
Date: Sat, 21 Mar 2009 13:17:57 +0100
Message-ID: <20090321121757.GB24247@adopmeer.homeip.net>
References: <20090320053509.GA3633@adopmeer.homeip.net> <200903202246.37383.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:47937 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZCUMSA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2009 08:18:00 -0400
Content-Disposition: inline
In-Reply-To: <200903202246.37383.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 20, 2009 at 10:46:37PM -0700, Dmitry Torokhov wrote:
> On Thursday 19 March 2009 22:35:09 Arjan Opmeer wrote:
> >
> > +	if (etd->jumpy_cursor) {
> > +		/* Discard packets that are likely to have bogus coordinates */
> > +		if (fingers > old_fingers) {
> > +			elantech_debug("elantech.c: discarding packet\n");
> > +			goto discard_packet_v1;
> 
> Can we do this unconditionally for the v1 protocol and not have an extra
> konb?

That is of course possible, although I am not sure it will not have any
negative side effects.

> Do you have access to boxes with unbroken V1 to test?

Nope. I am sorry. I don't have access to any machine with an Elantech
touchpad after my laptop died. I am trying to give the best support I can by
using 'remote development' where users have to report and test changes to
the driver. As you can imagine it is slow going.


Arjan
