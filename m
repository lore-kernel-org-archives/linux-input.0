From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC] Input: uinput - add new UINPUT_DEV_SETUP ioctl
Date: Fri, 20 Jun 2014 13:14:45 +0200
Message-ID: <CANq1E4QVvE_KPykvx=BmFi5VKqH_BUdiv4O=-Hsyp5_JN-=kaw@mail.gmail.com>
References: <1403183515-15621-1-git-send-email-dh.herrmann@gmail.com>
	<20140620005557.GA22050@jelly.redhat.com>
	<CANq1E4Sx4=ko=sbbOR-S=gOsnHU7m6asiz3XGzU_BD81F9mqeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36279 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965558AbaFTLOq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jun 2014 07:14:46 -0400
Received: by mail-ig0-f171.google.com with SMTP id h18so386066igc.16
        for <linux-input@vger.kernel.org>; Fri, 20 Jun 2014 04:14:45 -0700 (PDT)
In-Reply-To: <CANq1E4Sx4=ko=sbbOR-S=gOsnHU7m6asiz3XGzU_BD81F9mqeA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Fri, Jun 20, 2014 at 1:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>>> + *             abs: This is an appended array that contains parameters for ABS
>>> + *                  axes. See "struct input_absinfo" for a description of these
>>> + *                  fields. This array is copied unchanged into the kernel for
>>> + *                  all specified axes. However, to have effect, you must also
>>> + *                  enable the wanted axes via UI_SET_ABSBIT.
>>
>> last sentence: "Only axes previously enabled with UI_SET_ABSBIT are copied."
>
> This is not true. All axes are copied. That's how uinput always
> worked. You can set UI_SET_ABSBIT after SETUP. However, given that we
> do the "uinput_validate_absbits" only on SETUP, you would get weird
> errors during UI_DEV_CREATE if the axis data was invalid (afaik
> uinput_register_device() validates those values. Not sure, though).

Ok, I changed my mind again. I now explicitly ignore any axes not
enabled via UI_SET_ABSBIT. I think you're right and that's how users
would expect this to work.

Thanks
David
