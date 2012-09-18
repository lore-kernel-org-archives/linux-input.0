From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Input and HID updates for 3.7, version 4
Date: Tue, 18 Sep 2012 18:19:56 +0200
Message-ID: <20120918161956.GA1539@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <20120910190226.GA877@polaris.bitmath.org>
 <alpine.LNX.2.00.1209102248250.22683@pobox.suse.cz>
 <5556929.93aC5q4087@dtor-d630.eng.vmware.com>
 <20120914192554.GA6498@polaris.bitmath.org>
 <20120915153323.GA1391@polaris.bitmath.org>
 <alpine.LNX.2.00.1209181328500.31149@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:54060 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2IRQMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 12:12:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1209181328500.31149@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 18, 2012 at 01:29:29PM +0200, Jiri Kosina wrote:
> On Sat, 15 Sep 2012, Henrik Rydberg wrote:
> 
> > Ok, here is version 4 of the patchset. Rather than sending out all the
> > patches again, the diff to linux-next is given below, and the
> > refreshed tree can be pulled from
> > 
> >   git://github.com/rydberg/linux.git maybe
> > 
> > All Dmitry's comments are addressed. Changes in short:
> > 
> > * Also move 'slot' to input_mt
> > * Oops fix amended
> > * New patch to allow driver pressure handling
> > * Keep the synaptics specials in bcm5974
> > 
> > Needless to say, I want to move this tree to linux-next soonish, so if
> > there are more comments coming, I would appreciate a heads-up.
> 
> So if Dmitry has Acked all the input patches and I am going to take it, 
> could you please send me either a proper pull request, or the patch series 
> via e-mail, so that I could apply it?

Absolutely, a pull request is the plan, but I have not heard anything
from Dmitry yet. Dmitry, no news is good news?

Thanks,
Henrik

ps. Two people got this mail twice, sorry about that.
