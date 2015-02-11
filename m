From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS: Move v7 packet info to Documentation and
 v6 packet info
Date: Wed, 11 Feb 2015 08:38:13 +0100
Message-ID: <54DB06E5.7020403@redhat.com>
References: <1423572213-9680-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1423572213-9680-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 10-02-15 13:43, Pali Roh=C3=A1r wrote:
> This patch move all packet info from driver source code to documentat=
ion
> and adds info about v6 packet format (from driver source code).
>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Thanks for doing this:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   Documentation/input/alps.txt |   68 +++++++++++++++++++++++++++++++=
+++++++++--
>   drivers/input/mouse/alps.c   |   39 ------------------------
>   2 files changed, 66 insertions(+), 41 deletions(-)
>
> diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.=
txt
> index 90bca6f..a63e5e0 100644
> --- a/Documentation/input/alps.txt
> +++ b/Documentation/input/alps.txt
> @@ -3,8 +3,8 @@ ALPS Touchpad Protocol
>
>   Introduction
>   ------------
> -Currently the ALPS touchpad driver supports five protocol versions i=
n use by
> -ALPS touchpads, called versions 1, 2, 3, 4 and 5.
> +Currently the ALPS touchpad driver supports seven protocol versions =
in use by
> +ALPS touchpads, called versions 1, 2, 3, 4, 5, 6 and 7.
>
>   Since roughly mid-2010 several new ALPS touchpads have been release=
d and
>   integrated into a variety of laptops and netbooks.  These new touch=
pads
> @@ -240,3 +240,67 @@ For mt, the format is:
>    byte 3:    0  x23  x22   x21 x20  x19  x18   x17
>    byte 4:    0   x9   x8    x7  x6   x5   x4    x3
>    byte 5:    0  x16  x15   x14 x13  x12  x11   x10
> +
> +ALPS Absolute Mode - Protocol Version 6
> +---------------------------------------
> +
> +For trackstick packet, the format is:
> +
> + byte 0:    1    1    1    1    1    1    1    1
> + byte 1:    0   X6   X5   X4   X3   X2   X1   X0
> + byte 2:    0   Y6   Y5   Y4   Y3   Y2   Y1   Y0
> + byte 3:    ?   Y7   X7    ?    ?    M    R    L
> + byte 4:   Z7   Z6   Z5   Z4   Z3   Z2   Z1   Z0
> + byte 5:    0    1    1    1    1    1    1    1
> +
> +For touchpad packet, the format is:
> +
> + byte 0:    1    1    1    1    1    1    1    1
> + byte 1:    0    0    0    0   x3   x2   x1   x0
> + byte 2:    0    0    0    0   y3   y2   y1   y0
> + byte 3:    ?   x7   x6   x5   x4    ?    r    l
> + byte 4:    ?   y7   y6   y5   y4    ?    ?    ?
> + byte 5:   z7   z6   z5   z4   z3   z2   z1   z0
> +
> +(v6 touchpad does not have middle button)
> +
> +ALPS Absolute Mode - Protocol Version 7
> +---------------------------------------
> +
> +For trackstick packet, the format is:
> +
> + byte 0:    0    1    0    0    1    0    0    0
> + byte 1:    1    1    *    *    1    M    R    L
> + byte 2:   X7    1   X5   X4   X3   X2   X1   X0
> + byte 3:   Z6    1   Y6   X6    1   Y2   Y1   Y0
> + byte 4:   Y7    0   Y5   Y4   Y3    1    1    0
> + byte 5:  T&P    0   Z5   Z4   Z3   Z2   Z1   Z0
> +
> +For touchpad packet, the format is:
> +
> +         packet-fmt     b7     b6     b5     b4     b3     b2     b1=
     b0
> + byte 0: TWO & MULTI     L      1      R      M      1   Y0-2   Y0-1=
   Y0-0
> + byte 0: NEW             L      1   X1-5      1      1   Y0-2   Y0-1=
   Y0-0
> + byte 1:             Y0-10   Y0-9   Y0-8   Y0-7   Y0-6   Y0-5   Y0-4=
   Y0-3
> + byte 2:             X0-11      1  X0-10   X0-9   X0-8   X0-7   X0-6=
   X0-5
> + byte 3:             X1-11      1   X0-4   X0-3      1   X0-2   X0-1=
   X0-0
> + byte 4: TWO         X1-10    TWO   X1-9   X1-8   X1-7   X1-6   X1-5=
   X1-4
> + byte 4: MULTI       X1-10    TWO   X1-9   X1-8   X1-7   X1-6   Y1-5=
      1
> + byte 4: NEW         X1-10    TWO   X1-9   X1-8   X1-7   X1-6      0=
      0
> + byte 5: TWO & NEW   Y1-10      0   Y1-9   Y1-8   Y1-7   Y1-6   Y1-5=
   Y1-4
> + byte 5: MULTI       Y1-10      0   Y1-9   Y1-8   Y1-7   Y1-6    F-1=
    F-0
