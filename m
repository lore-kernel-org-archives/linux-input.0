From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 0/4] HID: implement new transport-driver callbacks
Date: Wed, 22 Jan 2014 20:01:21 +0100
Message-ID: <CANq1E4RHBpbnQ6bGtT-uv7LYmOCw=khACsNWCyoqpKCPXrJJrQ@mail.gmail.com>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32823 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbaAVTBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 14:01:22 -0500
Received: by mail-ig0-f175.google.com with SMTP id uq10so14723275igb.2
        for <linux-input@vger.kernel.org>; Wed, 22 Jan 2014 11:01:22 -0800 (PST)
In-Reply-To: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Wed, Jan 22, 2014 at 7:49 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> These patches are originally the work of David Herrmann who suggested that I
> update and submit them as their functionality is required for some pending
> patches to the hid-sony driver.
>
> These patches implement the SET/GET_REPORT and raw intr OUTPUT requests for all
> transport drivers.  It adds two callbacks to the hid_ll_driver struct:
>
> int (*raw_request)(struct hid_device *hdev, unsigned char reportnum,
>                    __u8 *buf, size_t len, unsigned char rtype, int reqtype);
>
> int (*output_report)(struct hid_device *hdev, __u8 *buf, size_t len);
>
> along with the necessary support fuctions in the USBHID, and HIDP drivers.
>
> UHID is not converted yet.

Thanks for picking it up. As background, people should read my HID
summary which originally was part of this series:
  http://cgit.freedesktop.org/~dvdhrm/linux/tree/Documentation/hid/hid-transport.txt?h=hid&id=86c08bb28302bb31dcd3b9aaf22b222f890397e0

Our current hid_output_raw_report() callbacks are implemented
differently in the USBHID, HIDP, I2CHID and UHID backends (I even
think they're all mutually different). We cannot easily change these
as drivers actually depend on the backends to do it differently.
Therefore, I proposed the raw_request() and output_report() functions.
raw_request() is basically the same as request() but takes a raw
buffer instead of an hid_report. output_report() is what HIDP
currently does with hid_output_raw_report() and sends the report as
asynchronous intr report.

The plan should be to use request(), raw_request() and output_report()
exclusively and carefully port drivers to use them. Once we're done,
we can remove hid_output_raw_report() (and any other legacy). This
should guarantee, that drivers can choose between ctrl-SET_REPORT and
intr-OUTPUT_REPORT messages without depending on the underlying
backend to choose the right one.

I hope that information helps.
Thanks
David
