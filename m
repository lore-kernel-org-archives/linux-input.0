From: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>
Subject: RE: [PATCH V3 0/2] Add DT support for tps6507x touchscreen
Date: Fri, 31 May 2013 06:04:32 +0000
Message-ID: <A4887BF146CD57468F700B415D2F470159C239@DBDE04.ent.ti.com>
References: <1369126458-24872-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1369126458-24872-1-git-send-email-manishv.b@ti.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>
List-Id: linux-input@vger.kernel.org

Hi Dmitry
Please let me know, are there any review comments on this patch series?

Thanks
Manish Badarkhe

On Tue, May 21, 2013 at 14:24:16, Vishwanathrao Badarkhe, Manish wrote:
> Patch set adds DT support for tps6507x based touchscreen.
> Also, add DT data for tps6507x touchscreen in da850-evm by
> providing touchscreen node inside tps6507x mfd device.
> 
> This patch series applies on top of linux-next tree and depends on [1].
> 
> [1]tps6507x-ts: update to devm_* API
>    https://patchwork.kernel.org/patch/2324441/
> 
> Tested on da850-evm board.
> 
> Changes since V2:
>  - Updated tps6507x documentation.
>  - Removed unnecessary code.
> 
> Changes since V1:
>  - Updated tps6507x documentation.
>  - Updated commit message.
>  - return proper error value in absence platform and DT data
>    for touchscreen.
> 
> Vishwanathrao Badarkhe, Manish (2):
>   tps6507x-ts: Add DT support
>   ARM: davinci: da850: add tps6507x touchscreen DT data
> 
>  Documentation/devicetree/bindings/mfd/tps6507x.txt |   28 ++++++-
>  arch/arm/boot/dts/da850-evm.dts                    |    9 ++
>  drivers/input/touchscreen/tps6507x-ts.c            |   98 ++++++++++++++------
>  3 files changed, 104 insertions(+), 31 deletions(-)
> 
> -- 
> 1.7.4.1
> 
> 


Regards, 
Manish
