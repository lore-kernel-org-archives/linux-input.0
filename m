From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Wed, 6 Feb 2008 22:54:24 -0500
Message-ID: <200802062254.24599.lenb@kernel.org>
References: <20071218235137.12838.75397.stgit@localhost> <20080115155215.ZZRA012@mailhub.coreip.homeip.net> <200801160138.36347.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40770 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbYBGDzd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Feb 2008 22:55:33 -0500
In-Reply-To: <200801160138.36347.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org

On Tuesday 15 January 2008 20:38, Carlos Corbacho wrote:
> On Tuesday 15 January 2008 20:54:29 Dmitry Torokhov wrote:
> > If there is a [planned] WMI sysfs device then I think input device should
> > use it to form proper sysfs hierarchy. What are the roadblocks for getting
> > WMI sysfs in?
> 
> The question is, would exporting the GUID virtual device and using that as the 
> parent make more sense? So, in the case of hp-wmi, it only uses the GUID 
> 95F24279-4D7B-4334-9387-ACCDC67EF61C, so should we use the virtual device 
> associated with that GUID as the parent, or just have WMI itself as the 
> parent device? I'm really not sure which would be the better way to go.

Why not used generic names like dev0, dev1 etc.
and have the guid be an attribute?

> Unfortunately, as you can see, a GUID is a 36 character string, which is 
> longer than the current 20 byte length of bus_id in a 'struct device'; so 
> either we have to have a temporary hack to shorten the GUID length when 
> creating the device, or wait for bus_id to switch to a variable length 
> (although it's not certain if this change will hit 2.6.25, or will be put off 
> until 2.6.26).
> 
> -Carlos
