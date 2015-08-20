From: Gabor Balla <gaborwho@gmail.com>
Subject: Re: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Fri, 21 Aug 2015 01:05:46 +0200
Message-ID: <CAMmwwr8ycdXKbrsfe_ameK+ZmdH2yZbUtMtcZrrceSAfsgz_0g@mail.gmail.com>
References: <CAMmwwr-7fQcMa=DiiCO+GU7R1ZLgh6o2SD40q+gTPmcu=A_8uA@mail.gmail.com>
	<20150820213526.GA10980@localhost>
	<CAMmwwr-uYWurxAQnDdy9hVO-A3PGK92uSmHjYagp5eTXmPnZ_Q@mail.gmail.com>
	<20150820225633.GA12900@localhost>
	<CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f65.google.com ([209.85.215.65]:35510 "EHLO
	mail-la0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbbHTXFr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 19:05:47 -0400
Received: by labia3 with SMTP id ia3so2629985lab.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 16:05:46 -0700 (PDT)
In-Reply-To: <CAKdAkRQwOhQ7ysyAQ3QV=mRfXBvVxC=wrqOhhK1J4YLpWh2hRA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Stephen Chandler Paul <thatslyude@gmail.com>, Nick Bowler <nbowler@draconx.ca>, Andrew Duggan <andrew.duggan@gmail.com>

Hi Dmitry,

On Fri, Aug 21, 2015 at 1:01 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Aug 20, 2015 at 3:56 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Fri, Aug 21, 2015 at 12:24:59AM +0200, Gabor Balla wrote:
>>> Hi Dmitry,
>>>
>>> On Thu, Aug 20, 2015 at 11:35 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Thu, Aug 20, 2015 at 10:50:27PM +0200, Gabor Balla wrote:
[...]
> Ah, wait, not quite still. So we actually do want to disable gestures
> when in Absolute mode (non extended). Although frankly I do not think
> we'll ever see pre 4.0 Synaptics device in a wild.

Also notice there is a function called synaptics_set_disable_gesture that can
change that bit regardless of current mode.

Thanks (also for your patience),
Gabor
