From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Fri, 11 Aug 2017 08:14:03 +0200
Message-ID: <5528ad84-9b42-8826-abb1-1aef06876284@bitmath.org>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay1.public.one.com ([91.198.169.124]:45854 "EHLO
        mailrelay1.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdHKG2o (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 02:28:44 -0400
In-Reply-To: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On 08/11/2017 02:44 AM, Dmitry Torokhov wrote:

> According to Microsoft specification [1] for Precision Touchpads (and
> Touchscreens) the devices use "confidence" reports to signal accidental
> touches, or contacts that are "too large to be a finger". Instead of
> simply marking contact inactive in this case (which causes issues if
> contact was originally proper and we lost confidence in it later, as
> this results in accidental clicks, drags, etc), let's report such
> contacts as MT_TOOL_PALM and let userspace decide what to do.
> Additionally, let's report contact size for such touches as maximum
> allowed for major/minor, which should help userspace that is not yet
> aware of MT_TOOL_PALM to still perform palm rejection.
>
> An additional complication, is that some firmwares do not report
> non-confident touches as active. To cope with this we delay release of
> such contact (i.e. if contact was active we first report it as still
> active MT+TOOL_PALM and then synthesize the release event in a separate
> frame).
Changing the tool identity to signal the tool property of low confidence 
does not seem quite right to me. Using MT_TOOL_PALM forces a semantic 
distinction between tool identity and touch state, which userland seems 
unprepared for. The additional kernel state needed to make it work 
raises the question if more considerations will turn up over with time.

Why not add a property event, like BTN_TOOL_PALM, instead? In other 
words, modifying the definition of "active" as you propose, but then use 
a BTN_TOOL_PALM property to signal "s->confidence_state"? It perhaps 
creates a different oddity for applications unaware of palm, but AFAICT, 
it would not complicate the notion of touch state. Or?

Henrik

