From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add MAX7359 key switch controller driver, v2
Date: Sun, 10 May 2009 19:08:36 -0700
Message-ID: <200905101908.36933.dmitry.torokhov@gmail.com>
References: <4A04E5EA.7000103@samsung.com> <20090509200118.GB1617@dtor-d630.eng.vmware.com> <4A0784A4.1010703@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:55533 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbZEKCIn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2009 22:08:43 -0400
In-Reply-To: <4A0784A4.1010703@samsung.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kim Kyuwon <q1.kim@samsung.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hi KIm,

On Sunday 10 May 2009 18:51:32 Kim Kyuwon wrote:
> Hi Dmitry,
>
> Thank you for streamlining this driver. I confirmed this streamlined driver
> is nicely working on my S3C6410 board and of course I mostly like your
> changes.

Great, thanks for testing.

> But I'm afraid this 'error' variable is not used at the final
> return statement in the probe function.

*blush* Hm, apparently I did not quite finish converting it all to use
"error" ;) I personally like calling such variables "error" if they are
"returned" only in error path and "ret" or "retval" when they are
returned upon both error and successful completion of a function.
I will fold your patch into the original version, thanks a lot.

-- 
Dmitry
