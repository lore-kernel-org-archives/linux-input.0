From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - remove mouse buttons and axes for dance
 pads
Date: Tue, 13 Jul 2010 09:45:29 -0700
Message-ID: <20100713164528.GB26529@core.coreip.homeip.net>
References: <1278768358.3018.2.camel@lovely.krouter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35660 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab0GMQph (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 12:45:37 -0400
Received: by pxi14 with SMTP id 14so2361929pxi.19
        for <linux-input@vger.kernel.org>; Tue, 13 Jul 2010 09:45:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278768358.3018.2.camel@lovely.krouter>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Nicolas =?iso-8859-1?Q?L=E9veill=E9?= <nicolas@uucidl.com>, Benjamin Valentin <benpicco@zedat.fu-berlin.de>, Anssi Hannula <anssi.hannula@iki.fi>, Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

On Sat, Jul 10, 2010 at 03:25:58PM +0200, Christoph Fritz wrote:
> Dance pads don't have any axes/sticks, only buttons for directions. For
> example buttons like left+right will get triggered at once, an axis
> can't handle this anyway.  So this patch adds a module parameter named
> "sticks_to_null" for unknown devices. A known dance pad makes use of
> it by changing to a new mapping-option named DANCEPAD_MAP_CONFIG. Other
> tested devices may follow by adding this mapping-option too.
> 
> Some buttons of xpad-devices are addressing mouse-buttons instead of
> gamepad-buttons. This gets fixed too.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>

Applied, thanks Christoph.

I hope not many people will be inconvenienced with changing of existing
mapping but the new one is definitely better...

-- 
Dmitry
