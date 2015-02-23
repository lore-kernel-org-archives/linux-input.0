From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 5/6] input: Add keycodes used by Lenovo Carbon X1 2014
Date: Mon, 23 Feb 2015 07:49:51 -0300
Message-ID: <1424688591.3045289.231119453.42C70082@webmail.messagingengine.com>
References: <1424292832.32581.49.camel@hadess.net>
 <20150218233420.GB23265@khazad-dum.debian.net>
 <1424686542.28361.10.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1424686542.28361.10.camel@hadess.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Darren Hart <dvhart@infradead.org>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 23, 2015, at 07:15, Bastien Nocera wrote:
> On Wed, 2015-02-18 at 21:34 -0200, Henrique de Moraes Holschuh wrote:
> > On Wed, 18 Feb 2015, Bastien Nocera wrote:
> > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > 
> > This one requires an ACK from the input maintainers, or no go...
> 
> Any comments about the other patches?

The series looks mostly good, but the new keymap and attributes need to
go
in the driver documentation (Documentation/laptops/thinkpad-acpi.txt),
and some
of the commit decriptions could use an update.

You could opt to change some of those keypresses dinamically into
driver-specific
ACPI events, by setting the keymap entry to KEY_RESERVED.  The driver
will
issue HKEY events in that case. That will be an viable alternative for
some of the new
keys.

The beauty of it is that keymaps are configurable in run-time, so
userspace can
just set any key entries it wants to change to something else, and ACPI
events will be
suppressed if the entry is not set to KEY_RESERVED anymore.

We need to be careful with tpacpi_input_send_key_masked(). If any of the
codepaths
could call it from the adaptative keyboard handling code, it needs to be
updated (just
assume anything above 32 is enabled, as the firmware does not have an
event mask
for the new keycodes).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
