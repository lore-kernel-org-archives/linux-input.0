From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev - add event-mask API
Date: Thu, 8 Oct 2015 17:27:52 +0200
Message-ID: <CANq1E4TcUMv50hdFenONdcMq0SiFY5zVjia0eQfbvmfKsei+UQ@mail.gmail.com>
References: <1441296841-16894-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34413 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbbJHP1x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 11:27:53 -0400
Received: by wicfx3 with SMTP id fx3so33780366wic.1
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2015 08:27:52 -0700 (PDT)
In-Reply-To: <1441296841-16894-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hey

On Thu, Sep 3, 2015 at 6:14 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hardware manufacturers group keys in the weirdest way possible. This may
> cause a power-key to be grouped together with normal keyboard keys and
> thus be reported on the same kernel interface.
>
> However, user-space is often only interested in specific sets of events.
> For instance, daemons dealing with system-reboot (like systemd-logind)
> listen for KEY_POWER, but are not interested in any main keyboard keys.
> Usually, power keys are reported via separate interfaces, however,
> some i8042 boards report it in the AT matrix. To avoid waking up those
> system daemons on each key-press, we had two ideas:
>  - split off KEY_POWER into a separate interface unconditionally
>  - allow filtering a specific set of events on evdev FDs
>
> Splitting of KEY_POWER is a rather weird way to deal with this and may
> break backwards-compatibility. It is also specific to KEY_POWER and might
> be required for other stuff, too. Moreover, we might end up with a huge
> set of input-devices just to have them properly split.
>
> Hence, this patchset implements the second idea: An event-mask to specify
> which events you're interested in. Two ioctls allow setting this mask for
> each event-type. If not set, all events are reported. The type==0 entry is
> used same as in EVIOCGBIT to set the actual EV_* mask of filtered events.
> This way, you have a two-level filter.
>
> We are heavily forward-compatible to new event-types and event-codes. So
> new user-space will be able to run on an old kernel which doesn't know the
> given event-codes or event-types.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Ping?

David
