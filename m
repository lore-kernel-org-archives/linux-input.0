From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question : drivers/input ] Fixing Event Filter Mechanism in
 input subsystem
Date: Mon, 22 Dec 2014 09:26:22 -0800
Message-ID: <20141222172622.GA18556@dtor-ws>
References: <CA+HOOsgL_fY=Wc+ciDAuk485d=uTn=YTgVGVDJ5Qk3UsqQ8zVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40987 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbaLVR02 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Dec 2014 12:26:28 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so4527192iec.25
        for <linux-input@vger.kernel.org>; Mon, 22 Dec 2014 09:26:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+HOOsgL_fY=Wc+ciDAuk485d=uTn=YTgVGVDJ5Qk3UsqQ8zVA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Hi Anshul,

On Mon, Dec 22, 2014 at 10:36:09PM +0530, Anshul Garg wrote:
> In function input_pass_values in input.c file , input core sends all
> events to each handler associated with the input device ,
> 
> rcu_read_lock();
> 
> handle = rcu_dereference(dev->grab);
> if (handle) {
> count = input_to_handler(handle, vals, count);
> } else {
> list_for_each_entry_rcu(handle, &dev->h_list, d_node)
> if (handle->open)
> count = input_to_handler(handle, vals, count);
> }
> 
> after this in input_to_handler function events are filtered and sent
> to the handler.
> 
> for (v = vals; v != vals + count; v++) {
> if (handler->filter &&
>    handler->filter(handle, v->type, v->code, v->value))
> continue;
> if (end != v)
> *end = *v;
> end++;
> }
> 
> 
> 
> But as per previous event filter mechanism all the events should be
> parsed from all
> handlers after that remaining events should be sent to handlers list.
> 
> And in comments also its mentioned as
> 
> /*
>  * Pass event first through all filters and then, if event has not been
>  * filtered out, through all open handles.*/
> 
> So current approach to filter events seems to be incorrect.
> 
> Please help to clarify my query.

When you "grab" input device your handler gets exclusive access to all
events coming form it. Neither filer handlers nor regular input handlers
receive events from this device until you release it.

So I believe it works as intended.

Thanks.

-- 
Dmitry
