From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/4] serio: support multiple child devices per single parent
Date: Sat, 14 Aug 2010 16:01:27 +0400
Message-ID: <AANLkTinaJ2Gu6f8Nof_N7xxmD6f+ntTcX8zuABHVCSYq@mail.gmail.com>
References: <1281605513-11586-1-git-send-email-dbaryshkov@gmail.com>
	<1281605513-11586-2-git-send-email-dbaryshkov@gmail.com>
	<20100813032642.GB2661@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37904 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016Ab0HNMB2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Aug 2010 08:01:28 -0400
Received: by qwh6 with SMTP id 6so3660171qwh.19
        for <linux-input@vger.kernel.org>; Sat, 14 Aug 2010 05:01:27 -0700 (PDT)
In-Reply-To: <20100813032642.GB2661@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On 8/13/10, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Dmitry,
>
> On Thu, Aug 12, 2010 at 01:31:50PM +0400, Dmitry Eremin-Solenikov wrote:
>> Some (rare) serio devices need to have multiple serio children. One of
>> the examples is PS/2 multiplexer present on several TQC STKxxx boards,
>> which connect PS/2 keyboard and mouse to single tty port.
>>
>
> I like idea of the patch, however I'd prefer if we kept recurstion out
> of the serio core and instead stick to iterative algorithms. Any chance
> you could rework the part that travels the [sub]trees?

Would you mind another list_head embedded into struct strio?
If it's suitable solution, I've refactored recursion out.

-- 
With best wishes
Dmitry
