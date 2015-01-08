From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Thu, 8 Jan 2015 10:09:14 +0100
Message-ID: <CAMsZVf9j6oQPE201gu3A6f-qRLM6eiBJECUtDFusi_tvLjVWyg@mail.gmail.com>
References: <20141230165739.050cc0b9@kruskal.home.chead.ca>
	<CAMsZVf_UT+m_8BWqz0+aYGJB+8Z_u6xRU7efLZ-Bd7WNhn4ZYA@mail.gmail.com>
	<20150107215004.2f3f748a@kruskal.home.chead.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48074 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbbAHJJP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 04:09:15 -0500
Received: by mail-qa0-f42.google.com with SMTP id n8so6442115qaq.1
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 01:09:14 -0800 (PST)
In-Reply-To: <20150107215004.2f3f748a@kruskal.home.chead.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Christopher Head <chead@chead.ca>

Jiri, I suppose you can close bugzilla bug 70181?

On Thu, Jan 8, 2015 at 6:50 AM, Christopher Head <chead@chead.ca> wrote:
> On Tue, 6 Jan 2015 13:37:26 +0100
> Fredrik Hallenberg <megahallon@gmail.com> wrote:
>
>> ...
>>     if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
>>                   HID_MAIN_ITEM_BUFFERED_BYTE)) &&
>>         (field->flags & HID_MAIN_ITEM_VARIABLE) &&
>>         usage->usage_index < field->maxusage &&
>>         value == field->value[usage->usage_index]) {
>> ...
>
> This works perfectly for me, thanks.
> --
> Christopher Head
