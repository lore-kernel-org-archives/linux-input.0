From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH v4 1/2] Input: DaVinci Keypad Driver
Date: Tue, 13 Oct 2009 12:21:47 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB800C@mi8nycmail19.Mi8.com>
References: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com> <20091013054644.GF2887@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from chip2og108.obsmtp.com ([64.18.13.65]:54892 "HELO
	chip2og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752067AbZJMQ1b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 12:27:31 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20091013054644.GF2887@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Monday, October 12, 2009 10:47 PM, Dmitry Torokhov wrote:
> Hi Miguel,
> 
> On Fri, Oct 09, 2009 at 11:27:05AM -0600, miguel.aguilar@ridgerun.com wrote:
>> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> 
>> Adds the driver for enabling keypad support for DaVinci platforms.
>> 
>> DM365 is the only platform that uses this driver at the moment.
>> 
>
> Looks pretty good, I have one question:
>
>> +static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
>> +{
>> +	u32 base = (u32)davinci_ks->base;
>> +
>> +	__raw_writel(val,(u32 *)(base + addr));
>> +}
>
> Do you really need these casts? I'd think that bare __raw_writel would
> work just fine.

The address for __raw_{write/read}* should be void __iomem *, davinci_ks->base
should already be the correct type due to ioremap().

You can probably just change the whole thing to:

+static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
+{
+	__raw_writel(val, davinci_ks->base + addr);
+}
+
+static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
+{
+	return __raw_readl(davinci_ks->base + addr);
+}

Regards,
Hartley
