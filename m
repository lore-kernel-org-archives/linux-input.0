From: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v6 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Wed, 6 Mar 2019 22:47:26 +0530
Message-ID: <CAMty3ZB3o1Np7_H7rmCgpUWPk7BRqHRm7gxRpgAq_YyeCUKgaw@mail.gmail.com>
References: <20190219101629.15977-1-jagan@amarulasolutions.com> <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMty3ZDpy5YX3V+6e=UtY=a9Lgiw-NEP1JPQn4_LKL3mYFtrvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, Feb 26, 2019 at 11:43 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi Dmitry,
>
> On Tue, Feb 19, 2019 at 3:46 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > This is v6 patchset for supporting goodix GT5553 CTP. Here is the
> > previous version[1]
> >
> > Changes for v5:
> > - document bindings for required regulators, which are need during
> >   power-on sequence
> > - enable, disable required regulators as described in power-on sequence
> >   using normal regulator calls
> > - update the proper commi messages
> > Changes for v4:
> > - document AVDD22, DVDD12, VDDIO as optional properties
> > - use regulator bulk calls, for get, enable and disable functionalities
> > Changes for v4:
> > - devm_add_action_or_reset for disabling regulator
> > Changes for v3:
> > - add cover-letter
> > - s/ADVV28/AVDD28 on commit head
> > - fix few typo
> > Changes for v2:
> > - Rename vcc-supply with AVDD28-supply
> > - disable regulator in remove
> > - fix to setup regulator in probe code
> > - add chipdata
> > - drop example node in dt-bindings
> >
> > [1] https://patchwork.kernel.org/cover/10816901/
> >
> > Jagan Teki (4):
> >   dt-bindings: input: touchscreen: goodix: Document regulator properties
> >   Input: goodix - Add regulators suppot
> >   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
> >   Input: goodix - Add GT5663 CTP support
> >
> >  .../bindings/input/touchscreen/goodix.txt     |  3 +
> >  drivers/input/touchscreen/goodix.c            | 60 +++++++++++++++++++
> >  2 files changed, 63 insertions(+)
>
> Let me know if you have any further comments on regulator patch, fyi
> Rob reviewed it already.

Would you comment on this? few dts changes are pending for this to support.

Jagan.
