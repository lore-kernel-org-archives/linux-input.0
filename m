From: Yusuke FUJIMAKI <usk.fujimaki@gmail.com>
Subject: Re: [PATCH] HID: asus: add support for hotkeys
Date: Wed, 18 May 2016 03:01:30 +0900
Message-ID: <CAK4LCm4mZARbx9AX15rX_YW4OMhLkPThu6TKZbqPfuRBiaX3Dw@mail.gmail.com>
References: <1462985167-8566-1-git-send-email-usk.fujimaki@gmail.com>
	<CAKdAkRQa-7w1_CyQ3DOUaZe+JHAkmMFXo1r85asdUdj1L3n7Sw@mail.gmail.com>
	<CAK4LCm5T4He4RcAtbECwKDNgVQOPppx=DimNeoN8UD3Cv3wy4g@mail.gmail.com>
	<alpine.LNX.2.00.1605122228050.31937@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36457 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcEQSBb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 14:01:31 -0400
Received: by mail-yw0-f196.google.com with SMTP id u62so3267149ywe.3
        for <linux-input@vger.kernel.org>; Tue, 17 May 2016 11:01:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1605122228050.31937@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Jiri,

When i press hotkey (excluding volume control) on vanilla kernel, no
output from "showkey -s".
therefore i can't run setkeycodes.

Best regards.

2016-05-13 5:28 GMT+09:00 Jiri Kosina <jikos@kernel.org>:
> On Fri, 13 May 2016, Yusuke FUJIMAKI wrote:
>
>> Hi Dmitry,
>>
>> > Can this be done via udev keymaps/hwdb instead of kernel driver?
>> I couldn't remap hotkeys.
>
> How exactly did you invike setkeycodes and how did that change evtest
> output?
>
> --
> Jiri Kosina
> SUSE Labs
>



-- 
Yusuke FUJIMAKI
