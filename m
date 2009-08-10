From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: Add keypad driver for w90p910
Date: Sun, 9 Aug 2009 21:47:25 -0700
Message-ID: <20090810051749.27122526EC9@mailhub.coreip.homeip.net>
References: <4A5C6D2A.7040501@gmail.com> <20090810020638.6B2EE526EC9@mailhub.coreip.homeip.net> <e68bb3470908092044x337f2f2ch10c7bdff79a5533c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:61205 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZHJEr3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 00:47:29 -0400
Received: by rv-out-0506.google.com with SMTP id f6so893215rvb.1
        for <linux-input@vger.kernel.org>; Sun, 09 Aug 2009 21:47:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e68bb3470908092044x337f2f2ch10c7bdff79a5533c@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, "Eric.miao" <eric.y.miao@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Trilok Soni <soni.trilok@gmail.com>

On Mon, Aug 10, 2009 at 11:44:34AM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> I have tested this patch, and it work very well.
> Thank you for helping me fix my keypad driver and I appreciate this kindness.
> 

Great, thank you for testing Wan. The w90p910_keypad is now in my 'next'
branch and should be pulled in the next merge window.

-- 
Dmitry
