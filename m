From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 1/3] input: add ABS_PRESSURE to da9034 touchscreen
Date: Mon, 13 Apr 2009 13:31:34 +0800
Message-ID: <f17812d70904122231j4aaa0386x3b25e5b6a62698ff@mail.gmail.com>
References: <f17812d70904122108r7b951b95o45ad9735722d8e7b@mail.gmail.com>
	 <20090413051345.GA15752@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:34739 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbZDMFbf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2009 01:31:35 -0400
Received: by gxk4 with SMTP id 4so4291401gxk.13
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2009 22:31:34 -0700 (PDT)
In-Reply-To: <20090413051345.GA15752@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Bin Yang <bin.yang@marvell.com>

On Mon, Apr 13, 2009 at 1:13 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Eric,
>
> On Mon, Apr 13, 2009 at 12:08:33PM +0800, Eric Miao wrote:
>> From 509bb071200cfe582199ba3ce2533e81949f42f0 Mon Sep 17 00:00:00 2001
>> From: Eric Miao <eric.miao@marvell.com>
>> Date: Mon, 13 Apr 2009 10:52:59 +0800
>> Subject: [PATCH 1/3] input: add ABS_PRESSURE to da9034 touchscreen
>>
>
> The driver does not seem to be reporting true pressure readings but
> surrogate events. Tslib has been updated to not require ABS_PRESSURE to
> recognize devices as touchscreens so this patch is not needed.
>

Some legacy apps here still require this to be reported, I'm a bit
upset that this will just break those apps.

> --
> Dmitry
>



-- 
Cheers
- eric
