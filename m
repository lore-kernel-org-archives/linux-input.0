From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/3] Input: wacom - allow both MT and pen data to be reported
Date: Wed, 3 Nov 2010 09:10:28 -0500
Message-ID: <AANLkTim+QrSFNifQGJOsdg+Q_fkVbp0FZ_MkgMjCdTdq@mail.gmail.com>
References: <1288741079-4993-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47887 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab0KCOK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Nov 2010 10:10:29 -0400
Received: by gwj21 with SMTP id 21so469621gwj.19
        for <linux-input@vger.kernel.org>; Wed, 03 Nov 2010 07:10:29 -0700 (PDT)
In-Reply-To: <1288741079-4993-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Tue, Nov 2, 2010 at 6:37 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> It was suggested by app and X server developers that both MT and pen =
data
> should be reported to the userland if the data is valid. Bamboo serie=
s are
> among these devices that both data are valid from the hardware perspe=
ctive.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0drivers/input/tablet/wacom_wac.c | =A0 13 +++++++------
> =A01 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index b3252ef..b9534a1 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -868,13 +868,14 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
> =A0 =A0 =A0 =A0for (i =3D 0; i < 2; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int p =3D data[9 * i + 2];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_slot(input, i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Touch events need to be disabled w=
hile stylus is
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* in proximity because user's hand i=
s resting on touchpad
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and sending unwanted events. =A0Us=
er expects tablet buttons
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to continue working though.
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* We send touch events even a stylus i=
s in proximity. Apps or
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* userland clients have the opportun=
ity to arbitrate these events
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* when pen is in proximity.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Wacom X server driver arbitrates t=
he events for all apps that
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* are based on X server.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p && !wacom->shared->stylus_in_prox=
imity) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int x =3D get_unaligne=
d_be16(&data[9 * i + 3]) & 0x7ff;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int y =3D get_unaligne=
d_be16(&data[9 * i + 5]) & 0x7ff;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->quirks &=
 WACOM_QUIRK_BBTOUCH_LOWRES) {
> --
> 1.7.2.3

I do not think we can remove this at this time; although I've heard
request before and why the original patch was separate.

The issue is that tablet is isolated on one input device and touchpad
on another.  This means, for example, that tablet can be handled by
xf86-input-wacom and touchpad by xf86-input-synaptics.  There is no
communication between the two apps so that xf86-input-synaptics would
know to disable itself while pen is in proximity.  Reverting the patch
in this combo would cause unwanted cursor movements.

When handled by a new xf86-input-wacom (or similar) then technically
there can be some communication to do masking but today that
communication does not exist across unrelated input devices.
Reverting the patch would also cause unwanted cursor movements in
today's xf86-input-wacom.

One thing that would need to occur first is wacom driver would need to
publish some sort of ID so that user land can tell which two devices
are somehow related; also accounting for 2 wacom devices being plugged
in at same time.  Next, if implemented, I'd make it a sysfs option to
control behavior so user has choice to also use apps like
xf86-input-multitouch which can't do masking.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
