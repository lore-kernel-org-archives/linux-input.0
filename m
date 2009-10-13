From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] Input: DaVinci Keypad Driver
Date: Tue, 13 Oct 2009 10:43:49 -0600
Message-ID: <4AD4AE45.8050607@ridgerun.com>
References: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20091013054644.GF2887@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20091013054644.GF2887-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dmitry,


Dmitry Torokhov wrote:
> Hi Miguel,
> 
> On Fri, Oct 09, 2009 at 11:27:05AM -0600, miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org wrote:
>> From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
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
> 
>> +
>> +static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
>> +{
>> +	u32 base = (u32)davinci_ks->base;
>> +
>> +	return __raw_readl((u32 *)(base + addr));
>> +}
> 
> Could you also please try the patch below and let me know if it breaks
> things. Also iof you coulr run sparse over the driver that would be
> nice.
> 
> Thanks!
> 

Thanks for the patch, I will add it and resend the whole patch.

Just one thing failed:

+fail6:
+	free_irq(davinci_ks->irq);

this must be:

	free_irq(davinci_ks->irq, davinci_ks);
