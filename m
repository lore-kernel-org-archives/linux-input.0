From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: input: serio: New driver to support
 Hyper-V synthetic keyboard
Date: Mon, 16 Sep 2013 21:55:44 +0000
Message-ID: <a76e49ef4b7f44f9a99acea5295d1491@SN2PR03MB061.namprd03.prod.outlook.com>
References: <1379309334-25042-1-git-send-email-kys@microsoft.com>
 <20130916082110.GN25896@mwanda>
 <3b5096d0190b4440a8e25afbd22ab72d@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916150548.GO25896@mwanda>
 <baabf219b12b40de8e17b029e621e079@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916170951.GB20734@core.coreip.homeip.net>
 <3e45f054c6e243eabf2896ab1dcf38d4@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916183319.GM19256@mwanda>
 <117fbf407a554684b4d72ab06b033eeb@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916201328.GN19256@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1lp0152.outbound.protection.outlook.com ([207.46.163.152]:52201
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab3IPVzs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Sep 2013 17:55:48 -0400
In-Reply-To: <20130916201328.GN19256@mwanda>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Monday, September 16, 2013 1:13 PM
> To: KY Srinivasan
> Cc: olaf@aepfle.de; gregkh@linuxfoundation.org; jasowang@redhat.com; Dmitry
> Torokhov; linux-kernel@vger.kernel.org; vojtech@suse.cz; linux-
> input@vger.kernel.org; apw@canonical.com; devel@linuxdriverproject.org
> Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
> synthetic keyboard
> 
> On Mon, Sep 16, 2013 at 06:42:25PM +0000, KY Srinivasan wrote:
> > Dan,
> >
> > Rolling the changes you have indicated is not the issue; this can trivially be
> done.
> > My contention is that it is not needed given that the underlying function is
> already
> > doing that. Look at the function  vmbus_recvpacket_raw() in
> drivers/hv/channel.c.
> >
> 
> I'm confused.
> 
> There is no mention of ->offset8 in vmbus_recvpacket_raw().

As you can see the vmbus_recvpacket_raw() ensures that the complete
packet is read and if the buffer specified is not large enough nothing is 
read. The packet header has information about the length of the packet
and the offset where the payload is.  
> 
> It's a good idea to add a check there but the lower levels don't know
> about the sizeof(synth_kbd_protocol_response) so we would still need
> something like my check.

Why would the lower level code need to know  anything about the layout of a
particular message type. The lower level code is guaranteeing that a complete
packet has been read in and that should be sufficient - assuming we trust the host.

We have already spent more time on this than we should; I will make the necessary
changes.

Regards,

K. Y
> 
> regards,
> dan carpenter

