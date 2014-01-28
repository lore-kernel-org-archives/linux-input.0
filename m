From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/4] HID: implement new transport-driver callbacks
Date: Tue, 28 Jan 2014 21:53:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401282153141.22492@pobox.suse.cz>
References: <1390416584-3667-1-git-send-email-frank.praznik@oh.rr.com> <CANq1E4RHBpbnQ6bGtT-uv7LYmOCw=khACsNWCyoqpKCPXrJJrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37897 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932134AbaA1Uxx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jan 2014 15:53:53 -0500
In-Reply-To: <CANq1E4RHBpbnQ6bGtT-uv7LYmOCw=khACsNWCyoqpKCPXrJJrQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Wed, 22 Jan 2014, David Herrmann wrote:

> > These patches are originally the work of David Herrmann who suggested that I
> > update and submit them as their functionality is required for some pending
> > patches to the hid-sony driver.
> >
> > These patches implement the SET/GET_REPORT and raw intr OUTPUT requests for all
> > transport drivers.  It adds two callbacks to the hid_ll_driver struct:
> >
> > int (*raw_request)(struct hid_device *hdev, unsigned char reportnum,
> >                    __u8 *buf, size_t len, unsigned char rtype, int reqtype);
> >
> > int (*output_report)(struct hid_device *hdev, __u8 *buf, size_t len);
> >
> > along with the necessary support fuctions in the USBHID, and HIDP drivers.
> >
> > UHID is not converted yet.
> 
> Thanks for picking it up. As background, people should read my HID
> summary which originally was part of this series:
>   http://cgit.freedesktop.org/~dvdhrm/linux/tree/Documentation/hid/hid-transport.txt?h=hid&id=86c08bb28302bb31dcd3b9aaf22b222f890397e0
> 
> Our current hid_output_raw_report() callbacks are implemented
> differently in the USBHID, HIDP, I2CHID and UHID backends (I even
> think they're all mutually different). We cannot easily change these
> as drivers actually depend on the backends to do it differently.
> Therefore, I proposed the raw_request() and output_report() functions.
> raw_request() is basically the same as request() but takes a raw
> buffer instead of an hid_report. output_report() is what HIDP
> currently does with hid_output_raw_report() and sends the report as
> asynchronous intr report.
> 
> The plan should be to use request(), raw_request() and output_report()
> exclusively and carefully port drivers to use them. Once we're done,
> we can remove hid_output_raw_report() (and any other legacy). This
> should guarantee, that drivers can choose between ctrl-SET_REPORT and
> intr-OUTPUT_REPORT messages without depending on the underlying
> backend to choose the right one.

I haven't finished reviewing the patchset yet, but anyway -- David, can I 
consider your e-mail as a potential Acked-by:?

Thanks,

-- 
Jiri Kosina
SUSE Labs
