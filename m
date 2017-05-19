From: =?big5?B?vEK5xcJA?= <scott.liu@emc.com.tw>
Subject: RE: How my i2c device bring up?
Date: Fri, 19 May 2017 16:38:03 +0800
Message-ID: <042c01d2d07b$3ac612e0$b05238a0$@emc.com.tw>
References: <032401d2cee9$6ab6ea80$4024bf80$@emc.com.tw> <9c683d1f-06c6-eadb-d9be-5ff22845181f@linux.intel.com> <040b01d2d06b$06c00010$14400030$@emc.com.tw> <ed46f222-9cbe-92f5-962f-cf38b678476b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <ed46f222-9cbe-92f5-962f-cf38b678476b@linux.intel.com>
Content-Language: zh-tw
Sender: linux-acpi-owner@vger.kernel.org
To: 'Jarkko Nikula' <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, benjamin.tissoires@gmail.com, jeff.chuang@emc.com.tw
List-Id: linux-input@vger.kernel.org

> >
> Nice to hear. Looks like those Chromium images don't support platforms
that
> require those CONFIG_MFD_INTEL_LPSS options.
> 

Those configurations are default in 64bits image.
The image was 32bits in the first place I built which 
doesn't default set those configurations for Intel Baytrail.

Thanks.
Scott

