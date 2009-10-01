From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] cmpc_acpi: Added support for Classmate PC ACPI devices.
Date: Thu, 1 Oct 2009 09:38:57 -0700
Message-ID: <20091001163857.GB22320@core.coreip.homeip.net>
References: <1254188280-29155-1-git-send-email-cascardo@holoscopio.com> <9b2b86520909290220g6b5f6beal6337b17f1bdd339@mail.gmail.com> <20090929141618.GD18847@vespa.holoscopio.com> <9b2b86520909290941g6295ba36i907dfda62b968529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b2b86520909290941g6295ba36i907dfda62b968529@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, don@syst.com.br, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 29, 2009 at 05:41:42PM +0100, Alan Jenkins wrote:
> On 9/29/09, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> wrote:
> 
> >> > +static void cmpc_tablet_idev_init(struct input_dev *inputdev)
> >> > +{
> >> > +	set_bit(EV_SW, inputdev->evbit);
> >> > +	set_bit(SW_TABLET_MODE, inputdev->swbit);
> >>
> >> Don't you need to initialize the switch value here?
> >>
> >
> > No, input_allocate_device does kzalloc. Otherwise, this would apply to
> > the other bitmaps as well.
> 
> The other bitmaps aren't for switches though.  Here's what prompted
> this comment - a snippet from the old (2.6.29) version of
> Documentation/rfkill.txt:
> 
> "2. Input device switches (sources of EV_SW events) DO store their current state
> (so you *must* initialize it by issuing a gratuitous input layer event on
> driver start-up and also when resuming from sleep), and that state CAN be
> queried from userspace through IOCTLs."
> 

There is a mixup betweeb capabilieies and state bitmasks. In init you
set up the capabilitis bits and you don't need to clear bitmaps. This is
true for everything - keys/buttons, switches, relatixe/absolute axis,
everything.

Now switches do naturally have a certain state. Unlke keys (which are
assumed to be normally in released state) switch can be on or off. So
the driver has (if it can) query the switch state (hardware state) and
issue appropriate input_event() to bring internal state of the device in
sync with the state of the hardware. The same on resume - the switch may
be altered while the box was asleep to upon resume we need to do the
same.

-- 
Dmitry
