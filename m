From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] input: keyboard: introduce lm8323 driver
Date: Fri, 20 Feb 2009 14:15:05 -0800
Message-ID: <20090220141505.d1d53e4b.akpm@linux-foundation.org>
References: <1235046677-29959-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57760 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538AbZBTWPQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2009 17:15:16 -0500
In-Reply-To: <1235046677-29959-1-git-send-email-me@felipebalbi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, felipe.balbi@nokia.com

On Thu, 19 Feb 2009 14:31:17 +0200
Felipe Balbi <me@felipebalbi.com> wrote:

> +struct lm8323_platform_data {
> +	int debounce_time; /* Time to watch for key bouncing, in ms. */
> +	int active_time; /* Idle time until sleep, in ms. */
> +
> +	int size_x;
> +	int size_y;
> +	int repeat : 1;

lm8323_platform_data.repeat appears to be never-written-to?
