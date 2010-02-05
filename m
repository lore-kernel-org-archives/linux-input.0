From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Thu, 4 Feb 2010 21:53:02 -0800
Message-ID: <20100205055302.GA17121@core.coreip.homeip.net>
References: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:38017 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0BEFxJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 00:53:09 -0500
Received: by pxi12 with SMTP id 12so3793898pxi.33
        for <linux-input@vger.kernel.org>; Thu, 04 Feb 2010 21:53:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, evilynux@gmail.com

On Thu, Feb 04, 2010 at 10:52:43PM -0500, Rafi Rubin wrote:
 +
> +		if (matched < nd->contact_count) {
> +			for (i = 0; i < nd->contact_count; i++) {
> +				if (nd->contacts[i].logical_id < 0) {
> +					for (j = 0; j < nd->prev_contact_count;
> +					     j++) {
> +						if (nd->
> +						    prev_contacts[j].confidence
> +						    &&
> +						    (contact_map
> +						     [nd->
> +						      prev_contacts
> +						      [j].logical_id] < 0)
> +						    &&
> +						    (abs
> +						     (nd->contacts[i].x -
> +						      nd->prev_contacts[j].x) <
> +						     nd->max_width)
> +						    &&
> +						    (abs
> +						     (nd->contacts[i].y -
> +						      nd->prev_contacts[j].y) <
> +						     nd->max_height)) {
> +							nd->contacts
> +							    [i].logical_id =
> +							    nd->prev_contacts
> +							    [j].logical_id;
> +							contact_map
> +							    [nd->prev_contacts
> +							     [j].logical_id]
> +							    = i;
> +							matched++;

OK, this kind code just makes me want to poke my eyes with a fork... 5
times...

Seriously, either factor it out into a nice function, or say "screw it"
to the 80 columt limit, or maybe both. Anything but this.

Thanks.

-- 
Dmitry
