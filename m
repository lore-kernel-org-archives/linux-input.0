From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: apple: Fix stuck function keys when using FN
Date: Tue, 27 Aug 2019 18:57:25 +0200
Message-ID: <bf759ce7-a0e1-0da8-ccd8-1925e5ccc184@redhat.com>
References: <20190610213106.19342-1-mail@joaomoreno.com>
 <CAHxFc3QC147B6j4pBztjK7stLgCveeYhJWojai_SbKNbnpC9yw@mail.gmail.com>
 <CAO-hwJ+1FyaXj0iuCjvc5R-Kqdh6PNB7Un0ko1F_NV7-f5GMdw@mail.gmail.com>
 <CAHxFc3QJ1Xkgckt1BPptXT5S1xkROVdJzHTYT=GAcHXgm5UGqg@mail.gmail.com>
 <CAHxFc3TjZu7_u0U3ZoB466WGNzbfYLe4ZB7C4LuKdBAwkRum5Q@mail.gmail.com>
 <CAN+gG=H6O202SYXGbTG5rTMUt_X5dZyi02YFUquPaqL=FGHXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=H6O202SYXGbTG5rTMUt_X5dZyi02YFUquPaqL=FGHXwQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Jo=c3=a3o_Moreno?= <mail@joaomoreno.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi João,

