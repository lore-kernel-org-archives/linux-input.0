From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Fri, 8 Feb 2008 15:26:32 +0000
Message-ID: <200802081526.33336.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <200801160138.36347.carlos@strangeworlds.co.uk> <200802062254.24599.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200802062254.24599.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 07 February 2008 03:54:24 Len Brown wrote:
> > The question is, would exporting the GUID virtual device and using that
> > as the parent make more sense? So, in the case of hp-wmi, it only uses
> > the GUID 95F24279-4D7B-4334-9387-ACCDC67EF61C, so should we use the
> > virtual device associated with that GUID as the parent, or just have WMI
> > itself as the parent device? I'm really not sure which would be the
> > better way to go.
>
> Why not used generic names like dev0, dev1 etc.
> and have the guid be an attribute?

Well, we'll have the virtual devices for the GUIDs anyway once I re-spin the 
relevant patch, so would it not be better to just reuse those, rather than 
start adding new virtual devices?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
