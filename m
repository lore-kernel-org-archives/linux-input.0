From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Always report a sync event after a lid state change
Date: Sun, 26 Oct 2008 12:00:45 +0100
Message-ID: <200810261200.46248.rjw@sisk.pl>
References: <20081023212833.GA1923@ziggurat.research.nokia.com> <alpine.LFD.1.10.0810241529110.3056@localhost.localdomain> <200810252203.35219.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200810252203.35219.dmitry.torokhov@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Guillem Jover <guillem.jover@nokia.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sunday, 26 of October 2008, Dmitry Torokhov wrote:
> Hi Len,
> 
> On Friday 24 October 2008, Len Brown wrote:
> > Dmitry,
> > 
> > Looking around the tree, the other calls to
> > input_report_switch() and input_report_key()
> > are all followed by input_sync().
> > 
> 
> The idea is that userspace can accumulate input events and not act on
> them till it gets the "whole state" of the device which is indicated by
> sending EV_SYN/SYN_REPORT event. This really does not matter for most
> of the simple devices (such as most button devices) but is required
> when you need to report state of a touchpad or a tablet (ABS_X, ABS_Y,
> ABS_PRESSURE, host of buttons and so on). And that is the reason to have
> 2 input_sync when you you reporting button down and up back to back -
> if there was only one input_sync userspace may (although I don't think
> anyone does) wait to reacting till the sync and by that time the up event
> will "cancel out" the down event.
> 
> > I guess we didn't understand the API when we added
> > these calls to button.c?
> >
> 
> The code was fine until acpi_lid_send_state was used un resume path,
> then it needed its own input_sync.
>  
> > Looks like the other users of input_report_* in
> > drivers/acpi and drivers/misc are okay,
> > with the exception of toshiba_acpi.c --
> > the most neglected driver we have,
> > so I"ll do the same to that one?
> > 
> > Ack?
> 
> Yep.

-stable material?

Rafael
