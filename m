From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / platform: Add SMB0001 HID to forbidden_id_list
Date: Wed, 21 Nov 2018 11:43:13 +0100
Message-ID: <2540392.2evLZ0RuP4@aspire.rjw.lan>
References: <20181119180601.962-1-hdegoede@redhat.com> <df516936-89f4-0fc9-1904-1a719bcd13fe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <df516936-89f4-0fc9-1904-1a719bcd13fe@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Lukas Kahnert <openproggerfreak@gmail.com>, Marc <suaefar@googlemail.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday, November 21, 2018 11:37:22 AM CET Hans de Goede wrote:
> HI,
> 
> On 19-11-18 19:06, Hans de Goede wrote:
> > Many HP AMD based laptops contain an SMB0001 device like this:
> > 
> > Device (SMBD)
> > {
> >      Name (_HID, "SMB0001")  // _HID: Hardware ID
> >      Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >      {
> >          IO (Decode16,
> >              0x0B20,             // Range Minimum
> >              0x0B20,             // Range Maximum
> >              0x20,               // Alignment
> >              0x20,               // Length
> >              )
> >          IRQ (Level, ActiveLow, Shared, )
> >              {7}
> >      })
> > }
> > 
> > The legacy style IRQ resource here causes acpi_dev_get_irqresource() to
> > be called with legacy=true and this message to show in dmesg:
> > ACPI: IRQ 7 override to edge, high
> > 
> > This causes issues when later on the AMD0030 GPIO device gets enumerated:
> > 
> > Device (GPIO)
> > {
> >      Name (_HID, "AMDI0030")  // _HID: Hardware ID
> >      Name (_CID, "AMDI0030")  // _CID: Compatible ID
> >      Name (_UID, Zero)  // _UID: Unique ID
> >      Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >      {
> > 	Name (RBUF, ResourceTemplate ()
> > 	{
> > 	    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
> > 	    {
> > 		0x00000007,
> > 	    }
> > 	    Memory32Fixed (ReadWrite,
> > 		0xFED81500,         // Address Base
> > 		0x00000400,         // Address Length
> > 		)
> > 	})
> > 	Return (RBUF) /* \_SB_.GPIO._CRS.RBUF */
> >      }
> > }
> > 
> > Now acpi_dev_get_irqresource() gets called with legacy=false, but because
> > of the earlier override of the trigger-type acpi_register_gsi() returns
> > -EBUSY (because we try to register the same interrupt with a different
> > trigger-type) and we end up setting IORESOURCE_DISABLED in the flags.
> > 
> > The setting of IORESOURCE_DISABLED causes platform_get_irq() to call
> > acpi_irq_get() which is not implemented on x86 and returns -EINVAL.
> > resulting in the following in dmesg:
> > 
> > amd_gpio AMDI0030:00: Failed to get gpio IRQ: -22
> > amd_gpio: probe of AMDI0030:00 failed with error -22
> > 
> > The SMB0001 is a "virtual" device in the sense that the only way the OS
> > interacts with it is through calling a couple of methods to do SMBus
> > transfers. As such it is weird that it has IO and IRQ resources at all,
> > because the driver for it is not expected to ever access the hardware
> > directly.
> > 
> > The Linux driver for the SMB0001 device directly binds to the acpi_device
> > through the acpi_bus, so we do not need to instantiate a platform_device
> > for this ACPI device. This commit adds the SMB0001 HID to the
> > forbidden_id_list, avoiding the instantiating of a platform_device for it.
> > Not instantiating a platform_device means we will no longer call
> > acpi_dev_get_irqresource() for the legacy IRQ resource fixing the probe of
> > the AMDI0030 device failing.
> > 
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1644013
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=198715
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199523
> > Reported-by: Lukas Kahnert <openproggerfreak@gmail.com>
> > Tested-by: Marc <suaefar@googlemail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> A quick status update on this, I've got confirmation from 4 different users
> that this fixes the touchscreen not working on various models AMD based
> HP laptops.
> 
> As such it would be nice to get this into 4.20 as a bugfix.

I'm going to queue it up.

Thanks,
Rafael
