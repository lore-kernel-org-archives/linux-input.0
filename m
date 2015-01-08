From: Anshul Garg <aksgarg1989@gmail.com>
Subject: Re: [PATCH] Input:Flush client events on clk_type change
Date: Thu, 8 Jan 2015 19:27:59 +0530
Message-ID: <CA+HOOshSijYZnshdKhV+uPW5NKhbQoOZfv3yptsR7Bv2CD7cUA@mail.gmail.com>
References: <aksgarg1989@gmail.com>
	<1420656963-44602-1-git-send-email-aksgarg1989@gmail.com>
	<20150107193207.GA3508@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:47989 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbbAHN6B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 08:58:01 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so9297354lab.11
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 05:58:00 -0800 (PST)
In-Reply-To: <20150107193207.GA3508@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Dear Mr. Dmitry ,

Thanks a lot for your suggestions.

> + spin_lock_irq(&dev->event_lock);
> + spin_lock(&client->buffer_lock);
> + spin_unlock(&dev->event_lock);

Umm, why?

Yes, there is no need of event_lock as we are modifying client
specific data structure only.

Hence only buffer_lock will guarantee atomicity for flushing of client
pending events buffer.

So i will modify locking mechanism to use buffer_lock only.

> +
> + /* Flush clients events after clk_type is changed
> + * and queue SYN_DROPPED event.*/
> + client->packet_head = client->head = client->tail;
> + spin_unlock_irq(&client->buffer_lock);
> +
> + evdev_queue_syn_dropped(client);

This is still racy. I'd rather we passed a flag to
evdev_queue_syn_dropped() to indicate it should also clear queue.

Can you please tell me in which scenario's this patch is prone to race
condition's?
As i think we are modifying the client's buffer indexes so buffer_lock
would be sufficient.


Yes by adding one more parameter in evdev_queue_syn_dropped function
on the basis
of which we can flush the buffer.

Example ::

static void evdev_queue_syn_dropped(struct evdev_client *client)

It can be changed to

static void evdev_queue_syn_dropped(struct evdev_client *client , bool flush)
{
spin_lock(buffer_lock);

if(flush)
    client->packet_head = client->head = client->tail;


.........

spin_unlock(buffer_lock);
}

OR
Similarly we can extend__evdev_flush_queue function to support
flushing of client event queue.
As currently this function flushes single type of events only.

I think 2nd way is better.

Please give your insignt on above suggested changes.

Thanks
Anshul Garg
