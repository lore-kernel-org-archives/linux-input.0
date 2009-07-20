From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 20 Jul 2009 19:43:56 +0800
Message-ID: <4A64587C.4040109@gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>	 <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>	 <20090629162619.GB24533@dtor-d630.eng.vmware.com>	 <4A55BC78.6010206@gmail.com> <4A602D6D.1090707@teltonika.lt>	 <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com>	 <4A60425D.9@teltonika.lt>	 <5d5443650907200012o4c84b0fm4a03cfb18f7fd738@mail.gmail.com>	 <4A6448D0.6050002@gmail.com> <5d5443650907200343l3f1f4f9clac79b60847830209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:36527 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbZGTLoG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2009 07:44:06 -0400
Received: by wa-out-1112.google.com with SMTP id j5so365563wah.21
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2009 04:44:06 -0700 (PDT)
In-Reply-To: <5d5443650907200343l3f1f4f9clac79b60847830209@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Trilok Soni wrote:
> Hi Eric,
> 
> On Mon, Jul 20, 2009 at 4:07 PM, Eric Miao<eric.y.miao@gmail.com> wrote:
>>>>> Did you tried assigning max_keypmap_size in platform data to
>>>>> MATRIX_MAX_COLS * MATRIX_MAX_ROWS ?
>>>>>
>>>> Yes, this fixes crashes. But this is just workaround for bug in driver.
>>>>
>>> As you have access to h/w, care to submit a patch which fixes this?
>>>
>> Dmitry & Trilok,
>>
>> How about this?  Due to the fact that we are not able to sort out the
>> proper solution for a dynamic maximum of columns/rows, let's simplify
>> the fix to the patch below:
>>
>>
>> From 61ea1bd16a3636f526fb12619e84a75fa16b7f38 Mon Sep 17 00:00:00 2001
>> From: Eric Miao <eric.y.miao@gmail.com>
>> Date: Mon, 20 Jul 2009 11:31:08 +0800
>> Subject: [PATCH] input: matrix keymap size fixed to maximum
>>
>> Introduced KEY_IDX(), merged keymap_data into 'matrix_keypad_platform_data'.
>>
>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> ---
>>  drivers/input/keyboard/matrix_keypad.c |   22 ++++++----------------
>>  include/linux/input/matrix_keypad.h    |   21 +++++----------------
>>  2 files changed, 11 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
>> index e9b2e7c..a0ba134 100644
>> --- a/drivers/input/keyboard/matrix_keypad.c
>> +++ b/drivers/input/keyboard/matrix_keypad.c
>> @@ -136,7 +136,7 @@ static void matrix_keypad_scan(struct work_struct *work)
>>                        if ((bits_changed & (1 << row)) == 0)
>>                                continue;
>>
>> -                       code = (row << 4) + col;
>> +                       code = KEY_IDX(row, col);
>>                        input_event(input_dev, EV_MSC, MSC_SCAN, code);
>>                        input_report_key(input_dev,
>>                                         keypad->keycodes[code],
>> @@ -313,7 +313,6 @@ err_free_cols:
>>  static int __devinit matrix_keypad_probe(struct platform_device *pdev)
>>  {
>>        const struct matrix_keypad_platform_data *pdata;
>> -       const struct matrix_keymap_data *keymap_data;
>>        struct matrix_keypad *keypad;
>>        struct input_dev *input_dev;
>>        unsigned short *keycodes;
>> @@ -326,20 +325,13 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
>>                return -EINVAL;
>>        }
>>
>> -       keymap_data = pdata->keymap_data;
>> -       if (!keymap_data) {
>> +       if (!pdata->keymap) {
>>                dev_err(&pdev->dev, "no keymap data defined\n");
>>                return -EINVAL;
>>        }
>>
>> -       if (!keymap_data->max_keymap_size) {
>> -               dev_err(&pdev->dev, "invalid keymap data supplied\n");
>> -               return -EINVAL;
>> -       }
>> -
>>        keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
>> -       keycodes = kzalloc(keymap_data->max_keymap_size *
>> -                               sizeof(keypad->keycodes),
>> +       keycodes = kzalloc(sizeof(keypad->keycodes) * MATRIX_MAX_KEYS,
>>                           GFP_KERNEL);
>>        input_dev = input_allocate_device();
>>        if (!keypad || !keycodes || !input_dev) {
>> @@ -362,16 +354,14 @@ static int __devinit matrix_keypad_probe(struct platform_device *pdev)
>>        input_dev->close        = matrix_keypad_stop;
>>
>>        input_dev->keycode      = keycodes;
>> -       input_dev->keycodesize  = sizeof(*keycodes);
>> -       input_dev->keycodemax   = keymap_data->max_keymap_size;
>>
>> -       for (i = 0; i < keymap_data->keymap_size; i++) {
>> -               unsigned int key = keymap_data->keymap[i];
>> +       for (i = 0; i < pdata->keymap_size; i++) {
>> +               unsigned int key = pdata->keymap[i];
>>                unsigned int row = KEY_ROW(key);
>>                unsigned int col = KEY_COL(key);
>>                unsigned short code = KEY_VAL(key);
>>
>> -               keycodes[(row << 4) + col] = code;
>> +               keycodes[KEY_IDX(row, col)] = code;
> 
> 
> How about just doing like this
> 
> keycodes[(row << ((fls(MATRIX_MAX_COLS) - 1))) + col] ?
> 

I doubt this will work correctly if MATRIX_MAX_COLS isn't something 2 ^ N
