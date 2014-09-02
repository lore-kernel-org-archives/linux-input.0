From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 0/2] input: Add INPUT_PROP_POINTING_STICK property
Date: Tue, 2 Sep 2014 14:55:53 +0200
Message-ID: <CANq1E4TU9Q3eWm25LhySk28de7r4tjZTLaCMHLOfVo738fnoFg@mail.gmail.com>
References: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:46595 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbaIBMzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Sep 2014 08:55:54 -0400
Received: by mail-ie0-f172.google.com with SMTP id rd18so7545480iec.17
        for <linux-input@vger.kernel.org>; Tue, 02 Sep 2014 05:55:53 -0700 (PDT)
In-Reply-To: <1409661804-10489-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Tue, Sep 2, 2014 at 2:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> It is useful for userspace to know that they're not dealing with a regular
> mouse but rather with a pointing stick (e.g. a trackpoint) so that userspace
> can e.g. automatically enable middle button scrollwheel emulation.
>
> It is impossible to tell the difference from the evdev info without resorting
> to putting a list of device / driver names in userspace, this is undesirable.

..so it is better to put that table into the kernel?

I thought the plan was to avoid putting more hardware tables into the
kernel. All those tables are always loaded into RAM, whereas solutions
like udev hwdb can provide the exact same features in user-space but
avoid loading it into RAM, except if used. hwdb is pretty nice to
store information about hardware. It is not meant for configuration or
volatile data, but rather as read-only lookup table for hardware
information.

You could easily extend the hwdb with a trackpoint variable that marks
specific devices as trackpoints.

Anyhow, if you guys want it in the kernel, go ahead. I just don't see
the advantage of having it in kernel-space.

Thanks
David
