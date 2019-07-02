From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/2] Support for buttons on newer MS Surface devices
Date: Tue, 2 Jul 2019 20:13:27 +0300
Message-ID: <CAHp75Ve-f-piRxwG2u2djWGt2fUKkvZSDJ+XkjGKLmMZeLEYsw@mail.gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702003740.75970-1-luzmaximilian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 2, 2019 at 3:38 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> This series adds suport for power and volume buttons on 5th and 6th
> generation Microsoft Surface devices. Specifically, it adds support for
> the power-button on the Surface Laptop 1 and Laptop 2, as well as
> support for power- and (on-device) volume-buttons on the Surface Pro 5
> (2017), Pro 6, and Book 2.
>
> These devices use the same MSHW0040 device as on the Surface Pro 4,
> however, whereas the Pro 4 uses an ACPI notify handler, the newer
> devices use GPIO interrupts to signal these events.
>
> The first patch of this series ensures that the surfacepro3_button
> driver, used for MSHW0040 on the Pro 4, does not probe for the newer
> devices. The second patch adapts soc_button_array to implement the
> actual button support.
>
> I think the changes to soc_button_array in the second patch warrant a
> thorough review. I've tried to make things a bit more generic to be able
> to integrate arbitrary ACPI GPIO power-/volume-button devices more
> easily, I'm not sure if there may be reasons against this.
>
> These patches have also been tested on various Surface devices via the
> github.com/jakeday/linux-surface patchset.
>

> Changes since v1:
>   - [PATCH 1/2] platform: Fix device check for surfacepro3_button
>     No changes.
>
>   - [PATCH 2/2] input: soc_button_array for newer surface devices
>     Ensure the patch compiles without CONFIG_ACPI.

I re-pushed to my queue, though if you are going to send a new
version, check my repository for the titles of the patches (you need
to use correct templates for the subsystems).

>
> Maximilian Luz (2):
>   platform: Fix device check for surfacepro3_button
>   input: soc_button_array for newer surface devices
>
>  drivers/input/misc/soc_button_array.c     | 145 ++++++++++++++++++++--
>  drivers/platform/x86/surfacepro3_button.c |  38 ++++++
>  2 files changed, 171 insertions(+), 12 deletions(-)
>
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
