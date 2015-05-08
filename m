From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 2/2] Input: Allow devices to state that they aren't joysticks
Date: Fri, 8 May 2015 13:28:59 +0200
Message-ID: <554C9DFB.7060402@vmware.com>
References: <1428905271-3416-1-git-send-email-thellstrom@vmware.com> <1428905271-3416-3-git-send-email-thellstrom@vmware.com> <553BAD4A.3080800@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:42339 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752251AbbEHL3T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 8 May 2015 07:29:19 -0400
In-Reply-To: <553BAD4A.3080800@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com

Ping?

/Thomas


On 04/25/2015 05:05 PM, Thomas Hellstrom wrote:
> Hi, Dmitry & input list.
>
> I noticed that patch 1 in this series (VMMouse support) has made it t=
o
> Linus' tree. However, this patch seems to be missing. It's crucial fo=
r
> VMMouse since without it, a number of games will recognize the vmmous=
e
> as a joystick and
> leave the cursor stuck in the upper left corner.
> (The VMware USB absolute mouse has been disabled for Linux guests
> because of this).
>
> Is there a chance we can have this patch in as well. An alternative t=
hat
> I've tested briefly is to add a fake
> BTN_DIGI to the absolute device to trick joydev, but that's rather
> hackish and will probably cause future confusion.
>
> Any feedback appreciated.
>
> Thanks,
> Thomas Hellstr=F6m
>
>
> On 04/13/2015 08:07 AM, Thomas Hellstrom wrote:
>> Sometimes the device driver knows that a device isn't a joystick.
>> In those cases, allow the driver to ovveride joydev's guess.
>>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> ---
>>  drivers/input/joydev.c        | 4 ++++
>>  drivers/input/mouse/vmmouse.c | 1 +
>>  include/linux/input.h         | 5 +++++
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
>> index f362883..6add101 100644
>> --- a/drivers/input/joydev.c
>> +++ b/drivers/input/joydev.c
>> @@ -750,6 +750,10 @@ static void joydev_cleanup(struct joydev *joyde=
v)
>> =20
>>  static bool joydev_match(struct input_handler *handler, struct inpu=
t_dev *dev)
>>  {
>> +	/* Avoid devices that explicitly don't want to be joysticks */
>> +	if (dev->flags & INPUT_FLAG_NO_JOYSTICK)
>> +		return false;
>> +
>>  	/* Avoid touchpads and touchscreens */
>>  	if (test_bit(EV_KEY, dev->evbit) && test_bit(BTN_TOUCH, dev->keybi=
t))
>>  		return false;
>> diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmm=
ouse.c
>> index b3a6170..0fabe3d 100644
>> --- a/drivers/input/mouse/vmmouse.c
>> +++ b/drivers/input/mouse/vmmouse.c
>> @@ -468,6 +468,7 @@ int vmmouse_init(struct psmouse *psmouse)
>>  	abs_dev->id.product =3D PSMOUSE_VMMOUSE;
>>  	abs_dev->id.version =3D psmouse->model;
>>  	abs_dev->dev.parent =3D &psmouse->ps2dev.serio->dev;
>> +	abs_dev->flags |=3D INPUT_FLAG_NO_JOYSTICK;
>> =20
>>  	if (input_register_device(priv->abs_dev))
>>  		goto init_fail;
>> diff --git a/include/linux/input.h b/include/linux/input.h
>> index 82ce323..516387e 100644
>> --- a/include/linux/input.h
>> +++ b/include/linux/input.h
>> @@ -117,6 +117,7 @@ struct input_value {
>>   * @vals: array of values queued in the current frame
>>   * @devres_managed: indicates that devices is managed with devres f=
ramework
>>   *	and needs not be explicitly unregistered or freed.
>> + * @flags: Device flags.
>>   */
>>  struct input_dev {
>>  	const char *name;
>> @@ -187,9 +188,13 @@ struct input_dev {
>>  	struct input_value *vals;
>> =20
>>  	bool devres_managed;
>> +
>> +	u32 flags;
>>  };
>>  #define to_input_dev(d) container_of(d, struct input_dev, dev)
>> =20
>> +#define INPUT_FLAG_NO_JOYSTICK      (1 << 0)
>> +
>>  /*
>>   * Verify that we are in sync with input_device_id mod_devicetable.=
h #defines
>>   */

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
