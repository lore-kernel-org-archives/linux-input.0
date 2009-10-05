From: Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Mon, 5 Oct 2009 13:29:52 -0600
Message-ID: <4ACA4930.80300@ridgerun.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3271@dbde02.ent.ti.com>
	<4ABCD1E8.5000200@ridgerun.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3@dbde02.ent.ti.com>
	<0554BEF07D437848AF01B9C9B5F0BC5D92C8EBC0@dlee01.ent.ti.com>
	<4ABCD78B.5050605@ridgerun.com>
	<20090928170231.GD21455@core.coreip.homeip.net>
	<0554BEF07D437848AF01B9C9B5F0BC5D92D13959@dlee01.ent.ti.com>
	<87iqf1v3zb.fsf@deeprootsystems.com>
	<4AC35FC8.9010108@ridgerun.com>
	<20091005175428.GB18588@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20091005175428.GB18588-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
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
Cc: "santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <santiago.nunez-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <clark.becker-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org" <todd.fischer-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, Sep 30, 2009 at 07:40:24AM -0600, Miguel Aguilar wrote:
>> Kevin Hilman wrote:
>>> "Paulraj, Sandeep" <s-paulraj-l0cyMroinI0@public.gmane.org> writes:
>>>
>>>>> On Fri, Sep 25, 2009 at 08:45:31AM -0600, Miguel Aguilar wrote:
>>>>>>>>>>> +     /* Enable Keyscan module and enable */
>>>>>>>>>>> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET |
>>>>>>>> DAVINCI_KEYSCAN_KEYEN,
>>>>>>>>>>> +                     DAVINCI_KEYSCAN_KEYCTRL);
>>>>>>>>>> We seem to be hardcoded to the 4x4 matrix type here.
>>>>>>>>>> Some DM365 boards could use 5x3 matrix.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Sekhar
>>>>>>>>>>
>>>>>>>>> [MA] I will add a platform option for matrix type to choose 4x4 or
>>>>> 5x3
>>>>>>>> matrix.
>>>>>>>>> What do think about this?
>>>>>>>>>
>>>>>>>> Sounds good. I am not sure if any other piece of code
>>>>>>>> needs to change though.
>>>>>>> The strobe and interval have to change.  Afcourse that change comes
>>>>> into the picture only when the mode is changed from 4x4 to 5x3.
>>>>>>> I can see that there are options given for this in board specific code.
>>>>>>>> Thanks,
>>>>>>>> Sekhar
>>>>>>> Thanks,
>>>>>>> Sandeep
>>>>>>>
>>>>>> struct davinci_ks_platform_data {
>>>>>> 	unsigned short	*keymap;
>>>>>> 	u32		keymapsize;
>>>>>> 	u32		rep:1;
>>>>>> 	u32		strobe;
>>>>>> 	u32		interval;
>>>>>> +	u32		matrix_type;
>>>>>> };
>>>>>>
>>>>>> I will add something like this, so from the board specific code you can
>>>>>> define strobe, interval and matrix type.
>>>>> Make it enum at least. BTW, is it possible to add u8 rows, cols instead
>>>>> and be able to handle more matrix variations?
>>>> The IP can handle only 4x4 or 5x3.
>>>>
>>> Even so, the rows, cols approach is more readable IMO.
>>>
>> The key sacan mode is set just by one bit 4X4 or 5X3, Is it really 
>> necessary use rows and cols in this case?
> 
> No, if the hardware only has 2 modes (switchable by a single bit or
> something like that) then an enum is more clear IMO.
> 

ok, I will use just a enum with the two possible cases.

Thanks,

Miguel Aguilar
