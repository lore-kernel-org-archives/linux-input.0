From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 16/20] HID: Only dump input if someone is listening
Date: Mon, 10 Sep 2012 14:12:19 -0700
Message-ID: <5556929.93aC5q4087@dtor-d630.eng.vmware.com>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se> <20120910190226.GA877@polaris.bitmath.org> <alpine.LNX.2.00.1209102248250.22683@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42222 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2IJVMY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 17:12:24 -0400
In-Reply-To: <alpine.LNX.2.00.1209102248250.22683@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, September 10, 2012 10:49:13 PM Jiri Kosina wrote:
> On Mon, 10 Sep 2012, Henrik Rydberg wrote:
> > > how do you want to handle this? I am fine with all the HID changes. So
> > > either I can take it through my tree and add your Sigoff to the Input
> > > patches (if you are fine with those), or vice versa (or take this
> > > through
> > > git branches, i.e. you apply the Input bits, I fetch that branch, and
> > > apply the rest on top of it).
> > 
> > I went ahead and pushed the (updated) branch to my for-next, to get
> > some integration coverage. It is that time. Jiri, I added your
> > Acked-by on the hid patches for now, hope that is alright.
> 
> Yes, it is, thanks Henrik.
> 
> Dmitry, I can pull the whole lot into my tree once you Ack/Signoff the
> input patches, if you wish.

Yes, let me try to go through the patches tonight and I'll let yo know...

-- 
Dmitry
