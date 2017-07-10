From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Mon, 10 Jul 2017 11:11:20 -0700
Message-ID: <20170710181120.GC23984@dtor-ws>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
 <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33199 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbdGJSLX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Jul 2017 14:11:23 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so15534336pfh.0
        for <linux-input@vger.kernel.org>; Mon, 10 Jul 2017 11:11:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, Martin Kaltenbrunner <modin@yuri.at>, Peter Hutterer <peter.hutterer@who-t.net>

On Mon, Jul 10, 2017 at 09:11:53AM +0200, Florian Echtler wrote:
> Good point, I'll send an updated patch ASAP.
> 
> Related question: we first attempted to label non-touch objects as MT_TOOL_PALM,
> but it looks like userspace (Xorg in particular) doesn't actually distinguish
> between MT_TOOL_* types; is that correct?

It really should, but I think Peter never got around implementing this.

Also, I think it is a good idea to set touch major to max in this case.
I believe that that will help clients that do no understand MT_TOOL_PALM
to still do palm rejection.

Peter?

> 
> Best, Florian
> 
> On 09.07.2017 23:41, Dmitry Torokhov wrote:
> > On Sun, Jul 09, 2017 at 08:54:51PM +0200, Florian Echtler wrote:
> >> The SUR40 labels all reported blobs as touch, token, or generic blob.
> >> Previously, all blobs were reported as touch regardless of type, causing
> >> lots of false positives. Present patch fixes this.
> >>
> >> Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
> >> Signed-off-by: Florian Echtler <floe@butterbrot.org>
> >> ---
> >>  drivers/input/touchscreen/sur40.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> >> index 12bdee9..fbd4010 100644
> >> --- a/drivers/input/touchscreen/sur40.c
> >> +++ b/drivers/input/touchscreen/sur40.c
> >> @@ -309,6 +309,8 @@ static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
> >>  	int slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
> >>  	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
> >>  		return;
> >> +	if (blob->type != SUR40_TOUCH)
> >> +		return;
> > 
> > I think we should be checking blob type before trying to get slot
> > number.
> > 
> >>  
> >>  	input_mt_slot(input, slotnum);
> >>  	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
> >> -- 
> >> 2.7.4
> >>
> > 
> > Thanks.
> > 
> 
> 
> -- 
> SENT FROM MY DEC VT50 TERMINAL
> 




-- 
Dmitry
