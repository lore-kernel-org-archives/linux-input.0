From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] Input: silead - list all supported compatible strings in
 binding document
Date: Mon, 3 Apr 2017 17:23:01 -0400
Message-ID: <fec3f0ac-01fc-e5c2-59b7-bd643148dde3@osg.samsung.com>
References: <20170329182531.17349-1-javier@osg.samsung.com>
 <20170403152543.im7tbkhfc3lj7lyt@rob-hp-laptop>
 <6574d158-7fe8-7a2f-dab6-1c155780c785@osg.samsung.com>
 <CAL_JsqLwxROZ=H9rBx6PKTR6m55B+nyoskfSLbtrrsHojFDgJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:60288
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751843AbdDCVXO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Apr 2017 17:23:14 -0400
In-Reply-To: <CAL_JsqLwxROZ=H9rBx6PKTR6m55B+nyoskfSLbtrrsHojFDgJw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Robert Dolca <robert.dolca@intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hello Rob,

On 04/03/2017 05:15 PM, Rob Herring wrote:
> On Mon, Apr 3, 2017 at 10:51 AM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Rob,
>>
>> On 04/03/2017 11:25 AM, Rob Herring wrote:
>>> On Wed, Mar 29, 2017 at 02:25:31PM -0400, Javier Martinez Canillas wrote:
>>>> The driver contains compatible strings for different models, but the DT
>>>> binding doc only lists one of them. Add the remaining to the document.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>> ---
>>>>
>>>>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt       | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> "dt-bindings: input: ..." is preferred for the subject, but no need to
>>> respin just for that.
>>>
>>
>> Can we document it in Documentation/devicetree/bindings/submitting-patches.txt?
> 
> Yes. Actually, I was thinking of adding the preferred prefixes to
> MAINTAINERS. Then checkpatch.pl could check it perhaps.
>

That would be great.

>> I'm asking because is true that at the beginning we used "dt-bindings: foo" for
>> all DT bindings patches but then many (most?) maintainers started asking for the
>> subsystem subject line to be used for both drivers and DT bindings docs since
>> they would be merging both and also they could miss the DT bindings patches if
>> their subsystem prefix was not used.
> 
> I'd argue that most subsys maintainers don't (or they just change it
> when applying). Mark B does the most. I'm not going to waste any time
> arguing over it if folks want something different. I'm mainly trying
> to get rid of subjects like "Documentation: devicetree: bindings:
> Document the DT binding for foo-bar". :)
>

Yeah, I don't have a strong opinion. I just want an authoritative doc
so I can refer subsystems maintainers to when they argue that I should
use their subsystem prefix instead of "dt-bindings: foo: ..." :)

> Rob
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
