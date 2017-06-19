From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Mon, 19 Jun 2017 13:02:18 -0700
Message-ID: <0995261b-8d19-64af-9b66-e1eab579a3d4@redhat.com>
References: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
 <20170603040349.GB16345@TopQuark.net>
 <e841f28c-4d63-170a-482f-8ef1deda1900@redhat.com>
 <KAWPR01MB1092C3572946C54C2CC4DEFBC7CD0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <75b84b97-5f36-a3be-bb4e-e43cd72d9921@redhat.com>
 <KAWPR01MB1092CFFDF4C4490669DCE92CC7C00@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170619184315.GF1855@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34495 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdFSUCW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 16:02:22 -0400
Received: by mail-qt0-f172.google.com with SMTP id v20so2981890qtg.1
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 13:02:22 -0700 (PDT)
In-Reply-To: <20170619184315.GF1855@TopQuark.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "scott.s.lowe@gmail.com" <scott.s.lowe@gmail.com>

On 06/19/2017 11:43 AM, Paul Donohue wrote:
> I get the same results as you - x_max and y_max affect cursor speed, and x_res and y_res seem to have no effect.  I can't seem to come up with any values that cause intermittent cursor issues on one side of the touchpad.
> Both max and res do get passed up to the X driver, and I do see references to both max and resolution in xf86-input-evdev, although I haven't actually traced it through to see if/where each value is actually consumed with my setup.
> 
> Maybe we should ask the user to try a few more tests?
> 1) Using the original code (without the modifications from bug 195215), add the following before 'return 0' at the end of alps_update_device_area_ss4_v2(), then run `dmesg | grep num-electrodes` after loading the alps kernel module to get the output.  This should tell us what values the user is actually reading from the hardware:
> psmouse_err(psmouse,
>     "pitch %dx%d num-electrodes %dx%d physical size %dx%dmm res %dx%d max %dx%d\n",
>     x_pitch, y_pitch, num_x_electrode, num_y_electrode,
>     x_phys / 10, y_phys / 10, priv->x_res, priv->y_res, priv->x_max, priv->y_max);
> 2) Use the old electrode count code but the new pitch code:
> 	if (IS_SS4PLUS_DEV(priv->dev_id)) {
> 		num_x_electrode =
> 			SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
> 		num_y_electrode =
> 			SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
> 
> 		priv->x_max =
> 			(num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> 		priv->y_max =
> 			(num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> 
> 		x_pitch = (otp[0][1] & 0x0F) + SS4PLUS_MIN_PITCH_MM;
> 		y_pitch = ((otp[0][1] >> 4) & 0x0F) + SS4PLUS_MIN_PITCH_MM;
> 
> 	} else {
> 3) Use the new electrode count code but the old pitch code:
> 	if (IS_SS4PLUS_DEV(priv->dev_id)) {
> 		num_x_electrode =
> 			SS4PLUS_NUMSENSOR_XOFFSET + (otp[0][2] & 0x0F);
> 		num_y_electrode =
> 			SS4PLUS_NUMSENSOR_YOFFSET + ((otp[0][2] >> 4) & 0x0F);
> 
> 		priv->x_max =
> 			(num_x_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
> 		priv->y_max =
> 			(num_y_electrode - 1) * SS4PLUS_COUNT_PER_ELECTRODE;
> 
> 		x_pitch = ((otp[1][2] >> 2) & 0x07) + SS4_MIN_PITCH_MM;
> 		y_pitch = ((otp[1][2] >> 5) & 0x07) + SS4_MIN_PITCH_MM;
> 
> 	} else {
> 

Can you produce patches for these test cases?

> On Thu, Jun 15, 2017 at 12:33:29AM +0000, Masaki Ota wrote:
>> Hi, Paul, Dmitry,
>>
>> About Laura's test result, it seems like this issue has to do with x_max, y_max, x_res, y_res.
>> This values are set as following code.
>> 	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
>> 	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
>>
>> 	input_abs_set_res(dev1, ABS_MT_POSITION_X, priv->x_res);
>> 	input_abs_set_res(dev1, ABS_MT_POSITION_Y, priv->y_res);
>>
>> For testing this code, I assigned an abnormal value to x_max, y_max , and it seems to effect only cursor speed.
>> About x_res, y_res , there is no effect, even if I set an abnormal value.(need this code?)
>> I don't understand why these values have to do with this issue.
>>
>> Can you guess the root cause of this issue?
>>
>> Best Regards,
>> Masaki Ota
>> -----Original Message-----
>> From: Laura Abbott [mailto:labbott@redhat.com] 
>> Sent: Thursday, June 15, 2017 3:53 AM
>> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Paul Donohue <linux-kernel@PaulSD.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; Pali Rohar <pali.rohar@gmail.com>; Nick Fletcher <nick.m.fletcher@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; scott.s.lowe@gmail.com
>> Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS - fix V8+ protocol handling (73 03 28)")
>>
>> On 06/11/2017 10:25 PM, Masaki Ota wrote:
>>> Hi, Laura,
>>>
>>> Could you try to check below modification?
>>> https://bugzilla.kernel.org/show_bug.cgi?id=195215#c10
>>>
>>> This thread person said, the issue was fixed by this change.
>>> I guess it's a XY coordinate setting problem, though the code that before the patch is applied also has a problem.
>>>
>>
>> With the previous patch plus the part you suggested:
>>
>> "it appears as if this resolves all remaining touchpad issues.
>> Cursor movement works as expected, both on the left-hand and right-hand sides of the touchpad, and I did not see any issues with two-finger scrolling on either side of the touchpad. Behavior with this test build appeared to be identical to 4.10.5, the last "official" kernel release to work with my touchpad."
>>
>> So it sounds like both parts together fix the issue.
>>
>> Thanks,
>> Laura
>>
>>> Best Regards,
>>> Masaki Ota
>>> -----Original Message-----
>>> From: Laura Abbott [mailto:labbott@redhat.com]
>>> Sent: Wednesday, June 07, 2017 1:59 AM
>>> To: Paul Donohue <linux-kernel@PaulSD.com>
>>> Cc: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Dmitry Torokhov 
>>> <dmitry.torokhov@gmail.com>; Pali Rohar <pali.rohar@gmail.com>; Nick 
>>> Fletcher <nick.m.fletcher@gmail.com>; linux-input@vger.kernel.org; 
>>> linux-kernel@vger.kernel.org; scott.s.lowe@gmail.com
>>> Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: 
>>> ALPS - fix V8+ protocol handling (73 03 28)")
>>>
>>> On 06/02/2017 09:03 PM, Paul Donohue wrote:
>>>> This might be related to
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=195215
>>>>
>>>> Could you have the user try this change? 
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=195215#c12
>>>>
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1447327#c13
>>>
>>> "Cursor movement seems to work, but there are intermittent two-finger scrolling issues on the right-hand side of the touchpad. There are no issues with cursor movement or two-finger scrolling on the left-hand side of the touchpad."
>>>
>>>> On Fri, Jun 02, 2017 at 10:54:52AM -0700, Laura Abbott wrote:
>>>>> Hi,
>>>>>
>>>>> Fedora got a bug report
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1447327
>>>>> of a touchpad failure on a Dell Latitude E7370. Testing showed that 
>>>>> the bad commit was
>>>>>
>>>>> commit e7348396c6d51b57c95c6646c390cd078e038e19
>>>>> Author: Masaki Ota <masaki.ota@jp.alps.com>
>>>>> Date:   Fri Mar 17 14:10:57 2017 -0700
>>>>>
>>>>>     Input: ALPS - fix V8+ protocol handling (73 03 28)
>>>>>     
>>>>>     Devices identified as E7="73 03 28" use slightly modified version of V8
>>>>>     protocol, with lower count per electrode, different offsets, and different
>>>>>     feature bits in OTP data.
>>>>>     
>>>>>     Fixes: aeaa881f9b17 ("Input: ALPS - set DualPoint flag for 74 03 28 devices")
>>>>>     Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
>>>>>     Acked-by: Pali Rohar <pali.rohar@gmail.com>
>>>>>     Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
>>>>>     Tested-by: Nick Fletcher <nick.m.fletcher@gmail.com>
>>>>>     Cc: stable@vger.kernel.org
>>>>>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>>>
>>>>> I suspect this particular model needs special handling as well?
>>>>>
>>>>> Thanks,
>>>>> Laura
>>>>>
>>>
>>

