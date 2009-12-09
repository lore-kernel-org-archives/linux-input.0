From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Allow filtering of i8042 events
Date: Wed, 9 Dec 2009 12:39:39 -0800
Message-ID: <20091209203939.GC10138@core.coreip.homeip.net>
References: <1260383609-7681-1-git-send-email-mjg@redhat.com> <20091209200614.GA10138@core.coreip.homeip.net> <20091209201620.GA25133@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091209201620.GA25133@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 09, 2009 at 08:16:20PM +0000, Matthew Garrett wrote:
> On Wed, Dec 09, 2009 at 12:06:15PM -0800, Dmitry Torokhov wrote:
> 
> > This is certainly going in the direction I wanted but it looks like
> > it is more complex than it needs to be. Why don't you just allow
> > installing global filter for entire i8042 (pass the status register
> > there along with data byte)? The data you are interested in goes kind of
> > "ouside" KBD/AUX port abstraction anyway...  Plus currently you are not
> > handling MUX case properly.
> 
> Wouldn't that require me to be able to process any conceivable mouse 
> protocol as well?

No, just have your filter function check STR to make sure the byte you got
is not coming from AUX. Or we could say that filter only works for data
pretending to be coming from KBD (because in reality the data we are
trying to filter out comes only this way) and move the check into i8042
itself.

-- 
Dmitry
