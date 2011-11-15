From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Tue, 15 Nov 2011 15:44:10 -0600
Message-ID: <CAGzDe_Y__qi9gfS3YKsbcocEd4Cef+16vp1rR_d07_pB9_GUig@mail.gmail.com>
References: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com>
	<CAGzDe_Ze8qyYjv7WJh_qtH=g7j1FCSJxp6maLZED_CE_EHFcbw@mail.gmail.com>
	<201111152228.47387.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54330 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079Ab1KOVoM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 16:44:12 -0500
Received: by eye27 with SMTP id 27so6205976eye.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 13:44:11 -0800 (PST)
In-Reply-To: <201111152228.47387.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Tue, Nov 15, 2011 at 3:28 PM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
>> On Mon, Nov 14, 2011 at 10:41 AM, Marek Vasut <marek.vasut@gmail.com=
> wrote:

>> > @@ -1377,6 +1377,7 @@ static const struct hid_device_id
>> > hid_have_special_driver[] =3D { { HID_USB_DEVICE(USB_VENDOR_ID_DWA=
V,
>> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) }, {
>> > HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) }, {
>> > HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) }, + =A0 =A0 =A0 {
>> > HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
>>
>> We have a merge issue here since the 0xa001 got committed as #5.
>
> Was it applied already?
>

Yes, its in Jiri's upstream-fixes branch.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
