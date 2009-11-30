From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Mon, 30 Nov 2009 16:59:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911301658240.4478-100000@iolanthe.rowland.org>
References: <87aay3losp.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49030 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752265AbZK3V7g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 16:59:36 -0500
In-Reply-To: <87aay3losp.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 30 Nov 2009, Ferenc Wagner wrote:

> > Just out of curiosity, how do you decide when the input should be 
> > muted and unmuted?
> 
> That's application logic.  For example, the user touches the "Lock"
> button, then slips the gadget into his pocket.  Then most other buttons
> (like volume control) are muted until the device is unlocked again by
> some very specific action.  My mobile phone doesn't work like this, it
> reacts to each button even when it's locked (though of course does
> nothing but says how to unlock it).

Okay.  This wasn't clear to me before.

> Well, I thought runtime PM is intended to have some "common sense"
> semantics, so it can be automatic.  After all, it's perfectly reasonable
> for somebody else to want the "normal" runtime PM for gpio-keys: to
> autosuspend when not in use.  If we stole the callbacks for our purpose,
> the "expected" behaviour couldn't be implemented later.  In other words,
> the wanted behaviour is not device specific, but usage specific.  And
> the runtime suspend behaviour of a device can't be usage specific, it
> should match common expectations (to the extent it's possible to talk
> about common expectations wrt. runtime PM -- but you may still want to
> build one up).  Are these fears unfounded?  Is runtime PM not what I
> think it is?

No, you are right.  Runtime PM is not well suited for this purpose.

Alan Stern

