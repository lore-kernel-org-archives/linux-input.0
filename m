From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 10/12] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Wed, 4 Jul 2018 15:18:33 +0000
Message-ID: <20180704151833.m5d3umukr75nq2dd@penguin>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
 <20180621120908.16706-11-benjamin.tissoires@redhat.com>
 <20180627010858.GB25847@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180627010858.GB25847@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Mario.Limonciello@dell.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 27, 2018 at 11:08:58AM +1000, Peter Hutterer wrote:
> On Thu, Jun 21, 2018 at 02:09:06PM +0200, Benjamin Tissoires wrote:
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > According to Microsoft specification [1] for Precision Touchpads (and
> > Touchscreens) the devices use "confidence" reports to signal accidental
> > touches, or contacts that are "too large to be a finger". Instead of
> > simply marking contact inactive in this case (which causes issues if
> > contact was originally proper and we lost confidence in it later, as
> > this results in accidental clicks, drags, etc), let's report such
> > contacts as MT_TOOL_PALM and let userspace decide what to do.
> > Additionally, let's report contact size for such touches as maximum
> > allowed for major/minor, which should help userspace that is not yet
> > aware of MT_TOOL_PALM to still perform palm rejection.
> 
> tbh. I have a queasy feeling about this last bit. MT_TOOL_PALM has shown to
> not be reliable on some devices (X1 Carbon 6th) and we mask it out on those.
> Changing the major/minor means it's impossible to rely on the touch size for
> palm detection once a device supports MT_TOOL_PALM.

OK, then let's drop this bit.

Thanks.

-- 
Dmitry
