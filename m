From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Wed, 9 Dec 2009 12:06:15 -0800
Message-ID: <20091209200614.GA10138@core.coreip.homeip.net>
References: <1260383609-7681-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44505 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbZLIUGP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 15:06:15 -0500
Content-Disposition: inline
In-Reply-To: <1260383609-7681-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Hi Matthew,

On Wed, Dec 09, 2009 at 01:33:28PM -0500, Matthew Garrett wrote:
> Some hardware (such as Dell laptops) signal a variety of events through the
> i8042 controller, even if these don't map to keyboard events. Add support
> for drivers to filter the i8042 event stream in order to respond to these
> events and (if appropriate) block them from entering the input stream.
> 

This is certainly going in the direction I wanted but it looks like
it is more complex than it needs to be. Why don't you just allow
installing global filter for entire i8042 (pass the status register
there along with data byte)? The data you are interested in goes kind of
"ouside" KBD/AUX port abstraction anyway...  Plus currently you are not
handling MUX case properly.

Also I don't think you need to handle the case when we install the same
filter twice? Just always return -EBUSY if there is a filter already and
let drivers keep track of their own stuff and not register tehir filters
twice.

Thanks.

-- 
Dmitry
