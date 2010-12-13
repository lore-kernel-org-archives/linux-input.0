From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: mt: Support separate contact and finger count
 reports
Date: Sun, 12 Dec 2010 18:34:31 -0800
Message-ID: <20101213023430.GB21401@core.coreip.homeip.net>
References: <1292063308-15327-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57420 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756613Ab0LMCej (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Dec 2010 21:34:39 -0500
Content-Disposition: inline
In-Reply-To: <1292063308-15327-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 11, 2010 at 11:28:27AM +0100, Henrik Rydberg wrote:
> A number of old and semi-recent touch devices are capable of counting
> the number of fingers on the pad within being able to give details for
> all individual contacts. This patch simplifies reporting for such
> hardware by providing a separate function for finger count.
> 

Looks good, just a couple nits below.

>  
>  /**
> + * input_mt_report_finger_count() - report contact count via buttons

"via buttons" is awkward, I'd simply dropped it,

> + * @dev: input device with allocated MT slots
> + * @count: the number of contacts
> + *
> + * Reports the contact count via BTN_TOOL_FINGER, BTN_TOOL_DOUBLETAP,
> + * BTN_TOOL_TRIPLETAP and BTN_TOOL_QUADTAP.
> + *
> + * The input core ensures only the KEY axes already setup for

s/axes/events/ ?

-- 
Dmitry
