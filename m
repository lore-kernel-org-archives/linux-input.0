From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 3/3] input/alps: Add device description for Dell Latitude
 E7470
Date: Thu, 26 May 2016 14:35:45 +0200
Message-ID: <20160526123545.GI29844@pali>
References: <201605251801.45240@pali>
 <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
 <1464252914-11450-4-git-send-email-ben@smart-cactus.org>
 <20160526090509.GE29844@pali>
 <5b09ed5d-838b-b319-1272-e9ca4c9bc627@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33344 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbcEZMft (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 08:35:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id a136so5012292wme.0
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 05:35:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5b09ed5d-838b-b319-1272-e9ca4c9bc627@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>

On Thursday 26 May 2016 14:19:18 Hans de Goede wrote:
> Hi,
>=20
> On 26-05-16 11:05, Pali Roh=C3=A1r wrote:
> >On Thursday 26 May 2016 10:55:14 Ben Gamari wrote:
> >>---
> >> drivers/input/mouse/alps.c | 1 +
> >> 1 file changed, 1 insertion(+)
> >>
> >>diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.=
c
> >>index 10e6836..eb4bf31 100644
> >>--- a/drivers/input/mouse/alps.c
> >>+++ b/drivers/input/mouse/alps.c
> >>@@ -143,6 +143,7 @@ static const struct alps_model_info alps_model_=
data[] =3D {
> >> 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
> >> 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Tos=
hiba Tecra A11-11L */
> >> 	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
> >>+	{ { 0x73, 0x03, 0x28 }, 0x00, { ALPS_PROTO_V8, 0x18, 0x18, ALPS_S=
S4_V2_ALT_DECODING | ALPS_DUALPOINT } }, /* Dell Latitude E7470 */
> >> };
> >>
> >> static const struct alps_protocol_info alps_v3_protocol_data =3D {
> >
> >Hi! I would rather move this code into alps_identify and probably cr=
eate
> >alps_v8_ss<name>_data structure for it.
> >
> >Above alps_model_data list looks like hooks for special touchpads wh=
ich
> >needs more flags to work correctly...
>=20
> Agreed, the alps_model_data array is really only used for quirks for =
old touchpads
> and should not be used for new touchpads.

Ben: Or maybe new structure for alps_identify is not needed at all. Jus=
t
set flags based on e7 data (if it has 0x28 or not).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
