From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom - Provide a range for the ABS_MISC axis
Date: Sat, 24 Aug 2013 16:50:39 -0700
Message-ID: <20130824235039.GG4454@core.coreip.homeip.net>
References: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
 <1377220537-1474-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:57702 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab3HXXum (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Aug 2013 19:50:42 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so2044601pbb.14
        for <linux-input@vger.kernel.org>; Sat, 24 Aug 2013 16:50:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377220537-1474-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, pinglinux@gmail.com

Hi Jason,

On Thu, Aug 22, 2013 at 06:15:36PM -0700, Jason Gerecke wrote:
> Android marks found axes as 'valid' only if they have a minimum
> and maximum value that aren't equal. Since we don't actually
> assign any range information for ABS_MISC, Android doesn't bother
> to mark it such. This prevents userspace from being able to make
> use of tool serial information.

That should be fixed in Android code. Min/max are filled on best effort
basis and 0/0 is effectively unknown.

Thanks.

-- 
Dmitry
