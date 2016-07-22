From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v3 3/8] Input: synaptics-rmi4: Add dribble and palm
 gesture parameters to device tree
Date: Fri, 22 Jul 2016 11:32:02 -0700
Message-ID: <682368c2-5692-5905-7538-36ce2e3d262f@synaptics.com>
References: <1468476522-8032-1-git-send-email-aduggan@synaptics.com>
 <20160722165239.GA5036@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160722165239.GA5036@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

On 07/22/2016 09:52 AM, Dmitry Torokhov wrote:
> On Wed, Jul 13, 2016 at 11:08:42PM -0700, Andrew Duggan wrote:
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
>> This version includes Nick's suggestion of adding force to the device tree
>> parameters so make it obvious that these parameters overwrite the
>> default values set in the firware config.
> Why do we want to support overwriting firmware behavior in DT instead of
> flashing new firmware as needed by the product?

If the firmware was configured incorrectly it might just be easier to 
add a device tree entry. This would allow platform owners to make the 
change without having to get Synaptics involved or have access to our 
tools. Customers have also requested using the same module and firmware 
across multiple platforms. Tracking which firmware is on which part 
would create an additional support burden and not all platforms have an 
automated way of checking and updating firmware versions in the event 
that a system is build with a module which has the incorrect firmware.

It is possible that neither of these cases will ever happen and the 
bindings will never be used. I figured it was better to have the options 
available if needed. But, if we want to avoid having tons of device tree 
parameters which are never used then we can leave this patch out and I 
can resubmit it if there is a platform which ends up needing them.

Andrew

> Thanks.
>
