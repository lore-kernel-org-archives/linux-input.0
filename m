From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: add support for PenMount dual-touch panel
Date: Wed, 20 Apr 2011 12:07:59 +0200
Message-ID: <20110420100759.GA2436@polaris.bitmath.org>
References: <1303291155-3148-1-git-send-email-salt@salt.com.tw>
 <20110420094700.GA2258@polaris.bitmath.org>
 <BANLkTin7Q3fD3vg90qCk12MGaVEvLBe0Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:53063 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab1DTKGZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2011 06:06:25 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin7Q3fD3vg90qCk12MGaVEvLBe0Mg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Richard Nauber <richard.nauber@googlemail.com>, PenMount <penmount.touch@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, PenMount <salt@salt.com.tw>

> > Benjamin: Since field->index == 0 is in use, it seems the driver could
> > execute event emission wrongly under some circumstances (when
> > last_field_index == 0). Is that related to the reason for the quirk in
> > this patch?
> 
> In fact, I have a second patch just on top of this one. It has been
> tested by Ryan with PenMount devices.

Great, and good timing. :-)

> I was waiting for Penmount to be included first as it does not impact
> any other drivers.

I would prefer the opposite order, since it is cleaner and means one
less device to test for the major change.

> 
> I inline the code here, but my gmail client will destroy tabs (so I
> attached it too)....
> 
> Can you test it against 3M?

I will test it against 3M and egalax. Thanks!

Henrik
