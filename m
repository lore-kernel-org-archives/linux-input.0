From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Thu, 10 Mar 2011 19:04:55 +0100
Message-ID: <20110310180455.GA24888@polaris.bitmath.org>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1103011702240.32580@pobox.suse.cz>
 <AANLkTikd67q_j_ySam7RZvau8WoESLEmdXkfCWerVrLp@mail.gmail.com>
 <alpine.LNX.2.00.1103011726300.32580@pobox.suse.cz>
 <20110310161635.GA23223@polaris.bitmath.org>
 <alpine.LNX.2.00.1103101859070.19969@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:53201 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592Ab1CJSCc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 13:02:32 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1103101859070.19969@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > I was wondering if this patch will appear in the final 2.6.38? It
> > seems the regression it fixes is pretty severe for ntrig devices, and
> > once out there, the callback argument change will create problems for
> > add-on modules such as dkms modules.
> 
> Hi Henrik,
> 
> I am not sure Linus will be taking it for .38 still, as he is now offline 
> and will be releasing final .38 after he appears, so it's unlikely that 
> he'll take pull requests unless it's something super-severe.
> 
> I'll put it on my list of commits to be pushed out to 38-stable right 
> away. Does that make sense?

Yes, that will be great. Thanks!

Henrik
