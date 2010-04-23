From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue is not
 empty.
Date: Fri, 23 Apr 2010 13:56:25 -0700
Message-ID: <20100423135625.1e12d005.randy.dunlap@oracle.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<1271984938-13920-7-git-send-email-arve@android.com>
	<1271984938-13920-8-git-send-email-arve@android.com>
	<1271984938-13920-9-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1271984938-13920-9-git-send-email-arve@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Sven Neumann <s.neumann@raumfeld.com>, Tero Saarni <tero.saarni@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Matthew Garrett <mjg@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:

> Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that wi=
ll block
> suspend while the event queue is not empty. This allows userspace cod=
e to
> process input events while the device appears to be asleep.


All new ioctls need to be added to Documentation/ioctl/ioctl-number.txt=
, please.

> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> ---
>  drivers/input/evdev.c |   22 ++++++++++++++++++++++
>  include/linux/input.h |    3 +++
>  2 files changed, 25 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 2ee6c7a..66e0d16 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -585,6 +594,19 @@ static long evdev_do_ioctl(struct file *file, un=
signed int cmd,
>  		else
>  			return evdev_ungrab(evdev, client);
> =20
> +	case EVIOCGSUSPENDBLOCK:
> +		return put_user(client->use_suspend_blocker, ip);
> +
> +	case EVIOCSSUSPENDBLOCK:
> +		spin_lock_irq(&client->buffer_lock);
> +		if (!client->use_suspend_blocker && p)
> +			suspend_blocker_init(&client->suspend_blocker, "evdev");
> +		else if (client->use_suspend_blocker && !p)
> +			suspend_blocker_destroy(&client->suspend_blocker);
> +		client->use_suspend_blocker =3D !!p;
> +		spin_unlock_irq(&client->buffer_lock);
> +		return 0;
> +
>  	default:
> =20
>  		if (_IOC_TYPE(cmd) !=3D 'E')
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 7ed2251..b2d93b4 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -82,6 +82,9 @@ struct input_absinfo {
> =20
>  #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
> =20
> +#define EVIOCGSUSPENDBLOCK	_IOR('E', 0x91, int)			/* get suspend blo=
ck enable */
> +#define EVIOCSSUSPENDBLOCK	_IOW('E', 0x91, int)			/* set suspend blo=
ck enable */
> +
>  /*
>   * Event types
>   */
> --=20


thanks,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
