From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH resend] N-Trig: change default value of logical/physical
 width/height to 1
Date: Tue, 25 Sep 2012 15:23:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209251522590.1391@pobox.suse.cz>
References: <1347956828-5967-1-git-send-email-jesse.sung@canonical.com> <1348570267-15322-1-git-send-email-jesse.sung@canonical.com> <50619CE4.2020604@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60738 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab2IYNXV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Sep 2012 09:23:21 -0400
In-Reply-To: <50619CE4.2020604@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Jesse Sung <jesse.sung@canonical.com>, linux-input@vger.kernel.org

On Tue, 25 Sep 2012, Rafi Rubin wrote:

> > Since something will be divided by these variables in 
> > show_min_width()/show_min_height() and show_activate_width()/ 
> > show_activate_height(), a divided error would be triggered if they are
> > zero.
> 
> Fair point about the divide by zero.  Would it be preferable to use real
> values.  As far as I know these devices all have logical dimensions of
> 9600x7200.  Unfortunately both logical and physical are used as denominators,
> so 1 for the physicals is probably sensible.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
