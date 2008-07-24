From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/input/misc/uinput.c: Removed duplicated include
Date: Wed, 23 Jul 2008 23:39:35 -0400
Message-ID: <20080724033935.GA1341@anvil.corenet.prv>
References: <20080723221059.9434.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:8549 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbYGXDji (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2008 23:39:38 -0400
Received: by an-out-0708.google.com with SMTP id d40so599921and.103
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2008 20:39:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080723221059.9434.WEIYI.HUANG@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: vojtech@suse.cz, linux-input@vger.kernel.org

On Wed, Jul 23, 2008 at 10:45:05PM +0800, Huang Weiyi wrote:
> Removed duplicated include file <linux/smp_lock.h> in 
> drivers/input/misc/uinput.c.
> 

Applied, thank you Huang.

-- 
Dmitry
