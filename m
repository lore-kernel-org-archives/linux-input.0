From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 00:32:30 -0800
Message-ID: <20101127083229.GA28745@core.coreip.homeip.net>
References: <4CEE6D2A.9040408@euromail.se>
 <4CEE6EE8.4060805@gmail.com>
 <AANLkTim3D0w5DzmKU6wckxJT3HeHK8eoMO1Zge1zOWOE@mail.gmail.com>
 <4CF0BC13.2010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45306 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0K0Icg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 03:32:36 -0500
Received: by iwn35 with SMTP id 35so349846iwn.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 00:32:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF0BC13.2010800@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Sat, Nov 27, 2010 at 11:06:43AM +0300, Nikolai Kondrashov wrote:
> On 11/27/2010 02:02 AM, Chris Bagwell wrote:
> >When I looked at input_absinfo.resolution, I see only synaptics.c is
> >using it right now and it is defined using units/mm.
> I'm not sure if it matters a lot, but Jiri has accepted my resolution
> calculation patch to hid-input.c [1] which does it in *units/inch* for
> generic HID devices, which choose to provide correct information in their
> report descriptors.
> 

OUCH. We need to fix this _now_. We can not allow reporting resolutions
in random units. Since we started with unit/mm we have to keep it and
if it gives issues we can think about adding other units later on, but
for everyone.

-- 
Dmitry
