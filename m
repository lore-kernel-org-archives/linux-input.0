From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Fri, 25 Sep 2009 08:45:31 -0600
Message-ID: <4ABCD78B.5050605@ridgerun.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3271@dbde02.ent.ti.com>	<4ABCD1E8.5000200@ridgerun.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3@dbde02.ent.ti.com>
	<0554BEF07D437848AF01B9C9B5F0BC5D92C8EBC0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <0554BEF07D437848AF01B9C9B5F0BC5D92C8EBC0-bGftbgMkZa+IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


>>>>> +     /* Enable Keyscan module and enable */
>>>>> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET |
>> DAVINCI_KEYSCAN_KEYEN,
>>>>> +                     DAVINCI_KEYSCAN_KEYCTRL);
>>>> We seem to be hardcoded to the 4x4 matrix type here.
>>>> Some DM365 boards could use 5x3 matrix.
>>>>
>>>> Thanks,
>>>> Sekhar
>>>>
>>> [MA] I will add a platform option for matrix type to choose 4x4 or 5x3
>> matrix.
>>> What do think about this?
>>>
>> Sounds good. I am not sure if any other piece of code
>> needs to change though.
> The strobe and interval have to change.  Afcourse that change comes into the picture only when the mode is changed from 4x4 to 5x3.
> I can see that there are options given for this in board specific code.
>> Thanks,
>> Sekhar
> 
> Thanks,
> Sandeep
> 

struct davinci_ks_platform_data {
	unsigned short	*keymap;
	u32		keymapsize;
	u32		rep:1;
	u32		strobe;
	u32		interval;
+	u32		matrix_type;
};

I will add something like this, so from the board specific code you can define 
strobe, interval and matrix type.

Thanks,

Miguel Aguilar
