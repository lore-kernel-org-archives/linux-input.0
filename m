From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question: drivers/input/input.c] Why input_no is initialized to 0 ?
Date: Thu, 20 Nov 2014 11:29:36 -0800
Message-ID: <4948988.DE0CZFC5sn@dtor-glaptop>
References: <CADYu3087SYHPSzzEP+92Kh69fUN7gXS1otAsmT8SfuPLQB3h_A@mail.gmail.com> <20141119205713.GG37989@dtor-ws> <CADYu30_O1CPKyAkQb+dQfQViDurej5Y37AbR-bbWd3TpBg=HKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63330 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaKTT3k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 14:29:40 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so3290170iec.8
        for <linux-input@vger.kernel.org>; Thu, 20 Nov 2014 11:29:39 -0800 (PST)
In-Reply-To: <CADYu30_O1CPKyAkQb+dQfQViDurej5Y37AbR-bbWd3TpBg=HKw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thursday, November 20, 2014 02:49:24 AM Aniroop Mathur wrote:
> Hello Mr. Torokhov,
> 
> Thank you for your answer.
> 
> As it is not a problem now, How about changing it to -1 ?
> Although extra subtraction is not expensive but still we could optimize it
> as we want kernel to optimized as much as possible.

Send patches. I think we have the same pattern in several subsystems.

Thanks.

-- 
Dmitry
