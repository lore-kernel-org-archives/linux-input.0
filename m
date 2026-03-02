Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022106.outbound.protection.outlook.com [52.101.126.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539522F3C13
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468546; cv=fail; b=iK51TMVNoW3jMXGaO+487eS5ZffEf4M/L9uU4rb/FjJSWnBuG2OkU69tO9JyZKu2G8E8TQHg8cLIi/uqAF/9DpZlqh53DLgahiVmez6Xn1eIX+TgA9K8YJPPZUj4Xhnn4f3LPEXSuK8wobGEyt852i+spJLi4WHChoBDR0cCU8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468546; c=relaxed/simple;
	bh=lwQFF0f4lLX4pLDWl2xVoUy3v5ZARO+GYgkzamoQgTc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ODcu9BvbKKKqgROJsxMOWnV6RinTOfsAjlB2MRHvYKaA6umPCje+zJgUhXsSmqh3yn54HCg8nlVieCUAqoEI8Thdakp7ItK98ECZo8WePqu8Yzo7E8NGYjw9omHaD54kKN71PG362TdX8PDKi6JYKFFkyCeAVkHfBfnvfrKf25Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axp.li; spf=pass smtp.mailfrom=axp.li; dkim=pass (2048-bit key) header.d=axp.li header.i=@axp.li header.b=0ruAZjXf; arc=fail smtp.client-ip=52.101.126.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axp.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axp.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axp.li header.i=@axp.li header.b="0ruAZjXf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2DmJKp3ZYmtuJZ6AyymGm2rl4rhJJ9Id3TJIq32aL3bSZG/srs0uY98aNZRZk4NERNzMpwmgWhkU1Bz8YqcCDzx/C/PSmqIsUYBO4Pg/QkbOJTCJWN3qLNNuXFJn8bades0AxwM+ckoZLyWyG8IGR/DkbcgrUDCCoJHGmgq7BpoO35IA/jeaSDDah4woh96+9uxDETkaelcKE50nYJWzSEyZ9eovf95JAEclBHHJtkTYY2DROkMkrKYWtmjSA2U8oW8hr7ExiAbB+zJdHGydLvG8b6asPpnFG5F9KV+atLfzA8O2oL0zIrF5vyQziQfMzP7QMD66gqLEti0cf/tTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvO4sefqL7pxqg7ORpQeRuo+DRondXw0cTaFOclQfE0=;
 b=lXNrGnUrxWOtkpHxAQ7Wn3z5vj6UBson0iVchQCbQo3EWEOZ4Hqs/VNhSEF3qT4O9cFz6/P+rA610Xk3Ni11+G+xV/dHPnhcQ4BuHyNGlWlDgYEwqlaV2RBS3+caf4nprZTfpIci3vi5JLzQdh8hEoQFyokdePQfPaUtzkou++oOE2O9lSVrK3nlWBsN5Eg9lBDd3ddDehYoZv4dSVbkyeUxQBMqqA+tgS6OIhNMp6aFXwY83GbpqO5mWbT4wizKpa1xErZEi/9go9N8cniRsNrxkyLIKiIXEWrbLW9VH9kG8OYLe/qeg5K0/Bqul47xf1Mzb8SkT3Ap7X9hNe3AAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axp.li; dmarc=pass action=none header.from=axp.li; dkim=pass
 header.d=axp.li; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axp.li; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvO4sefqL7pxqg7ORpQeRuo+DRondXw0cTaFOclQfE0=;
 b=0ruAZjXfBkCGygnLO4N89E8UA+NbdGUNLknfeQh61dwjo597IcsmV8mMD6UrfzzPjqekrcGpd2ZbhNadCo1q9EQX/telbRagFMMX9a4HZTW+R9OoA4vZp2BRBGQVqyuPJ5nyyy5XhJTJY0nC1CNWfSHQvDTtblEV4+UO/zlJc5LP/P53KcLIdSaHErDXmx8HBxEPnRgsnj8ku+FtSga8xzGYJPWJq45E8FU4RIzDUB2dJZeoAJTjSUrJXS6HDMzf4W7pO51jldx2AtLHnHkZLwNAh5rd5e+S3dUUSSc2184Z7VLtisJGnn1Lko7dv39ixYlqyNHtHH3UML1xvb/8vw==
Received: from TYSPR03MB8026.apcprd03.prod.outlook.com (2603:1096:400:47c::9)
 by JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 16:22:19 +0000
Received: from TYSPR03MB8026.apcprd03.prod.outlook.com
 ([fe80::50fd:172d:1766:ce6c]) by TYSPR03MB8026.apcprd03.prod.outlook.com
 ([fe80::50fd:172d:1766:ce6c%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:22:19 +0000
From: Kokutou Mikan <hello@axp.li>
To: "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"bleung@chromium.org" <bleung@chromium.org>, "groeck@chromium.org"
	<groeck@chromium.org>
Subject: [BUG] cros_ec: Chromebook side volume keys not generating volume
 events on UEFI firmware
Thread-Topic: [BUG] cros_ec: Chromebook side volume keys not generating volume
 events on UEFI firmware
Thread-Index: AQHcqmB4qmljH01cPESX0ZXDVP/xjw==
Date: Mon, 2 Mar 2026 16:22:18 +0000
Message-ID:
 <TYSPR03MB8026DDD72291AD506F2C6C5CDA7EA@TYSPR03MB8026.apcprd03.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axp.li;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYSPR03MB8026:EE_|JH0PR03MB7983:EE_
x-ms-office365-filtering-correlation-id: ff820cf7-4d29-4679-f171-08de7877e019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|6049299003|376014|34036016|38070700021|4053099003|8096899003;
x-microsoft-antispam-message-info:
 U0NmoR5paltdjJzTFFYJINnlya62C0lr+EEo4dH57IBGEeV2wiyceuCbrNsnKYHrwePl1ID4NUfnQlwiJBgE7yAusp6JX3iuPQuWwZKq4snZHR319U339bX8IeH75ZcPFdiLVnCJNAbbjZcoxiWVh/3Vi3yz6tyOqdCiQAYK5EymtnHhtwy+Pr2uzaYUFaYPdG8V3Exd0+un/OJyQrPuRveJIl7cdkR128D/QXmPuPKNQOJKVMOYAUVlizEhMWwhrQhdQ0ai7xxzm8N82LfriaDkmK9oLskN3Vezfeha1IXybyJZrGdNaEXA1XUHjSw2x/fI/mMBpFbnnMYzWOJc99ERxoTLViNx7d2leyFMpINZrhfazu/6Fjlr1bNcXKawScSFvmdJU3tudWG78F8lF2G9cyg/LU5zfqn4pI2zcQUpzXLeD0jj/rW4hGg8x/OuJMHyFyBa1Gadxe45+WjX0UlM+MiLQHwDQF1ZP28Mc+vjmNWQZHlKATtBgYJeoYOZhRBK0dZeGEGxWGe4KDKBGfcugRA7V/VfmarBJe5yCJS5XuUC1vw4iPNT9sTH9bt+v5qpz7hlGtlc63uocu5RIMWoIcG7qqu0VISzDnmHwd4OT6/kG24cdWBQQY66/EElT25dgNG/pBzZo2STZRKtn4FNJwj5CNRd3A4BD3P23PZqPXbY+bP5o68cj9+R47BligvH9U3bd6JySk+HcFPgmcTsworpKHUV1GrQnyihH90=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR03MB8026.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(6049299003)(376014)(34036016)(38070700021)(4053099003)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RwT7zSjqWHCYOQQfXs1hoV+u0yJzeyHl9ONvV+XT1SPhwFNE4IlBjuuMhI?=
 =?iso-8859-1?Q?GyUH4RLTug9r7Uz6EJrI6wvW5jFiel2bA9bL3Wx3W3tjVhE6hBBbR/xU4S?=
 =?iso-8859-1?Q?aeeGT/ho+VNBK98r3wv11056Dwah5qySbs0hmfzupS1HYnLBDdgfIT5n3C?=
 =?iso-8859-1?Q?RehmxiT+LZh4oaHK9lQH9W0S9587NWx+TjpErh6Dh7OioXag+yA8Ce2nON?=
 =?iso-8859-1?Q?JQbxm9KguReuy3p3JjO4RZiWw3KFJ0FfsCNh6s552TUeDYn9HksEPndq0g?=
 =?iso-8859-1?Q?H35JPw+om4B0V8SRfrQ2VqKXMCZ2tX29N8lQi5ibKvyNeB2qkjGGJa1Opl?=
 =?iso-8859-1?Q?jRU8DVjK/l3hQ3SWZxrYYpvAbntVQTYQgVSTz7tQ3A4jlHVRN9uYNkW4u5?=
 =?iso-8859-1?Q?FG9JoCF/r0t1+kNMJJuhxA91REtVy+8FoGzr7D22FiRCYDcOtbZyMMHr1o?=
 =?iso-8859-1?Q?+vac4myF8vPzdBfF5wWUBq7HAXiWzNsDUJ7oMzaF6l07zHIKVNug0bZqV3?=
 =?iso-8859-1?Q?VLbSJErnMN1wWO9Q02PFb/Y3QDj3zGJcjIYfX7OGFwpTAHOuSfuaWrOXXc?=
 =?iso-8859-1?Q?MIGu9nSh83C81M5yOMeDo8/RGNTnAOqOEgCsJ+iuuFD7NZJLXeCEtazDbX?=
 =?iso-8859-1?Q?ZdeA8azY1yzwoFgfBVvByyIsgiCY7hs3eLcVXYYonqd+ggfh2qWo5pWQtG?=
 =?iso-8859-1?Q?FG03BIXv1K290ZiG5LffWF5RopLdkhW/3F39cgnOkakEvt1khnpulKCnKA?=
 =?iso-8859-1?Q?nl3+SnpI0dz6K8GzbmPKl0qx1iiHYgZSO+b/liiVRSRUIUg4OjEFZavdOt?=
 =?iso-8859-1?Q?lNccBPAjRFXPMaKOqwTymlsDgtWCA7WwkZ1BqIvAOhIsCs2qh+11x8UKMw?=
 =?iso-8859-1?Q?UOg0W0b0PQVaWcsqL5U2Kmrc4SWg6uDhapxitK4U++s6LkdM26UdrjDR9c?=
 =?iso-8859-1?Q?lX7pPlf8NZPp3x+ys+PgTU04qFtVVm8wqOZF3J9Xl+QWTLrKsEbLT0qBGG?=
 =?iso-8859-1?Q?dGMQnQWEXywXlbz0zUIyJCPtqoensRHLt1vWc6vz1PHJF5xKaVj75OBNMr?=
 =?iso-8859-1?Q?qcMMvwgOrPchgtKMx3769Vb8Btpznp8fkZ/OBxSa63dWtFwDrc3IxcNmyX?=
 =?iso-8859-1?Q?VF96Yra9GaA1vmOErMaDx5LPJ6oN2YWbPPSPtGxqdX8vSCmwhyW+CwIACS?=
 =?iso-8859-1?Q?OFA/UfPj/8guSPUgDvBbOOcLprYNxBn0TdSpFrIxaR6ryYI55eNbWKBaba?=
 =?iso-8859-1?Q?eZ+bVMjU8wHKmK+1URKiJIpksYaIcj8KW+Cbxy3XgoK5F4ilj4hWhL+s8+?=
 =?iso-8859-1?Q?nCjsWg2RCRFlYAwJ7lcwZ4u/PwXuAuWhZU048AXT5LQ22Xm+UiGyMqKRi9?=
 =?iso-8859-1?Q?ZuERMaKw0jhD3OeXDYMy7Ct83yxPU+vqSRrr0Ov0oLeXJdlK5F/5xWQE2u?=
 =?iso-8859-1?Q?13gtrqYf+fdjAyqVKUY5DJKiEOZ9F+4A6f5g4/bdLP6bLdp29c0c87K8B2?=
 =?iso-8859-1?Q?KFNLACSBsZbpKNubm8d8aW426uwlwAS1yinEOQSGjl5nEbV/Pmk2Ukun+d?=
 =?iso-8859-1?Q?b4i6EYKx3+Jq4Cvv5DTcRDlyIRx3EzINEYaG0Y8xZV60TI2+nfWcyAGzdC?=
 =?iso-8859-1?Q?tZYJ65ey9yTzduVDmMoTyflIrW6Smuf2HXf9sVQUoPzQECXG+eFsaV2I5F?=
 =?iso-8859-1?Q?h6+JCml1rZSg597fGuWQ1KJGuib57y2WCspdlkPIk8FY+kD5b3HsgszgxY?=
 =?iso-8859-1?Q?kOg2XwgQPjWq+TBe7JtGuj6Pc=3D?=
Content-Type: multipart/mixed;
	boundary="_005_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_"
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axp.li
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYSPR03MB8026.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff820cf7-4d29-4679-f171-08de7877e019
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 16:22:18.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d335799-4653-458a-8f78-ad4631042851
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NnH9R4e5IlWcCUrGNHMOy8DyouFt40l1SMByWYzu22Ihj/EmU+bdhrX9z01bdU/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7983

--_005_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_
Content-Type: multipart/alternative;
	boundary="_000_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_"

--_000_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi maintainers,

I am reporting a ChromeOS EC input issue on a Chromebook platform.

Hardware / firmware:
- Vendor/Product: Google Redrix (HP Elite Dragonfly Chromebook)
- Firmware: MrChromebox-2512.1

Software:
- Ubuntu 25.10
- Tested kernels:
  - 6.17.0-14-generic
  - 6.18.14-061814-generic
- Session: KDE Wayland

Problem:
- Side volume buttons do not generate Linux input events.
- `evtest` on `cros_ec_buttons` (`/dev/input/event9`) shows no key events w=
hile pressing side buttons.
- `evtest --grab /dev/input/event2` also shows no side-button events (norma=
l keys are captured as expected).

Expected:
- Side `Volume Up` / `Volume Down` should produce `KEY_VOLUMEUP` / `KEY_VOL=
UMEDOWN`.

Observed low-level behavior:
1) EC sees button presses:
- Polling `ectool mkbpget buttons` while pressing side buttons shows state =
transitions:
  - `0x0000` (idle)
  - `0x0002` (volume up)
  - `0x0004` (volume down)

2) Input node exists and advertises volume keys:
- `cros_ec_buttons` is present in `/proc/bus/input/devices`
- KEY bitmap includes `KEY_VOLUMEDOWN`/`KEY_VOLUMEUP`/`KEY_POWER`

3) Driver reset does not help:
- Unbind/bind of `GOOG0007:00` from `cros-ec-keyb` re-creates the input nod=
e
- No side-button events appear afterward

