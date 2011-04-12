From: wanlong gao <wanlong.gao@gmail.com>
Subject: Re: [PATCH] INPUT:Change a more clearly name for the input handlers' table
Date: Tue, 12 Apr 2011 20:01:07 +0800
Message-ID: <BANLkTikDvdNa-Mob3oBwrqSqR3NmXPyo0w@mail.gmail.com>
References: <1302265424-4434-1-git-send-email-wanlong.gao@gmail.com>
	<20110412062416.GE1854@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110412062416.GE1854@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 4/12/11, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Fri, Apr 08, 2011 at 08:23:44PM +0800, wanlong.gao@gmail.com wrote:
>> From: Wanlong Gao <wanlong.gao@gmail.com>
>>
>> Change the input handlers' table name to input_handler_table for
>> making more clearly sense .
>>
>
> Sorry but I think the old name is fine. I'd rather see this table
> removed altogether and character devices pushed down into input handlers
> themselves.
If so , it will be a really hard work .
Thanks a lot.
>
> Thanks.
>
> --
> Dmitry
>
