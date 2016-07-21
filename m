From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH 2/4] input: tablet: pegasus_notetaker: Fix usb_autopm
 calls to be balanced
Date: Thu, 21 Jul 2016 13:00:56 +0200
Message-ID: <1a7eb7f1-169f-ee92-66a4-0acbc78106d2@posteo.de>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
 <1468852149-2614-3-git-send-email-martink@posteo.de>
 <20160720212943.GA26006@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160720212943.GA26006@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 2016-07-20 um 23:29 schrieb Dmitry Torokhov:
> On Mon, Jul 18, 2016 at 04:29:07PM +0200, Martin Kepplinger wrote:
>> Signed-off-by: Martin Kepplinger <martink@posteo.de>
>> ---
>>  drivers/input/tablet/pegasus_notetaker.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
>> index 27cb352..fdbc5e8 100644
>> --- a/drivers/input/tablet/pegasus_notetaker.c
>> +++ b/drivers/input/tablet/pegasus_notetaker.c
>> @@ -208,27 +208,30 @@ static int pegasus_open(struct input_dev *dev)
>>  		return retval;
>>  
>>  	pegasus->irq->dev = pegasus->usbdev;
>> -	if (usb_submit_urb(pegasus->irq, GFP_KERNEL))
>> +	if (usb_submit_urb(pegasus->irq, GFP_KERNEL)) {
>>  		retval = -EIO;
>> +		goto out;
>> +	}
>>  
>>  	retval = pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
> 
> If this fails I we should kill URB and cancel work. I adjusted and
> applied.

You're right. Thanks for this!

> 
>>  
>> -	usb_autopm_put_interface(pegasus->intf);
>> +out:
>>  
>> -	return retval;
>> +	if (retval < 0) {
>> +		usb_autopm_put_interface(pegasus->intf);
>> +		return retval;
>> +	} else {
>> +		return 0;
>> +	}
>>  }
>>  
>>  static void pegasus_close(struct input_dev *dev)
>>  {
>>  	struct pegasus *pegasus = input_get_drvdata(dev);
>> -	int autopm_error;
>>  
>> -	autopm_error = usb_autopm_get_interface(pegasus->intf);
>>  	usb_kill_urb(pegasus->irq);
>>  	cancel_work_sync(&pegasus->init);
>> -
>> -	if (!autopm_error)
>> -		usb_autopm_put_interface(pegasus->intf);
>> +	usb_autopm_put_interface(pegasus->intf);
>>  }
>>  
>>  static int pegasus_probe(struct usb_interface *intf,
>> -- 
>> 2.1.4
>>
> 
