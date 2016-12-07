From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: Method to power off HID device from driver?
Date: Tue, 6 Dec 2016 16:25:56 -0800
Message-ID: <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34981 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcLGAZ6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2016 19:25:58 -0500
Received: by mail-ua0-f172.google.com with SMTP id 12so399773218uas.2
        for <linux-input@vger.kernel.org>; Tue, 06 Dec 2016 16:25:58 -0800 (PST)
In-Reply-To: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I looked a bit deeper and found EV_PWR, though it isn't clearly
defined, but it is used in some places for purposes like this. Would
this be an acceptable method?

Thanks,
Roderick

On Thu, Dec 1, 2016 at 6:05 PM, Roderick Colenbrander
<roderick@gaikai.com> wrote:
> Hi,
>
> Some of the devices I'm dealing with have methods to disconnect the
> device through HID reports. This is mostly useful for wireless devices
> to save battery and power them off e.g. when no activity in a wihle or
> user wants to turn device off (some devices don't have a power off
> button).
>
> I was trying to figure out if it there is some generic way without
> inventing a driver specific method. So far I haven't found anything on
> the HID side. The use case is not that common often a user would
> unplug a cable, but for some devices there is no real other way.
>
> The closest thing I found was 'poweroff' as supported by device power
> management spec:
> https://www.kernel.org/doc/Documentation/power/devices.txt. The HID
> drivers only support a subset of this so far.
>
> Does anyone have a good suggestion for handling this?
>
> Thanks,
> Roderick



-- 
Roderick Colenbrander
Senior Manager of Software Engineering
Gaikai, a Sony Interactive Entertainment Company
roderick@gaikai.com
