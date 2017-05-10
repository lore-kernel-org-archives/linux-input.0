From: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Wed, 10 May 2017 12:44:51 +0200
Message-ID: <16983da3879599981b28ed3ac57c8ee3@suse.de>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56189 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751909AbdEJKox (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 May 2017 06:44:53 -0400
In-Reply-To: <20170510004327.GA32584@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 2017-05-10 02:43, Dmitry Torokhov wrote:
> Hi Michal,
> 
> On Tue, May 09, 2017 at 09:14:18PM +0200, Michal Suchanek wrote:
>> There is nothing mac-specific about this driver. Non-mac hardware with
>> suboptimal built-in pointer devices exists.
>> 
>> This makes it possible to use this emulation not only on x86 and ppc
>> notebooks but also on arm and mips.
> 
> I'd rather we did not promote from drivers/macintosh to other 
> platforms,
> but rather removed it. The same functionality can be done from
> userspace.

Why do we even have drivers/input? What in there cannot be done in 
userspace? We can just remove everything but uinput, right?

> 
> What hardware do you believe would benefit from this and why?

Many notebooks have built-in touchpad that has only two buttons, no or 
limited multitouch and is not built in a way that allows pressing both 
buttons together to trigger the X11 middle button emulation.

This is a facility that exists in the kernel already and allows mapping 
the missing button(s) to keys near the touchpad. Easy, works with 
anything that uses the Linux input events (ie does not depend on X11).

Thanks

Michal