On 8/12/19 6:57 PM, Benjamin Tissoires wrote:
> Hi João,
> 
> On Thu, Aug 8, 2019 at 10:35 PM João Moreno <mail@joaomoreno.com> wrote:
>>
>> Hi Benjamin,
>>
>> On Mon, 8 Jul 2019 at 22:35, João Moreno <mail@joaomoreno.com> wrote:
>>>
>>> Hi Benjamin,
>>>
>>> No worries, also pretty busy over here. Didn't mean to press.
>>>
>>> On Mon, 1 Jul 2019 at 10:32, Benjamin Tissoires
>>> <benjamin.tissoires@redhat.com> wrote:
>>>>
>>>> Hi João,
>>>>
>>>> On Sun, Jun 30, 2019 at 10:15 PM João Moreno <mail@joaomoreno.com> wrote:
>>>>>
>>>>> Hi Jiri & Benjamin,
>>>>>
>>>>> Let me know if you need something else to get this patch moving forward. This
>>>>> fixes an issue I hit daily, it would be great to get it fixed.
>>>>
>>>> Sorry for the delay, I am very busy with internal corporate stuff, and
>>>> I tried setting up a new CI system at home, and instead of spending a
>>>> couple of ours, I am down to 2 weeks of hard work, without possibility
>>>> to switch to the new right now :(
>>>> Anyway.
>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>> On Mon, 10 Jun 2019 at 23:31, Joao Moreno <mail@joaomoreno.com> wrote:
>>>>>>
>>>>>> This fixes an issue in which key down events for function keys would be
>>>>>> repeatedly emitted even after the user has raised the physical key. For
>>>>>> example, the driver fails to emit the F5 key up event when going through
>>>>>> the following steps:
>>>>>> - fnmode=1: hold FN, hold F5, release FN, release F5
>>>>>> - fnmode=2: hold F5, hold FN, release F5, release FN
>>>>
>>>> Ouch :/
>>>>
>>>
>>> Right?!
>>>
>>>>>>
>>>>>> The repeated F5 key down events can be easily verified using xev.
>>>>>>
>>>>>> Signed-off-by: Joao Moreno <mail@joaomoreno.com>
>>>>>> ---
>>>>>>  drivers/hid/hid-apple.c | 21 +++++++++++----------
>>>>>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
>>>>>> index 1cb41992aaa1..81867a6fa047 100644
>>>>>> --- a/drivers/hid/hid-apple.c
>>>>>> +++ b/drivers/hid/hid-apple.c
>>>>>> @@ -205,20 +205,21 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>>>>>>                 trans = apple_find_translation (table, usage->code);
>>>>>>
>>>>>>                 if (trans) {
>>>>>> -                       if (test_bit(usage->code, asc->pressed_fn))
>>>>>> -                               do_translate = 1;
>>>>>> -                       else if (trans->flags & APPLE_FLAG_FKEY)
>>>>>> -                               do_translate = (fnmode == 2 && asc->fn_on) ||
>>>>>> -                                       (fnmode == 1 && !asc->fn_on);
>>>>>> +                       int fn_on = value ? asc->fn_on :
>>>>>> +                               test_bit(usage->code, asc->pressed_fn);
>>>>>> +
>>>>>> +                       if (!value)
>>>>>> +                               clear_bit(usage->code, asc->pressed_fn);
>>>>>> +                       else if (asc->fn_on)
>>>>>> +                               set_bit(usage->code, asc->pressed_fn);
>>>>
>>>> I have the feeling that this is not the correct fix here.
>>>>
>>>> I might be wrong, but the following sequence might also mess up the
>>>> driver state, depending on how the reports are emitted:
>>>> - hold FN, hold F4, hold F5, release F4, release FN, release F5
>>>>
>>>
>>> I believe this should be fine. Following the code:
>>>
>>> - hold FN, sets asc->fn_on to true
>>> - hold F4, in the trans block fn_on will be true and we'll set the F4
>>> bit in the bitmap
>>> - hold F5, in the trans block fn_on will be true and we'll set the F5 bit
>>> - release F4, in the trans block fn_on will be true (because of the bitmap) and
>>> we'll clear the F4 bit
>>> - release FN, asc->fn_on will be false, but it doesn't matter since...
>>> - release F5, in the trans block we'll look into the bitmap (instead
>>> of asc->fn_on),
>>> so fn_on will be true and we'll clear the F5 bit
>>>
>>> I tested it in practice using my changes:
>>>
>>> Interestingly the Apple keyboard doesn't seem to emit an even for F5 when F4 is
>>> pressed, seems like a hardware limitation. But F6 does work. So, when I execute
>>> these events in that order, everything works as it should: xev reports
>>> the following:
>>>
>>> KeyPress F4
>>> KeyPress F6
>>> KeyRelease F4
>>> KeyRelease F6
>>>
>>>> The reason is that the driver only considers you have one key pressed
>>>> with the modifier, and as the code changed its state based on the last
>>>> value.
>>>>
>>>
>>> I believe the bitmap takes care of storing the FN state per key press. The
>>> trick I did was to check on the global `asc->fn_on` state only when a key
>>> is pressed, but check on the bitmap instead when it's released.
>>>
>>> Let me know what you think. Am I missing something here?
>>>
>>> Cheers,
>>> João.
>>>
>>>> IMO a better fix would:
>>>>
>>>> - keep the existing `trans` mapping lookout
>>>> - whenever a `trans` mapping gets found:
>>>>   * get both translated and non-translated currently reported values
>>>> (`test_bit(keycode, input_dev->key)`)
>>>>   * if one of them is set to true, then consider the keycode to be the
>>>> one of the key (no matter fn_on)
>>>>     -> deal with `value` with the corrected keycode
>>>>   * if the key was not pressed:
>>>>     -> chose the keycode based on `fn_on` and `fnmode` states
>>>>     and report the key press event
>>>>
>>>> This should remove the nasty pressed_fn state which depends on the
>>>> other pressed keys.
>>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>>>> +
>>>>>> +                       if (trans->flags & APPLE_FLAG_FKEY)
>>>>>> +                               do_translate = (fnmode == 2 && fn_on) ||
>>>>>> +                                       (fnmode == 1 && !fn_on);
>>>>>>                         else
>>>>>>                                 do_translate = asc->fn_on;
>>>>>>
>>>>>>                         if (do_translate) {
>>>>>> -                               if (value)
>>>>>> -                                       set_bit(usage->code, asc->pressed_fn);
>>>>>> -                               else
>>>>>> -                                       clear_bit(usage->code, asc->pressed_fn);
>>>>>> -
>>>>>>                                 input_event(input, usage->type, trans->to,
>>>>>>                                                 value);
>>>>>>
>>>>>> --
>>>>>> 2.19.1
>>>>>>
>>
>> Gave this another look and I still haven't found any issues, let me
>> know if you still
>> think I'm missing something. Thanks!
>>
> 
> OK, I am tempted to take the patch, but I'll need to add this as a
> regression test in my test-suite. This is too complex that it can
> easily break next time someone looks at it.
> 
> Can you send me the report descriptors of the device using
> hid-recorder from hid-tools[0].
> Ideally, if you can put the faulty sequence in the logs, that would
> help writing down the use case.
> 

I finally managed to get the regression tests up in
https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/52

This allowed me to better understand the code, and yes, for the F-keys,
I could not find a faulty situation with your patch.

However, the same problem is happening with the arrow keys, as arrow up
is translated to page up.

We *could* adapt your patch to solve this, but I find it really hard to understand.

How about the following diff:
---
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 81df62f48c4c..ef916c0f3c0b 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -54,7 +54,6 @@ MODULE_PARM_DESC(swap_opt_cmd, "Swap the Option (\"Alt\") and Command (\"Flag\")
 struct apple_sc {
 	unsigned long quirks;
 	unsigned int fn_on;
-	DECLARE_BITMAP(pressed_fn, KEY_CNT);
 	DECLARE_BITMAP(pressed_numlock, KEY_CNT);
 };
 
@@ -181,6 +180,8 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 {
 	struct apple_sc *asc = hid_get_drvdata(hid);
 	const struct apple_key_translation *trans, *table;
+	bool do_translate;
+	u16 code = 0;
 
 	if (usage->code == KEY_FN) {
 		asc->fn_on = !!value;
@@ -189,8 +190,6 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (fnmode) {
-		int do_translate;
-
 		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table = macbookair_fn_keys;
@@ -202,25 +201,33 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		trans = apple_find_translation (table, usage->code);
 
 		if (trans) {
-			if (test_bit(usage->code, asc->pressed_fn))
-				do_translate = 1;
-			else if (trans->flags & APPLE_FLAG_FKEY)
-				do_translate = (fnmode == 2 && asc->fn_on) ||
-					(fnmode == 1 && !asc->fn_on);
-			else
-				do_translate = asc->fn_on;
-
-			if (do_translate) {
-				if (value)
-					set_bit(usage->code, asc->pressed_fn);
-				else
-					clear_bit(usage->code, asc->pressed_fn);
-
-				input_event(input, usage->type, trans->to,
-						value);
-
-				return 1;
+			if (test_bit(trans->from, input->key))
+				code = trans->from;
+			if (test_bit(trans->to, input->key))
+				code = trans->to;
+
+			if (!code) {
+				if (trans->flags & APPLE_FLAG_FKEY) {
+					switch (fnmode) {
+					case 1:
+						do_translate = !asc->fn_on;
+						break;
+					case 2:
+						do_translate = asc->fn_on;
+						break;
+					default:
+						/* should never happen */
+						do_translate = false;
+					}
+				} else {
+					do_translate = asc->fn_on;
+				}
+
+				code = do_translate ? trans->to : trans->from;
 			}
+
+			input_event(input, usage->type, code, value);
+			return 1;
 		}
 
 		if (asc->quirks & APPLE_NUMLOCK_EMULATION &&
---

This is more or less what I suggested, minus the bug fixes.

I find this easier to understand as the .pressed_fn field is not there
anymore and we just rely on the actual state of the input subsystem.

Comments?

Cheers,
Benjamin


> Cheers,
> Benjamin
> 
> [0] https://gitlab.freedesktop.org/libevdev/hid-tools
> 
