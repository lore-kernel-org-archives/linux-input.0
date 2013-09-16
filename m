From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
 synthetic keyboard
Date: Mon, 16 Sep 2013 10:13:20 -0700
Message-ID: <20130916171320.GC20734@core.coreip.homeip.net>
References: <1379309334-25042-1-git-send-email-kys@microsoft.com>
 <20130916152019.GB12105@core.coreip.homeip.net>
 <076938490f5141ef957947dc10b82c65@SN2PR03MB061.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <076938490f5141ef957947dc10b82c65@SN2PR03MB061.namprd03.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vojtech@suse.cz" <vojtech@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 16, 2013 at 03:52:18PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Monday, September 16, 2013 8:20 AM
> > To: KY Srinivasan
> > Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; linux-input@vger.kernel.org; vojtech@suse.cz;
> > olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> > Subject: Re: [PATCH 1/1] Drivers: input: serio: New driver to support Hyper-V
> > synthetic keyboard
> > 
> > Hi K. Y.
> > 
> > On Sun, Sep 15, 2013 at 10:28:54PM -0700, K. Y. Srinivasan wrote:
> > > Add a new driver to support synthetic keyboard. On the next generation
> > > Hyper-V guest firmware, many legacy devices will not be emulated and this
> > > driver will be required.
> > >
> > > I would like to thank Vojtech Pavlik <vojtech@suse.cz> for helping me with the
> > > details of the AT keyboard driver.
> > >
> > 
> > In addition to what Dan said:
> > 
> > > +
> > > +struct synth_kbd_protocol_response {
> > > +	struct synth_kbd_msg_hdr header;
> > > +	u32 accepted:1;
> > > +	u32 reserved:31;
> > > +};
> > 
> > Use of bitfields for on the wire structures makes me uneasy. I know that
> > currently you only going to run LE on LE, but still, maybe using
> > explicit shifts and masks would be better,
> 
> This definition of the data structure is defined by the host. I will see what I
> can do here.

You do not really need to change protocol, you just sat that accepted is
the bit 0 of the word and define endianness (LE in your case). Then you
do:

	struct synth_kbd_protocol_response {
		struct synth_kbd_msg_hdr header;
		__le32 status;
	}

	#define KBD_PROTOCOL_ACCEPTED BIT(0)

	...

	status = _le32_to_cpu(response->status);
	accepted = status & KBD_PROTOCOL_ACCEPTED;

Thanks.

-- 
Dmitry
