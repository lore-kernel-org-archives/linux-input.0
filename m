From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify
	exact irq flags
Date: Wed, 25 Nov 2009 22:35:07 -0800
Message-ID: <20091126063506.GM23244@core.coreip.homeip.net>
References: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com> <87y6lxchwf.fsf@tac.ki.iif.hu> <20091123172451.GD17813@core.coreip.homeip.net> <87tywlcbyr.fsf@tac.ki.iif.hu> <20091124063711.GL17675@esdhcp04058.research.nokia.com> <87my2cp4h6.fsf@tac.ki.iif.hu> <20091124170249.GQ17675@esdhcp04058.research.nokia.com> <87k4xfojhb.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:52720 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbZKZGfG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 01:35:06 -0500
Received: by pxi10 with SMTP id 10so344161pxi.33
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2009 22:35:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87k4xfojhb.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Mika Westerberg <ext-mika.1.westerberg@nokia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Nov 24, 2009 at 07:39:28PM +0100, Ferenc Wagner wrote:
> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> 
> >
> > So I'll try to implement this gpio-keys muting so that it allows
> > also multiple buttons to share single IRQ line.
> 
> Thanks.  But you'd better wait for Dmitry's response, because I'm by no
> means authoritative in this business.

I would not refuse a reasonable patch as long as there is a use case for
it. The only think is that I would prefer to keep compatibility with the
current format of the platform data, otherwise we will screw up embedded
guys that are currently using the driver. But if compatibility results
in too ugly code then I reserve the right to invoke "out of tree drivers
- don't care" card ;)

-- 
Dmitry
