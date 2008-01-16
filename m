From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Wed, 16 Jan 2008 01:49:47 +0000
Message-ID: <20080116014947.GA7101@srcf.ucam.org>
References: <20071218235137.12838.75397.stgit@localhost> <200801142225.11066.carlos@strangeworlds.co.uk> <20080115155215.ZZRA012@mailhub.coreip.homeip.net> <200801160138.36347.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200801160138.36347.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 16, 2008 at 01:38:35AM +0000, Carlos Corbacho wrote:

> The question is, would exporting the GUID virtual device and using that as the 
> parent make more sense? So, in the case of hp-wmi, it only uses the GUID 
> 95F24279-4D7B-4334-9387-ACCDC67EF61C, so should we use the virtual device 
> associated with that GUID as the parent, or just have WMI itself as the 
> parent device? I'm really not sure which would be the better way to go.

It's possible for a driver to bind itself to multiple GUIDs, and I guess 
it's /potentially/ possible for a machine to have multiple event GUIDs. 
I'm not sure whether those should be created as separate input devices, 
or whether it would make sense for a driver to bind them into a single 
input driver. If the latter, wmi probably ought to be the parent?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
