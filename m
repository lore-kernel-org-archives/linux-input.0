From: Steve Chen <schen@mvista.com>
Subject: RE: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci
	Keyscan platform data
Date: Tue, 01 Dec 2009 11:08:10 -0600
Message-ID: <1259687290.3120.128.camel@linux-1lbu>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
	 <20091119025946.GC20172@core.coreip.homeip.net>
	 <4B057315.5070302@ridgerun.com>
	 <20091119165509.GA15647@core.coreip.homeip.net>
	 <4B05865B.7060303@ridgerun.com>
	 <20091119203321.GF15647@core.coreip.homeip.net>
	 <4B05B1B3.4050201@ridgerun.com>
	 <7A436F7769CA33409C6B44B358BFFF0C012B4387B4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hu47.mvista.com ([206.112.117.47]:35476 "HELO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with SMTP id S1754314AbZLAQ7M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Dec 2009 11:59:12 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012B4387B4@dlee02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>

On Thu, 2009-11-19 at 15:33 -0600, Narnakaje, Snehaprabha wrote:
> [...]
> 
> > > How do you ensure that only one of these drivers is loaded at a time?
> > > Or is the set of supported devices is board-specific (in which case the
> > > board code should have an idea how to properly set the configuration for
> > > the devices that are supported on that board)?
> > The DM365 EVM has other device that can't coexist with key scan, so this
> > is a
> > particular situation. There no way to ensure that one of this modules is
> > loaded
> > at time, but using device_enable handler is a proper way to ensure that a
> > driver
> > will be loaded properly, the board code can't assume which driver is going
> > to be
> > loaded.
> > 
> > I think Sneha, can bring you more details about this particular
> case.
> 
> Ideally PINMUX settings and any other EVM/board related
> initializations should be done in the board-setup files, when the
> platform_data for the driver is registered. Our PINMUX configuration
> APIs do not really have resource management capabilities to remember
> what drivers/peripherals have taken the resource/bits.
> 
> As Miguel mentioned, we have PINMUX conflict between Keyscan lines and
> the EMIF address lines used by CPLD. PINMUX2 register can only select
> one of configurations. CPLD is required for the video capture driver
> which should be enabled all the time in a system. So Miguel in his
> initial patch called the keyscan_init function within the #ifdef
> CONFIG_KEYSCAN construct. The keyscan_init function handled the PINMUX
> configuration for keyscan and also registered the platform_device. The
> general guideline in the board-setup files is that we should always
> let platform_device registered. The driver is enabled/disabled anyway
> using the CONFIG option.
> 
> The default configuration for the board does not enable Keyscan. One
> can test/use kescyan driver by enabling the CONFIG option, but CPLD
> (video capture input selection, to be specific) configuration will not
> be available. I would say, it is a limitation in the board/EVM design.
> Other board designs can have CPLD use different address lines, in
> which case the CONFIG option can be enabled in the default
> configuration.
> 
> Thanks
> Sneha
> 

During DA830/OMAP-L137 development in MVL 5, automatic pinmux detection
was added.  This allows pinmux configuration to change dynamically as
modules are loaded/unloaded.  When pinmux conflict is detected, driver
load would fail and the user is notified via error message with the
exact pins that caused the failure.

The pinmux conflict detection was tied to the clock interface, and the
patch was rejected by the community for that reason.  If you think it
would be helpful, you are welcome to look at the MVL Pro 5.0 code and
the patch submitted in the DaVinci mailing list archive.

Regards,

Steve

