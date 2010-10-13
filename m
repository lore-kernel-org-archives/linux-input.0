From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch trackpad
 (rev4)
Date: Wed, 13 Oct 2010 20:21:39 +0200
Message-ID: <4CB5F8B3.6010504@euromail.se>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>	<1283607783-29388-5-git-send-email-rydberg@euromail.se> <AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:57115 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab0JMSYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 14:24:16 -0400
In-Reply-To: <AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

Hi Ping,

> I know this patchset is under Linus tree and I've acked it already.

> But, I am trying to catch up with the fast moving MT train and to make
> sure the train is moving to my destination :).


By all means, where ever Ping Station might be located. :-)

[...]

>> +static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)

>> +{
>> +       static int trkid;
>> +       struct input_dev *input = wacom->input;
>> +       unsigned char *data = wacom->data;
>> +       int sp = 0, sx = 0, sy = 0, count = 0;
>> +       int i;
>> +
>> +       if (len != WACOM_PKGLEN_BBTOUCH)
>> +               return 0;
>> +
>> +       for (i = 0; i < 2; i++) {
>> +               int p = data[9 * i + 2];
>> +               input_mt_slot(input, i);
>> +               if (p) {
>> +                       int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
>> +                       int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
>> +                       input_report_abs(input, ABS_MT_PRESSURE, p);
>> +                       input_report_abs(input, ABS_MT_POSITION_X, x);
>> +                       input_report_abs(input, ABS_MT_POSITION_Y, y);
>> +                       if (wacom->id[i] < 0)
>> +                               wacom->id[i] = trkid++ & MAX_TRACKING_ID;
> 
> Why do we need an arbitrary MAX_TRACKING_ID when the device can tell
> us how many IDs we can have and it tracks the individual fingers for
> us? In this case, there are only two ID/fingers and the ID can be
> retrieved from the raw data. I must be missing something in the
> defintion of MAX_TRACKING_ID.


In the language of ABS_MT, there is a distinction between slot and id. The slot
is the handle used to communicate a unique touch. The id is the identifier of
that touch. The device tells us how many slots we have. The range of ids is in
principle infinite. In practice, it is set to a large number.

To answer a possible follow-up question: from the tracking id, you can tell if a
contact is present, if it is new, and if it is older than another contact.

[...]

>> +
>> +       input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
>> +       input_report_key(input, BTN_FORWARD, (data[1] & 0x04) != 0);
>> +       input_report_key(input, BTN_BACK, (data[1] & 0x02) != 0);
>> +       input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
> 
> This implementation impairs the value of those buttons since I know a
> lot of users want them configurable. If we can not or do not pass a
> generic set to the userland, we will need to make it configurable in
> the kernel driver as Dmitry suggested (if I remember it correctly).
> Which approach, in the userland or the kernel, do you like, Henrik?


Perhaps I should not remind you that the current code was your suggestion. ;-)
In my mind, these are buttons just like the buttons on any mouse or trackpad.

Regarding remapping, I think it matters if buttons have strong or weak semantics.

Henrik
