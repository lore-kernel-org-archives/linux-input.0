From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH] Input: set default for iProc touchscreen
Date: Tue, 11 Oct 2016 11:58:21 -0700
Message-ID: <3621cdc8-71b0-6638-84f8-dd83e634fd8b@broadcom.com>
References: <1475950295-9660-1-git-send-email-scott.branden@broadcom.com>
 <20161011174949.GA8841@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011174949.GA8841@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,


On 16-10-11 10:49 AM, Dmitry Torokhov wrote:
> On Sat, Oct 08, 2016 at 11:11:35AM -0700, Scott Branden wrote:
>> Enable the Broadcom iProc touchscreen by default for all iProc platforms.
>
> Why? Not all of them will have touchscreen attached, will they?
Correct - the touchscreen is enabled via the dtb configuration.  But, 
the default option when ARCH_BCM_IPROC is selected should have the 
driver enabled.  This avoids having to hunt around and turn on drivers 
after the upper level Kconfig options are selected.  Goal is to make it 
easy for user to get their kernel running by having defaults set 
appropriately.  If user wishes to optimize kernel size they can turn off 
drivers they do not need for their board.
>
> Thanks.
>
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/input/touchscreen/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 2fb1f43..f785371 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -364,6 +364,7 @@ config TOUCHSCREEN_ILI210X
>>  config TOUCHSCREEN_IPROC
>>  	tristate "IPROC touch panel driver support"
>>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
>> +	default ARCH_BCM_IPROC
>>  	help
>>  	  Say Y here if you want to add support for the IPROC touch
>>  	  controller to your system.
>> --
>> 2.5.0
>>
>
Regards,
  Scott
