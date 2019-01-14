From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add PNP IDs for Dell XPS models to
 forcepad
Date: Mon, 14 Jan 2019 10:40:12 -0800
Message-ID: <20190114184012.GC117329@dtor-ws>
References: <20190111205430.15371-1-kim@kimphillips.com>
 <20190112014004.GA122403@dtor-ws>
 <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22e2d619-0622-1816-2057-c9005288b46b@kimphillips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim@kimphillips.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Jan 12, 2019 at 04:04:36PM -0600, Kim Phillips wrote:
> On 1/11/19 7:40 PM, Dmitry Torokhov wrote:
> > Hi Kim,
> 
> Hi Dmitry,
> 
> > On Fri, Jan 11, 2019 at 02:54:30PM -0600, Kim Phillips wrote:
> >> This patch is the result of seeing this message:
> >>
> >> psmouse serio1: synaptics: Your touchpad (PNP: DLL087c PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> >>
> >> If I set psmouse.synaptics_intertouch=1, or add the PNP ID to
> >> smbus_pnp_ids, the touchpad continues to work, and the above message
> >> goes away, but we now get:
> >>
> >> psmouse serio1: synaptics: Trying to set up SMBus access
> >> psmouse serio1: synaptics: SMbus companion is not ready yet
> >>
> >> With this patch applied, i.e., the PNP IDs are added to the forcepad
> >> array, the touchpad continues to work and all of the above messages
> >> disappear.
> > 
> > Are you sure the touchpad in XPSes is a forcepad (i.e. it does not have
> > physical button underneath it)? As far as I know there were only couple
> > of HP laptops with forcepads and when switching to RMI mode forcepads
> > need F21 handler that we do not currently have in the kernel.
> 
> I see, no, I'm not sure, but assuming you're right, the IDs 
> should be added to the smbus array instead, after fixing 
> the SMbus "companion not ready" problem?  Pointers for that and 
> the below interrupts when touchpad idle after resume, welcome.
> 
> Also, the link to get the RMI4 spec in
> Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
> is broken.  Any pointers for that also appreciated.

OK, sorting it all out some more:

- because we do not have support for F21 necessary for forcepads adding
  APIC ID to forcepad list actuallty disables SMbus companion mode, that
  is why you no longer see "companion not ready" messages vs. setting
  psmouse.synaptics_intertouch=1 module parameter.

- this does not really matter as your touchpad ends up being driven by
  i2c-hid and hid-multitouch drivers, and that is how we wait it to
  work, as we do not want to deviate from behavior on Windows since OEM
  tested it (the device and firmware) in tha configuration.

- we need to figure out issue with interrupts on resume, maybe Benjamin
  have seen it?

Thanks.

-- 
Dmitry
