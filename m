From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: DT binding: Change touchscreen to touch for use
 with touchscreens and touchpads
Date: Fri, 15 Jan 2016 11:20:50 -0800
Message-ID: <56994692.1040701@synaptics.com>
References: <1452814965-22731-1-git-send-email-aduggan@synaptics.com>
 <20160115032914.GA31562@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:3641 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbcAOTUv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 14:20:51 -0500
In-Reply-To: <20160115032914.GA31562@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, devicetree@vger.kernel.org

Hi Rob,

On 01/14/2016 07:29 PM, Rob Herring wrote:
> On Thu, Jan 14, 2016 at 03:42:45PM -0800, Andrew Duggan wrote:
>> These generic touchscreen bindings can also be used for touchpads.
>> Instead of creating new generic bindings this patch just renames then to
>> touch-*.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
>> It was suggested that for the synaptics-rmi4 driver I use the generic
>> bindings. But, since the rmi4 driver is used for both touchpads and
>> touchscreens it seemed weird to have a touchpad with a parameter
>> of touchscreen-inverted-y. I changed all of the references to it in the
>> source tree. But, I realize this could cause a backwards compatibilty
>> issue with device trees which are not included in the kernel.
> It does and you cannot do this. Live with the weirdness or support both
> names...

Ok, I had a feeling this wouldn't go over well. I guess I'll try living 
with the weirdness for now.

Thanks,
Andrew

> Rob

