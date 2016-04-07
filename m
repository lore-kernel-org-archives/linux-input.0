From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v7 1/6] mfd: cros_ec: Add MKBP event support
Date: Thu, 7 Apr 2016 16:29:47 +0100
Message-ID: <20160407152947.GD3323@x1>
References: <1459842789-13852-1-git-send-email-tomeu.vizoso@collabora.com>
 <1459842789-13852-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459842789-13852-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, Olof Johansson <olof@lixom.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 05 Apr 2016, Tomeu Vizoso wrote:

> From: Vic Yang <victoryang@google.com>
>=20
> Newer revisions of the ChromeOS EC add more events besides the keyboa=
rd
> ones. So handle interrupts in the MFD driver and let consumers regist=
er
> for notifications for the events they might care.
>=20
> To keep backward compatibility, if the EC doesn't support MKBP event,=
 we
> fall back to the old MKBP key matrix host command.
>=20
> Signed-off-by: Vic Yang <victoryang@chromium.org>
> [bleung: fixup some context changes going from v3.14 to v3.18]
> Signed-off-by: Benson Leung <bleung@chromium.org>
> [tomeu: adapted to changes in mainline (in power-supply and platform/=
chrome)]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

I'm not interested in your BSP submission path.  As far as I'm
concerned *this* is the first submission.  If these guys are happy
with the patch, they can either choose to Ack or Review it.  Drop the
blurb in the middle.

> Cc: Randall Spangler <rspangler@chromium.org>
> Cc: Vincent Palatin <vpalatin@chromium.org>
> ---
>=20
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> - Calculate correctly the size of the payloads in
>   cros_ec_get_host_command_version_mask.
>=20
> Changes in v3:
> - Remove duplicated prototype of cros_ec_get_host_event.
>=20
> Changes in v2:
> - Allocate enough for the structs in cros_ec_get_host_command_version=
_mask,
>   not their pointers.
> - Allocate msg in the stack in get_next_event and
>   get_keyboard_state_event, as suggested by Gwendal.
>=20
>  drivers/input/keyboard/cros_ec_keyb.c   | 135 ++++++++--------------=
----------
>  drivers/mfd/cros_ec.c                   |  57 +++++++++++++-
>  drivers/platform/chrome/cros_ec_proto.c |  92 ++++++++++++++++++++++
>  include/linux/mfd/cros_ec.h             |  34 ++++++++
>  include/linux/mfd/cros_ec_commands.h    |  34 ++++++++

What are the *build time* dependencies that warrant all of these
changes happening in one patch?

>  5 files changed, 245 insertions(+), 107 deletions(-)

