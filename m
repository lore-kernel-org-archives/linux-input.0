From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Problem with Mighty Mouse
Date: Thu, 17 Oct 2013 15:30:24 -0400
Message-ID: <CAN+gG=E3JgUZ9vGY7N-D3OYLGcRqy5OXu8w5WXjJ2YLuYW4UWw@mail.gmail.com>
References: <1381621726.21761.7.camel@nuvo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:61300 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669Ab3JQTaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Oct 2013 15:30:25 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so2287206lab.11
        for <linux-input@vger.kernel.org>; Thu, 17 Oct 2013 12:30:24 -0700 (PDT)
In-Reply-To: <1381621726.21761.7.camel@nuvo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Bastien,

On Sat, Oct 12, 2013 at 7:48 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Heya,
>
> I've tested a Bluetooth Apple Mighty Mouse (AA1197) and though I can
> move the cursor without a problem, none of the buttons work. evtest
> doesn't see any button events.
>
> Any ideas what I should look at, or which tool I could use to capture
> the raw data?

you can use hid-recorder[1] to retrieve the raw events from hidraw (it
mainly does a hexdump on /dev/hidrawX or you can use the kernel
debugfs interface for some devices which are preventing hidraw to
forward the events).

Ideally, you should give the output of evtest (or evemu) and
hid-recorder at the same time so we can have an idea of the input and
the output of the kernel driver.

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/

>
> Cheers
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
