From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH v2 5/7] mfd: cros_ec: wait for completion of commands that
 return IN_PROGRESS
Date: Mon, 8 Sep 2014 09:16:17 -0700
Message-ID: <CAL1qeaHeAkr+1i1wP=Q=LUugDab78LCFGiVHs2F5CR6Ofgc-uA@mail.gmail.com>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
	<1408974008-17184-6-git-send-email-javier.martinez@collabora.co.uk>
	<20140904083426.GD8257@lee--X1>
	<540D9577.9000702@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <540D9577.9000702@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 8, 2014 at 4:39 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Lee,
>
> On 09/04/2014 10:34 AM, Lee Jones wrote:
>> On Mon, 25 Aug 2014, Javier Martinez Canillas wrote:
>>> From: Andrew Bresticker <abrestic@chromium.org>
>>>
>>> When an EC command returns EC_RES_IN_PROGRESS, we need to query
>>> the state of the EC until it indicates that it is no longer busy.
>>> Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
>>> commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
>>> it is working on the in-progress command.
>>>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>> ---
>>>
>>> Changes since v1:
>>>  - The *xfer() calls don't modify the passed cros_ec_command so there is
>>>    no need to populate it inside the for loop. Suggested by Lee Jones.
>>> ---
>>>  drivers/mfd/cros_ec.c | 34 +++++++++++++++++++++++++++++++++-
>>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>>> index c53804a..cd0c93c 100644
>>> --- a/drivers/mfd/cros_ec.c
>>> +++ b/drivers/mfd/cros_ec.c
>>> @@ -23,6 +23,10 @@
>>>  #include <linux/mfd/core.h>
>>>  #include <linux/mfd/cros_ec.h>
>>>  #include <linux/mfd/cros_ec_commands.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#define EC_COMMAND_RETRIES  50
>>> +#define EC_RETRY_DELAY_MS   10
>>
>> Where did these values come from?
>>
>
> These patches were taken from the ChromeOS 3.8 kernel so I don't really know
> why these values were chosen. I'll let Andrew or one of the ChromiumOS folks
> to answer this question.

These are the values flashrom used when retrying commands.
