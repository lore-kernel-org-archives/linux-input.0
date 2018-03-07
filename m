From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: input: Add binding for RAVE SP input driver
Date: Tue, 6 Mar 2018 17:51:29 -0800
Message-ID: <CAHQ1cqHaSyZZVJC68PZPxggsvhH6BPcLxVHbdU2QS4pb5y_Bwg@mail.gmail.com>
References: <20180301165527.22274-1-andrew.smirnov@gmail.com>
 <20180301165527.22274-2-andrew.smirnov@gmail.com> <CAOMZO5DTWrMS-RrDwqMg5CTjH_dCdkiyvDJ+zgje49yzbbNUhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5DTWrMS-RrDwqMg5CTjH_dCdkiyvDJ+zgje49yzbbNUhg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 6, 2018 at 6:17 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Andrey,
>
> On Thu, Mar 1, 2018 at 1:55 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> l
>> +++ b/Documentation/devicetree/bindings/input/zii,rave-sp-pwrbutton.txt
>> @@ -0,0 +1,24 @@
>> +Zodiac Inflight Innovations RAVE Supervisory Processor Power Button Bindings
>> +
>> +RAVE SP input device is a "MFD cell" device corresponding to power
>> +button functionality of RAVE Supervisory Processor. It is expected
>> +that its Device Tree node is specified as a child of the node
>> +corresponding to the parent RAVE SP device (as documented in
>> +Documentation/devicetree/bindings/mfd/zii,rave-sp.txt)
>> +
>> +Required properties:
>> +
>> +- compatible: Should be "zii,rave-sp-pwrbutton"
>> +
>> +Example:
>> +
>> +       rave-sp {
>> +               compatible = "zii,rave-sp-rdu1";
>> +               current-speed = <38400>;
>> +
>> +               pwrbutton {
>> +                       compatible = "zii,rave-sp-pwrbutton";
>> +                       status = "okay";
>
> In the dts patch review Shawn said:
>
> "The okay status is to flip the state of devices that are initially
> disabled.  I think it's unnecessary for the case here."
>
> so please remove the status line.

Sure, will do in v3.

Thanks,
Andrey Smirnov
