From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] Documentation: sample averaging for imx6ul_tsc
Date: Thu, 8 Dec 2016 09:45:36 -0600
Message-ID: <CAL_JsqKLPsdi+fm8Dt=hRBqnd+JOr+1wcbimD+ynXaUj5Udn-Q@mail.gmail.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
 <20161201161343.g7p2maxiatp4m5di@rob-hp-laptop>
 <82b04890-692d-4e22-36c1-a21affad5126@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <82b04890-692d-4e22-36c1-a21affad5126@mobi-wize.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 8, 2016 at 9:15 AM, Guy Shapiro <guy.shapiro@mobi-wize.com> wrote:
> On 01/12/2016 18:13, Rob Herring wrote:
>>
>> On Sun, Nov 27, 2016 at 09:44:57AM +0200, Guy Shapiro wrote:
>>>
>>> The i.MX6UL internal touchscreen controller contains an option to
>>> average upon samples. This feature reduces noise from the produced
>>> touch locations.
>>>
>>> This patch introduces a new device tree optional property for this
>>> feature. It provides control over the amount of averaged samples per
>>> touch event.
>>>
>>> The property was inspired by a similar property on the
>>> "brcm,iproc-touchscreen" binding.
>>>
>>> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
>>> ---
>>>   .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt          | 8
>>
>> ++++++++
>>>
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git
>>
>> a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
>> b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
>>>
>>> index 853dff9..a66069f 100644
>>> --- a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
>>> +++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
>>> @@ -17,6 +17,13 @@ Optional properties:
>>>     This value depends on the touch screen.
>>>   - pre-charge-time: the touch screen need some time to precharge.
>>>     This value depends on the touch screen.
>>> +- average-samples: Number of data samples which are averaged for each
>>
>> read.
>>>
>>> +       Valid values 0-4
>>> +       0 =  1 sample
>>> +       1 =  4 samples
>>> +       2 =  8 samples
>>> +       3 = 16 samples
>>> +       4 = 32 samples
>>
>> Either this needs a vendor prefix or should be documented as a generic
>> property. In the latter case, you should use actual number of samples
>> (1-32) for the values.
>
> In the term "generic property", do you mean to document it on
> bindings/input/touchscreen/touchscreen.txt ?

Yes.

> If so, should I add the "touchscreen-" prefix like all the other properties
> in that file?

Yes.

> Grepping bindings/input/touchscreen/, I found two other device drivers that
> implement a
> similar property - "ti-tsc-adc" and "brcm,iproc-touchscreen" (The latter,
> BTW, uses a non
> vendor prefixed property name).

Unfortunately, the brcm one doesn't look directly usable.

> Do we want to move from per-vendor properties to a generic one?

No. Those are set already. I just don't want to get more vendor properties.

Rob
