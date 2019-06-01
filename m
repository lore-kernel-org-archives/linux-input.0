From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drivers: hid: Add a module description line to the
 hid_hyperv driver
Date: Sat, 1 Jun 2019 14:30:56 -0400
Message-ID: <20190601183056.GO12898@sasha-vm>
References: <20190530173720.17994-1-sashal@kernel.org>
 <nycvar.YFH.7.76.1906010018310.1962@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1906010018310.1962@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Joseph Salisbury <Joseph.Salisbury@microsoft.com>
List-Id: linux-input@vger.kernel.org

On Sat, Jun 01, 2019 at 12:19:11AM +0200, Jiri Kosina wrote:
>On Thu, 30 May 2019, Sasha Levin wrote:
>
>> From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
>>
>> This patch only adds a MODULE_DESCRIPTION statement to the driver.
>> This change is only cosmetic, so there should be no runtime impact.
>>
>> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/hid/hid-hyperv.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
>> index 704049e62d58a..d3311d714d359 100644
>> --- a/drivers/hid/hid-hyperv.c
>> +++ b/drivers/hid/hid-hyperv.c
>> @@ -614,5 +614,7 @@ static void __exit mousevsc_exit(void)
>>  }
>>
>>  MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
>> +
>
>Is there a reason why you didn't CC Joseph on this submission?

Hm, no, I just went with my usual get_maintainers.pl + whomever git
adds. Sorry Joe!

--
Thanks,
Sasha
