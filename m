From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] Input: synaptics - add multitouch packet support
Date: Tue, 14 Dec 2010 00:15:24 +0100
Message-ID: <4D06A90C.90009@euromail.se>
References: <1292280948-1933-1-git-send-email-rydberg@euromail.se> <4D06A7B1.6060609@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D06A7B1.6060609@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Takashi Iwai <tiwai@suse.de>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/14/2010 12:09 AM, Chase Douglas wrote:

> On 12/13/2010 02:55 PM, Henrik Rydberg wrote:
>> @@ -638,7 +677,7 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
>>  	__set_bit(BTN_LEFT, dev->keybit);
>>  	__set_bit(BTN_RIGHT, dev->keybit);
>>  
>> -	if (SYN_CAP_MULTIFINGER(priv->capabilities)) {
>> +	if (SYN_CAP_MULTIFINGER(priv->capabilities) | priv->multitouch) {
> 
> ^^ Although I think this is functionally correct, it is nevertheless a
> typo. Note that there's only one '|' where there should be two.


Ah, this one was removed but kept popping back in subsequent versions. Will fix,
but not resending now.

Thanks,
Henrik
