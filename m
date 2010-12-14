From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] input: mt: Interface and MT_TOOL documentation updates
Date: Tue, 14 Dec 2010 13:53:05 +1000
Message-ID: <20101214035303.GA11781@salty.local>
References: <1292001842-5000-1-git-send-email-rydberg@euromail.se>
 <20101210173611.GA1630@core.coreip.homeip.net>
 <4D026634.4000602@euromail.se>
 <AANLkTimnJpmRJCFhOvZndTmL3r21KEdqXr2Bd9ZT3kUb@mail.gmail.com>
 <4D0267A6.5020603@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:48015 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab0LNDx3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 22:53:29 -0500
Content-Disposition: inline
In-Reply-To: <4D0267A6.5020603@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pinglinux@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 10, 2010 at 06:47:18PM +0100, Henrik Rydberg wrote:
> >>> Legacy to me implies we can upgrade, but this is hardware limitation.
> 
> >>> Can we say "rectangle corner - used by older hardware"?
> >>>
> >> How about "- older hw only", to stay within a single line?
> > 
> > Why do we suggest it will only be used by older hardware?
> 
> 
> To limit its use - we really do not want to use anything but good contact data
> anywhere, but we do not want to leave abundant (= old) hardware out, either.
> Why, is there some case where it would be useful, you think?

"old" implies a timeline but for all we know some new hardware may come out
tomorrow that requires the use of this field. so it's new old hardware then
:)

"limited capabilities hw" maybe? my bikeshed is green, btw.

Cheers,
  Peter
