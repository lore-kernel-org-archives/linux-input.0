From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - Adjust threshold for treating position values as negative
Date: Mon, 10 Sep 2012 14:10:13 -0700
Message-ID: <5697296.C0n5qnnV7e@dtor-d630.eng.vmware.com>
References: <1347281227-20973-1-git-send-email-seth.forshee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42226 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab2IJVK3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 17:10:29 -0400
Received: by pbbrr13 with SMTP id rr13so3049361pbb.19
        for <linux-input@vger.kernel.org>; Mon, 10 Sep 2012 14:10:28 -0700 (PDT)
In-Reply-To: <1347281227-20973-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: linux-input@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>

On Monday, September 10, 2012 07:47:07 AM Seth Forshee wrote:
> Commit c039450 (Input: synaptics - handle out of bounds values from the
> hardware) caused any hardware reported values over 7167 to be treated as
> a wrapped-around negative value. It turns out that some firmware uses
> the value 8176 to indicate a finger near the edge of the touchpad whose
> actual position cannot be determined. This value now gets treated as
> negative, which can cause pointer jumps and broken edge scrolling on
> these machines.
> 
> I only know of one touchpad which reports negative values, and this
> hardware never reports any value lower than -8 (i.e. 8184). Moving the
> threshold for treating a value as negative up to 8176 should work fine
> then for any hardware we currently know about, and since we're dealing
> with unspecified behavior it's probably the best we can do. The special
> 8176 value is also likely to result in sudden jumps in position, so
> let's also clamp this to the maximum speicified value for the axis.

It looks like there is another touchpad that got broken with that "out of 
bounds" change, see:

https://bugzilla.kernel.org/show_bug.cgi?id=46371

Thanks.

-- 
Dmitry
