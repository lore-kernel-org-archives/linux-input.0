From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307
 2-in-1
Date: Fri, 15 Mar 2019 18:39:04 +0100
Message-ID: <8082b51a-32e9-3e39-969d-9121d2901ba1@redhat.com>
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro>
 <CAHp75VeQ=6zD5tVV_gVE4S3CDWaYgQ0Lpqq57bxjQjqJYerUAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeQ=6zD5tVV_gVE4S3CDWaYgQ0Lpqq57bxjQjqJYerUAQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 3/15/19 6:33 PM, Andy Shevchenko wrote:
> On Fri, Mar 15, 2019 at 3:31 PM Gabriel Lazar
> <gabriel.lazar@com.utcluj.ro> wrote:
>>
>> Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.
> 
> You sent one patch twice or two patches?
> Please, clarify this by sending v2 with correct subject line(s) and
> amount of patches.

Gabriel send the same patch twice, the first version came from
his yahoo email address, which vger bounced (but the direct addressed
people received), so he send a second copy from his other email address.

Regards,

Hans




> 
>>
>> Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
>> ---
>>   drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
>> index 2d56ff7c8230..3319f0cbb558 100644
>> --- a/drivers/platform/x86/touchscreen_dmi.c
>> +++ b/drivers/platform/x86/touchscreen_dmi.c
>> @@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
>>          .properties     = jumper_ezpad_mini3_props,
>>   };
>>
>> +static const struct property_entry myria_my8307_props[] = {
>> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
>> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
>> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
>> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
>> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
>> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
>> +       { }
>> +};
>> +
>> +static const struct ts_dmi_data myria_my8307_data = {
>> +       .acpi_name      = "MSSL1680:00",
>> +       .properties     = myria_my8307_props,
>> +};
>> +
>>   static const struct property_entry onda_obook_20_plus_props[] = {
>>          PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
>>          PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
>> @@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>>                          DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
>>                  },
>>          },
>> +       {
>> +               /* Myria MY8307 */
>> +               .driver_data = (void *)&myria_my8307_data,
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
>> +               },
>> +       },
>>          {
>>                  /* Onda oBook 20 Plus */
>>                  .driver_data = (void *)&onda_obook_20_plus_data,
>> --
>> 2.21.0
>>
> 
> 
