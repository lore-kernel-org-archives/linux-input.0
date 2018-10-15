From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH] HID: steam: remove input device when a hid client is
 running.
Date: Mon, 15 Oct 2018 12:55:58 -0700
Message-ID: <5114a63f-d6dc-e703-41de-6f78a2699611@valvesoftware.com>
References: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181014173643.9643-1-rodrigorivascosta@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



On 10/14/18 10:36 AM, Rodrigo Rivas Costa wrote:
> Previously, when a HID client such as the Steam Client was running, this
> driver disabled its input device to avoid doubling the input events.
>=20
> While it worked mostly fine, some games got confused by the idle gamepad,
> and switched to two player mode, or asked the user to choose which gamepa=
d
> to use. Other games just crashed, probably a bug in Unity [1].
>=20
> With this commit, when a HID client starts, the input device is removed;
> when the HID client ends the input device is recreated.
>=20
> [1]: https://github.com/ValveSoftware/steam-for-linux/issues/5645

Hi Rodrigo,

Thanks a lot, this should indeed help a ton. Just the presence of an=20
extra gamepad node can indeed cause applications to go completely=20
different paths. Assuming it otherwise looks good, is there a chance=20
this fix could be put back into the 4.18 branch?

Thanks,
  - Pierre-Loup

>=20
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> ---
>   drivers/hid/hid-steam.c | 154 +++++++++++++++++++++++-----------------
>   1 file changed, 90 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 0422ec2b13d2..dc4128bfe2ca 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -23,8 +23,9 @@
>    * In order to avoid breaking them this driver creates a layered hidraw=
 device,
