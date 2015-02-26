From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/7] thinkpad_acpi: Remember adaptive kbd presence
Date: Thu, 26 Feb 2015 12:22:32 +0100
Message-ID: <1424949752.2459.14.camel@hadess.net>
References: <1424443450.22910.13.camel@hadess.net>
	 <20150226061814.GC7331@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45819 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbbBZLWq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 06:22:46 -0500
In-Reply-To: <20150226061814.GC7331@fury.dvhart.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Wed, 2015-02-25 at 22:18 -0800, Darren Hart wrote:
> On Fri, Feb 20, 2015 at 03:44:10PM +0100, Bastien Nocera wrote:
> > Rather than checking on each suspend and resume whether the laptop
> > has an adaptive keyboard, check when the driver is initialised.
> 
> Bastien, am I awaiting another version of this from you to address comments from
> Henrique?

I was waiting for more comments on the additional keycodes from Dmitry
and Jiri.

> Henrique, when you're satisfied, please provide a Reviewed-by for the series.

I can send the first 5 patches of that series if you want to land it
soon.

