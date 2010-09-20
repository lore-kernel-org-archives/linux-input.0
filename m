From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable()
 conditions
Date: Mon, 20 Sep 2010 16:18:49 +0800
Message-ID: <4C9718E9.5040104@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com> <1284634286-8871-4-git-send-email-jason77.wang@gmail.com> <1284634286-8871-5-git-send-email-jason77.wang@gmail.com> <201009162339.06395.dmitry.torokhov@gmail.com> <4C9332CE.6040905@gmail.com> <20100917160709.GC14186@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63867 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab0ITIPH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 04:15:07 -0400
In-Reply-To: <20100917160709.GC14186@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Wang <jason77.wang@gmail.com>, notasas@gmail.com, vapier@gentoo.org, linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Fri, Sep 17, 2010 at 05:20:14PM +0800, Jason Wang wrote:
>   
>> Dmitry Torokhov wrote:
>>     
>>> Hi Jason,
>>>
>>> On Thursday, September 16, 2010 03:51:26 am Jason Wang wrote:
>>>       
>>>> The design like that, we can stop or disable ADC, one difference is
>>>> the disable not only stop the ADC but also close the power regulator.
>>>> So we change the condition flag to stopped in the _stop() function.
>>>>
>>>> Because we call __ads7846_disable() in the suspend/resume process, so
>>>> move disabled flag modification from ads7846_disable() to the
>>>> __ads7846_disable(), otherwise when we call _disable() in the suspend,
>>>> and the ADC is really suspended but the flag shows that it isn't.
>>>>         
>>> I disagree with the patch. "Disable" knob is separate from PM
>>> knobs (suspend/resume); and thus that attribute should only read
>>> "1" when
>>> user forcibly disabled the device via sysfs. Same goes for open/close.
>>>
>>> Thanks.
>>>
>>>       
>> OK, i will fix this patch.
>>
>>     
>
> Hmm, I am not sure what there is to fix... Maybe I misunderstood your
> description. Could you please try again to explain what you are trying
> to achieve?
>
> Thanks!
>
>   
It seems that i mis-understand your original design. I am wrong for this
patch because i mingled disabled and suspended flags.

Your original design is like that, these two flags are separate ones, 
either one
is true, we should stop ADC, Both of them is false we can restart ADC.

But current design(don't apply my 0004-xxx.patch) has some little bugs:
the condition in the ads7846_restart is,
static void ads7846_restart(struct ads7846 *ts)
{
if (!ts->disabled && !ts->suspended) {

But, when we call ads7846_enable()/ads7846_resume(), the 
disabled/suspended flag's
update are all at the place after the ads7846_restart() is called, so 
this will cause the
ads7846_restart() can't be executed. User will see after they 
enable/wakeup this driver
through sysfs, the driver still doesn't work.

There are two smallest fixes, i don't know which one is better?

1) replace the stop()/restart() condition flag to ->stopped:
static void ads7846_stop(struct ads7846 *ts)
{
- if (!ts->disabled && !ts->suspended) {
+ if (!ts->stopped) {
/* Signal IRQ thread to stop polling and disable the handler. */
ts->stopped = true;
mb();
@@ -210,7 +210,7 @@ static void ads7846_stop(struct ads7846 *ts)
/* Must be called with ts->lock held */
static void ads7846_restart(struct ads7846 *ts)
{
- if (!ts->disabled && !ts->suspended) {
+ if (ts->stopped) {
/* Tell IRQ thread that it may poll the device. */
ts->stopped = false;
mb();

2) move the flags update in the enable()/resume() a little bit forward:

--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -253,10 +253,11 @@ static void ads7846_enable(struct ads7846 *ts)
{
mutex_lock(&ts->lock);

- if (ts->disabled && !ts->suspended)
+ if (ts->disabled && !ts->suspended) {
+ ts->disabled = false;
__ads7846_enable(ts);
-
- ts->disabled = false;
+ } else
+ ts->disabled = false;

mutex_unlock(&ts->lock);
}
@@ -919,10 +920,10 @@ static int ads7846_resume(struct spi_device *spi)
if (device_may_wakeup(&ts->spi->dev))
disable_irq_wake(ts->spi->irq);

+ ts->suspended = false;
+
if (!ts->disabled)
__ads7846_enable(ts);
-
- ts->suspended = false;
}

mutex_unlock(&ts->lock);


Thanks,
Jason.
