From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely()
 call around IS_ERR()
Date: Tue, 20 Aug 2019 14:21:33 +0200
Message-ID: <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
References: <1566298572-12409-1-git-send-email-info@metux.net>
 <1566298572-12409-2-git-send-email-info@metux.net>
 <20190820111719.7blyk5jstgwde2ae@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820111719.7blyk5jstgwde2ae@pali>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On 20.08.19 13:17, Pali Rohár wrote:
> On Tuesday 20 August 2019 12:56:12 Enrico Weigelt, metux IT consult wrote:
>> From: Enrico Weigelt <info@metux.net>
>>
>> IS_ERR() already calls unlikely(), so this extra unlikely() call
>> around IS_ERR() is not needed.
>>
>> Signed-off-by: Enrico Weigelt <info@metux.net>
>> ---
>>   drivers/input/mouse/alps.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 34700ed..ed16614 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -1476,7 +1476,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>>   		/* On V2 devices the DualPoint Stick reports bare packets */
>>   		dev = priv->dev2;
>>   		dev2 = psmouse->dev;
>> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
>> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>>   		/* Register dev3 mouse if we received PS/2 packet first time */
>>   		if (!IS_ERR(priv->dev3))
>>   			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> 
> Hello! Two months ago I already saw this patch. See discussion:
> https://patchwork.kernel.org/patch/10977099/

phuh, that's long chain of links to folow ;-)

So, your primary argument is just *documenting* that this supposed to
be a rare condition ?

In that case, wouldn't a comment be more suitable for that ?

It seems that this issue is coming up again and again ... when people
run cocci scans (like I didn't), I'd suspect this to happen even more
in the future.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
