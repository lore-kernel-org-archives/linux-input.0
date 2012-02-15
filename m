From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] Fix ALPS touchpad detection
Date: Wed, 15 Feb 2012 10:18:55 -0600
Message-ID: <20120215161855.GA2495@ubuntu-macmini>
References: <4F3BABF1.8050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48586 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab2BOQS7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Feb 2012 11:18:59 -0500
Content-Disposition: inline
In-Reply-To: <4F3BABF1.8050204@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Akio Idehara <zbe64533@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 15, 2012 at 09:58:25PM +0900, Akio Idehara wrote:
> ALPS touchpad detection fails if some buttons of ALPS are pressed.
> The reason is that the query response byte is different from what is expected.
> This was tested on a Toshiba Portege R500.

I've reproduced the problem and confirmed that your approach fixes it.

However, your patch seems to be malformed as it won't apply cleanly for
me. For the comment you're modifying you should also keep the line
length under 80 characters.

This fix seems like a good candidate for stable as well.

Seth
