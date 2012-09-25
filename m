From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCHv2 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
Date: Tue, 25 Sep 2012 23:31:07 +0530
Message-ID: <CAKdam576mtUpe0UdFPCiB_9OVv4pVOc=fw5Qs-1TeGmkEmw8Pw@mail.gmail.com>
References: <1346844964-24839-1-git-send-email-sourav.poddar@ti.com>
	<20120925175255.GA13823@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120925175255.GA13823@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, b-cousson@ti.com, balbi@ti.com, santosh.shilimkar@ti.com, sameo@linux.intel.com
List-Id: linux-input@vger.kernel.org

Hi,

On Tue, Sep 25, 2012 at 11:22 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Sep 05, 2012 at 05:06:04PM +0530, Sourav Poddar wrote:
>
>> +static struct regmap_config smsc_regmap_config = {
>> +             .reg_bits = 8,
>> +             .val_bits = 8,
>> +             .max_register = SMSC_MAX_REGISTER - 1;
>> +             .cache_type = REGCACHE_COMPRESSED,
>> +};
>
> That definition of max_register looks wrong - why are we subtracting 1
> from a macro called MAX_REGISTER to get it?
>
Yes, my bad.
Actually, I have define in .h file something like this..
#define SMSC_MAX_REG                                    (SMSC_VEN_ID_H
+ 1) where
SMSC_VEN_ID_H is the last register address which this chip supports.

I think I should directly assign max_address to SMSC_VEN_ID_H.   ?
+
+
> Indentation here is a bit odd too.
>
Will rectify.
>> +static int smsc_i2c_remove(struct i2c_client *i2c)
>> +{
>> +     return 0;
>> +}
>
> Remove empty functions.
Ok.
