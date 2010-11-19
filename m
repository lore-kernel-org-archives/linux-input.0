From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 2/4] da850-evm: add UI Expander pushbuttons
Date: Fri, 19 Nov 2010 15:28:00 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302477EA939@dbde02.ent.ti.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
 <95f48a32a0256ecdb7148aa08d16f64928a7e5d8.1289935504.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34030 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab0KSJ6W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 04:58:22 -0500
In-Reply-To: <95f48a32a0256ecdb7148aa08d16f64928a7e5d8.1289935504.git.bengardiner@nanometrics.ca>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>, Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.co>
Cc: "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Ben,

Thanks for the patches. Some comments/questions below:

On Wed, Nov 17, 2010 at 01:09:35, Ben Gardiner wrote:
> This patch adds EV_KEYs for each of the 8 pushbuttons on the UI board via a
> gpio-key device.
>
> The expander is a tca6416; it controls the SEL_{A,B,C} lines which enable and
> disable the peripherals found on the UI board in addition to the 8 pushbuttons
> mentioned above. The reason the existing tca6416-keypad driver is not employed
> is because there was no aparent way to keep the gpio lines used as
> SEL_{A,B,C} registered while simultaneously registering the pushbuttons as a
> tca6416-keypad instance.
>
> Some experimentation with the polling interval was performed; we were searching
> for the largest polling interval that did not affect the feel of the
> responsiveness of the buttons. It is very subjective but 200ms seems to be a
> good value that accepts firm pushes but rejects very light ones. The key values
> assigned to the buttons were arbitrarily chosen to be F1-F8.
>
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> Reviewed-by: Chris Cordahi <christophercordahi@nanometrics.ca>
> CC: Govindarajan, Sriramakrishnan <srk@ti.com>
>
> ---
>
> Changes since v1:
>  * set INPUT_POLLDEV default for DA850_EVM machine, but don't select it
>    unconditionally

I didn't see the v1 posting (wonder why), but why is this
required? Why cant we depend on this being selected from
Device Drivers->Input device support in menuconfig?

[...]

> @@ -349,6 +421,10 @@ static struct i2c_board_info __initdata da850_evm_i2c_devices[] = {
>       {
>               I2C_BOARD_INFO("tca6416", 0x20),
>               .platform_data = &da850_evm_ui_expander_info,
> +             /*
> +              * TODO : populate at runtime using
> +              * .irq = gpio_to_irq(GPIO_TO_PIN(2,7)),
> +              */

You seem to be adding this in this patch and removing
in 4/4.

Thanks,
Sekhar

