From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Tue, 15 Nov 2011 23:20:06 +0100
Message-ID: <201111152320.06148.marek.vasut@gmail.com>
References: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com> <201111152228.47387.marek.vasut@gmail.com> <CAGzDe_Y__qi9gfS3YKsbcocEd4Cef+16vp1rR_d07_pB9_GUig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45921 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535Ab1KOWUJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 17:20:09 -0500
Received: by fagn18 with SMTP id n18so947443fag.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 14:20:08 -0800 (PST)
In-Reply-To: <CAGzDe_Y__qi9gfS3YKsbcocEd4Cef+16vp1rR_d07_pB9_GUig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

> On Tue, Nov 15, 2011 at 3:28 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On Mon, Nov 14, 2011 at 10:41 AM, Marek Vasut <marek.vasut@gmail.com> 
wrote:
> >> > @@ -1377,6 +1377,7 @@ static const struct hid_device_id
> >> > hid_have_special_driver[] = { { HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2) }, {
> >> > HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3) }, {
> >> > HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4) }, +       {
> >> > HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> >> > USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5) },
> >> 
> >> We have a merge issue here since the 0xa001 got committed as #5.
> > 
> > Was it applied already?
> 
> Yes, its in Jiri's upstream-fixes branch.
> 
> Chris

Good

M
