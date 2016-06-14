From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Tue, 14 Jun 2016 17:12:03 +0200
Message-ID: <1465917123.606.11.camel@hadess.net>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>	
 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>	
 <1465509287.24319.3.camel@linux.intel.com>
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>	
 <1465566904.10525.11.camel@linux.intel.com>
	 <1465568791.7409.38.camel@hadess.net>	
 <1465569941.10525.17.camel@linux.intel.com>
	 <1465571076.7409.39.camel@hadess.net>	
 <1465572227.24319.7.camel@linux.intel.com>
	 <1465572452.7409.41.camel@hadess.net>
	 <CACxGe6sjFHS9VaeWUY1PsJXhTW1Nvkuoqutty9oSX2Ywj+yV9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6sjFHS9VaeWUY1PsJXhTW1Nvkuoqutty9oSX2Ywj+yV9g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2016-06-14 at 14:44 +0100, Grant Likely wrote:
> On Fri, Jun 10, 2016 at 4:27 PM, Bastien Nocera <hadess@hadess.net>
> wrote:
> > On Fri, 2016-06-10 at 08:23 -0700, Srinivas Pandruvada wrote:
> > > On Fri, 2016-06-10 at 17:04 +0200, Bastien Nocera wrote:
> > > > > 
> > > 
> > > [...]
> > > 
> > > > Are there any errors when setting the triggers?
> > > > 
> > > Is there any debug option in this service to give more verbose
> > > output?
> > 
> > Add:
> > Environment="G_MESSAGES_DEBUG=all"
> > 
> > To the service file. You should see the debug in systemctl:
> > systemctl status iio-sensor-proxy.service
> > 
> > Or in journalctl if there's too much data:
> > journalctl --reverse -u iio-sensor-proxy.service
> 
> Still no joy on the sensors. The proxy starts up and detects the
> sensors, but I don't see any sensor events occurring:

Could you try again with the current master of iio-sensor-proxy? Make
sure to install the file in the same location as in your distro
provided package.

I've added more debug/warnings to a few cases where it would have
silently failed in the past.

In particular, I don't see any messages that would be coming out of:
https://github.com/hadess/iio-sensor-proxy/blob/master/src/iio-buffer-utils.c#L512

Could it be that the sub-directory is populated after the device is
created in the kernel, causing a race?

Either that, or the contents of the scan_elements/ directory is not the
one expected by this code.

The output of this command should us that:
ls /sys/devices/pci0000:00/0000:00:13.0/{33AECD58-B679-4E54-9BD9-A04D34F0C226}/001E:8086:22D8.0001/HID-SENSOR-200073.8.auto/iio:device1/scan_elements

Cheers
