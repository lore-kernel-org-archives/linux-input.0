From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: use %pUL for uuid formatting
Date: Thu, 01 Dec 2016 15:51:13 -0800
Message-ID: <1480636273.2442.0.camel@linux.intel.com>
References: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>
         <20161201142110.GB1280@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29823 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbcLAXvO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 1 Dec 2016 18:51:14 -0500
In-Reply-To: <20161201142110.GB1280@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-12-01 at 15:21 +0100, Benjamin Tissoires wrote:
> On Nov 30 2016 or thereabouts, Rasmus Villemoes wrote:
> > 
> > We have the %pU printf extension for doing exactly this. Saves some
> > .text, and is likely also a little faster.
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> 
> > 
> > ---
> >  drivers/hid/intel-ish-hid/ishtp/bus.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c
> > b/drivers/hid/intel-ish-hid/ishtp/bus.c
> > index 256521509d20..f4cbc744e657 100644
> > --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> > +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> > @@ -585,14 +585,7 @@ int ishtp_bus_new_client(struct ishtp_device
> > *dev)
> >  	 */
> >  	i = dev->fw_client_presentation_num - 1;
> >  	device_uuid = dev->fw_clients[i].props.protocol_name;
> > -	dev_name = kasprintf(GFP_KERNEL,
> > -		"{%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-
> > %02X%02X%02X%02X%02X%02X}",
> > -		device_uuid.b[3], device_uuid.b[2],
> > device_uuid.b[1],
> > -		device_uuid.b[0], device_uuid.b[5],
> > device_uuid.b[4],
> > -		device_uuid.b[7], device_uuid.b[6],
> > device_uuid.b[8],
> > -		device_uuid.b[9], device_uuid.b[10],
> > device_uuid.b[11],
> > -		device_uuid.b[12], device_uuid.b[13],
> > device_uuid.b[14],
> > -		device_uuid.b[15]);
> > +	dev_name = kasprintf(GFP_KERNEL, "{%pUL}", device_uuid.b);
> >  	if (!dev_name)
> >  		return	-ENOMEM;
> >  
> > -- 
> > 2.1.4
> > 
