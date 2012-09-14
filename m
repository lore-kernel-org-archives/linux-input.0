From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 16/20] HID: Only dump input if someone is listening
Date: Fri, 14 Sep 2012 21:25:54 +0200
Message-ID: <20120914192554.GA6498@polaris.bitmath.org>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se>
 <20120910190226.GA877@polaris.bitmath.org>
 <alpine.LNX.2.00.1209102248250.22683@pobox.suse.cz>
 <5556929.93aC5q4087@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:49677 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab2INTSc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 15:18:32 -0400
Content-Disposition: inline
In-Reply-To: <5556929.93aC5q4087@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > > I went ahead and pushed the (updated) branch to my for-next, to get
> > > some integration coverage. It is that time. Jiri, I added your
> > > Acked-by on the hid patches for now, hope that is alright.
> > 
> > Yes, it is, thanks Henrik.
> > 
> > Dmitry, I can pull the whole lot into my tree once you Ack/Signoff the
> > input patches, if you wish.
> 
> Yes, let me try to go through the patches tonight and I'll let yo know...

Dmitry, given the oops-fix amended, are you ok with the input core
changes at this point? If so, I can add your ACK on those, and refresh
the input, input-mt and hid changes to next. I will be back with the
reworked bcm5974 set, but the rest should be ready for a pull from
Jiri.

Thanks,
Henrik
