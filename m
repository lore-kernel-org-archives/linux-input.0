From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH] HID: wacom: Remove raport header check.
Date: Tue, 15 May 2012 19:30:07 +0100
Message-ID: <1337106607.22228.7.camel@pldmachine>
References: <1337012006-6854-1-git-send-email-przemo@firszt.eu>
	 <CAF8JNhJozNYzTbEHXHbr2mkOBH-RqxzeFqFWNbTXBLo6oYQppg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:50672 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932894Ab2EOSaP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 May 2012 14:30:15 -0400
In-Reply-To: <CAF8JNhJozNYzTbEHXHbr2mkOBH-RqxzeFqFWNbTXBLo6oYQppg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linuxwacom-devel <linuxwacom-devel@lists.sourceforge.net>

Dnia 2012-05-14, pon o godzinie 13:21 -0700, Ping Cheng pisze:
> On Mon, May 14, 2012 at 9:13 AM, Przemo Firszt <przemo@firszt.eu> wrote:
> > That check was valid when hid-wacom was only supporting Wacom Graphire, as the
> > device raports always start with 0x03. Intuos4 WL high-speed raports
> > begin with 0x04, so the check would be filtering out valid reports.
> 
> I assume the if-statement was added on purpose. It was most likely
> used to filter noises for Graphire.
> 
> Should we change to
> 
> if (data[0] != 0x03 || (data[0] != 0x04 &&
>     hdev->product == USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH)) {
> 
>         hid_err(hdev, "Unknown report: %d,%d size:%d\n",
> 					data[0], data[1], size);
>         return 0;
> }
> 
> and remove default case for I4?
> 
> Or, remove the if-statement as you suggested and add a default case
> for Graphire to post hid_err and exit when data[0] != 3.
> 
> Either way works for me.
Hi Ping,
Thanks for the comment. I'll go with the second option and I hope we
won't be generating too much noise in the logs :-)

Patches (there are 2 more for speed setting through sysfs for I4 WL) on
the way...
-- 
Regards,
Przemo Firszt <przemo@firszt.eu>

