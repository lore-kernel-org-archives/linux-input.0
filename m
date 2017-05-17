From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH] input: edt-ft5x06: increase allowed data range for
 threshold parameter
Date: Wed, 17 May 2017 14:39:16 +0200
Message-ID: <33877b30-e903-c0ce-37d7-ec344a03da58@ginzinger.com>
References: <1493737259-26210-1-git-send-email-martin.kepplinger@ginzinger.com>
 <20170508161146.vkmaohiesjd6e6vq@rob-hp-laptop>
 <2a2d6377-1d3c-8639-0f28-d9519965296c@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a2d6377-1d3c-8639-0f28-d9519965296c@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, dmitry.torokhov@gmail.com
Cc: simon.budig@kernelconcepts.de, daniel.wagener@kernelconcepts.de, mchehab@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Schoefegger Stefan <stefan.schoefegger@ginzinger.com>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-input@vger.kernel.org

On 2017-05-11 10:32, Martin Kepplinger wrote:
> On 2017-05-08 18:11, Rob Herring wrote:
>> On Tue, May 02, 2017 at 05:00:59PM +0200, Martin Kepplinger wrote:
>>> The datasheet and application note does not mention an allowed range for
>>> the M09_REGISTER_THRESHOLD parameter. One of our customers needs to set
>>> lower values than 20 and they seem to work just fine on EDT EP0xx0M09 with
>>> T5x06 touch.
>>>
>>> So, lacking a known lower limit, we increase the range for thresholds,
>>> and set the lower limit to 0. The documentation is updated accordingly.
>>>
>>> Signed-off-by: Schoefegger Stefan <stefan.schoefegger@ginzinger.com>
>>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>>> ---
>>>  Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 2 +-
>>>  Documentation/input/devices/edt-ft5x06.rst                         | 2 +-
>>>  drivers/input/touchscreen/edt-ft5x06.c                             | 2 +-
>>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
> 
> Dmitry, any objections or thoughts?

Hey Dmitry, this still applies to today's -next and wouldn't take too
long for you to review :)

thanks

                      martin