[...]
 =20
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 0eee63542038..fbe78b819fdd 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -23,6 +23,7 @@
>  #include <linux/module.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/cros_ec.h>
> +#include <asm/unaligned.h>
> =20
>  #define CROS_EC_DEV_EC_INDEX 0
>  #define CROS_EC_DEV_PD_INDEX 1
> @@ -49,11 +50,28 @@ static const struct mfd_cell ec_pd_cell =3D {
>  	.pdata_size =3D sizeof(pd_p),
>  };
> =20
> +static irqreturn_t ec_irq_thread(int irq, void *data)
> +{
> +	struct cros_ec_device *ec_dev =3D data;
> +	int ret;
> +
> +	if (device_may_wakeup(ec_dev->dev))
> +		pm_wakeup_event(ec_dev->dev, 0);
> +
> +	ret =3D cros_ec_get_next_event(ec_dev);
> +	if (ret > 0)
> +		blocking_notifier_call_chain(&ec_dev->event_notifier,
> +					     0, ec_dev);
> +	return IRQ_HANDLED;
> +}
> +
>  int cros_ec_register(struct cros_ec_device *ec_dev)
>  {
>  	struct device *dev =3D ec_dev->dev;
>  	int err =3D 0;
> =20
> +	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
> +
>  	ec_dev->max_request =3D sizeof(struct ec_params_hello);
>  	ec_dev->max_response =3D sizeof(struct ec_response_get_protocol_inf=
o);
>  	ec_dev->max_passthru =3D 0;
> @@ -70,13 +88,24 @@ int cros_ec_register(struct cros_ec_device *ec_de=
v)
> =20
>  	cros_ec_query_all(ec_dev);
> =20
> +	if (ec_dev->irq) {
> +		err =3D request_threaded_irq(ec_dev->irq, NULL, ec_irq_thread,
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					   "chromeos-ec", ec_dev);
> +		if (err) {
> +			dev_err(dev, "request irq %d: error %d\n",

This is an ugly error message.  Write them like you (as I user) would
like to see.  I suggest using proper English and grammar.

"Failed to request IRQ %d: %d", irq, err ?

> +				ec_dev->irq, err);
> +			return err;
> +		}
> +	}
> +
>  	err =3D mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell,=
 1,
>  			      NULL, ec_dev->irq, NULL);
>  	if (err) {
>  		dev_err(dev,
>  			"Failed to register Embedded Controller subdevice %d\n",
>  			err);
> -		return err;
> +		goto fail_mfd;
>  	}
> =20
>  	if (ec_dev->max_passthru) {
> @@ -94,7 +123,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev=
)
>  			dev_err(dev,
>  				"Failed to register Power Delivery subdevice %d\n",
>  				err);
> -			return err;
> +			goto fail_mfd;
>  		}
>  	}
> =20
> @@ -103,13 +132,18 @@ int cros_ec_register(struct cros_ec_device *ec_=
dev)
>  		if (err) {
>  			mfd_remove_devices(dev);
>  			dev_err(dev, "Failed to register sub-devices\n");
> -			return err;
> +			goto fail_mfd;
>  		}
>  	}
> =20
>  	dev_info(dev, "Chrome EC device registered\n");
> =20
>  	return 0;
> +
> +fail_mfd:
> +	if (ec_dev->irq)
> +		free_irq(ec_dev->irq, ec_dev);
> +	return err;
>  }
>  EXPORT_SYMBOL(cros_ec_register);
> =20
> @@ -136,13 +170,30 @@ int cros_ec_suspend(struct cros_ec_device *ec_d=
ev)
>  }
>  EXPORT_SYMBOL(cros_ec_suspend);
> =20
> +static void cros_ec_drain_events(struct cros_ec_device *ec_dev)
> +{
> +	while (cros_ec_get_next_event(ec_dev) > 0)
> +		blocking_notifier_call_chain(&ec_dev->event_notifier,
> +					     1, ec_dev);
> +}
> +
>  int cros_ec_resume(struct cros_ec_device *ec_dev)
>  {
>  	enable_irq(ec_dev->irq);
> =20
> +	/*
> +	 * In some case, we need to distinguish events that occur during

s/case/cases/

s/distinguish/distinguish between/

> +	 * suspend if the EC is not a wake source. For example, keypresses
> +	 * during suspend should be discarded if it does not wake the syste=
m.
> +	 *
> +	 * If the EC is not a wake source, drain the event queue and mark t=
hem
> +	 * as "queued during suspend".
> +	 */
>  	if (ec_dev->wake_enabled) {
>  		disable_irq_wake(ec_dev->irq);
>  		ec_dev->wake_enabled =3D 0;
> +	} else {
> +		cros_ec_drain_events(ec_dev);
>  	}
> =20
>  	return 0;

[...]

> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.=
h
> index a677c2bd485c..ddc935ef1911 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -72,6 +72,24 @@ struct cros_ec_command {
>  	uint8_t data[0];
>  };
> =20
> +/*
> + * event_data is used by keyboard or event notifier:
> + * event_data format:
> + * If MKBP protocol is supported:
> + * 0           1
> + * +-----------+--------------------------------
> + * | type      | payload
> + * +-----------+--------------------------------
> + * |HOST_EVENT | EVENT (32 bit)
> + * |KEY_MATRIX | Keyboard keys pressed.
> + * |SENSOR_FIFO| Sensors FIFO information.
> + *
> + * Otherwise:
> + * 0           1
> + * +-----------+--------------------------------
> + * |Unused     | Keyboard keys pressed.
> + */

Personally, I don't think this documentation is required.  But if you
insist on supplying it, I think it'll be better placed near the
'struct ec_response_get_next_event' definition.

>  /**
>   * struct cros_ec_device - Information about a ChromeOS EC device
>   *
> @@ -107,6 +125,9 @@ struct cros_ec_command {
>   *     should check msg.result for the EC's result code.
>   * @pkt_xfer: send packet to EC and get response
>   * @lock: one transaction at a time
> + * @event_notifier: interrupt event notifier for transport devices.
> + * @event_data: raw payload transferred with the MKBP event.
> + * @event_size: size in bytes of the event data.
>   */
>  struct cros_ec_device {
> =20
> @@ -135,6 +156,11 @@ struct cros_ec_device {
>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
>  	struct mutex lock;
> +	bool mkbp_event_supported;

Did you document this?

> +	struct blocking_notifier_head event_notifier;
> +
> +	struct ec_response_get_next_event event_data;
> +	int event_size;
>  };
> =20
>  /* struct cros_ec_platform - ChromeOS EC platform information
> @@ -252,6 +278,14 @@ int cros_ec_register(struct cros_ec_device *ec_d=
ev);
>   */
>  int cros_ec_query_all(struct cros_ec_device *ec_dev);
> =20
> +/**
> + * cros_ec_get_next_event -  Fetch next event from the ChromeOS EC
> + *
> + * @ec_dev: Device to fetch event from
> + * @return 0 if ok, -ve on error

I'd prefer easy to read/descriptive over trying to be smart.

The 'return' value doesn' require a @.  Instead, the return section
should look like "Return: <blah>".

I suggest: "Return: 0 on success, Linux error number on failure"

> + */
> +int cros_ec_get_next_event(struct cros_ec_device *ec_dev);
> +
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
>  extern struct attribute_group cros_ec_lightbar_attr_group;
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd=
/cros_ec_commands.h
> index 13b630c10d4c..d86526f0bd8e 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1762,6 +1762,40 @@ struct ec_result_keyscan_seq_ctrl {
>  	};
>  } __packed;
> =20
> +/*
> + * Get the next pending MKBP event.
> + *
> + * Returns EC_RES_UNAVAILABLE if there is no event pending.
> + */

You're documenting this command as if it's a function.  This command
does nothing by it's self, rather it is supplied to a function call,
which does the work.  Similarly this command returns nothing, the
device will provide the UNAVAILABLE return value.  Please update the
comment.

> +#define EC_CMD_GET_NEXT_EVENT 0x67
> +
> +enum ec_mkbp_event {
> +	/* Keyboard matrix changed. The event data is the new matrix state.=
 */
> +	EC_MKBP_EVENT_KEY_MATRIX =3D 0,
> +
> +	/* New host event. The event data is 4 bytes of host event flags. *=
/
> +	EC_MKBP_EVENT_HOST_EVENT =3D 1,
> +
> +	/* New Sensor FIFO data. The event data is fifo_info structure. */
> +	EC_MKBP_EVENT_SENSOR_FIFO =3D 2,
> +
> +	/* Number of MKBP events */
> +	EC_MKBP_EVENT_COUNT,
> +};
> +
> +union ec_response_get_next_data {
> +	uint8_t   key_matrix[13];
> +
> +	/* Unaligned */
> +	uint32_t  host_event;
> +} __packed;
> +
> +struct ec_response_get_next_event {
> +	uint8_t event_type;
> +	/* Followed by event data if any */
> +	union ec_response_get_next_data data;
> +} __packed;
> +
>  /*******************************************************************=
**********/
>  /* Temperature sensor commands */
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
