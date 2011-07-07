From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Revert to anonymous 'type A' MT protocol for touch
Date: Thu, 7 Jul 2011 14:35:06 -0700
Message-ID: <20110707213506.GA20310@core.coreip.homeip.net>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39467 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab1GGVfO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 17:35:14 -0400
Received: by pwj7 with SMTP id 7so737392pwj.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 14:35:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>

On Thu, Jul 07, 2011 at 02:04:57PM -0700, Jason Gerecke wrote:
> Android (at least up to Gingerbread) does not understand the 'B' protocol
> first made available in 2.6.36. As a workaround until this is fixed, we
> drop back to using the 'A' protocol.
> 

Well, fix Android then. Same goes for patches 2 & 3.

Thanks.

-- 
Dmitry
