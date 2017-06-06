From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Input: mouse: Trackpoint middle button not recognized on
 Thinkpad E470
Date: Wed, 7 Jun 2017 09:22:09 +1000
Message-ID: <20170606232209.GA7980@jelly>
References: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
 <f516c725-48d8-6f82-5ac7-c6afee303e59@techfak.uni-bielefeld.de>
 <20170425211633.bl72ajw5duwdpq4j@beacon.debie>
 <20170425221014.GD30843@dtor-ws>
 <a1682c1c-3894-0439-f224-b6c6fc73eba6@techfak.uni-bielefeld.de>
 <20170428210531.3mfkua2lxj36yx2p@beacon.debie>
 <20170531191305.u4hkksajll4q7o5l@beacon.debie>
 <2b78eeba-3f8b-3caf-ee76-cf32147b026e@techfak.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:11542 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdFFXW7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 19:22:59 -0400
Content-Disposition: inline
In-Reply-To: <2b78eeba-3f8b-3caf-ee76-cf32147b026e@techfak.uni-bielefeld.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julian Exner <jexner@techfak.uni-bielefeld.de>
Cc: ulrik.debie-os@e2big.org, Oscar Campos <oscar.campos@member.fsf.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, aduggan@synaptics.com

On Tue, Jun 06, 2017 at 08:09:50PM +0200, Julian Exner wrote:
> Hi all,
> 
> sorry for neglecting this thread for so long. And thanks Ulrik for pointing
> me to the formalities.
> 
> > I was kind of surprised at first that the value was 0x33 instead of 0x3
> > until I read the documentation pointers Julian provided.
> 
> It seems like some kind of softswitch or masking for the individual buttons.
> One of the 4-bit nibbles indicates the number of available buttons in
> hardware, the other one the number of activated buttons.
> 
> > I really would like this patch to become part of the linux kernel and
> > I hope that Julian will go through the formalities for patch submission.
> 
> I'm willing to do so, but I'm very short on time currently. Additionally, I
> checked on a Thinkpad forum and was told that there are Thinkpads from the
> 90s with two buttons (e.g. ThinkPad 760 and those before ThinkPad
> 390/600/770). So I'm a bit afraid that simply setting the default to three
> buttons may break something for these models and a more elaborate patch may
> be necessary.

how many of these do you expect to still be alive *and* in need of a new
kernel? wikipedia says the 760 was produced 1995 to 1998 which would make
the newest of them 19 years old now. I'd rather have a hwdb quirk for those
in userspace, because disabling event codes is trivial.

Cheers,
   Peter
