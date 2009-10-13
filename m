From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: support the specified input device number
Date: Mon, 12 Oct 2009 19:36:47 -0700
Message-ID: <20091013023646.GD21626@core.coreip.homeip.net>
References: <4ACD4A4B.3080200@samsung.com> <20091009162951.GD1092@core.coreip.homeip.net> <9c9fda240910121850t4ec8ee96i7517d6a0f0526ae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:43812 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758760AbZJMChb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 22:37:31 -0400
Received: by ewy4 with SMTP id 4so2988694ewy.37
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2009 19:36:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9c9fda240910121850t4ec8ee96i7517d6a0f0526ae5@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Tue, Oct 13, 2009 at 10:50:16AM +0900, Kyungmin Park wrote:
> Hi,
> 
> On Sat, Oct 10, 2009 at 1:29 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Joonyoung,
> >
> > On Thu, Oct 08, 2009 at 11:11:23AM +0900, Joonyoung Shim wrote:
> >> Currently, the input device number is decided by order of driver probe.
> >> But we need the specified input device number regardless of order of
> >> driver probe because the platform or the middleware tends to access
> >> using fixed device node of the input devices.
> >>
> >> This patch supports to use the specified input device number when the
> >> input device is registered. If the input device number bigger than zero
> >> is registered before by other input device, returns error.
> >>
> >
> > No, I don't think this is a good solution. You can have persistent
> > device nodes without hadrcoding it into the driver. See how UDEV creates
> > 'by-id' and 'by-path' links.
> >
> 
> Please let me know how to use udev at input device.
> 
> At our system,
> input0: h/w keypad
> input1: gpio key
> input2: touchscreen
> input3: jack or others
> 
> but in previous system, we always set the touchscreen as input1. Right
> we can modify it but it's not easy.
> With this patch we always set touchscreen as input1.
> 
> How can we do this?
> 
> FYI: when launch the X, we set the tsdevice as input1 and keyboard as input0.
> 

Do you have udev running? On Fedora there is a rule here:

/lib/udev/rules.d/60-persistent-input.rules

that handles everythign and creates 'by-id' and 'by-path' symlinks.

-- 
Dmitry
