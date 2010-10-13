From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev4)
Date: Wed, 13 Oct 2010 13:15:54 -0700
Message-ID: <AANLkTi=RZ5OmBBOV2=kYJ+wE2GD1N9ZKMNyKGVvFqwiR@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
	<1283607783-29388-5-git-send-email-rydberg@euromail.se>
	<AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
	<4CB5F8B3.6010504@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45333 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab0JMUP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:15:57 -0400
Received: by wwj40 with SMTP id 40so6997936wwj.1
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 13:15:56 -0700 (PDT)
In-Reply-To: <4CB5F8B3.6010504@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

On Wed, Oct 13, 2010 at 11:21 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
>
> In the language of ABS_MT, there is a distinction between slot and id=
=2E The slot
> is the handle used to communicate a unique touch. The id is the ident=
ifier of
> that touch. The device tells us how many slots we have. The range of =
ids is in
> principle infinite. In practice, it is set to a large number.
>
> To answer a possible follow-up question: from the tracking id, you ca=
n tell if a
> contact is present, if it is new, and if it is older than another con=
tact.

I see. Somehow I remember tracking ID is the ID from the hardware/firmw=
are.

>>> +
>>> + =A0 =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D=
 0);
>>> + =A0 =A0 =A0 input_report_key(input, BTN_FORWARD, (data[1] & 0x04)=
 !=3D 0);
>>> + =A0 =A0 =A0 input_report_key(input, BTN_BACK, (data[1] & 0x02) !=3D=
 0);
>>> + =A0 =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=
=3D 0);
>>
>> This implementation impairs the value of those buttons since I know =
a
>> lot of users want them configurable. If we can not or do not pass a
>> generic set to the userland, we will need to make it configurable in
>> the kernel driver as Dmitry suggested (if I remember it correctly).
>> Which approach, in the userland or the kernel, do you like, Henrik?
>
> Perhaps I should not remind you that the current code was your sugges=
tion. ;-)

Yes, I remember that. TBH, I did not want to open another can of worms
then. And I did not have time to care about where that train went :).

> In my mind, these are buttons just like the buttons on any mouse or t=
rackpad.

=46or this particular model, it might be fine. My concern is for the ot=
her models.

> Regarding remapping, I think it matters if buttons have strong or wea=
k semantics.

Supporting button remapping is not a question. It is a decision. The
question is how. I hate to open this can of worms even now. But, we do
have to face the reality.

Currently, I use BTN_TOOL_FINGER to group those buttons together and
to pass them to the userland. This has never been an issue before MT
became such a hot topic. Now, we need to EITHER choose a new
BTN_TOOL_something to pass the poor buttons to the userland OR use the
kernel approach that Dmitry suggested. I am open to all suggestions
although I feel passing the buttons to the userland is a
better/cleaner solution.

My goal is to get a consensus so no one can blame me or the maintainer
for the decision :). Fair?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
