From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Invert HWHEEL mappings for some Logitech mice
Date: Wed, 18 Jun 2008 18:03:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806181802480.23194@twin.jikos.cz>
References: <1213464384-4602-1-git-send-email-dbn.lists@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:59944 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYFRQDG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Jun 2008 12:03:06 -0400
In-Reply-To: <1213464384-4602-1-git-send-email-dbn.lists@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Nicholson <dbn.lists@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, 14 Jun 2008, Dan Nicholson wrote:

> Some Logitech mice have a tilt wheel which register as HWHEEL buttons.
> The events are positive for a click to the right and negative for a
> click to the left. Applications expect the opposite, though.
> I suspect this affects a lot more Logitech mice, but these are the only
> two I have. I tested this using evtest and a GTK application. A similar
> Microsoft Intellimouse I have works correctly.

Thanks Dan, applied.

-- 
Jiri Kosina
SUSE Labs

