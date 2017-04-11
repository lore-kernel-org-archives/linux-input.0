From: Peter Fink <pfink@christ-es.de>
Subject: Re: [PATCH] input: touchscreen: stmpe: check fifo_empty flag before
 reading x/y values
Date: Tue, 11 Apr 2017 12:07:55 +0200
Message-ID: <0ebff60f-67ee-a3b1-2206-14ef172b6d6d@christ-es.de>
References: <1491817946-13926-1-git-send-email-pfink@christ-es.de>
 <20170411033347.GA4346@dtor-ws>
 <F50ED7964AF8784493DDA71A307917F9D157D0B6@BEXBE01.christ.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm21-vm9.bullet.mail.ir2.yahoo.com ([212.82.97.6]:42263 "EHLO
        nm21-vm9.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753208AbdDKKIA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 06:08:00 -0400
In-Reply-To: <F50ED7964AF8784493DDA71A307917F9D157D0B6@BEXBE01.christ.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: pfink@christ-es.de, stefan.agner@toradex.com, linux-input@vger.kernel.org

Hi Dmitry,
thank you for your response.

On Mon, Apr 10, 2017 at 20:33:47 -0700, Dmitry Torokhov wrote:
> Hi Peter,
>
> On Mon, Apr 10, 2017 at 11:52:26AM +0200, Peter Fink wrote:
>> STMPE driver with STMPE811 reported x=0/y=0 when clicking in
>> succession at higher speeds. In some configurations the consuming X11
>> input stack is able to ignore this input, but e.g. with inverted axes this is prone to fail.
>>
>> In these cases it might happen that even applications are closed when
>> the close-X is located in the same corner as touch 0/0 is mapped to.
>> This happens when touch coordinates are read from an empty fifo
>> although the threshold interrupt indicates that new data is available.
>>
>> To avoid wrong touch data read and evaluate the fifo_empty bit before
>> accessing the fifo.
>>
>> Signed-off-by: Peter Fink <pfink@christ-es.de>
>> ---
>>   drivers/input/touchscreen/stmpe-ts.c | 24 +++++++++++++++---------
>>   1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/stmpe-ts.c
>> b/drivers/input/touchscreen/stmpe-ts.c
>> index 2a78e27..dcc9d48 100644
>> --- a/drivers/input/touchscreen/stmpe-ts.c
>> +++ b/drivers/input/touchscreen/stmpe-ts.c
>> @@ -44,6 +44,7 @@
>>   #define OP_MOD_XYZ                   0
>>
>>   #define STMPE_TSC_CTRL_TSC_EN                (1<<0)
>> +#define STMPE_FIFO_EMPTY             (1<<5)
> This belongs with other FIFO STA register definitions, please move there.  Also, all these could be converted to BIT().

Sorry, this define was intended to go unter FIFO_STA_RESET. I copied the 
define to the wrong line. Should I include conversion to BIT in the same 
patch or prepare a second patch?

>>   #define STMPE_FIFO_STA_RESET         (1<<0)
>>
>> @@ -175,17 +176,22 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
>>        stmpe_set_bits(ts->stmpe, STMPE_REG_TSC_CTRL,
>>                                STMPE_TSC_CTRL_TSC_EN, 0);
>>
>> -     stmpe_block_read(ts->stmpe, STMPE_REG_TSC_DATA_XYZ, 4, data_set);
>> +     if (!(stmpe_reg_read(ts->stmpe, STMPE_REG_FIFO_STA)
>> +                                     & STMPE_FIFO_EMPTY)) {
> We probably want to check for errors. So:
>
>          fifo_sta = stmpe_reg_read(ts->stmpe, STMPE_REG_FIFO_STA);
>          if (fifo_sta >= 0 && !(fifo_sta & STMPE_FIFO_EMPTY)) {
>                  ...
>          }

fifo_sta could only indicate fifo_overflow, fifo_full and
fifo_treshold_triggered and does not contain any other error flags.
Would that be useful in this case?
We flush the fifo anyway after the event is (not) reported:

        /* flush the FIFO after we have read out our values. */
         __stmpe_reset_fifo(ts->stmpe);
>
> I am also looking at stmpe_work() and wonder if we should not check FIFO status when we see touch detect and if we see it there we probably want to bail?

Good point. I think the best way would be not to schedule stmpe_work() 
at all in the case of the fifo not containing any samples.

         /* start polling for touch_det to detect release */
         schedule_delayed_work(&ts->work, msecs_to_jiffies(50));

What do you think?
>
> Thanks.
>
> --
> Dmitry

--
Peter
