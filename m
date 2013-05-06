From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 16/26] HID: wiimote: add Classic Controller extension
Date: Mon, 6 May 2013 07:40:35 +0200
Message-ID: <CANq1E4TR5UXMWEMt3U1w=F7gUh=y0ed9JOqoNbHYf2dNfa8zRg@mail.gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
	<1367788390-29835-17-git-send-email-dh.herrmann@gmail.com>
	<CAFmpkyhX4vmavY8ZHh-ssLFbKrB_AhUa-kL+euuu+X+Yv2k6UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:44191 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3EFFkg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 01:40:36 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so3684975iee.27
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 22:40:36 -0700 (PDT)
In-Reply-To: <CAFmpkyhX4vmavY8ZHh-ssLFbKrB_AhUa-kL+euuu+X+Yv2k6UA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Todd

On Mon, May 6, 2013 at 2:39 AM, Todd Showalter <todd@electronjump.com> wrote:
> On Sun, May 5, 2013 at 5:13 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>
>> Add a new extension module for the classic controller so we get hotplug
>> support for this device. It is mostly the same as the old static classic
>> controller parser.
>
>     Could the buttons/axis values on this please be mapped as
> appropriate for the standard gamepad?  What I'd like, ideally, with
> new #defines in input.h as needed:
>
> - left stick to ABS_LX, ABS_LY
> - right stick to ABS_RX, ABS_RY
> - dpad to ABS_DX, ABS_DY
> - left trigger to ABS_LTRIG
> - right trigger to ABS_RTRIG
> - x to BTN_NORTH
> - a to BTN_EAST
> - b to BTN_SOUTH
> - y to BTN_WEST
> - zl to BTN_LSHOULDER
> - zr to BTN_RSHOULDER
> - plus to BTN_START
> - minus to BTN_SELECT
> - home to BTN_SYSTEM

I cannot change the mapping here, because it has to be
backwards-compatible with the old classic-controller mapping.
Libraries like "xwiimote" depend on it.
This patch only converts the code into a "wiimod" extension module.

Regards
David
