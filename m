From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [4.12 regression] Thinkpad X250 Touchpad and Trackpoint not recognized anymore; commit e839ffa: "Input: synaptics - add support for Intertouch devices"
Date: Fri, 19 May 2017 12:08:34 -0700
Message-ID: <C88AA3FF-8943-417D-AFC5-57CFFB3CA74E@gmail.com>
References: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36180 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdESTIi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 15:08:38 -0400
In-Reply-To: <41de7f92-8d98-3266-5d28-28ba48c5da38@pa-w.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Wichmann <pascal.wichmann@pa-w.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On May 19, 2017 11:46:16 AM PDT, Pascal Wichmann <pascal=2Ewichmann@pa-w=2E=
de> wrote:
>Hello,
>
>using the latest 4=2E12-rc1 kernel, the trackpoint and touchpad of my
>Thinkpad X250 are not recognized=2E
>
>This is caused by commit
>e839ffa  Input: synaptics - add support for Intertouch devices
>
>
>The specific problem seems to be the detection of whether to use
>synaptics_intertouch for the psmouse module or not=2E That parameter
>is set to -1 by default, in which case synaptics_intertouch is
>enabled on my device=2E
>
>When I explicitly set that parameter to 0, the trackpoint and touchpad
>are recognized and work as expected=2E
>
>Removing my device from smbus_pnp_ids in 4=2E12 rc1 fixes the issue
>without need to manually disable synaptics_intertouch in the psmouse
>module:
>
>diff -ruN a/drivers/input/mouse/synaptics=2Ec
>b/drivers/input/mouse/synaptics=2Ec
>--- a/drivers/input/mouse/synaptics=2Ec	2017-05-19 19:31:48=2E930734395
>+0200
>+++ b/drivers/input/mouse/synaptics=2Ec	2017-05-19 19:32:00=2E490782484
>+0200
>@@ -170,7 +170,6 @@
> static const char * const smbus_pnp_ids[] =3D {
>	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras
>*/
> 	"LEN0048", /* X1 Carbon 3 */
>-	"LEN0046", /* X250 */
> 	"LEN004a", /* W541 */
> 	"LEN200f", /* T450s */
> 	NULL
>
>
>Is the ThinkPad X250 not supporting intertouch or is there another
>problem causing the input devices not to work with it enabled?
>

Do you have i801_smbus driver enabled and loaded?


Thanks=2E

--=20
Dmitry
