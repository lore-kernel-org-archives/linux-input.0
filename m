From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] wacom + runtime PM = AA deadlock
Date: Mon, 4 Oct 2010 11:38:49 -0700
Message-ID: <20101004183848.GG8321@core.coreip.homeip.net>
References: <4C8E180D.4020309@suse.cz>
 <201009140807.39977.oliver@neukum.org>
 <20101004161320.GA14180@core.coreip.homeip.net>
 <201010042033.53453.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51248 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab0JDSi6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Oct 2010 14:38:58 -0400
Content-Disposition: inline
In-Reply-To: <201010042033.53453.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm@lists.linux-foundation.org, pingc@wacom.com, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, Oct 04, 2010 at 08:33:53PM +0200, Oliver Neukum wrote:
> Am Montag, 4. Oktober 2010, 18:13:20 schrieb Dmitry Torokhov:
> > Lost track of this issue for a while. So I think we still need to fix
> > the deadlock for .36 and I think that the following will do that. Then
> > we'll adjust the driver to actually enable runtime PM for .37.
> 
> That's a viable plan.
> 

I take it as an "acked-by" for this patch, right?

-- 
Dmitry
