From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: X-Box one controller causes Xpad to crash [NEW INFO]
Date: Fri, 27 Nov 2015 09:34:36 -0800
Message-ID: <20151127173436.GB27040@dtor-ws>
References: <56588978.9030300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36776 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbbK0Rej (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 12:34:39 -0500
Received: by pacdm15 with SMTP id dm15so119773789pac.3
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2015 09:34:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56588978.9030300@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Beilharz <greenbigfrog@gmail.com>
Cc: pavel@rojtberg.net, linux-input@vger.kernel.org

Hi Jonathan,

On Fri, Nov 27, 2015 at 05:48:56PM +0100, Jonathan Beilharz wrote:
> Still haven't got it on the mailing list... Also can't find any info
> on how to add new stuff. I already had sent an email sometime ago
> but since then I found out more.

Hmm, not sure why your email do not reach the list, it does not require
subscription for posting...

> 
> [1.] One line summary of the problem:
> X-Box one controller causes Xpad to crash
> 
> [2.] Full description of the problem/report:
> Plugging in the so called "Xbox one (converted forces)" controller
> crashes the Xpad module.
> Important part of dmesg:
> "BUG: unable to handle kernel NULL pointer dereference at 000000000000004e"
> "RIP  [<ffffffffc02c952a>] xpad_probe+0x37a/0x9eb [xpad]"
> 

You need the following commit from mainline:

39a7a88872df98f0c3c50fe278fd1a1f597afd95  - Input: xpad - add Covert
Forces edition of the Xbox One controller

There was a report that while it fixes the crash the controller is not
really working, so I'd like to hear about your results.

Thanks.

-- 
Dmitry
