From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH RESEND 0/7] MFD: ti_am335x_tscadc: DT support and TSC
 features addition
Date: Fri, 16 Nov 2012 10:33:00 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E96C54A@DBDE01.ent.ti.com>
References: <1352271124-5513-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352271124-5513-1-git-send-email-rachna@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Jonathan Cameron <jic23@cam.ac.uk>
List-Id: linux-input@vger.kernel.org

Hi,

This is just a gentle reminder of the patch set I had posted earlier viz.
"[PATCH RESEND 0/7] MFD: ti_am335x_tscadc: DT support and TSC features addition"
Can this patch set be pulled in if there are no review comments.
This patch set does not break anything existing, it just adds new features and DT support for the MFD core and its clients.

Regards,
Rachna

On Wed, Nov 07, 2012 at 12:21:57, Patil, Rachna wrote:
> This patch set is a cumulative set of [1] and [2] sent earlier.
> 
> Note that there are no code changes in either of the patch set, only rebased on top of MFD-next to make sure that all the patches apply without any conflicts.
> 
> This patch set has been tested on AM335x EVM and is based on top of [3].
> 
> [1] http://www.spinics.net/lists/linux-input/msg23060.html
> [2] http://www.spinics.net/lists/linux-input/msg23090.html
> [3] https://lkml.org/lkml/2012/11/6/67
> 
> Patil, Rachna (7):
>   input: ti_am335x_tsc: Step enable bits made configurable
>   input: ti_am335x_tsc: Order of TSC wires, made configurable
>   input: ti_am335x_tsc: Add variance filter
>   MFD: ti_am335x_tscadc: add device tree binding information
>   MFD: ti_am335x_tscadc: Add DT support
>   input: ti_am335x_tsc: Add DT support
>   IIO: ti_am335x_adc: Add DT support
> 
>  .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   35 +++
>  drivers/iio/adc/ti_am335x_adc.c                    |   24 ++-
>  drivers/input/touchscreen/ti_am335x_tsc.c          |  239 +++++++++++++++++---
>  drivers/mfd/ti_am335x_tscadc.c                     |   28 ++-
>  include/linux/input/ti_am335x_tsc.h                |   12 +
>  include/linux/mfd/ti_am335x_tscadc.h               |   11 +-
>  6 files changed, 308 insertions(+), 41 deletions(-)  create mode 100644 Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> 
> 
