From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Wed, 16 Jan 2008 01:38:35 +0000
Message-ID: <200801160138.36347.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <200801142225.11066.carlos@strangeworlds.co.uk> <20080115155215.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53654 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091AbYAPBil (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2008 20:38:41 -0500
In-Reply-To: <20080115155215.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org

On Tuesday 15 January 2008 20:54:29 Dmitry Torokhov wrote:
> If there is a [planned] WMI sysfs device then I think input device should
> use it to form proper sysfs hierarchy. What are the roadblocks for getting
> WMI sysfs in?

The question is, would exporting the GUID virtual device and using that as the 
parent make more sense? So, in the case of hp-wmi, it only uses the GUID 
95F24279-4D7B-4334-9387-ACCDC67EF61C, so should we use the virtual device 
associated with that GUID as the parent, or just have WMI itself as the 
parent device? I'm really not sure which would be the better way to go.

Unfortunately, as you can see, a GUID is a 36 character string, which is 
longer than the current 20 byte length of bus_id in a 'struct device'; so 
either we have to have a temporary hack to shorten the GUID length when 
creating the device, or wait for bus_id to switch to a variable length 
(although it's not certain if this change will hit 2.6.25, or will be put off 
until 2.6.26).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
