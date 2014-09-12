From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Handle spurious backslash key repeats on some keyboards
Date: Fri, 12 Sep 2014 13:47:52 +0200
Message-ID: <CANq1E4Rw7q9QpA1UYsjuu9umB_AE2qE6JhNKQ9e8W3xp+m_2EA@mail.gmail.com>
References: <1407664566-5303-1-git-send-email-megahallon@gmail.com>
	<CAMsZVf_h2fODG2UTs6ddZYZLGfF5hdyY+1PdwXO8N5taDahRwg@mail.gmail.com>
	<alpine.LNX.2.00.1409101025430.5523@pobox.suse.cz>
	<CANq1E4S98gWYSHJ=WxNYKB2t=95WY=4tcC3ioFYcm5ZkwFSs=g@mail.gmail.com>
	<CAMsZVf9_RHYMRmpvenYcHwXFN3B=D5KnZ0zGOR+zzTw1eOqWHw@mail.gmail.com>
	<CANq1E4Q0oiAxDB7osAMrqs=OGEys6GzZh8GDj9B8jAEpxX7now@mail.gmail.com>
	<20140910225134.GH38736@core.coreip.homeip.net>
	<CAMsZVf_NiHJW9mv+k7Tu4hX5EfcAosnyCfn7G1pVWR8oG5qQ0Q@mail.gmail.com>
	<CANq1E4TjgTs+4_84NZGCctGpNJ4x5VG05_ej9=eGjczcdim6Yg@mail.gmail.com>
	<CAMsZVf_K1ji75K3CcqGjED01Lppbk8gFSw0ADB-QOG=wVYiF_g@mail.gmail.com>
	<CANq1E4Qw3_0M7BCgDJTX0WGHU+CnFdnuASX0JfEK-Btkc=7Rsg@mail.gmail.com>
	<CAMsZVf-r6GvPOUEUye9wcLrT-g8SXkk5b3HKBDDTyHjAj38aKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:43502 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754268AbaILLrx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Sep 2014 07:47:53 -0400
Received: by mail-ig0-f179.google.com with SMTP id r10so344157igi.12
        for <linux-input@vger.kernel.org>; Fri, 12 Sep 2014 04:47:52 -0700 (PDT)
In-Reply-To: <CAMsZVf-r6GvPOUEUye9wcLrT-g8SXkk5b3HKBDDTyHjAj38aKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fredrik Hallenberg <megahallon@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Fri, Sep 12, 2014 at 1:34 PM, Fredrik Hallenberg
<megahallon@gmail.com> wrote:
> Is the country tag derived from the bCountryCode seen in the HID
> device descriptor seen when doing "lsusb -v"?

Yes, it is.

> If so it probably wont work as it says "0 (Not supported)" on my
> keyboard and a few others I have tested.

"0" might also be used as default, so it's not surprising that your
US-style keyboard uses "0".

Furthermore, the non-US style keyboards might even use different
product IDs or version numbers. So it'd be nice if you could include a
full set of device information here.

Thanks
David
