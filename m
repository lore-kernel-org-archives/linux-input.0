From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: Re: [PATCH] Input: pwm-beeper - defer pwm config if pwm can sleep
Date: Tue, 23 Feb 2016 09:46:02 +0100
Message-ID: <56CC1C4A.7010509@gmx.at>
References: <56C4735E.6020300@gmx.at> <20160222194639.GD26177@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:53508 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098AbcBWIqN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 03:46:13 -0500
In-Reply-To: <20160222194639.GD26177@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 2016-02-22 20:46, Dmitry Torokhov wrote:
> On Wed, Feb 17, 2016 at 02:19:26PM +0100, Manfred Schlaegl wrote:
>> If the pwm can sleep defer actions to it using a worker.
>> A similar approach was used in leds-pwm (c971ff185)
>>
>> Trigger:
>> On a Freescale i.MX53 based board we ran into "BUG: scheduling while
>> atomic" because input_inject_event locks interrupts, but
>> imx_pwm_config_v2 sleeps.
>>
>> Tested on Freescale i.MX53 SoC with 4.5-rc1 and 4.1.
>>
>> Unmodified applicable to
>>  * 4.5-rc4
>>  * 4.4.1 (stable)
>>  * 4.3.5 (stable)
>>  * 4.1.18 (longterm)
>>
>> Modified applicable to
>>  * 3.18.27 (longterm)
>>
>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
>> ---
>>  drivers/input/misc/pwm-beeper.c | 62 +++++++++++++++++++++++++++++------------
>>  1 file changed, 44 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
>> index f2261ab..c160b5e 100644
>> --- a/drivers/input/misc/pwm-beeper.c
>> +++ b/drivers/input/misc/pwm-beeper.c
>> @@ -20,21 +20,42 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pwm.h>
>>  #include <linux/slab.h>
>> +#include <linux/workqueue.h>
>>  
>>  struct pwm_beeper {
>>  	struct input_dev *input;
>>  	struct pwm_device *pwm;
>> +	struct work_struct work;
>>  	unsigned long period;
>> +	bool can_sleep;
> 
> I wonder if it is not better to always schedule work, regardless of
> whether PWM may sleep or not.
> 
> Thanks.
> 

In my opinion there is no real strong argument to do it this or that way.
I decided to do it this way because of following weaker arguments:
 1. If pwm can not sleep the behavior stays exactly the same as before
 2. The introduced conditions do not really add much complexity to the code
 3. It was successfully done the same way in leds-pwm

Best regards,
Manfred


