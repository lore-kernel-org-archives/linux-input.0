From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:evdev - Fix to avoid the execution of same
 instruction in every iteration of for loop.
Date: Wed, 20 May 2015 12:36:44 -0700
Message-ID: <20150520193644.GF23809@dtor-ws>
References: <1432148746-3845-1-git-send-email-shailendra.capricorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:32950 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbbETTgs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 15:36:48 -0400
Content-Disposition: inline
In-Reply-To: <1432148746-3845-1-git-send-email-shailendra.capricorn@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Shailendra,

On Thu, May 21, 2015 at 12:35:46AM +0530, Shailendra Verma wrote:
> Here in for loop the instruction "len / sizeof(compat_long_t)" is used
> as a terminating condition which is executing (being computed) in every
> iteration of for loop. Below is the armv7-a architecture assembly code with
> similar for loop having the same instruction in condition.Note that the
> instruction "lsr r3, r3, #2" i.e Logical Shift Right on behalf of
> "len / sizeof(compat_long_t)" is getting executed every time the loop
> iterates.

No, it is not. We compile kernel with -O2 and compiler is smart enough
to optimize such constructs.

Thanks.

-- 
Dmitry