4) Re-tested on 6.18:
- Disabled userspace bridge service to avoid masking native behavior
- `evtest /dev/input/event9` still shows no side-button key events
- `ectool mkbpget buttons` still shows side-button state transitions

So behavior is unchanged between 6.17 and 6.18 on this machine.

Modules/config:
- Loaded: `cros_ec`, `cros_ec_lpcs`, `cros_ec_spi`, `cros_ec_keyb`, `matrix=
_keymap`
- Kernel config:
  - `CONFIG_KEYBOARD_CROS_EC=3Dm`
  - `CONFIG_CROS_EC=3Dm`
  - `CONFIG_CROS_EC_LPC=3Dm`
  - `CONFIG_CROS_EC_SPI=3Dm`
  - `CONFIG_CROS_EC_PROTO=3Dm`

Working theory:
- This looks like an event propagation issue in the path:
  `MKBP (EC) -> cros_ec_keyb/cros_ec_buttons -> input subsystem`
- EC-level button state is changing, but no corresponding input events are =
emitted.

Current workaround:
- A userspace bridge polls `ectool mkbpget buttons` and controls volume via=
 `wpctl`.
- This workaround works, but it should not be required.

Questions:
1. Is there a known quirk needed for Redrix / MrChromebox firmware in `cros=
_ec_keyb`?
2. Is there a known MKBP event handling path where button state changes can=
 be visible via host command but not pushed as input events?

