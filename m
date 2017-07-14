From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Fri, 14 Jul 2017 09:54:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1707140951540.18874@butterbrot>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org> <1499626491-22592-2-git-send-email-floe@butterbrot.org> <20170709214105.GE21945@dtor-ws> <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org> <20170710181120.GC23984@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:44383 "EHLO butterbrot.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdGNHyE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Jul 2017 03:54:04 -0400
In-Reply-To: <20170710181120.GC23984@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Martin Kaltenbrunner <modin@yuri.at>, Peter Hutterer <peter.hutterer@who-t.net>

On Mon, 10 Jul 2017, Dmitry Torokhov wrote:
> On Mon, Jul 10, 2017 at 09:11:53AM +0200, Florian Echtler wrote:
>>
>> Related question: we first attempted to label non-touch objects as MT_TOOL_PALM,
>> but it looks like userspace (Xorg in particular) doesn't actually distinguish
>> between MT_TOOL_* types; is that correct?
>
> It really should, but I think Peter never got around implementing this.
>
> Also, I think it is a good idea to set touch major to max in this case.
> I believe that that will help clients that do no understand MT_TOOL_PALM
> to still do palm rejection.
>
> Peter?

Would you consider merging v2 of the patch regardless of the Xorg 
situation? Right now, it's a useful bugfix in any case, and we can deal 
with how to represent blobs/palms/tokens later on.

Best, Florian
-- 
"_Nothing_ brightens up my morning. Coffee simply provides a shade of
grey just above the pitch-black of the infinite depths of the _abyss_."
