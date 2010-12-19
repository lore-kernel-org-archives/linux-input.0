From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse: disable the synaptics extension on OLPC
 machines.
Date: Sun, 19 Dec 2010 00:20:27 -0800
Message-ID: <20101219082026.GD10074@core.coreip.homeip.net>
References: <20101217210939.19b6111a@queued.net>
 <20101218054927.GA14718@core.coreip.homeip.net>
 <20101217221447.375b9977@queued.net>
 <20101218070205.GA15847@core.coreip.homeip.net>
 <AANLkTimmcCB455DKt1jMVsLUTr5GdiUgFQzOWeiio361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:49216 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0LSIUe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Dec 2010 03:20:34 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimmcCB455DKt1jMVsLUTr5GdiUgFQzOWeiio361@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Andres Salomon <dilinger@queued.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pgf@laptop.org, James Cameron <quozl@laptop.org>

On Sat, Dec 18, 2010 at 10:00:51AM +0000, Daniel Drake wrote:
> On 18 December 2010 07:02, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > What about just adding psmouse.proto=exps then?
> 
> It's not quite that simple either, because we want the same distro
> image to work on all versions of XO. XO's can come with either hgpk,
> synaptics, or sentelic touchpads. In the sentelic and hgpk cases, we'd
> want the "real" drivers to kick in.
> 

Hmm, I am confused. HGPK depends on OLPC so your distribution must have
it defined. Are there general purpose distributions that enable OLPC?

Thanks.

-- 
Dmitry
