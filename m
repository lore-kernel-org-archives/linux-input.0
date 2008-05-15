From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fix migor_ts dependency and compile warning
Date: Thu, 15 May 2008 08:38:54 -0400
Message-ID: <20080515083758.ZZRA012@mailhub.coreip.homeip.net>
References: <20080515113821.18971.12147.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:28477 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbYEOMi6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 May 2008 08:38:58 -0400
Received: by py-out-1112.google.com with SMTP id u52so324407pyb.10
        for <linux-input@vger.kernel.org>; Thu, 15 May 2008 05:38:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080515113821.18971.12147.sendpatchset@rx1.opensource.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Magnus,

On Thu, May 15, 2008 at 08:38:21PM +0900, Magnus Damm wrote:
> This patch adds I2C dependencies to the MigoR touchscreen driver,
> and while at it kills off a compile warning.
> 

I am going to fold it into original patch since I have to rebuild my
tree for that -next thing, if you don't mind.

-- 
Dmitry
