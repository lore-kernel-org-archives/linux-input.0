From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [Question : drivers/input ] Fixing Event Filter Mechanism in input subsystem
Date: Mon, 22 Dec 2014 18:43:26 +0530
Message-ID: <CA+HOOsiKrg14kr7VKGn1h0NP54YUABr=P5ZjX17Y2s477RGfPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:40863 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbaLVNN0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Dec 2014 08:13:26 -0500
Received: by mail-yk0-f177.google.com with SMTP id 9so2191751ykp.8
        for <linux-input@vger.kernel.org>; Mon, 22 Dec 2014 05:13:26 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "anshul.g@samsung.com" <anshul.g@samsung.com>, linux-input@vger.kernel.org

Dear Mr. Dmitry and Linux Community,

I am Anshul Garg working on Linux Kernel from last 2 years .

I have one query regarding event filter mechanism in input subsystem.
Can you please help in answering my query as below:

=====================================================
In function input_pass_values in input.c file , input core sends all
events to each handler associated with

the input device ,

rcu_read_lock();

handle = rcu_dereference(dev->grab);
if (handle) {
count = input_to_handler(handle, vals, count);
} else {
list_for_each_entry_rcu(handle, &dev->h_list, d_node)
if (handle->open)
count = input_to_handler(handle, vals, count);
}

after this in input_to_handler function events are filtered and sent
to the handler.

for (v = vals; v != vals + count; v++) {
if (handler->filter &&
   handler->filter(handle, v->type, v->code, v->value))
continue;
if (end != v)
*end = *v;
end++;
}



But as per previous event filter mechanism all the events should be
parsed from all
handlers after that remaining events should be sent to handlers list.

And in comments also its mentioned as

/*
 * Pass event first through all filters and then, if event has not been
 * filtered out, through all open handles.*/

So current approach to filter events seems to be incorrect.

Please help to clarify my query.


I have prepared one patch with new event filter mechanism which will
first filter all events from attached handlers then pass the remaining
events after being filtered
through all handlers unlike current implementation.

Once My query is resolved , I will send the patch.


Thanks
Anshul Garg
+91-9899777351
