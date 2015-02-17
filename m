From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: i2c-hid: The interrupt should be level
 sensitive
Date: Tue, 17 Feb 2015 13:24:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502171323420.2279@pobox.suse.cz>
References: <1422282573-18215-1-git-send-email-mika.westerberg@linux.intel.com> <20150129200950.GC27265@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150129200950.GC27265@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 29 Jan 2015, Benjamin Tissoires wrote:

> > The Microsoft HID over I2C specification says two things regarding the
> > interrupt:
> > 
> >  1) The interrupt should be level sensitive
> >  2) The device keeps the interrupt asserted as long as it has more reports
> >     available.
> > 
> > We've seen that at least some Atmel and N-Trig panels keep the line low as
> > long as they have something to send. The current version of the driver only
> > detects the first edge but then fails to read rest of the reports (as the
> > line is still asserted).
> > 
> > Make the driver follow the specification and configure the HID interrupt to
> > be level sensitive.
> > 
> > The Windows HID over I2C driver also seems to do the same.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> 
> FWIW, this one is
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> looks like we are going to drop 2/2, but this one is still valid.

Applied to for-3.20/upstream-fixes, thanks for your friendly ping in form 
of Ack :)

-- 
Jiri Kosina
SUSE Labs
