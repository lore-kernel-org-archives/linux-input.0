From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: i8042 - make function definitions in i8042.h
 "static inline"
Date: Wed, 30 Jun 2010 00:50:03 -0700
Message-ID: <20100630075003.GB4154@core.coreip.homeip.net>
References: <1277875611-22907-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64014 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab0F3HuI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 03:50:08 -0400
Received: by pxi8 with SMTP id 8so245809pxi.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 00:50:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277875611-22907-1-git-send-email-feng.tang@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: feng.tang@intel.com
Cc: linux-input@vger.kernel.org

On Wed, Jun 30, 2010 at 01:26:51PM +0800, feng.tang@intel.com wrote:
> From: Feng Tang <feng.tang@intel.com>
> 
> Otherwise when build kernel with allyesconfig on x86_32, it will
> have such errors:
> 

Applied, thank you Feng. Not sure what I was thinking when I omitted
"inline" on these stubs...

-- 
Dmitry
