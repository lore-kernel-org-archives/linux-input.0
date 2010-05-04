From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mt: introduce MT event slots
Date: Tue, 4 May 2010 10:29:03 -0700
Message-ID: <20100504172903.GB29428@core.coreip.homeip.net>
References: <1270685590-2204-1-git-send-email-rydberg@euromail.se>
 <20100415232523.GA18263@core.coreip.homeip.net>
 <4BDFD356.7070008@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51374 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab0EDR3P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 May 2010 13:29:15 -0400
Content-Disposition: inline
In-Reply-To: <4BDFD356.7070008@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 04, 2010 at 09:57:10AM +0200, Henrik Rydberg wrote:
> > It would be nice to use abs[ABS_MT_MAX - ABS_MT_TOUCH_MAJOR] to save
> > some memory.
> > 
> 
> Is it possible this was meant to read "ABS_MAX - ABS_MT_TOUCH_MAJOR"? It would
> explain my confusion.
> 

By ABS_MT_MAX I meant highest MT event currently defined. No need to go all
the way to ABS_MAX if there are no MT events defined there.

-- 
Dmitry
