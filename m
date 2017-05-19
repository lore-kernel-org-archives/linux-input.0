From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: How my i2c device bring up?
Date: Fri, 19 May 2017 11:23:29 +0300
Message-ID: <ed46f222-9cbe-92f5-962f-cf38b678476b@linux.intel.com>
References: <032401d2cee9$6ab6ea80$4024bf80$@emc.com.tw>
 <9c683d1f-06c6-eadb-d9be-5ff22845181f@linux.intel.com>
 <040b01d2d06b$06c00010$14400030$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <040b01d2d06b$06c00010$14400030$@emc.com.tw>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, benjamin.tissoires@gmail.com, jeff.chuang@emc.com.tw
List-Id: linux-input@vger.kernel.org

On 05/19/2017 09:42 AM, ¼B¹ÅÂ@ wrote:
> Hi Jarkko,
> 	After enabled those configurations on, the touch works.
> 	Chrome can recognize my touch device, thank you for help.
>
Nice to hear. Looks like those Chromium images don't support platforms 
that require those CONFIG_MFD_INTEL_LPSS options.

-- 
Jarkko

