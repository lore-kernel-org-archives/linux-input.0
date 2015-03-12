From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Thu, 12 Mar 2015 17:28:07 +0200
Message-ID: <20150312152807.GO1563@lahna.fi.intel.com>
References: <1425930287-4615-1-git-send-email-dianders@chromium.org>
 <20150310122307.GM1563@lahna.fi.intel.com>
 <CAD=FV=WmXA6SnyMx2KC9gP+Q0eVyu+kg54QkY50hKb4LsLFxng@mail.gmail.com>
 <20150311112003.GN1563@lahna.fi.intel.com>
 <CAD=FV=WUNHM2eCuP68a6B3A=ASXXE1QqcVuKe6f4TVGxWQmJ8Q@mail.gmail.com>
 <20150312091014.GW1563@lahna.fi.intel.com>
 <CAD=FV=UGZE6wyve651HkjV1dkiWt2ZqMS=e8efoGq3+oSP5+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37668 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbbCLP2X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 11:28:23 -0400
Content-Disposition: inline
In-Reply-To: <CAD=FV=UGZE6wyve651HkjV1dkiWt2ZqMS=e8efoGq3+oSP5+Hw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jmaneyrol@invensense.com, borneo.antonio@gmail.com, seth.forshee@canonical.com, archana.patni@linux.intel.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Mar 12, 2015 at 08:24:53AM -0700, Doug Anderson wrote:
> Mika,
> 
> On Thu, Mar 12, 2015 at 2:10 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > That's interesting. So you have an ARM device with i2c-hid compatible
> > device connected to it? Out of curiousity, do you use DT or some
> > platform board file to configure the thing?
> 
> Using DT.  That's allowed, right?  (3d7d248 HID: i2c-hid: add DT bindings)

Of course.

I was just curious because I have only seen i2c-hid devices that are
ACPI enumerated.
