From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] Input: ads7846: Convert to hwmon_device_register_with_groups
Date: Tue, 26 Nov 2013 17:20:13 -0800
Message-ID: <529548CD.7060906@roeck-us.net>
References: <1385440744-6607-1-git-send-email-linux@roeck-us.net> <20131126185846.GB22242@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131126185846.GB22242@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 11/26/2013 10:58 AM, Dmitry Torokhov wrote:
> Hi Guenter,
>
> On Mon, Nov 25, 2013 at 08:39:04PM -0800, Guenter Roeck wrote:
>> Simplify the code and create mandatory 'name' attribute by using
>> new hwmon API.
>
> So this moves hwmon attributes from the parent i2c device to the hwmon
> device, right? Would not that break userspace which expects to find the
> attributes where they were?
>

In addition to Jean's earlier comments ... s/i2c/spi/, I assume. spi devices
don't create the mandatory name attribute automatically, which means
that the created hwmon device was not recognized by standard user space
applications (eg the sensors command or anything else using libsensors)
in the first place. Which in turn means that only applications which don't
support the standard hwmon ABI - if there are any - would be affected.
What we are more concerned about is to make sure that applications
which _do_ follow the hwmon ABI are working.

Thanks,
Guenter
