From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove useless synchronize_rcu() calls
Date: Wed, 11 May 2011 15:42:25 -0700
Message-ID: <20110511224225.GF11178@core.coreip.homeip.net>
References: <1305149155.3232.11.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55587 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932265Ab1EKWmb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 18:42:31 -0400
Content-Disposition: inline
In-Reply-To: <1305149155.3232.11.camel@edumazet-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, May 11, 2011 at 11:25:55PM +0200, Eric Dumazet wrote:
> There is no need to call synchronize_rcu() after a list insertion,
> or a NULL->ptr assignment.
> 
> However, the reverse operations do need this call.

Applied, thanks Eric.

-- 
Dmitry
