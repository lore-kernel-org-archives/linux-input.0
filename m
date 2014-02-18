From: Clinton Sprain <clintonsprain@gmail.com>
Subject: Re: USB keyboard occasional key stuck
Date: Mon, 17 Feb 2014 20:08:50 -0600
Message-ID: <5302C0B2.9010506@gmail.com>
References: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34714 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbaBRCQg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 21:16:36 -0500
In-Reply-To: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel J Blueman <daniel@quora.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I noticed your examples are both fn combos. I'm seeing something like
this and it seems specifically related to the fn key. Reproducible on a
Macbook (3,1) and a Lenovo Yoga 13. Sequence is simple:

Press key
Press fn
Release key
Release fn

The key will be 'stuck' until you press another key. It seems to only
apply to keys that are part of a fn combo, so affected keys vary from
one model to another; it appears that if nothing is mapped to fn+key on
a given hardware, the key is not affected. For example, delete is
affected on the Macbook (which has fn+delete = backspace), but not on
the Yoga (which has a dedicated backspace key). Arrow keys are an
exception to this rule though.

Is this what you're seeing?

- Clinton

On 02/17/2014 07:23 AM, Daniel J Blueman wrote:
> Across 5+ years of kernels, I've been seeing occasional (1-2 times per
> day) key-stuck issues where eg a fn+delete combo repeats delete until
> I press delete again. I've seen this happen with fn+ctrl+left, leaving
> left held and likewise with right.
>
> This has occurred on Apple laptops, external USB keyboards and Dell
> laptops, so seems like a linux USB input issue, as I haven't seen
> occur on Windows or MacOS on the same hardware.
>
> It seems a good move for me to rebuild and run a kernel with some USB
> HID instrumentation to locate this issue over time. Without apriori
> knowledge of the linux USB input stack, what is a good initial
> approach?
>
> Thanks,
>   Daniel

