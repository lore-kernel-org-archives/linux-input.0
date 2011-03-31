From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] uinput: Allow for 0/0 min/max on absolute axes.
Date: Wed, 30 Mar 2011 22:25:26 -0700
Message-ID: <20110331052526.GA31630@core.coreip.homeip.net>
References: <20110331050503.GA9318@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56220 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab1CaFZc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 01:25:32 -0400
Content-Disposition: inline
In-Reply-To: <20110331050503.GA9318@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 31, 2011 at 03:05:03PM +1000, Peter Hutterer wrote:
> Some devices provide absolute axes with min/max of 0/0 (e.g. wacom's
> ABS_MISC axis). Current uinput restrictions do not allow duplication of
> these devices and require hacks in userspace to work around this.
> 
> If the kernel accepts physical devices with a min/max of 0/0, uinput
> shouldn't disallow the same range.
> 

Right, we should treat 0/0 as unlimited, or not specified, not
applicable.

Applied, thank you Peter.

-- 
Dmitry