I have attached the artifact bundle: cros-side-volume-artifacts-20260301-20=
2113.tar.gz (includes dmesg, evtest traces, /proc/bus/input/devices, and ec=
tool polling logs).

Thanks.

Mikan

3/3/26

--_000_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi maintainers, <br>
<br>
I am reporting a ChromeOS EC input issue on a Chromebook platform. <br>
<br>
Hardware / firmware: <br>
- Vendor/Product: Google Redrix (HP Elite Dragonfly Chromebook) <br>
- Firmware: MrChromebox-2512.1 <br>
<br>
Software: <br>
- Ubuntu 25.10 <br>
- Tested kernels: <br>
&nbsp; - 6.17.0-14-generic <br>
&nbsp; - 6.18.14-061814-generic <br>
- Session: KDE Wayland <br>
<br>
Problem: <br>
- Side volume buttons do not generate Linux input events. <br>
- `evtest` on `cros_ec_buttons` (`/dev/input/event9`) shows no key events w=
hile pressing side buttons.
<br>
- `evtest --grab /dev/input/event2` also shows no side-button events (norma=
l keys are captured as expected).
<br>
<br>
Expected: <br>
- Side `Volume Up` / `Volume Down` should produce `KEY_VOLUMEUP` / `KEY_VOL=
UMEDOWN`.
<br>
<br>
Observed low-level behavior: <br>
1) EC sees button presses: <br>
- Polling `ectool mkbpget buttons` while pressing side buttons shows state =
transitions:
<br>
&nbsp; - `0x0000` (idle) <br>
&nbsp; - `0x0002` (volume up) <br>
&nbsp; - `0x0004` (volume down) <br>
<br>
2) Input node exists and advertises volume keys: <br>
- `cros_ec_buttons` is present in `/proc/bus/input/devices` <br>
- KEY bitmap includes `KEY_VOLUMEDOWN`/`KEY_VOLUMEUP`/`KEY_POWER` <br>
<br>
3) Driver reset does not help: <br>
- Unbind/bind of `GOOG0007:00` from `cros-ec-keyb` re-creates the input nod=
e <br>
- No side-button events appear afterward <br>
<br>
4) Re-tested on 6.18: <br>
- Disabled userspace bridge service to avoid masking native behavior <br>
- `evtest /dev/input/event9` still shows no side-button key events <br>
- `ectool mkbpget buttons` still shows side-button state transitions <br>
<br>
So behavior is unchanged between 6.17 and 6.18 on this machine. <br>
<br>
Modules/config: <br>
- Loaded: `cros_ec`, `cros_ec_lpcs`, `cros_ec_spi`, `cros_ec_keyb`, `matrix=
_keymap`
<br>
- Kernel config: <br>
&nbsp; - `CONFIG_KEYBOARD_CROS_EC=3Dm` <br>
&nbsp; - `CONFIG_CROS_EC=3Dm` <br>
&nbsp; - `CONFIG_CROS_EC_LPC=3Dm` <br>
&nbsp; - `CONFIG_CROS_EC_SPI=3Dm` <br>
&nbsp; - `CONFIG_CROS_EC_PROTO=3Dm` <br>
<br>
Working theory: <br>
- This looks like an event propagation issue in the path: <br>
&nbsp; `MKBP (EC) -&gt; cros_ec_keyb/cros_ec_buttons -&gt; input subsystem`=
 <br>
