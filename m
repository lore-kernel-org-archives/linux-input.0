From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 1/5] Input: elan_i2c: Export the device id whitelist
Date: Sun, 30 Jun 2019 00:18:49 -0700
Message-ID: <20190630071849.GC91171@dtor-ws>
References: <20190621144854.38568-1-jeffrey.l.hugo@gmail.com>
 <20190621145042.38637-1-jeffrey.l.hugo@gmail.com>
 <20190623062000.GB204275@dtor-ws>
 <CAOCk7Nr4+Sj9U=qAZTEhPGgZNrZ1VVvNtuUg-9vQzp15xFdCUw@mail.gmail.com>
 <CAO-hwJLEDCbMud6dCfvXzwDfauAgfOZmQwkmELEF2e6-4Oe6=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJLEDCbMud6dCfvXzwDfauAgfOZmQwkmELEF2e6-4Oe6=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <agross@kernel.org>, Lee Jones <lee.jones@linaro.org>, xnox@ubuntu.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jun 27, 2019 at 04:29:29PM +0200, Benjamin Tissoires wrote:
> On Thu, Jun 27, 2019 at 4:02 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
> >
> > On Sun, Jun 23, 2019 at 12:20 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Jun 21, 2019 at 07:50:42AM -0700, Jeffrey Hugo wrote:
> > > > Elan_i2c and hid-quirks work in conjunction to decide which devices each
> > > > driver will handle.  Elan_i2c has a whitelist of devices that should be
> > > > consumed by hid-quirks so that there is one master list of devices to
> > > > handoff between the drivers.  Put the ids in a header file so that
> > > > hid-quirks can consume it instead of duplicating the list.
> > > >
> > > > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > >
> > > Benjamin, are you happy with this version?
> >
> > Benjamin, ping?
> > Sorry to be a bother, but I'm still anxious to get this queued for 5.3.
> 
> Ooops, yeah, sorry I missed Dmitry's email.
> 
> Fine by me:
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

-- 
Dmitry
