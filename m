From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Mon, 6 May 2013 07:49:49 +0200
Message-ID: <CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:37853 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab3EFFtt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 01:49:49 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so2909735iar.2
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 22:49:49 -0700 (PDT)
In-Reply-To: <CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Todd

On Mon, May 6, 2013 at 2:43 AM, Todd Showalter <todd@electronjump.com> wrote:
> On Sun, May 5, 2013 at 5:13 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>
>> The Wii U Pro Controller is a new Nintendo remote device that looks very
>> similar to the XBox controller. It has nearly the same features and uses
>> the same protocol as the Wii Remote.
>
>     As with the classic controller, could this please be mapped to the
> standard gamepad where possible?

> - left stick to ABS_LX, ABS_LY
> - right stick to ABS_RX, ABS_RY

These make sense to me, indeed.

> - dpad to ABS_DX, ABS_DY

These are digital buttons on this gamepad. What's wrong with
KEY_{left, right, up, down}? Or I would prefer BTN_{left, right, up,
down} instead.

> - left trigger to ABS_LTRIG
> - right trigger to ABS_RTRIG

These are also digital buttons, so what's wrong with BTN_TL/TR?

> - x to BTN_NORTH
> - a to BTN_EAST
> - b to BTN_SOUTH
> - y to BTN_WEST

These make sense to me. At least keyboards also return the American
keycodes instead of trying to guess the label. However, if you want
"help texts" in your applications, like "press A to continue", you
need a user-space helper library, anyway. Otherwise, you cannot be
sure this key is labeled "A" on the current device.
That's also the reason why I don't think these mappings really help.

> - zl to BTN_LSHOULDER
> - zr to BTN_RSHOULDER

Again, why not reuse BTN_ZL/ZR?

> - plus to BTN_START
> - minus to BTN_SELECT
> - home to BTN_SYSTEM

The other Nintendo drivers return BTN_MODE for "home". Could you
explain what's wrong with that?

Thanks!
David
