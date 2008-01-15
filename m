From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Tue, 15 Jan 2008 15:54:29 -0500
Message-ID: <20080115155215.ZZRA012@mailhub.coreip.homeip.net>
References: <20071218235137.12838.75397.stgit@localhost> <20080114174107.GA14494@srcf.ucam.org> <200801141827.34059.carlos@strangeworlds.co.uk> <200801142225.11066.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200801142225.11066.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 14, 2008 at 10:25:10PM +0000, Carlos Corbacho wrote:
> On Monday 14 January 2008 18:27:33 Carlos Corbacho wrote:
> > On Monday 14 January 2008 17:41:07 Matthew Garrett wrote:
> > > On Thu, Jan 03, 2008 at 11:58:02AM -0500, Dmitry Torokhov wrote:
> > > > There is no sysfs device to attach the input device to, by any chance?
> > >
> > > Not as far as I can tell, but I may be misinterpreting this. Carlos?
> 
> What would be better - to have WMI itself as the parent device, or should I 
> add something like this to WMI:
> 
> wmi_get_dev(const char *guid, struct device *dev)
> 
> to return the virtual device associated with a GUID, and then allow that to be 
> used as the parent? (trade off is that this driver would then become 
> dependent on the WMI sysfs patch going in as well, rather than just on the 
> in-kernel WMI support).
> 

If there is a [planned] WMI sysfs device then I think input device should
use it to form proper sysfs hierarchy. What are the roadblocks for getting
WMI sysfs in?

-- 
Dmitry

