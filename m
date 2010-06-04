From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 0/4] input: evdev: Dynamic buffers (rev3)
Date: Fri, 04 Jun 2010 18:11:47 +0200
Message-ID: <4C0925C3.5060403@bitmath.org>
References: <1275552062-8153-1-git-send-email-rydberg@euromail.se> <20100604065915.GF21239@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp1.one.com ([195.47.247.21]:34725 "EHLO csmtp1.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897Ab0FDQLz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 Jun 2010 12:11:55 -0400
In-Reply-To: <20100604065915.GF21239@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

Dmitry Torokhov wrote:
> Hi Henrik,
[...]
> 
> I think the patchet moves things in the right direction, however I am
> unsure at the moment about buflock implementation. Any chance you coudl
> redo the series without the buflock (with readers taking dev->event_lock
> for now) and once buflock is sorted we can switch to is as a followup).
> 
> Thanks.
> 

Good idea, I will do that.

Thanks,
Henrik