> +
> + L:         Left button
> + R / M:     Non-clickpads: Right / Middle button
> +            Clickpads: When > 2 fingers are down, and some fingers
> +            are in the button area, then the 2 coordinates reported
> +            are for fingers outside the button area and these report
> +            extra fingers being present in the right / left button
> +            area. Note these fingers are not added to the F field!
> +            so if a TWO packet is received and R =3D 1 then there ar=
e
> +            3 fingers down, etc.
> + TWO:       1: Two touches present, byte 0/4/5 are in TWO fmt
> +            0: If byte 4 bit 0 is 1, then byte 0/4/5 are in MULTI fm=
t
> +               otherwise byte 0 bit 4 must be set and byte 0/4/5 are
> +               in NEW fmt
> + F:         Number of fingers - 3, 0 means 3 fingers, 1 means 4 ...
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index d88d73d..5ac2a91 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -881,34 +881,6 @@ static void alps_get_finger_coordinate_v7(struct=
 input_mt_pos *mt,
>   					  unsigned char *pkt,
>   					  unsigned char pkt_id)
>   {
> -	/*
> -	 *       packet-fmt    b7   b6    b5   b4   b3   b2   b1   b0
> -	 * Byte0 TWO & MULTI    L    1     R    M    1 Y0-2 Y0-1 Y0-0
> -	 * Byte0 NEW            L    1  X1-5    1    1 Y0-2 Y0-1 Y0-0
> -	 * Byte1            Y0-10 Y0-9  Y0-8 Y0-7 Y0-6 Y0-5 Y0-4 Y0-3
> -	 * Byte2            X0-11    1 X0-10 X0-9 X0-8 X0-7 X0-6 X0-5
> -	 * Byte3            X1-11    1  X0-4 X0-3    1 X0-2 X0-1 X0-0
> -	 * Byte4 TWO        X1-10  TWO  X1-9 X1-8 X1-7 X1-6 X1-5 X1-4
> -	 * Byte4 MULTI      X1-10  TWO  X1-9 X1-8 X1-7 X1-6 Y1-5    1
> -	 * Byte4 NEW        X1-10  TWO  X1-9 X1-8 X1-7 X1-6    0    0
> -	 * Byte5 TWO & NEW  Y1-10    0  Y1-9 Y1-8 Y1-7 Y1-6 Y1-5 Y1-4
> -	 * Byte5 MULTI      Y1-10    0  Y1-9 Y1-8 Y1-7 Y1-6  F-1  F-0
> -	 * L:         Left button
> -	 * R / M:     Non-clickpads: Right / Middle button
> -	 *            Clickpads: When > 2 fingers are down, and some finger=
s
> -	 *            are in the button area, then the 2 coordinates report=
ed
> -	 *            are for fingers outside the button area and these rep=
ort
> -	 *            extra fingers being present in the right / left butto=
n
> -	 *            area. Note these fingers are not added to the F field=
!
> -	 *            so if a TWO packet is received and R =3D 1 then there=
 are
> -	 *            3 fingers down, etc.
> -	 * TWO:       1: Two touches present, byte 0/4/5 are in TWO fmt
> -	 *            0: If byte 4 bit 0 is 1, then byte 0/4/5 are in MULTI=
 fmt
> -	 *               otherwise byte 0 bit 4 must be set and byte 0/4/5 =
are
> -	 *               in NEW fmt
> -	 * F:         Number of fingers - 3, 0 means 3 fingers, 1 means 4 .=
=2E.
> -	 */
> -
>   	mt[0].x =3D ((pkt[2] & 0x80) << 4);
>   	mt[0].x |=3D ((pkt[2] & 0x3F) << 5);
>   	mt[0].x |=3D ((pkt[3] & 0x30) >> 1);
> @@ -1026,17 +998,6 @@ static void alps_process_trackstick_packet_v7(s=
truct psmouse *psmouse)
>   	struct input_dev *dev2 =3D priv->dev2;
>   	int x, y, z, left, right, middle;
>
> -	/*
> -	 *        b7 b6 b5 b4 b3 b2 b1 b0
> -	 * Byte0   0  1  0  0  1  0  0  0
> -	 * Byte1   1  1  *  *  1  M  R  L
> -	 * Byte2  X7  1 X5 X4 X3 X2 X1 X0
> -	 * Byte3  Z6  1 Y6 X6  1 Y2 Y1 Y0
> -	 * Byte4  Y7  0 Y5 Y4 Y3  1  1  0
> -	 * Byte5 T&P  0 Z5 Z4 Z3 Z2 Z1 Z0
> -	 * M / R / L: Middle / Right / Left button
> -	 */
> -
>   	x =3D ((packet[2] & 0xbf)) | ((packet[3] & 0x10) << 2);
>   	y =3D (packet[3] & 0x07) | (packet[4] & 0xb8) |
>   	    ((packet[3] & 0x20) << 1);
>
