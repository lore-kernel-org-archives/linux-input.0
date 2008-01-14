From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Mon, 14 Jan 2008 22:25:10 +0000
Message-ID: <200801142225.11066.carlos@strangeworlds.co.uk>
References: <20071218235137.12838.75397.stgit@localhost> <20080114174107.GA14494@srcf.ucam.org> <200801141827.34059.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:52073 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbYANWZR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jan 2008 17:25:17 -0500
In-Reply-To: <200801141827.34059.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org

On Monday 14 January 2008 18:27:33 Carlos Corbacho wrote:
> On Monday 14 January 2008 17:41:07 Matthew Garrett wrote:
> > On Thu, Jan 03, 2008 at 11:58:02AM -0500, Dmitry Torokhov wrote:
> > > There is no sysfs device to attach the input device to, by any chance?
> >
> > Not as far as I can tell, but I may be misinterpreting this. Carlos?

What would be better - to have WMI itself as the parent device, or should I 
add something like this to WMI:

wmi_get_dev(const char *guid, struct device *dev)

to return the virtual device associated with a GUID, and then allow that to be 
used as the parent? (trade off is that this driver would then become 
dependent on the WMI sysfs patch going in as well, rather than just on the 
in-kernel WMI support).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
