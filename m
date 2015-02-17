From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2 1/2] HID: hid-sensor-hub: Enhance get feature report
 API
Date: Tue, 17 Feb 2015 08:18:56 -0800
Message-ID: <1424189936.2136.294.camel@spandruv-DESK3.jf.intel.com>
References: <1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1421455165-3944-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <54CE018F.9010600@kernel.org>
	 <alpine.LNX.2.00.1502171338390.2279@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23724 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbbBQQUY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2015 11:20:24 -0500
In-Reply-To: <alpine.LNX.2.00.1502171338390.2279@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, borneo.antonio@gmail.com

Hi Jiri,
On Tue, 2015-02-17 at 13:39 +0100, Jiri Kosina wrote: 
> On Sun, 1 Feb 2015, Jonathan Cameron wrote:
> 
> > On 17/01/15 00:39, Srinivas Pandruvada wrote:
> > > Some hid sensor feature report can contain more than one reports.
> > > This API can now support receiving multiple values from the feature
> > > report.
> > > Also update the parameters in the users of this API.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Oops, commented on old version.
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> I don't seem to have been CCed on v2 submission of this series. Srinivas, 
> could you please resend to me with Jonathan's ack added?
I will resend by addressing comments and adding ack.

Thanks,
Srinivas

> 
> -- 
> Jiri Kosina
> SUSE Labs