- EC-level button state is changing, but no corresponding input events are =
emitted.
<br>
<br>
Current workaround: <br>
- A userspace bridge polls `ectool mkbpget buttons` and controls volume via=
 `wpctl`.
<br>
- This workaround works, but it should not be required. <br>
<br>
Questions: <br>
1. Is there a known quirk needed for Redrix / MrChromebox firmware in `cros=
_ec_keyb`?
<br>
2. Is there a known MKBP event handling path where button state changes can=
 be visible via host command but not pushed as input events?
<br>
<br>
I have attached the artifact bundle: cros-side-volume-artifacts-20260301-20=
2113.tar.gz (includes dmesg, evtest traces, /proc/bus/input/devices, and ec=
tool polling logs).
<br>
<br>
Thanks. <br>
<br>
Mikan <br>
<br>
3/3/26 </div>
</body>
</html>

--_000_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_--

--_005_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_
Content-Type: application/gzip; name="bundle.tar.gz"
Content-Description: bundle.tar.gz
Content-Disposition: attachment; filename="bundle.tar.gz"; size=7049;
	creation-date="Mon, 02 Mar 2026 16:21:50 GMT";
	modification-date="Mon, 02 Mar 2026 16:22:18 GMT"
Content-Transfer-Encoding: base64

H4sIAKCzpWkAA+1bB1wUR9tHTSxnLGjsJk6wgXKF4wA9VJqoqAiCoKjI7d3twcrd7rK7R1GRBKOx
RAWNMfZE7KjYolExJBrsiRoLlqgg9gqoKBbum9ndg6OY+n7J+32/rOVuZ3afeebpM/M/rTmawWmK
4aQ6hmKlLKHHpfGU0WzCpQyuZ4hEmUlv9xcvhULh7q4C8NPFw01h+4kuF4VKoQAubvCPQunh5q4A
CqWrSqG0A4q/OvDvucwshzGQlVgq1sxRZhMRi5G1Pfdb/cJkQMXn/5GrM/A1RwPBBNTAL4ahTLiW
omIBsgQgWALQmjmOIllAUhzQ40YiHoe2ATgKDCVIcyIgSNrMSSSdO4NQs8mEMUmSIBJgtsQcNQMp
KtqIgxDepjTOwEAwpgSMwYEmkLE+mChVurkoZS4aJ8CYSZIgo0GY1kxyZqB0k7konGvlCdHQ4xyu
4yBL2iTg7ycPHOIbjPohv0BHMQzO0hSpR+Rs+AV4PE5ywvvROIkzGCLgqMHjOZzlNIDFcX7CMeg9
igQa5B9RuC5KHFgDMFIPTBhBglg8SUthjB7yEU/ocCcZGBFDsEioDKU36yAd+L4WkgIad5mLh0wh
dVFJ+TEJnUAGtfeSwVaFu0svm04ZL1V/Mp5gKNIE+ZVIQX+C5RhKXUU0wHG4GXKNWB1upmJjMSf4
4AjYAqcUizMkbmTVEgCktTFQ0V4bA5DMIDgzpCk1qKZE2DdA1KK6VjXCB0JxliUoUg2G9PcHwUaM
NWFgJJZkhJMWppZIi5rDY7B4gmIkwQx6BU6EV7YmXNB2GK0B8oq7/lQCCTUUQ5mN+grl1aZcR80Q
/4io8KChYYH+YcE8icqG/kEjh0FTQ/LH9ONhHABsEpSYSbQwQfY+Os6MGSvZg1NCfAlGAGjELNSv
ngI9ekBj6dEDiDqvygc0ElvuWLNWGEqG9ImzsRxFA8ysJyirdespwfqALgYjo3GQQHBwthz0Kh1k
lDKBBIqJxRjKTOoFPvszyCvlJjg41BCMaZyZlQTyd4KNI1YhL/x0jRSmx/VqOLjVqjU236OMtI6t
0sDSRJV7ZPB8gwnjoCWgexNGaySSIbytQacjDUS08MGYWDhfGsUXAJ0CJzGtEeobY4HAK8uz4Rc0
bEDAwCioHN8gn5D+UX4hQaFR/n59TRqb3l9rjBoa/IaO0OCA2juCQ4JGBKEuJL8Q0Vk5aK1QfDjN
SlxkwE+YQS3OjydCN+SdCnkPyqFA6uOiBFJfJehe7enuQA6J6+RaMyvnDUAuBAooZKUMBFIkwVEM
b+9S0a4EMxGeso7BmqGVCdEJIAIiKd7CemskrjLAu06tQRKyh6P4ZkySSVQyEKRlcSYeR/FR4x+O
pK6xWqoBclLVaeTVXQYanB+cICvVxeC62GohkMa4GDUSXSiyadgMx4a2QeMMIAwVRuiIJ2Im2og7
qcV5Ce6g44xQ9sJ7el44fhjNmaH1MlhC5RgCq+qqIpFKoxlMW0Myyl+XTHVxWKUAI5nwuFWCjiTF
mGAggEywwEjEwtDko+EdSyewqHcSHHEInDLUmx4ndTi87wxcnKr6vpBXqqhbGBWZ6Bv1y4uRQPmO
A5oRYqyXyWQakBBDGAX3tgmbPeVSjcyG4BulY2Uf8VQ5QSF5clWI8ZNROlUkWD5ECZm3iqgkwZTR
iDjRwB6KMtbOIT8MjOAJrDWWopiFi/FOCAp8ixooElFFpaneoqzRooKuzGdeAmZ7HWxnIbNSI5yp
UWQUOTfst5qhtmoZgGYMHZXGovlaoGp9IwrA1UkMtQDRgD5K6Pn3DAR8jpOE4FpCKDX4kCHFdVI+
WKL5mEnUB7NoUNBAyK2HWphULY2SmvGGQfV4NIw5OMM684zzBhTLWxs/A2gSRiPKRIgd5HEYg/KO
taAR+Vc5AZTqET3eMBx95L5O4rsGjDAiK/SlKDR/goQSeHNlIuVdnMb1cj3BCkFdyxB6mKyQN8HA
hQSIxVMEqpLYWCQTEuOg6CqSqexXLV4tcoWC1K8HJKsE3mRnwji8MQJTrJaOxjlQIVhatFZhMMEi
bX1TMEuOwUiWQPaDigrRIkEfaT+gEY1RrhFtEMUBmDd0RrNQ+RAsa4ZcQb2hjAEwA1ShWJQBMw3d
Us9LitcK1BeHDBhalpkW4onehLPRIIaIjjHCf0KU4OWkBtWMRAgHguYhl0L2AILVwAKJT2xmnQ7H
9awTEskwClovg9wXMielK0Jk1SQkypYSYqRYbQSYaEzH2RSHVWIrzPuwQjUKTmUmzbx1VNZA1lqm
egkzAjfBKgEuH2x6oN/SRioJ10t8xBxRw8oSMLbiKSRImG2g2wPrIsBGhxQIJmh8JJxzNU7VfKXK
k4NZRY5zOrk4mPgpr7E4FpiQiUzwpa6OIWgOvW9mGbmR0mFGOfRtOXorSngrSnyLTkIv8MVFtHVA
PW7AzEbuTSNVhDYoVVv5UKQxyRMwFCoVMTOLV+QJKG4Y/PrZKNG6dEvik7Qg85GVlEwYiUXj4iLD
j0/tQhlZW45G7eB3CKW/EBrkkCsKen4l4+JypBphMZLAdEVSCb9Nv5IErNGkBvCnNFeDyO9SX61D
/6YOa50zBmVDwuiOqnKNuIxmxWUR9CBMouFt2dHfz0kDUMSxLcPlNTIFeqLaMkOMkBXJDYUCg1hy
Wl2BT8iUGH9oI8bBB0zyimW6jjJBafCvCpYzFOPjNsZwhAHGAuhqpB5qzhHFMSde8yi0UEwSMvAY
uDCU2+6gyJEl1JSTlRorVSqU7gpXhQv64uLiimxpBMZoMaPxP0JPxmGMLHqCRvJP77/809cfFtmf
GAPt/6neuP+ncFe42ez/KVRAoVS5Ktz/3f/7O65OsxoKX+o9GHuPvHTU/ieqX663rHmHt+XHlnR5
f8tUac9+AzYeO5VLpK15y3+zMfzd9UXaMR8Of9LkxS275JzHXS53dYpYox2iNl9fdVk+PeDHKwnx
hgRDwp3+2PFDy2eVLTkZtPaLXRk/dLg0rMXjbV3uzXP44EVqmsO3ZfvSGm5Y/HnfRkdP3H+PuL6i
y0i3gOTOH0SeWuXx5euHLRK823ePf6uom+TA9d2JS/anBPe69DjKN7ztGPvSre/pPth9aY+n4xRz
WPI8y54NzmVZ4ac6hCxd06J8yNVtBY1frXhssevoWce++5xB9X2/H7v5UmzT+p02lcZlEuHTMlSD
QtLc6gS0IheEF8iW7CtPWmtatmLxAgdfnx6TDxTInea0lH+TGvUzrdw69/0Wbuq1Pzrvlfu/O0c/
39B7vse9a6+ST3PFh7fXe3hrWCbRZGIbww11gGHrBzN37drl+/5Iev/6UQUvDpC7TnfoM8c8+/WF
wpjuB1wz88bO7T04S/v9rtPf7V5+YXPz/P7HT6erLl8puxFXmHH2wdil8w+xT4uKFzyY1WjOGheq
gcyrcfKJYtr5J4dHB+Nv9sbGFUzrfqBU83xBv29uLzXPHJf/uqjH9W+dLAlpKavGnA/Yf3LXmvmn
7p9bnr/+vSDnSVOmXI8wbwkoT/90cEnW3cELjlj60XZxd6cpthXG5ic36NF7FrYgl57a8vD5sQWj
uz/aW+Z5UvNlQf1BCe06HbFQnqPbjWu/97hlz9Nnitl1L+0a0L+t82IuE/+uW9nCGVu8Pk95e716
viU5306yXD2j2auGzxsVTWpe4vpSMpBudqpV0fvZq7PL32ptKTtxfvfaPQWTP+sW0Db7xg/36Jm5
Ab0C5iuWTWjp2Zw6EOOg/upRy8j9Xn2/+/j5RburjRUgF7zdzrvbSadFqg8atmz7CZGvNJVs2nrs
VdT2a0lL89fHznY4sW9/a/tlXS5vrOd+OGfl3a4vg8K7+mMlOc3SyrwKiW7lzVJPPC488+yDaMXG
JvOWWnw/zehw4vtfKEt53ppe3/kVqh02pA59r+WXxWBug6Q+vYzuXz4tX9U4oGEkNc0r0b7ftQ+v
OeyIvN8iMr1vgWJ7+MyvRvXJbZJreavXloH94lNSIz7WLW3b2Hf4wa3zEz3O23lO3I99Vr9OxOxO
6Rvqryp9rbLr0Sx7VVELh6z6G9rNa3qo04spK7wXTajz5fh33CM2H0iiW7bIONq4Xr0BMqZjXvyC
rT3Wb47MvDDP9eDOaQe/dvl5YFNpNj7/zOXHofX06qIC2j1o8wFvp/H16237YWYTb/r2xNC5Zzqe
3bB49Mc7i1Sf3qx/5u0zDk5bA8N1g+yfnHNw887wVH3Z40yX3j8Rs7c7Do2u/25y9x9+cPh+yQR6
UeS0q5NfP90VZVmUt2udbDrRcUY/Yo98Trb3qoiIpPCp3zY3sHNi7YkxpSAELFE+b3v6SKpi4ZOJ
gwe/6nJsQqTF+N3x5aOJ/Mvvta4z4NPCL7gH6XVyO3zs2jHts0JF3fb1wm+tPHCGDdwj65t6quO2
qJ9PeaybUvhJcajZsdXafpFjwy6Gzo9a2VR+Rv/xuJwjl84VTF28sUfW1eume0UhgZtTGgRe2db0
hHvZ17fuLTwoK11hSPreOdC5zelGmOeludoDL4IGTLhgGaKSj7E8eLsB3aqgXdGh/tzzlr13PXG+
P2p3chvL0/JEuymHm2qvrik5c6jRYcX3j4fHDHw4pnn08NvTM1Stt2/9oLVuSuFPTXoF6ELnNU8d
0vEbTB/Sxp7LOBm4rIslbkbnHsyavhucxl76cGffXMON3S16js378OHTPu77znc7MLjFjOkTvvqs
jTwuud6Lx4kdl8xaPN11XpP0G+tvn+0SNvndvpaerD5Z9U62vNuz7XW8WtY70/2s8sg1xxd156cv
2btXD2bltv2mZcikrNNuXV+cy1alD22/8mSnR0s6uT59YpcGOgM8IL1rl/XXp5Y3yPU/f/bezm6Z
STFfq8fVWbN754sm83om741Zvvjs2TmbpJ7h7/U8NidMj++4P+ru/Im3z9/MjVsytGimT+aab0Pf
afHsrfrY4rLskXvC458v+Cbq3ohDGa26faQtVjWPSJ3ZpevwZlsTWv1y0b61anD+45ye7WbuKDm4
rX7dByvD5qSVlrwaPOSI70usYUCm36AJMU5HCr9avXr4q5M7tg+79Wm81yb/cec+39Sh8bzzpoTV
00asfXJ20sxnd5UnHG5dzGtwjhl0Nke5WJlwnlH1njuw5epnXl8cvQvWeZ11ezE+b+M7qUNW3vdb
/OKrUNnFlN19vEzxP3RoX7rDMT3x9dzXPrPcVRO92pXe8XywULc+PG37xqPJw1Nuz8oLT3qn53m8
PGv0w3cPjbzkObmxscTiEDjmkuXs+fJH47bstMzf2jbxSqPklSPqrly3M67eyF6LD+xfdix7t9c7
8cWW8JHPUtqEZro1Tr7q+7Nre2zKq85djvUsj5p6OGdA67Ch5c8+IvtvvPJLp4mLmnzolToqu9jb
ud7QvPzypQ2LN3339MGd42sH9m797cVJ7+hJ7dJ2xy3eLbZmLFPQOp/mvbQLjh32nhkc9kQ7P9En
9O39RW6L1+Sdi3m6ePRKInXwQr+uo5ssOHby7Yj0vJg9o+WnNqSuio1VfR2+OSps3dnMrqMDg9O2
Dcg8ekN5+O4oaV7WsItjZBmyM5mr+6V19VkfG7ujfY/VC9LBsRs7pu/YdSZl29CLY4b1bDz+628H
ZG5akJlW+vnpFuVHj01OemD/45bG8RGWgPD2zVtqF66OmhZ4zyuixyPLkPbaWymlqfUOJ0qyf4xM
9JkwsnTF3bqnDINuzNi/Lv1Qq6b09d50WpOmEedw/7NfXr3bwnXnBaO5wbk7h0rj7mXXeeTQ7EqB
fXAu6LBYH9P+nQazjW2aPBy/Z3Umfe79mRHrhxLZreGoZ4+9tBD5fVNK5Ie6leVtWLfDkrUubGf5
pcbhP1ke7sz4Kbl9i4cpN4fF3e9/5VMyYUlO9CeWxKX5h52Prmkwbt93kZ8Xf9903vP13g9DvVJe
Hm9y09V48P2IZdrN7X5JHN52aFxa9uNJxpKIwrF9doZ6JW0IG/u4qWeyskULNtN0//052w/vTIk9
UZh7ol/80P53ze+nrfjW0jvTKz7o5s3PPntQzHkGAPssumRfTHbk9agx51MWPZun0u64HKLJsAzs
8TLlcKgOpoo+5vKEI9ckeYMypi9/tq9p4bW29PEVJ11z1q3Ja/hywNVjowzn39u70RIWm5ph97L1
1keHrpROzg8sydpYltIqAhJo01G/+bLdlfJNp4gcT6/tVzy8lnNzJq4Nz8i7M+bHaUk5DZNmaiK5
HN/7CSfyZlweF33S5WrqoGZps8oU1yz0qC/AKXvPwGzqvtKSEWaRL+rQWpYfqNZsfx3Vz/KVQySO
GEywfDLuZQT5ZdbziYW/FOz9prTeJ3HqJVOH+564bVh11z6vCRWn97512VP2rFu9vnF7Sk43oaYs
LboYWZQyO/KmZc+CPc8Pxq8Nn5ytLczNqdshz7Jhh7tl5IWyrH0oZae2+dQvvwxWOTdvOkuiew2+
+WSYXV8337kfTi/7qhXZdmhdh+y0FZKPjg4elfth/CDVTDbyY2VB+U8wDWd9/sAiTajrfsnCXCjP
23DcktPGuM2SM75cbpgs6VbgpYpPT5nRcHJqoR5/sWv8mEQ796OWi69T/E/bw2pBE1jekpp5QPVR
++vHp529s+wY0Wz7q/OPXT62/2Zc/1YDVdF38w/tl5VkOd9MUbe6fq2T53J/rzrFUcmWKW9tTrb4
6Uot44rOvMrRx5UWN9u9PyDh8Clzo9mL9lpSGnkeznFe8MwSRz9WluaMvmJZaL5pudo4vNTiYUpv
9vLHceUBWwZ6OLycYsi76z5xtmGi5ujYXWwctmxXgx+v3Cie6tQoZPadWY/awoKHuWDpdHXCDHZf
cbfbA8qyPn+dssHB1XJ13JYjlhxN3NY6W56XxTSw2/TIznHgL1NvGfJ2N7m9Y3ed1+cG1D19Mvf4
HUtfrI0lR1vmUpA/66pl3oKSF51cXqYE9frw07VzsxLt+6Y80keX7X8+eXz39ITowKJJ4088bNMm
9k6ysbQ4q1OnvYdTTGeL2zQPK/ctT9HabXxpwbtZXn539+CV2LypmOW8fzl+bNkEz6vlF7TlAyeU
lTfTllomB5+3FPdp/d7VObr0LaOebBtidy6wFJuR9dZPJVlDR13Yuu9pfnqbn3+4cKi7d3noGm3q
mWe7tyuyS1zyDsgihtObYuKi8ucsdOvSeDoB6td2TWvzfYrd8fWhXewS/9k1yr/X/94lbERHmTDC
GMVvNUexJEHTOBeFlv9ShatUoZRxidxfGePX8T9wte/hIqz/lR5KF6U7j/9R/bv+/1sudGDJH0UY
qWiAJ+pwhuYq9gate0LolElbAROSdAahlJnR8ZuCJgzt5XYG42ELiRnRhqY0Fki1QCplCRI+073S
joBLLzX8q+jdHfaaSY4w1tKrVHQHYyFBACYB4VjdnxBO1MdESSNx3STxXG2SeGI2xlXlESneuKgm
VdsOnWR7CjcJHf5M0vEwFYAo8d8otrtEEogxoIIFFwXg1SxlcaOwDSt4iXDiIjWzWlovJSmOMCRJ
MR1NAJEVV7VCoQZ+CJVCducAOmYSMDHoPEI8jqEpguRwRvaHRoT8c0k0rgPWafID6awDGdAJIo0x
aIu3YqT/qgGsqBI1Dz3hEVVmTkoZpByD4yIQBHAYgU6ahPf+kIAqyYuk4nGGMKAjYH6nG8Y2XK+G
Fh1NYjyaANqsnEInuHFmguFpJUHywqmhVOADfRWG+DOMWC1CkGMNI7Ce5OL630v8DSd+GAusWBI5
rSNQ5IEjysVPtYtBppAHDwtW+Cl6o3YbruQ2B87iuSv/v1L1Rw2HhQ4A/0mDQ4IRmvMPztjlt8hD
ArbfZUoZBuMwHIIJCgUDoJpgxGKgwkCgX1gFEPCPDsLiJEsxMWZtzRaZqzigmYwlqQQSIEcBvf6/
HBxUyf8MZuCibA+8BAjwXy0FfiP/q9Cev5D/3T1cPdyg4tzc3f/N/3/LNQJatpAHpdZDP28jAirI
jOiwXgZdTuKng3Eb3Un5EOEdD31OJoZpiol2BlojbiajvXk6hNkkNEYzFK6LrdIoCTVrx0MPVIMx
vmEDIyuPGQUO1LVi16qCe4EtuLcSB9KjGlqBFEGqEskggkeooaCOoDMSSQDATGIlg4K8FacMowmk
LlARIBtUNRCzlVsZJGqFPcgrgMwIQxCOk3qKkQcLSEI1qIKXrQKXrYmWlUhCKQNnpWQL7n0DlLcG
ktfaWgtcpzoStwKCC1mFyjOprbjW6rIX0ES/ArG1wfBoaodJC5AaqC0brFJtSJ0KRF511JpGOJbG
qyENhSNtkoKvYkaWqhynJrIOaswKNK6YaQWwWI7QxDXAxL8JHIY0RdwgwtMmiDAzK7RJLXFBSDkB
7WfLkIgYFkGd1aByNdFJvwGds4El8RR5fIEVneRI6I24U9VmJWwWdWymq/WpKvv0UCROEonSCQTw
uualLEBeRbw0rLA4AkGfbeADVqRqDROwgdwhRNob0bD86whAqSU4BOMhEIpKX3UQfnyaSuBBVEkS
SQ1AnhU5HYMbaZGjMB55J6+JtBOAnlWheggap2NwHj5IVMxeIBRaw7Rqg91JJCon6PS8CcMHRbyd
AMtBdsxiJiuqd1hVRFwVIB7/ALIhvk2IWNXQkjb6l1jR3nIRfe0ooLx5eYmoa6cqkG/naohv56qA
b+dqeG/nGnDvfxy37Wdm+DWJLaxICgIq4WAYMEMXZWkMlqDVwYkxGMeD/9g3ex8SnQhItZpgPIEB
TQIN17k8BJLHZNnAsdBXHntFM5iOg+MIWM1qOYfH2GhxAbAlgiJFRCAcTS/gEYWAhAhWIOYqJyOi
FmEQCoGLGGhoaOLBRhyDBKFzQs+EoQOHxsYIg/GwMaF+RWueWH6JL+QluU0uqshmzoDiAduIAi68
bV0gIfAYmiGfiKX9aqxJakOcQT59OA7TxZh45DavJB2GpEQhqDQwmI38DgQrr4CfAEcNvx+F7O5N
AcO5IvU4V6KNrYBO6BvwGR7p6FMNpASDEVrNosCtw4xGBFH6E9AhyQiorFiYXP7pGu6vXCH+Pv0D
/f8DP/L7les36n+Fu0op1P+uSjcPFw+gcHFzd1P9W///HZd1/4+3fTFEVWD5quEDnUQMqtjNA+05
6NAw/SAvghGCJNBPCFBsESpFMahVRj7KIGTASkfjy0K+4IZBIkBI+HwYN9MsB9Owid955JemsBHm
Nh0KbpW7kSjv4izfZTRaQZOiu3MCYhA4op+PWH+UgcCJaLkr0ORjvICxFje+Ua0ocIGSN21maIrl
a3Ifv+AAwCJoJqwlQl3loQqE+Sfj0Y8xRFClntIhVqxRVO4bAJcVNukBh1UoQ5jEX3sYMQYlJGEv
Fe2ECcWNmWRwI/8LBBQR/09Hl3+vf69/r//m638AD7O/jgBAAAA=

--_005_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_
Content-Type: application/gzip; name="side_volume_bridge.tar.gz"
Content-Description: side_volume_bridge.tar.gz
Content-Disposition: attachment; filename="side_volume_bridge.tar.gz";
	size=5096; creation-date="Mon, 02 Mar 2026 16:21:59 GMT";
	modification-date="Mon, 02 Mar 2026 16:22:18 GMT"
Content-Transfer-Encoding: base64

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
4XtH35fr5Xq5Xq7vd/0b6JrqbQBUAAA=

--_005_TYSPR03MB8026DDD72291AD506F2C6C5CDA7EATYSPR03MB8026apcp_--
