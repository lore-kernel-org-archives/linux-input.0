From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: enable all buttons on the TiVo Slide Pro remote
Date: Sun, 15 Mar 2015 10:05:36 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1503151005240.24876@pobox.suse.cz>
References: <i825gaplvjcd1oha4ethkjj325m51ujano@4ax.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60890 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbbCOOFi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Mar 2015 10:05:38 -0400
In-Reply-To: <i825gaplvjcd1oha4ethkjj325m51ujano@4ax.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Wilkinson <web11.forest@tibit.com>
Cc: linux-input@vger.kernel.org

On Thu, 12 Mar 2015, Forest Wilkinson wrote:

> The linux kernel has supported the TiVo Slide remote control for some time,
> but does not recognize the USB ID of the newer Slide Pro. This patch adds
> the missing data structures so the newer remote will be recognized by the
> driver, thereby allowing the TiVo, LiveTV, and Thumbs Up/Down buttons to be
> mapped with a hwdb file.
> 
> Signed-off-by: Forest Wilkinson <web11.forest@tibit.com>

Applied to for-4.0/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
