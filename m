From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 3/3] hid: thingm: improve locking
Date: Tue, 1 Mar 2016 21:18:29 +0100
Message-ID: <56D5F915.7070309@gmail.com>
References: <56D4AC4C.3050707@gmail.com>
 <20160229223806.GD22340@mail.corp.redhat.com> <56D543BC.1060808@gmail.com>
 <20160301080329.GE22340@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20160301080329.GE22340@mail.corp.redhat.com>
Sender: linux-leds-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 01.03.2016 um 09:03 schrieb Benjamin Tissoires:
> On Mar 01 2016 or thereabouts, Heiner Kallweit wrote:
>> Am 29.02.2016 um 23:38 schrieb Benjamin Tissoires:
>>> Hi Heiner,
>>>
>>> On Feb 29 2016 or thereabouts, Heiner Kallweit wrote:
>>>> When reading from the device the full operation including sending the
>>>> read command and the actual read should be protected by the mutex.
>>>> Facilitate this by changing the semantics of thingm_recv to include
>>>> sending the read command.
>>>
>>> I really like the cleanups of patches 1/3 and 2/3. However, this patch
>>> does not make sense to me. thingm_send() and thingm_recv() are pretty
>>> well defined to me. One reads data from the device, the other writes it.
>>>
>>> With this change, whenever you read data from the device, you start by
>>> overwriting its value and then read it back. Am I missing something?
>>>
>>> I think you'd better add the proper mutexes around thingm_version()
>>> or add the read command before thingm_send() in thingm_write_color()
>>> (and please add a comment explaining why we need to read first).
>>>
>> The semantical read operation consists of writing the read command and
>> the actual read. If another read command should come in between then the read
>> returns wrong data. Therefore I'd like to protect the complete semantical
>> read operation with the mutex. I change nothing in the content or order
>> of calls. 
> 
> Hmm, OK, then this explanation should go in the commit message and
> please also add a comment in thingm_recv() that a read is a 2 operations
> sequence.
> 
OK, will send a v2 of this patch.

>>
>> Basically this patch changes thingm_recv from a technical read to a
>> semantical read and ensures that a write read command + subsequent read
>> sequence can't be interrupted by another device access.
> 
> Ack, but the mutex is not needed currently as there is no other concurrent
> access that can happen (the LED are initialized after the firmware read,
> which is the only user of thingm_recv()).
> 
>>
>> And it allows to move the mutex handling to the thingm_send/recv helpers
>> so that we don't have to take care of it on a upper driver logic level
>> thus making the code simpler.
> 
> Well, I also think that the problem lies in the ordering of the
> functions in probe(). thingm_recv() is only used to fetch the firmware
> version. In case of an error, the driver bails out.
> 
> The problem here is that hid_hw_start() is called before
> thingm_version() which allows user space to briefly introduce races
> between thingm_version() and any hidraw requests. Your mutex will not
> help here as it is initialized after hid_hw_start() and only used for
> protecting the concurrent access of the rgb.
> 
> In the end, I think the driver should be re-ordered as such:
> - mutex_init()
> - thingm_version()
> - foreach leds: thingm_init_rgb()
> - hid_hw_start()
> 
We can't move hid_hw_start() after thingm_init_rgb() because there we
access hdev->hidraw which is still NULL at this time.
But we can move it at least after thingm_version().
I will provide a separate patch for it.

Rgds, Heiner

> I believe you don't need to call hid_device_io_start() nor call
> hid_hw_start() earlier as thingm is using hid_hw_raw_request() which
> does not rely on the parsing of the hid report descriptor.
> 
> Moving the mutexes in thingm_recv() will only be cosmetic given that
> no one can race against thingm_version(), but at least, it will prevent
> future use of thingm_recv() to race against thingm_send().
> 
> Cheers,
> Benjamin
> 
>>
>> Rgds, Heiner
>>
>>> Cheers,
>>> Benjamin
>>>
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/hid/hid-thingm.c | 28 +++++++++++++++++-----------
>>>>  1 file changed, 17 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
>>>> index 5e35ec1..0e4b50c 100644
>>>> --- a/drivers/hid/hid-thingm.c
>>>> +++ b/drivers/hid/hid-thingm.c
>>>> @@ -77,9 +77,13 @@ static int thingm_send(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
>>>>  			buf[0], buf[1], buf[2], buf[3], buf[4],
>>>>  			buf[5], buf[6], buf[7], buf[8]);
>>>>  
>>>> +	mutex_lock(&tdev->lock);
>>>> +
>>>>  	ret = hid_hw_raw_request(tdev->hdev, buf[0], buf, REPORT_SIZE,
>>>>  			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>>>>  
>>>> +	mutex_unlock(&tdev->lock);
>>>> +
>>>>  	return ret < 0 ? ret : 0;
>>>>  }
>>>>  
>>>> @@ -87,16 +91,26 @@ static int thingm_recv(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
>>>>  {
>>>>  	int ret;
>>>>  
>>>> +	mutex_lock(&tdev->lock);
>>>> +
>>>> +	ret = hid_hw_raw_request(tdev->hdev, buf[0], buf, REPORT_SIZE,
>>>> +			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>>>> +	if (ret < 0)
>>>> +		goto err;
>>>> +
>>>>  	ret = hid_hw_raw_request(tdev->hdev, buf[0], buf, REPORT_SIZE,
>>>>  			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>>>>  	if (ret < 0)
>>>> -		return ret;
>>>> +		goto err;
>>>> +
>>>> +	ret = 0;
>>>>  
>>>>  	hid_dbg(tdev->hdev, "<- %d %c %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx\n",
>>>>  			buf[0], buf[1], buf[2], buf[3], buf[4],
>>>>  			buf[5], buf[6], buf[7], buf[8]);
>>>> -
>>>> -	return 0;
>>>> +err:
>>>> +	mutex_unlock(&tdev->lock);
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  static int thingm_version(struct thingm_device *tdev)
>>>> @@ -104,10 +118,6 @@ static int thingm_version(struct thingm_device *tdev)
>>>>  	u8 buf[REPORT_SIZE] = { REPORT_ID, 'v', 0, 0, 0, 0, 0, 0, 0 };
>>>>  	int err;
>>>>  
>>>> -	err = thingm_send(tdev, buf);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>>  	err = thingm_recv(tdev, buf);
>>>>  	if (err)
>>>>  		return err;
>>>> @@ -135,14 +145,10 @@ static int thingm_led_set(struct led_classdev *ldev,
>>>>  	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
>>>>  	int ret;
>>>>  
>>>> -	mutex_lock(&led->rgb->tdev->lock);
>>>> -
>>>>  	ret = thingm_write_color(led->rgb);
>>>>  	if (ret)
>>>>  		hid_err(led->rgb->tdev->hdev, "failed to write color\n");
>>>>  
>>>> -	mutex_unlock(&led->rgb->tdev->lock);
>>>> -
>>>>  	return ret;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.7.1
>>>>
>>>
>>
> 
