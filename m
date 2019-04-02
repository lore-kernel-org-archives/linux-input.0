From: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v7 0/4] input: touchscreen: Add goodix GT5553 CTP support
Date: Tue, 2 Apr 2019 19:00:26 +0530
Message-ID: <CAMty3ZBKGpsGLJ8Z-WEOH+puULrh5BjREn+608dUmTMUW9Qhqg@mail.gmail.com>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 21, 2019 at 1:51 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This is v7 patchset for supporting goodix GT5553 CTP. Here is the
> previous version[1]
>
> Changes for v5:
> - rebase on linux-next
> Changes for v5:
> - document bindings for required regulators, which are need during
>   power-on sequence
> - enable, disable required regulators as described in power-on sequence
>   using normal regulator calls
> - update the proper commi messages
> Changes for v4:
> - document AVDD22, DVDD12, VDDIO as optional properties
> - use regulator bulk calls, for get, enable and disable functionalities
> Changes for v4:
> - devm_add_action_or_reset for disabling regulator
> Changes for v3:
> - add cover-letter
> - s/ADVV28/AVDD28 on commit head
> - fix few typo
> Changes for v2:
> - Rename vcc-supply with AVDD28-supply
> - disable regulator in remove
> - fix to setup regulator in probe code
> - add chipdata
> - drop example node in dt-bindings
>
> [1] https://patchwork.kernel.org/cover/10819645/
>
> Jagan Teki (4):
>   dt-bindings: input: touchscreen: goodix: Document regulator properties
>   Input: goodix - Add regulators suppot
>   dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
>   Input: goodix - Add GT5663 CTP support

Ping?
