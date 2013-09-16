From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: input: serio: New driver to support
 Hyper-V synthetic keyboard
Date: Mon, 16 Sep 2013 16:56:03 +0000
Message-ID: <baabf219b12b40de8e17b029e621e079@SN2PR03MB061.namprd03.prod.outlook.com>
References: <1379309334-25042-1-git-send-email-kys@microsoft.com>
 <20130916082110.GN25896@mwanda>
 <3b5096d0190b4440a8e25afbd22ab72d@SN2PR03MB061.namprd03.prod.outlook.com>
 <20130916150548.GO25896@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:35634
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750932Ab3IPQ4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Sep 2013 12:56:07 -0400
In-Reply-To: <20130916150548.GO25896@mwanda>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Monday, September 16, 2013 8:06 AM
> To: KY Srinivasan
> Cc: olaf@aepfle.de; gregkh@linuxfoundation.org; jasowang@redhat.com;
> dmitry.torokhov@gmail.com; linux-kernel@vger.kernel.org; vojtech@suse.cz;
> linux-input@vger.kernel.org; apw@canonical.com; devel@linuxdriverproject.org
> Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
> synthetic keyboard
> 
> On Mon, Sep 16, 2013 at 02:46:24PM +0000, KY Srinivasan wrote:
> > > > +			case VM_PKT_DATA_INBAND:
> > > > +				hv_kbd_on_receive(device, desc);
> > >
> > > This is the error handling I mentioned at the top.  hv_kbd_on_receive()
> > > doesn't take into consideration the amount of data we recieved, it
> > > trusts the offset we recieved from the user.  There is an out of bounds
> > > read.
> >
> > What user are you referring to. The message is sent by the host - the user
> keystroke
> > is normalized into a fixed size packet by the host and sent to the  guest. We will
> parse this
> > packet, based on the host specified layout here.
> >
> 
> The user means the hypervisor, yes.
> 
> I don't want the hypervisor accessing outside of the buffer.  It is
> robustness issue.  Just check the offset against "bytes_recvd".  It's
> not complicated.

At the outset, let me apologize for not understanding your concern.
You say: " I don't want the hypervisor accessing outside of the buffer"
Where did you see the hypervisor accessing anything outside the buffer?
The buffer is allocated by this driver and a packet from vmbus is read into this
buffer - this is the call to vmbus_recvpacket(). If the specified buffer is smaller
than the packet that needs to be read, then nothing will be read. Once the read
completes, we can be sure we have read a valid packet and can proceed to parse it in
this driver.

I don't want to be argumentative, I am just not seeing the issue.

Regards,

K. Y
 
