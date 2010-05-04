From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] input: mt: introduce MT event slots
Date: Tue, 04 May 2010 09:57:10 +0200
Message-ID: <4BDFD356.7070008@bitmath.org>
References: <1270685590-2204-1-git-send-email-rydberg@euromail.se> <20100415232523.GA18263@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:58371 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753866Ab0EDH5P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 May 2010 03:57:15 -0400
In-Reply-To: <20100415232523.GA18263@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> It would be nice to use abs[ABS_MT_MAX - ABS_MT_TOUCH_MAJOR] to save
> some memory.
> 

Is it possible this was meant to read "ABS_MAX - ABS_MT_TOUCH_MAJOR"? It would
explain my confusion.

Henrik

