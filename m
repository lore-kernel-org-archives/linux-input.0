From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input: Use driver hint to compute the evdev buffer
 size
Date: Thu, 3 Jun 2010 23:34:30 -0700
Message-ID: <20100604063429.GB21239@core.coreip.homeip.net>
References: <1275552062-8153-1-git-send-email-rydberg@euromail.se>
 <1275552062-8153-2-git-send-email-rydberg@euromail.se>
 <1275552062-8153-3-git-send-email-rydberg@euromail.se>
 <1275552062-8153-4-git-send-email-rydberg@euromail.se>
 <1275552062-8153-5-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57616 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0FDGeg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Jun 2010 02:34:36 -0400
Content-Disposition: inline
In-Reply-To: <1275552062-8153-5-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

Hi Henrik,

On Thu, Jun 03, 2010 at 10:01:02AM +0200, Henrik Rydberg wrote:
>  
> +static inline void input_set_events_per_packet(struct input_dev *dev, int nev)

A kerneldoc-style comment explaining the purpose of the new function would
be very beneficial.

> +{
> +	dev->hint_events_per_packet = nev;
> +}
> +

Thanks.

-- 
Dmitry
