From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v5 2/2] cap11xx: add LED support
Date: Tue, 23 Jun 2015 09:00:31 +0200
Message-ID: <5589040F.5050605@samsung.com>
References: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
 <1434599897-22505-3-git-send-email-mranostay@gmail.com>
 <20150622180828.GB15851@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-reply-to: <20150622180828.GB15851@dtor-ws>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, zonque@gmail.com, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 06/22/2015 08:08 PM, Dmitry Torokhov wrote:
[...]

>> +
>> +	for_each_child_of_node(node, child) {
>> +		led->cdev.name =
>> +			of_get_property(child, "label", NULL) ? : child->name;
>> +		led->cdev.default_trigger =
>> +			of_get_property(child, "linux,default-trigger", NULL);
>
> Hmm, we do not have standard LEDs fwnode parser? Maybe we should have
> one.

We don't have one. That's something to be added.

-- 
Best Regards,
Jacek Anaszewski
