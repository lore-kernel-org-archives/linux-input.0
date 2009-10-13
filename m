From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] Input: DaVinci Keypad Driver
Date: Tue, 13 Oct 2009 11:03:26 -0600
Message-ID: <4AD4B2DE.6050905@ridgerun.com>
References: <1255109225-6833-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20091013054644.GF2887@core.coreip.homeip.net>
	<BD79186B4FD85F4B8E60E381CAEE190901DB800C@mi8nycmail19.Mi8.com>
	<20091013165524.GA21593@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20091013165524.GA21593-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
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
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dmitry,

>>>> +static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
>>>> +{
>>>> +	u32 base = (u32)davinci_ks->base;
>>>> +
>>>> +	__raw_writel(val,(u32 *)(base + addr));
>>>> +}
>>> Do you really need these casts? I'd think that bare __raw_writel would
>>> work just fine.
>> The address for __raw_{write/read}* should be void __iomem *, davinci_ks->base
>> should already be the correct type due to ioremap().
>>
>> You can probably just change the whole thing to:
>>
>> +static void davinci_ks_write(struct davinci_ks *davinci_ks, u32 val, u32 addr)
>> +{
>> +	__raw_writel(val, davinci_ks->base + addr);
>> +}
>> +
>> +static u32 davinci_ks_read(struct davinci_ks *davinci_ks, u32 addr)
>> +{
>> +	return __raw_readl(davinci_ks->base + addr);
>> +}
>>
> 
> Better yet, use __raw_readl() and __raw_writel() directly - there is no
> need for wrappers that just rename existig functions not adding any
> additional functionality.
> 

Yes, I just test it with your patch and it worked fine.

Thanks,

Miguel Aguilar
