From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add depends on support for w90p910 ts.
Date: Sun, 12 Jul 2009 20:48:52 -0700
Message-ID: <20090713034851.GF10819@dtor-d630.eng.vmware.com>
References: <4A56024F.4060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:15251 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbZGMDs4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jul 2009 23:48:56 -0400
Received: by wf-out-1314.google.com with SMTP id 26so673476wfd.4
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2009 20:48:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A56024F.4060500@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Wan,

On Thu, Jul 09, 2009 at 10:44:31PM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> Add depends on support for w90p910 ts.
> 

Since it compiles just fone on other arches that have HAVE_CLK I think I
will just leave that dependency. Please adjust your arch to sleect
HAVE_CLK.

Thanks!

-- 
Dmitry
