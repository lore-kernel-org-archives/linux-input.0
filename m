From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 1/2] Input: DaVinci Keypad Driver
Date: Tue, 13 Oct 2009 12:59:19 -0600
Message-ID: <4AD4CE07.6090801@ridgerun.com>
References: <1255454163-22179-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20091013181301.GB21593@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20091013181301.GB21593-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
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

Dmitry Torokhov wrote:
> Miguel,
> 
> On Tue, Oct 13, 2009 at 11:16:03AM -0600, miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org wrote:
>> From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
>>
>> Adds the driver for enabling keypad support for DaVinci platforms.
>>
>> DM365 is the only platform that uses this driver at the moment.
>>
> 
> Could you please also get rid of davinci_ks_{read,write} - they are
> pointless. I promise this is my last request ;)
Sure, I misunderstood this point. I'll remove those function and call readl and 
writel directly.
> 
> Also - I wonder who "owns" board-specific code (the one your second
> patch is affecting). I usually let arch people to merge it instead of
> goping thruogh input tree.
> 
Kevin Hilman is the one who owns the the DaVinci code.
