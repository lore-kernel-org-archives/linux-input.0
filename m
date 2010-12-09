From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 08/20] mfd/tc3589x: rename tc35892 structs/registers to
 tc359x
Date: Thu, 9 Dec 2010 16:45:51 +0100
Message-ID: <20101209154550.GT8884@sortiz-mobl>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
 <1291388753-14662-9-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55924 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166Ab0LIPpy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 10:45:54 -0500
Content-Disposition: inline
In-Reply-To: <1291388753-14662-9-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Sundar,

On Fri, Dec 03, 2010 at 08:35:41PM +0530, Sundar Iyer wrote:
> Most of the register layout, client IRQ numbers on the TC35892 is shared also
> by other variants. Make this generic as tc3589x

I suppose board-mop500.c is the only tc35892 user ? I couldn't find any other
piece of code using it, I just want to double check.
If that's the case then:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