>    * so it can detect when the client is running and then:
>    *  - it will not send any command to the controller.
> - *  - this input device will be disabled, to avoid double input of the s=
ame
> + *  - this input device will be removed, to avoid double input of the sa=
me
>    *    user action.
> + * When the client is closed, this input device will be created again.
>    *
>    * For additional functions, such as changing the right-pad margin or s=
witching
>    * the led, you can use the user-space tool at:
> @@ -113,7 +114,7 @@ struct steam_device {
>   =09spinlock_t lock;
>   =09struct hid_device *hdev, *client_hdev;
>   =09struct mutex mutex;
> -=09bool client_opened, input_opened;
> +=09bool client_opened;
>   =09struct input_dev __rcu *input;
>   =09unsigned long quirks;
>   =09struct work_struct work_connect;
> @@ -279,18 +280,6 @@ static void steam_set_lizard_mode(struct steam_devic=
e *steam, bool enable)
>   =09}
>   }
>  =20
> -static void steam_update_lizard_mode(struct steam_device *steam)
> -{
> -=09mutex_lock(&steam->mutex);
> -=09if (!steam->client_opened) {
> -=09=09if (steam->input_opened)
> -=09=09=09steam_set_lizard_mode(steam, false);
> -=09=09else
> -=09=09=09steam_set_lizard_mode(steam, lizard_mode);
> -=09}
> -=09mutex_unlock(&steam->mutex);
> -}
> -
>   static int steam_input_open(struct input_dev *dev)
>   {
>   =09struct steam_device *steam =3D input_get_drvdata(dev);
> @@ -301,7 +290,6 @@ static int steam_input_open(struct input_dev *dev)
>   =09=09return ret;
>  =20
>   =09mutex_lock(&steam->mutex);
> -=09steam->input_opened =3D true;
>   =09if (!steam->client_opened && lizard_mode)
>   =09=09steam_set_lizard_mode(steam, false);
>   =09mutex_unlock(&steam->mutex);
> @@ -313,7 +301,6 @@ static void steam_input_close(struct input_dev *dev)
>   =09struct steam_device *steam =3D input_get_drvdata(dev);
>  =20
>   =09mutex_lock(&steam->mutex);
> -=09steam->input_opened =3D false;
>   =09if (!steam->client_opened && lizard_mode)
>   =09=09steam_set_lizard_mode(steam, true);
>   =09mutex_unlock(&steam->mutex);
> @@ -400,7 +387,7 @@ static int steam_battery_register(struct steam_device=
 *steam)
>   =09return 0;
>   }
>  =20
> -static int steam_register(struct steam_device *steam)
> +static int steam_input_register(struct steam_device *steam)
>   {
>   =09struct hid_device *hdev =3D steam->hdev;
>   =09struct input_dev *input;
> @@ -414,17 +401,6 @@ static int steam_register(struct steam_device *steam=
)
>   =09=09return 0;
>   =09}
>  =20
> -=09/*
> -=09 * Unlikely, but getting the serial could fail, and it is not so
> -=09 * important, so make up a serial number and go on.
> -=09 */
> -=09if (steam_get_serial(steam) < 0)
> -=09=09strlcpy(steam->serial_no, "XXXXXXXXXX",
> -=09=09=09=09sizeof(steam->serial_no));
> -
> -=09hid_info(hdev, "Steam Controller '%s' connected",
> -=09=09=09steam->serial_no);
> -
>   =09input =3D input_allocate_device();
>   =09if (!input)
>   =09=09return -ENOMEM;
> @@ -492,11 +468,6 @@ static int steam_register(struct steam_device *steam=
)
>   =09=09goto input_register_fail;
>  =20
>   =09rcu_assign_pointer(steam->input, input);
> -
> -=09/* ignore battery errors, we can live without it */
> -=09if (steam->quirks & STEAM_QUIRK_WIRELESS)
> -=09=09steam_battery_register(steam);
> -
>   =09return 0;
>  =20
>   input_register_fail:
> @@ -504,27 +475,88 @@ static int steam_register(struct steam_device *stea=
m)
>   =09return ret;
>   }
>  =20
> -static void steam_unregister(struct steam_device *steam)
> +static void steam_input_unregister(struct steam_device *steam)
>   {
>   =09struct input_dev *input;
> +=09rcu_read_lock();
> +=09input =3D rcu_dereference(steam->input);
> +=09rcu_read_unlock();
> +=09if (!input)
> +=09=09return;
> +=09RCU_INIT_POINTER(steam->input, NULL);
> +=09synchronize_rcu();
> +=09input_unregister_device(input);
> +}
> +
> +static void steam_battery_unregister(struct steam_device *steam)
> +{
>   =09struct power_supply *battery;
>  =20
>   =09rcu_read_lock();
> -=09input =3D rcu_dereference(steam->input);
>   =09battery =3D rcu_dereference(steam->battery);
>   =09rcu_read_unlock();
>  =20
> -=09if (battery) {
> -=09=09RCU_INIT_POINTER(steam->battery, NULL);
> -=09=09synchronize_rcu();
> -=09=09power_supply_unregister(battery);
> +=09if (!battery)
> +=09=09return;
> +=09RCU_INIT_POINTER(steam->battery, NULL);
> +=09synchronize_rcu();
> +=09power_supply_unregister(battery);
> +}
> +
> +static int steam_register(struct steam_device *steam)
> +{
> +=09int ret;
> +
> +=09/*
> +=09 * This function can be called several times in a row with the
> +=09 * wireless adaptor, without steam_unregister() between them, because
> +=09 * another client send a get_connection_status command, for example.
> +=09 * The battery and serial number are set just once per device.
> +=09 */
> +=09if (!steam->serial_no[0]) {
> +=09=09/*
> +=09=09 * Unlikely, but getting the serial could fail, and it is not so
> +=09=09 * important, so make up a serial number and go on.
> +=09=09 */
> +=09=09if (steam_get_serial(steam) < 0)
> +=09=09=09strlcpy(steam->serial_no, "XXXXXXXXXX",
> +=09=09=09=09=09sizeof(steam->serial_no));
> +
> +=09=09hid_info(steam->hdev, "Steam Controller '%s' connected",
> +=09=09=09=09steam->serial_no);
> +
> +=09=09/* ignore battery errors, we can live without it */
> +=09=09if (steam->quirks & STEAM_QUIRK_WIRELESS)
> +=09=09=09steam_battery_register(steam);
> +
> +=09=09mutex_lock(&steam_devices_lock);
> +=09=09list_add(&steam->list, &steam_devices);
> +=09=09mutex_unlock(&steam_devices_lock);
>   =09}
> -=09if (input) {
> -=09=09RCU_INIT_POINTER(steam->input, NULL);
> -=09=09synchronize_rcu();
> +
> +=09mutex_lock(&steam->mutex);
> +=09if (!steam->client_opened) {
> +=09=09steam_set_lizard_mode(steam, lizard_mode);
> +=09=09ret =3D steam_input_register(steam);
> +=09} else {
> +=09=09ret =3D 0;
> +=09}
> +=09mutex_unlock(&steam->mutex);
> +
> +=09return ret;
> +}
> +
> +static void steam_unregister(struct steam_device *steam)
> +{
> +=09steam_battery_unregister(steam);
> +=09steam_input_unregister(steam);
> +=09if (steam->serial_no[0]) {
>   =09=09hid_info(steam->hdev, "Steam Controller '%s' disconnected",
>   =09=09=09=09steam->serial_no);
> -=09=09input_unregister_device(input);
> +=09=09mutex_lock(&steam_devices_lock);
> +=09=09list_del(&steam->list);
> +=09=09mutex_unlock(&steam_devices_lock);
> +=09=09steam->serial_no[0] =3D 0;
>   =09}
>   }
>  =20
> @@ -600,6 +632,9 @@ static int steam_client_ll_open(struct hid_device *hd=
ev)
>   =09mutex_lock(&steam->mutex);
>   =09steam->client_opened =3D true;
>   =09mutex_unlock(&steam->mutex);
> +
> +=09steam_input_unregister(steam);
> +
>   =09return ret;
>   }
>  =20
> @@ -609,13 +644,13 @@ static void steam_client_ll_close(struct hid_device=
 *hdev)
>  =20
>   =09mutex_lock(&steam->mutex);
>   =09steam->client_opened =3D false;
> -=09if (steam->input_opened)
> -=09=09steam_set_lizard_mode(steam, false);
> -=09else
> -=09=09steam_set_lizard_mode(steam, lizard_mode);
>   =09mutex_unlock(&steam->mutex);
>  =20
>   =09hid_hw_close(steam->hdev);
> +=09if (steam->connected) {
> +=09=09steam_set_lizard_mode(steam, lizard_mode);
> +=09=09steam_input_register(steam);
> +=09}
>   }
>  =20
>   static int steam_client_ll_raw_request(struct hid_device *hdev,
> @@ -744,11 +779,6 @@ static int steam_probe(struct hid_device *hdev,
>   =09=09}
>   =09}
>  =20
> -=09mutex_lock(&steam_devices_lock);
> -=09steam_update_lizard_mode(steam);
> -=09list_add(&steam->list, &steam_devices);
> -=09mutex_unlock(&steam_devices_lock);
> -
>   =09return 0;
>  =20
>   hid_hw_open_fail:
> @@ -774,10 +804,6 @@ static void steam_remove(struct hid_device *hdev)
>   =09=09return;
>   =09}
>  =20
> -=09mutex_lock(&steam_devices_lock);
> -=09list_del(&steam->list);
> -=09mutex_unlock(&steam_devices_lock);
> -
>   =09hid_destroy_device(steam->client_hdev);
>   =09steam->client_opened =3D false;
>   =09cancel_work_sync(&steam->work_connect);
> @@ -792,12 +818,14 @@ static void steam_remove(struct hid_device *hdev)
>   static void steam_do_connect_event(struct steam_device *steam, bool con=
nected)
>   {
>   =09unsigned long flags;
> +=09bool changed;
>  =20
>   =09spin_lock_irqsave(&steam->lock, flags);
> +=09changed =3D steam->connected !=3D connected;
>   =09steam->connected =3D connected;
>   =09spin_unlock_irqrestore(&steam->lock, flags);
>  =20
> -=09if (schedule_work(&steam->work_connect) =3D=3D 0)
> +=09if (changed && schedule_work(&steam->work_connect) =3D=3D 0)
>   =09=09dbg_hid("%s: connected=3D%d event already queued\n",
>   =09=09=09=09__func__, connected);
>   }
> @@ -1019,13 +1047,8 @@ static int steam_raw_event(struct hid_device *hdev=
,
>   =09=09=09return 0;
>   =09=09rcu_read_lock();
>   =09=09input =3D rcu_dereference(steam->input);
> -=09=09if (likely(input)) {
> +=09=09if (likely(input))
>   =09=09=09steam_do_input_event(steam, input, data);
> -=09=09} else {
> -=09=09=09dbg_hid("%s: input data without connect event\n",
> -=09=09=09=09=09__func__);
> -=09=09=09steam_do_connect_event(steam, true);
> -=09=09}
>   =09=09rcu_read_unlock();
>   =09=09break;
>   =09case STEAM_EV_CONNECT:
> @@ -1074,7 +1097,10 @@ static int steam_param_set_lizard_mode(const char =
*val,
>  =20
>   =09mutex_lock(&steam_devices_lock);
>   =09list_for_each_entry(steam, &steam_devices, list) {
> -=09=09steam_update_lizard_mode(steam);
> +=09=09mutex_lock(&steam->mutex);
> +=09=09if (!steam->client_opened)
> +=09=09=09steam_set_lizard_mode(steam, lizard_mode);
> +=09=09mutex_unlock(&steam->mutex);
>   =09}
>   =09mutex_unlock(&steam_devices_lock);
>   =09return 0;
>=20
