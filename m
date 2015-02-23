From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 5/6] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Mon, 23 Feb 2015 12:41:35 +0100
Message-ID: <1424691695.28361.15.camel@hadess.net>
References: <1424292832.32581.49.camel@hadess.net>
	 <20150218233420.GB23265@khazad-dum.debian.net>
	 <1424686542.28361.10.camel@hadess.net>
	 <1424688591.3045289.231119453.42C70082@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424688591.3045289.231119453.42C70082@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2015-02-23 at 07:49 -0300, Henrique de Moraes Holschuh wrote:
> On Mon, Feb 23, 2015, at 07:15, Bastien Nocera wrote:
> > On Wed, 2015-02-18 at 21:34 -0200, Henrique de Moraes Holschuh wrote:
> > > On Wed, 18 Feb 2015, Bastien Nocera wrote:
> > > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > 
> > > This one requires an ACK from the input maintainers, or no go...
> > 
> > Any comments about the other patches?
> 
> The series looks mostly good, but the new keymap and attributes need to
> go
> in the driver documentation (Documentation/laptops/thinkpad-acpi.txt),
> and some
> of the commit decriptions could use an update.
> 
> You could opt to change some of those keypresses dinamically into
> driver-specific
> ACPI events, by setting the keymap entry to KEY_RESERVED.  The driver
> will
> issue HKEY events in that case. That will be an viable alternative for
> some of the new
> keys.

I don't understand what you mean here.

> The beauty of it is that keymaps are configurable in run-time, so
> userspace can
> just set any key entries it wants to change to something else, and ACPI
> events will be
> suppressed if the entry is not set to KEY_RESERVED anymore.

Keymaps are already configurable at run-time, that's how udev changes
keymaps. Or did you mean something else?

> We need to be careful with tpacpi_input_send_key_masked(). If any of the
> codepaths
> could call it from the adaptative keyboard handling code,

But we're not calling it from there, are we?

>  it needs to be
> updated (just
> assume anything above 32 is enabled, as the firmware does not have an
> event mask
> for the new keycodes).
