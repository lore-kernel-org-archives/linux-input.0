From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH] Input: evdev: Fall back to vmalloc for client event buffer
Date: Mon, 28 Oct 2013 11:50:31 +0000
Message-ID: <CAPj87rMGYQYBPa1uuyKSuaKA8k0wuRQ0yPuvaP1EF4UuAzr+gw@mail.gmail.com>
References: <1381151213-32690-1-git-send-email-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53230 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756403Ab3J1Lud (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Oct 2013 07:50:33 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so6400203wes.19
        for <linux-input@vger.kernel.org>; Mon, 28 Oct 2013 04:50:32 -0700 (PDT)
In-Reply-To: <1381151213-32690-1-git-send-email-daniels@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Henrik Rydberg <rydberg@euromail.se>

Hi,

On 7 October 2013 14:06, Daniel Stone <daniel@fooishbar.org> wrote:
> evdev always tries to allocate the event buffer for clients using
> kzalloc rather than vmalloc, presumably to avoid mapping overhead where
> possible.  However, drivers like bcm5974, which claims support for
> reporting 16 fingers simultaneously, can have an extraordinarily large
> buffer.  The resultant contiguous order-4 allocation attempt fails due
> to fragmentation, and the device is thus unusable until reboot.
>
> Try kzalloc if we can to avoid the mapping overhead, but if that fails,
> fall back to vzalloc.
>
> Signed-off-by: Daniel Stone <daniels@collabora.com>

Ping? This bit me again yesterday, and is pretty much guaranteed to
happen eventually, if you suspend and resume enough times.

Cheers,
Daniel
