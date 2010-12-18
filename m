From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] psmouse: disable the synaptics extension on OLPC machines.
Date: Sat, 18 Dec 2010 10:00:51 +0000
Message-ID: <AANLkTimmcCB455DKt1jMVsLUTr5GdiUgFQzOWeiio361@mail.gmail.com>
References: <20101217210939.19b6111a@queued.net>
	<20101218054927.GA14718@core.coreip.homeip.net>
	<20101217221447.375b9977@queued.net>
	<20101218070205.GA15847@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41788 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab0LRKAw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 05:00:52 -0500
In-Reply-To: <20101218070205.GA15847@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andres Salomon <dilinger@queued.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pgf@laptop.org, James Cameron <quozl@laptop.org>

On 18 December 2010 07:02, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> What about just adding psmouse.proto=exps then?

It's not quite that simple either, because we want the same distro
image to work on all versions of XO. XO's can come with either hgpk,
synaptics, or sentelic touchpads. In the sentelic and hgpk cases, we'd
want the "real" drivers to kick in.

Daniel
