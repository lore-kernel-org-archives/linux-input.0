From: =?big5?B?vEK5xcJA?= <scott.liu@emc.com.tw>
Subject: RE: How my i2c device bring up?
Date: Fri, 19 May 2017 14:42:03 +0800
Message-ID: <040b01d2d06b$06c00010$14400030$@emc.com.tw>
References: <032401d2cee9$6ab6ea80$4024bf80$@emc.com.tw> <9c683d1f-06c6-eadb-d9be-5ff22845181f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:38026 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751513AbdESGlX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 02:41:23 -0400
In-Reply-To: <9c683d1f-06c6-eadb-d9be-5ff22845181f@linux.intel.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Jarkko Nikula' <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, benjamin.tissoires@gmail.com, jeff.chuang@emc.com.tw

Hi Jarkko,
	After enabled those configurations on, the touch works.
	Chrome can recognize my touch device, thank you for help.

BR,
Scott 


> -----Original Message-----
> From: Jarkko Nikula [mailto:jarkko.nikula@linux.intel.com]
> Sent: Wednesday, May 17, 2017 7:56 PM
> To: ¼B¹ÅÂ@; linux-i2c@vger.kernel.org; linux-acpi@vger.kernel.org;
> linux-input@vger.kernel.org
> Cc: Dmitry Torokhov; benjamin.tissoires@gmail.com;
> jeff.chuang@emc.com.tw
> Subject: Re: How my i2c device bring up?
> 
> Hi
> 
> On 05/17/2017 11:41 AM, ¼B¹ÅÂ@ wrote:
> >
> > I have tried to install three versions of Chromium OS(R58-9334,
> > R59-9351,
> > R60-9554) respectively,
> > all of them runs kernel v4.4 and all of them can see nothing for my
> > device by ¡§ls /sys/bus/i2c/devices¡¨.
> > The output file is as ¡§Chromum_v4.4.52_dev_bus_i2c_devices_0517.jpg¡¨.
> > I guess the underlying drivers(I2C bus, ACPI DSDT table) could be
> > failed to recognize my I2C device.
> >
> Is this Intel Skylake ix-6xxx based laptop?
> 
> My guess is that based on your finding that i2c touchscreen works in
Ubuntu
> that Chromium kernel may not have needed drivers enabled.
> 
> If you have access to kernel config of Chromium image could you check does
it
> have these MFD_INTEL_LPSS configurations on? I have them as built-in but
> should work when built as modules too.
> 
> CONFIG_MFD_INTEL_LPSS=y
> CONFIG_MFD_INTEL_LPSS_ACPI=y
> CONFIG_MFD_INTEL_LPSS_PCI=y
> 
> I suppose these I2C_DESIGNWARE options are already on since I know there
> are Intel Baytrail based Chromebooks out there.
> 
> CONFIG_I2C_DESIGNWARE_CORE=m
> CONFIG_I2C_DESIGNWARE_PLATFORM=m
> CONFIG_I2C_DESIGNWARE_PCI=m
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
> 
> --
> Jarkko

