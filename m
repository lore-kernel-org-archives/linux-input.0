From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 1/2] Input: synaptics - add multitouch packet support
Date: Tue, 14 Dec 2010 13:37:16 -0800
Message-ID: <4D07E38C.4020201@canonical.com>
References: <1292280948-1933-1-git-send-email-rydberg@euromail.se> <4D06A7B1.6060609@canonical.com> <4D06A90C.90009@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57961 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab0LNVhX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 16:37:23 -0500
In-Reply-To: <4D06A90C.90009@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/13/2010 03:15 PM, Henrik Rydberg wrote:
> On 12/14/2010 12:09 AM, Chase Douglas wrote:
> 
>> On 12/13/2010 02:55 PM, Henrik Rydberg wrote:
>>> @@ -638,7 +677,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
>>>  	__set_bit(BTN_LEFT, dev->keybit);
>>>  	__set_bit(BTN_RIGHT, dev->keybit);
>>>  
>>> -	if (SYN_CAP_MULTIFINGER(priv->capabilities)) {
>>> +	if (SYN_CAP_MULTIFINGER(priv->capabilities) | priv->multitouch) {
>>
>> ^^ Although I think this is functionally correct, it is nevertheless a
>> typo. Note that there's only one '|' where there should be two.
> 
> 
> Ah, this one was removed but kept popping back in subsequent versions. Will fix,
> but not resending now.

Henrik, Chris,

After some testing this is mostly fine, but I have one of those terrible
"integrated buttons" (or whatever we call it) trackpads. When switching
to multitouch mode, the cursor will sometimes jump when I go to push the
button.

Take the following sequence:

1. Touch in top right corner of pad to position cursor
2. Touch in bottom left corner over button
3. Press button, but finger moves a little

Step 3 causes the primary coordinates in the synaptics MT protocol to
flip to the button-pressing touch. This causes a cursor jump. *Many*
times I have gone to press an "Ok" dialog button and found that I
accidentally launched an application from my dock :).

I think we should perform some rudimentary touch tracking to ensure the
same touch is always used for reporting ABS_X/ABS_Y. A simple distance
comparison between the two touches, as I implemented in one of my other
patches, would suffice.

What do you think?

Thanks,

-- Chase
