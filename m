From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: RESEND: [PATCH 3/3] Misc: Add HP WMI laptop extras driver
Date: Thu, 29 May 2008 09:07:19 +0100
Message-ID: <20080529080719.GA16444@srcf.ucam.org>
References: <20080528132152.GB32646@srcf.ucam.org> <20080528132900.GC32646@srcf.ucam.org> <20080528224200.0c740819.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080528224200.0c740819.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, carlos@strangeworlds.co.uk
List-Id: linux-input@vger.kernel.org

On Wed, May 28, 2008 at 10:42:00PM -0700, Andrew Morton wrote:
> On Wed, 28 May 2008 14:34:25 +0100 Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > --- /dev/null
> > +++ b/drivers/misc/hp-wmi.c
> 
> I see no Kconfig or Makefile updates.

Oops. Will resend.

> > +static struct key_entry hp_wmi_keymap[] = {
> > +	{KE_SW, 0x01, SW_DOCK},
> > +	{KE_KEY, 0x02, KEY_BRIGHTNESSUP},
> > +	{KE_KEY, 0x03, KEY_BRIGHTNESSDOWN},
> > +	{KE_KEY, 0x04, KEY_HELP},
> > +	{KE_END, 0}
> > +};
> 
> Could be made const.  hp_wmi_input_setup() already honours that,
> others will need tweaks.

Not if we want to be able to set the keymap, surely?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
