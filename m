From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 2/4] da850-evm: add UI Expander pushbuttons
Date: Fri, 19 Nov 2010 10:38:10 -0500
Message-ID: <AANLkTi=HS7ym8n6=hF8vAg2WR33Md5=YRZL2NS7a+F2y@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<95f48a32a0256ecdb7148aa08d16f64928a7e5d8.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EA939@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42606 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754946Ab0KSPiP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 10:38:15 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302477EA939@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Sekhar,

Thank you for your reviews.

On Fri, Nov 19, 2010 at 4:58 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> [...]
> On Wed, Nov 17, 2010 at 01:09:35, Ben Gardiner wrote:
>> [...]
>> Changes since v1:
>> =A0* set INPUT_POLLDEV default for DA850_EVM machine, but don't sele=
ct it
>> =A0 =A0unconditionally
>
> I didn't see the v1 posting (wonder why), but why is this
> required? Why cant we depend on this being selected from
> Device Drivers->Input device support in menuconfig?

I'm sorry about that. I checked gmane and the v1 never made it to the
davinci-linux list. I think it was because of my (mis)use of git
send-email. Version 2 made it to the list so I've now found the magic
incantation.

The reason we should at least select INPUT_POLLDEV as a default option
is: when it is not set the gpio-keys instances registered by the
da850-evm board setup routine will fail probe() of the gpio-keys
driver since it will not have polled-input support enabled.

By setting INPUT_POLLDEV default for the da850-evm users will get
functioning pushbuttons and switches with the default config but they
will be able to disable INPUT_POLLDEV or gpio-keys drivers in their
defconfig at their convenience.

> [...]
>
>> @@ -349,6 +421,10 @@ static struct i2c_board_info __initdata da850_e=
vm_i2c_devices[] =3D {
>> =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_BOARD_INFO("tca6416", 0x20),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &da850_evm_ui_expande=
r_info,
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* TODO : populate at runtime using
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* .irq =3D gpio_to_irq(GPIO_TO_PIN(2,7)=
),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>
> You seem to be adding this in this patch and removing
> in 4/4.

Oops. That's my fault. The internal reviewers also reminded me to
remove these before sending. Sorry for the noise/ I will remove this
block in _this_ patch in the re-spin.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
