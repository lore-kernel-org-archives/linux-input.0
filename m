From: kitsunyan <kitsunyan@inbox.ru>
Subject: Re: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480 devices
 should use RMI
Date: Sat, 14 Jul 2018 16:20:23 +0300
Message-ID: <16d5f040-cb2d-9984-53a4-5ae127bf7d6f@inbox.ru>
References: <20180707051913.24035-1-kitsunyan@inbox.ru>
 <20180714.153501.1002564188152837590.teika@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180714.153501.1002564188152837590.teika@gmx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Teika Kazura <teika@gmx.com>
Cc: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi, Teika. (Yes, you are right.)

I should've worried about real name earlier since I already sent the patch from pseudonym. I don't mind if the patch will be authored by maintainer, replacing my sign with "reported-by". (Hope it's possible.)

Regards,
kitsunyan

On 14/07/18 09:35, Teika Kazura wrote:
> Hi, kitsunyan. (Привет, perhaps?) Thanks for you patch, but the "signed-off" tag needs your real name. You can re-submit your patch conforming to that rule. Or if you're ok, the kernel maintainer can instead sign it off, adding "reported-by: kitsunyan <kitsunyan@inbox.ru>". (I'm not sure about the latter case. Sorry if I'm wrong.)
>
> You can find the instruction in <kernell source tree>/Documentation/process/submitting-patches.rst .
>
> Best regards / Пока, 
> Teika (Teika kazura)
>
>
> From: kitsunyan <kitsunyan@inbox.ru>
> Subject: [PATCH] Input: synaptics - Lenovo ThinkPad T25 and T480 devices should use RMI
> Date: Sat,  7 Jul 2018 08:19:12 +0300
>
>> The touchpads on both T25 and T480 are accessible over SMBUS/RMI.
>>
>> Signed-off-by: kitsunyan <kitsunyan@inbox.ru>
>> ---
>>  drivers/input/mouse/synaptics.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
>> index 55d33500d55e..be934a082424 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -175,7 +175,9 @@ static const char * const smbus_pnp_ids[] = {
>>  	"LEN0071", /* T480 */
>>  	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
>>  	"LEN0073", /* X1 Carbon G5 (Elantech) */
>> +	"LEN008e", /* T25 */
>>  	"LEN0092", /* X1 Carbon 6 */
>> +	"LEN0093", /* T480 */
>>  	"LEN0096", /* X280 */
>>  	"LEN0097", /* X280 -> ALPS trackpoint */
>>  	"LEN200f", /* T450s */
>> -- 
>> 2.18.0
