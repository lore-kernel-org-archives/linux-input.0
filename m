From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro
 V13 (was Re: Synaptics touchpad on Dell Vostro V13)
Date: Tue, 11 Jan 2011 08:37:42 -0800
Message-ID: <20110111163741.GA8596@core.coreip.homeip.net>
References: <8583070.26.1294325869588.JavaMail.root@butch.jtdata.net>
 <alpine.LNX.2.00.1101071105350.26685@pobox.suse.cz>
 <20110107172847.GA28785@core.coreip.homeip.net>
 <alpine.LNX.2.00.1101111359410.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62631 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932399Ab1AKQhx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 11:37:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101111359410.26685@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "James T. Dickson" <james.dickson@jtdata.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 02:00:27PM +0100, Jiri Kosina wrote:
> On Fri, 7 Jan 2011, Dmitry Torokhov wrote:
> 
> > > Dmitry, what is your current plan with the notimeout thing for V13, 
> > > please? Still .38 material?
> > 
> > Yeah, especially given that not all V13 seem to suffer from
> > suspend/resume issue.
> 
> Hi Dmitry,
> 
> I can see that you applied the patch, thanks.
> 
> It seems to be in 'next' branch -- does that mean that it will not go in 
> this merge window still?
> 

Hi Jiri,

It is in the next because I wanted to start staging 2nd pull before
Linus pulled first one so I used 'next' for that. I will be merging next
and for-linus tonight and it should be in 38-rc1 unless Linus surprises
us.

Thanks.

-- 
Dmitry
