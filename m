From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 11:51:41 +0300
Message-ID: <4CF0C69D.9080904@gmail.com>
References: <4CEE6D2A.9040408@euromail.se> <4CEE6EE8.4060805@gmail.com> <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com> <4CF0BC13.2010800@gmail.com> <20101127083229.GA28745@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34233 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0K0IwE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:52:04 -0500
Received: by ewy5 with SMTP id 5so1267550ewy.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 00:52:03 -0800 (PST)
In-Reply-To: <20101127083229.GA28745@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On 11/27/2010 11:32 AM, Dmitry Torokhov wrote:
> OUCH. We need to fix this _now_. We can not allow reporting resolutions
> in random units. Since we started with unit/mm we have to keep it and
> if it gives issues we can think about adding other units later on, but
> for everyone.
I understand your concerns, but this will make this feature useless for the
8 tablet models I was aiming it at. Most of them have 2000 LPI resolution.

The thing is, I suspect, there is basicly very little to none real devices
correctly specifying their resolution in the report descriptors. Plus almost
no one uses the resolution field in input_absinfo currently and especially
for generic processing (as opposed to working with a specific device). Even
more, I have failed to find any noticeable amount of device drivers filling
it in, but it could be my fault of course.

So, I think, now is the best time to standardize on this and do real
changes.

Sincerely,
Nick
