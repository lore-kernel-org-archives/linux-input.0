From: Yusuke FUJIMAKI <usk.fujimaki@gmail.com>
Subject: Re: [PATCH] HID: asus: add support for hotkeys
Date: Fri, 13 May 2016 03:10:09 +0900
Message-ID: <CAK4LCm5T4He4RcAtbECwKDNgVQOPppx=DimNeoN8UD3Cv3wy4g@mail.gmail.com>
References: <1462985167-8566-1-git-send-email-usk.fujimaki@gmail.com>
	<CAKdAkRQa-7w1_CyQ3DOUaZe+JHAkmMFXo1r85asdUdj1L3n7Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33575 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcELSKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 14:10:34 -0400
Received: by mail-yw0-f193.google.com with SMTP id y6so8512688ywe.0
        for <linux-input@vger.kernel.org>; Thu, 12 May 2016 11:10:33 -0700 (PDT)
In-Reply-To: <CAKdAkRQa-7w1_CyQ3DOUaZe+JHAkmMFXo1r85asdUdj1L3n7Sw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

> Can this be done via udev keymaps/hwdb instead of kernel driver?
I couldn't remap hotkeys.
evtest command output is below.

Fn+F1(sleep)
Event: time 1463068038.605052, type 3 (EV_ABS), code 40 (ABS_MISC), value 0
Event: time 1463068038.605052, -------------- EV_SYN ------------
Event: time 1463068038.669030, type 3 (EV_ABS), code 40 (ABS_MISC), value 1
Event: time 1463068038.669030, -------------- EV_SYN ------------

Fn+F2(Airplane mode)
Event: time 1463068094.753052, type 3 (EV_ABS), code 40 (ABS_MISC), value 0
Event: time 1463068094.753052, -------------- EV_SYN ------------
Event: time 1463068094.805040, type 3 (EV_ABS), code 40 (ABS_MISC), value 1
Event: time 1463068094.805040, -------------- EV_SYN ------------

Fn+F5(Display Brightness Down)
Event: time 1463068127.261051, type 3 (EV_ABS), code 40 (ABS_MISC), value 0
Event: time 1463068127.261051, type 3 (EV_ABS), code 56
(ABS_MT_BLOB_ID), value 1
Event: time 1463068127.261051, -------------- EV_SYN ------------
Event: time 1463068127.313042, type 3 (EV_ABS), code 56
(ABS_MT_BLOB_ID), value 0
Event: time 1463068127.313042, type 3 (EV_ABS), code 40 (ABS_MISC), value 1
Event: time 1463068127.313042, -------------- EV_SYN ------------

Fn+F6(Display Brightness Up)
Event: time 1463068227.209051, type 3 (EV_ABS), code 40 (ABS_MISC), value 0
Event: time 1463068227.209051, -------------- EV_SYN ------------
Event: time 1463068227.277042, type 3 (EV_ABS), code 40 (ABS_MISC), value 1
Event: time 1463068227.277042, -------------- EV_SYN ------------

Fn+F7(Display Power Off)
Event: time 1463068227.209051, type 3 (EV_ABS), code 40 (ABS_MISC), value 0
Event: time 1463068227.209051, -------------- EV_SYN ------------
Event: time 1463068227.277042, type 3 (EV_ABS), code 40 (ABS_MISC), value 1
Event: time 1463068227.277042, -------------- EV_SYN ------------

Fn+F9 (Touchpad toggle)
Event: time 1463068441.937052, type 3 (EV_ABS), code 40 (ABS_MISC), value 0
Event: time 1463068441.937052, -------------- EV_SYN ------------
Event: time 1463068441.989049, type 3 (EV_ABS), code 40 (ABS_MISC), value 1
Event: time 1463068441.989049, -------------- EV_SYN ------------

Below volume control hotkeys work out of the box.

Fn+F10 (Mute)
Event: time 1463068508.229058, type 4 (EV_MSC), code 4 (MSC_SCAN), value c00e2
Event: time 1463068508.229058, type 1 (EV_KEY), code 113 (KEY_MUTE), value 1
Event: time 1463068508.229058, -------------- EV_SYN ------------
Event: time 1463068508.281048, type 4 (EV_MSC), code 4 (MSC_SCAN), value c00e2
Event: time 1463068508.281048, type 1 (EV_KEY), code 113 (KEY_MUTE), value 0
Event: time 1463068508.281048, -------------- EV_SYN ------------

Fn+F11(Volume Down)
Event: time 1463068543.501053, type 4 (EV_MSC), code 4 (MSC_SCAN), value c00ea
Event: time 1463068543.501053, type 1 (EV_KEY), code 114
(KEY_VOLUMEDOWN), value 1
Event: time 1463068543.501053, -------------- EV_SYN ------------
Event: time 1463068543.565055, type 4 (EV_MSC), code 4 (MSC_SCAN), value c00ea
Event: time 1463068543.565055, type 1 (EV_KEY), code 114
(KEY_VOLUMEDOWN), value 0
Event: time 1463068543.565055, -------------- EV_SYN ------------

Fn+F12(Volume Up)
Event: time 1463068575.305053, type 4 (EV_MSC), code 4 (MSC_SCAN), value c00e9
Event: time 1463068575.305053, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 1
Event: time 1463068575.305053, -------------- EV_SYN ------------
Event: time 1463068575.345093, type 4 (EV_MSC), code 4 (MSC_SCAN), value c00e9
Event: time 1463068575.345093, type 1 (EV_KEY), code 115 (KEY_VOLUMEUP), value 0
Event: time 1463068575.345093, -------------- EV_SYN ------------

If there is any method to remap above hotkeys via udev,please tell me.

Best regards.
-- 
Yusuke FUJIMAKI
