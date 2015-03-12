From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Fix suspend/resume when already runtime suspended
Date: Thu, 12 Mar 2015 08:24:53 -0700
Message-ID: <CAD=FV=UGZE6wyve651HkjV1dkiWt2ZqMS=e8efoGq3+oSP5+Hw@mail.gmail.com>
References: <1425930287-4615-1-git-send-email-dianders@chromium.org>
	<20150310122307.GM1563@lahna.fi.intel.com>
	<CAD=FV=WmXA6SnyMx2KC9gP+Q0eVyu+kg54QkY50hKb4LsLFxng@mail.gmail.com>
	<20150311112003.GN1563@lahna.fi.intel.com>
	<CAD=FV=WUNHM2eCuP68a6B3A=ASXXE1QqcVuKe6f4TVGxWQmJ8Q@mail.gmail.com>
	<20150312091014.GW1563@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35698 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbCLPYz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 11:24:55 -0400
Received: by ieclw3 with SMTP id lw3so45086407iec.2
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2015 08:24:54 -0700 (PDT)
In-Reply-To: <20150312091014.GW1563@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jmaneyrol@invensense.com, borneo.antonio@gmail.com, seth.forshee@canonical.com, archana.patni@linux.intel.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Mika,

On Thu, Mar 12, 2015 at 2:10 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> That's interesting. So you have an ARM device with i2c-hid compatible
> device connected to it? Out of curiousity, do you use DT or some
> platform board file to configure the thing?

Using DT.  That's allowed, right?  (3d7d248 HID: i2c-hid: add DT bindings)

-Doug
