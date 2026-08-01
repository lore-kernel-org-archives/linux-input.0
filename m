Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013085.outbound.protection.outlook.com [52.103.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A23955DC
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785597093; cv=fail; b=uLkXd7IJfq7kwSzf2dsRvdvMQY6jORPRxIjQ8SfIaPbhLIyrOLAjUqP9PzrIVjxOxU/78YeJNDpFmaYXfBx0NyGaBBhjbQ/AnVD+v66FPbeIcAm7jNmhiogFeN6qHM0G/Gp/1bxMbK3dOU+gbjnKq/WPCO4un7ucWzBlteflbX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785597093; c=relaxed/simple;
	bh=LU24cNMdvcr7TCuCRMXI02EYisH8X4hUO9oFBdjAhc8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GU1pmlcALLvBHXNZe0+IRlPsTMplbCviAUQU5aMMhHI1b+SRwuIPWGKvk12iuT9XMKviqopsuuwzWmvXLy7O1K5tyRsIjd/vITK9UVnCwt+0njP2iBfl7qLazVVFl9SvRq/ZrRQdx6PTM2yRD9wMSS8SvdhFExDfR9YhaVgn4lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tvkSkJuP; arc=fail smtp.client-ip=52.103.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tvkSkJuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow2b7BjNsIgxeSe3Nxt11SF+rfRyhZekjGXou4W08ztqxFzagr6NbSv8gKO3hGCMQg2zlfZxQlj0w0+alJFZB504H2aCVzDLXfTau33PwL51DQdYhMk8aM+ZZyeDSTvMVN/hXevMQg56DwR5EacNq7Tjd+GAqYjPiRGxgari9zDXaUTWreWlp1iEOyGPDYJH5XrB31MoQC9Ml88nRY7KdJLG+EbV+wUTDMLvNGz2xHpXYIesos9nTbynPApnTMtDSgTnxBr7/2VEoSVW8+cGkYYVXiC6L6Xq5eC3utJhl5WLqU0UraVolDx3lxWQUqGc9Ntds8SxB97hyxCRzsBUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fP4OvLqbhMuslD92uPMmf3PuMjgfrKUuKaUj7S9KlA4=;
 b=icObM9ko6Q84qPIMMoDB5G4SzmuDATLoeJi9GY9FZb5r6kfCwyF7XIj45TR6EEE/Q+lvGo0fM+zoaGhEke/v04M8IE+jHXdOGAFf6T8Yr2/dFpXdL2Ogp5cUfMw38ivABcaQFMD7R7wPYmiSyLzSrms3Os7T8dAeHa7KbGMFAQoRVBlAGKgNE9gEG7St4N2q2gBc5VjdA18wcB9Kl0E0BwKebIiwopdQBQC2PEAFD/N8v+MZUXxctLvHNyCFKRsUMFWnrJZaVydGUj9f8MJ0YIx09r78g5pn2oxAIidatWFDNFIGrjLkL7mtZ6mXAsZtZCbhN/onPMlJKEtimie5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP4OvLqbhMuslD92uPMmf3PuMjgfrKUuKaUj7S9KlA4=;
 b=tvkSkJuPuFKZ0AMELFqBZCwk1wsZpueEXOk+SDHGcNko5yh5iFxkh/D8RraGuDVsrTy7Zo33dzm9K4mhTbP9v94diHpLBk1oITuwrIXK2P7qRn3/zGt6K0W0DgGnAY9J/oF3oeBrFMylUJmOH5ECE/RRB3YkbJK43Vbpfcxbl1Q5EHQusc+Yik+3hdYBoyrh1dzq4QyCts0kUn5/sNHh2z3+SEp+m6kX4NvtxwwBy1ZH4Ah62KeDvcPj8zmWKj2+pLLIxpeAsbwByB6xXAFBrShfujxuhrcA9oQ2juNaLacyZDwQEA+vyIUHKjdVoi5sk5/JRp98M817b6cgVrBCuw==
Received: from DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:3a::8) by
 PH7P220MB1613.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:312::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.16; Sat, 1 Aug 2026 15:11:30 +0000
Received: from DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM
 ([fe80::bef0:a986:1cd1:a57a]) by DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM
 ([fe80::bef0:a986:1cd1:a57a%5]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 15:11:30 +0000
From: Donglin Lyu <DongLin_Lyu@outlook.com>
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Donglin Lyu
	<DongLin_Lyu@outlook.com>
Subject: [PATCH v2] Input: atkbd - skip deactivate for HONOR ZQC-P
Thread-Topic: [PATCH v2] Input: atkbd - skip deactivate for HONOR ZQC-P
Thread-Index: AQHdIcgHTmDYkccwxkuEtbFguFAFfw==
Date: Sat, 1 Aug 2026 15:11:30 +0000
Message-ID: <20260801151115.52709-1-donglin_lyu@outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8P220MB0584:EE_|PH7P220MB1613:EE_
x-ms-office365-filtering-correlation-id: a4e2cc39-f86e-4c33-0457-08deefdf2a66
x-ms-exchange-slblob-mailprops:
 laRBL560oLSPhlJ95/U7v6W/AahuugGaTBqAsSpemUNiVZKLrDQUbsDQ1XdUSwUmMzWIRjggXSvEnaN43Arzz/qQBXBBTEEoz06O99jVvamMzfxKv5VAq5EAU+W7fxi5V3VQd4TPvK1gpC9PMvQ8fnp3nPjTvYAQ/9plu5vnV8TDngQdN7CUrtxcXLcXwaepvqA/U/ZXpcuoFxZT1n+qR+L/f9MQrssU/ENzXOTSpJEqsh/3jO6FZXTg9WYcGoTqriXTI86dJXUKnuRFTmO/sy5vcB05tvBm89P80sjqikrBs5Wx/DNN877SBaKWt5ZEMoLaWOPaniyvPdJTlouRlQ0eppvEyMiTXm3WYePGUMl/JRuLcSBU5RP7TB1KcYOeRoiK6rWe+qKIwuA9U+NGf5h7Iiu4j5B/8zNl9MIceA2B+hyYrywrEyM+nZSzk+Qo0h2imgSgeTGLM3WUHEOUAGsqEksdId/G/Vas40R5pufjtXVjc08R3KcYFcSx75wYxRF2YQsUII1wsh3lwF+QC2v/4Q5Qnpghhv5kX/++58snSZ3F625PbaXacatwVURYRBkUAvm/LnAwsygQqCvo7d3psVnYjs3vojJ6t52zWymzwDTR7MVtiVl+fPY5TqOUVUW8+CC+f30ym1FQp5mv1dWHN6h7e5Uy/acN/FfPqUYdIo+w40V0SkDuFy0ARALXrcD+sX/2Rw/h5jaLrqOjYAlV1/ydLcNMdrY3qN6tgBGumAMYLR7xo7nm0QuAyQpI7G/nwmDgs64PSYlvTS3xRk6uMHmrk9Dx
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|31061999003|8060799015|8062599012|19110799012|15080799012|24021099003|25010399006|38102599003|40105399003|2607281247196008|102099032|3412199025|440099028|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mnIaotcJNMBWY5m1fmIWSn1C/kJxMBKxHZoC/Oz4ORWcMzDkQfJFJYNbRx?=
 =?iso-8859-1?Q?DRFrGIpYEi0Q1n7nqU4FOl6JULqpLNlL5FbIaIsOPI8bJ11yfebxPmDhH1?=
 =?iso-8859-1?Q?fcqHR6MQeO32w1HUBptsNZEtb5S+n0Sf2euaR79DJTn2O4NKTm6bBbhQiC?=
 =?iso-8859-1?Q?hGPKU8Fp+UMg37YlxQaSGTwXyittPmeg66BcKQ42ok245/whoUr8ACWJvg?=
 =?iso-8859-1?Q?U1RBLf7VPS2YDv79wSLvbitGl9PLk5HrjvGhcHzoHFxMy8WzsyCmzmZdwQ?=
 =?iso-8859-1?Q?q9YRBjimVs09XQLHvFoWIE0SwtLGkEjD9vptxzVALuruv9A3vInmZPuFyG?=
 =?iso-8859-1?Q?uEQFfYAqlV0fMgJsb1L9QA4N+kjeLUiZIsjOizES4o1bZMrYiPEuQFZViX?=
 =?iso-8859-1?Q?CVS4UNEclwEQaZ1+BGUS47Tnlfbz4QPT8WhdufKBAFSnuwa0tXq/b+F+NG?=
 =?iso-8859-1?Q?rUbd24wsV0z+xQLFKp0qLKN52KgTIJrn60Fw3GJMPfdOeBZ/ciwPWUkk0o?=
 =?iso-8859-1?Q?yHZNpBYrbB2MpyjCaPietlL5tJcVibrSvtLqNAvstEXS0CyvJ5mkfhdsPx?=
 =?iso-8859-1?Q?IjRLsBLcnXLLF/iaZzDdekZLIIcVq4PWXSWOG+ttv3MGKmTUUjts2F98py?=
 =?iso-8859-1?Q?VFcJkg20UXeq8JtAaD+th2o3Tp/rDKr82mVD9bMxPatIdWqy0mJujapMCx?=
 =?iso-8859-1?Q?WVcr9XsmRT9QOFnWVyUXFyQM5qxb911Gutgj4d0671KwofdWUeDn+agh39?=
 =?iso-8859-1?Q?xg6eF5yW8Iv7VKlqTeeZzxN4r0cze3uwLc6koCLlorjUxMJD1ME1E1NYWs?=
 =?iso-8859-1?Q?J0W8JEoAdq0Uly+lkiDOsKaQ9E9m3gbAZbMHdjoBnIcp5xvuI9wG11NHUI?=
 =?iso-8859-1?Q?QhwcFOzVqUf5XfkFv/8g10p6T++sxp3lg6dQtaIVXlk7Qb5qjK77obYAm7?=
 =?iso-8859-1?Q?h2odO9fYraTnDkBlOrtAj72a/7Bhf67K7Xa1jQvf0yFB0tz3guQFUFuX2n?=
 =?iso-8859-1?Q?yrlB44IWwbF5On5D8InK+6yH8OlVWPqHy/jU5z?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bB0GUq1/4OGS06QUviGmx1a4Orzv7qB7NVjzwPWAnAcMYz/ZhdRTEDW/Wt?=
 =?iso-8859-1?Q?rL0Ufc4bxohjcrt4pngmCMx64GWzyXukNi1RY3l0nDWbPwBsJRMfFaWESl?=
 =?iso-8859-1?Q?JCMIFHlAiwNEna6ToPJ4icua641mdqbwQGzv4vRhk19dG50quyPADKB7dM?=
 =?iso-8859-1?Q?VytwDgbEsBFqJP31QRtv46UlYjIZqIyTqtIqIji+lae1sO399vE7of8vEb?=
 =?iso-8859-1?Q?+M7qZ8zs0dnvBkonnz+Hw9Yf0HFFOeyRWGUoXoEgRySWi4wuEnEeIGPRXs?=
 =?iso-8859-1?Q?MwlrDJbhYYFA0GTKVNl+fT7cZHHztx4UnZq3gqqFQrLIfjfGnBzpdSGldN?=
 =?iso-8859-1?Q?1vHr7O+9VjsPTYG8v2dOh7Bi8aC8THslmgbnJRxEVI2L0zzBTP3X/KvvVQ?=
 =?iso-8859-1?Q?OIrrjEQB34ONe+cI24hK8xlRszkca0tIiyFpW2mdPn6cS9EARpddrJKECQ?=
 =?iso-8859-1?Q?eyKxudgkwxMxlHfP3icC48et708e96KhxTryHl3CMkR5L0800TlGdOgQox?=
 =?iso-8859-1?Q?2gTpCdYDaDRYI4slbPbYKbQ4/3LaOO0hZV1yeT3rD/jX/yu946gwR27Q3W?=
 =?iso-8859-1?Q?asdvNR05x9nlrhVyF+phKhHd9lzaSpHBH/mWf+8M3ExIovvY9wvHN/y4O1?=
 =?iso-8859-1?Q?sTaYpzdzSdDC1NqSiieLZkCg6388OhI+AnYNWJGnwqganZGdVK5VQfZ48Q?=
 =?iso-8859-1?Q?iN2eVLFzFUW84p6JQ5zmHseoLP1HcpRA8waUdGUmuvhUFWd4G+11Iwstie?=
 =?iso-8859-1?Q?8cUCvZSyZtuwyw7zLImkO9aHZF64ggZyiBriTxTiJaljODV3TQ/X3O0dgB?=
 =?iso-8859-1?Q?3nz2/L66qX5LpwFaNIi6kgIHAcY9aO7B99OIOMPivR2vkkZbARF6P8J4F1?=
 =?iso-8859-1?Q?bslJKPXwesuquQw7ljgiNo4r/NgEMvyjxBnvTMxcULTWe9B3IhHyNep9SR?=
 =?iso-8859-1?Q?/KO96Hwl9Vw7CRrAOsbBlE9b5ki75hIBSuBVV/dSEbgqTJyXX7JMC4LSeu?=
 =?iso-8859-1?Q?9PSH/JKQyqFMjrCXUPQeYLRagr3UZ4JPG4mIAiWbHgSJJhMwdwTBvSHj+4?=
 =?iso-8859-1?Q?ksNQGbxmvOTO3iFOeIcsQ4/w2GYYqUUEZGEBSVoCOJgd6V6By8kW+/CAMj?=
 =?iso-8859-1?Q?BFQcexiBghcN4WNajFYv2F2dv7+4LmwFHTb7qOSk1SmQfwXxUGO5ojbllL?=
 =?iso-8859-1?Q?KkS4MOCb0L4RIcxiUZNaMUIL2fhtPj/EOJ0AIgQLmc+eMyfNA+jJEyKvCz?=
 =?iso-8859-1?Q?wIn4F8Qxk46DofjSiv5r2RibG66rNv709DLb8NLS2H+DAY3DEHR9X6TRKU?=
 =?iso-8859-1?Q?/1sYzUHbS8PzRSRyzt3XfWnyerMAtIbcvO+t9qsow+UUEviH+SZJGqBjKr?=
 =?iso-8859-1?Q?qAWwx1XAjRcF0A+fjmtdqzd3cRFJYZkN6Ku5A06qs4SujMK8mtONgF0V+n?=
 =?iso-8859-1?Q?cYsGQD0bgNV4TGZO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P220MB0584.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e2cc39-f86e-4c33-0457-08deefdf2a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2026 15:11:30.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1613

The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026) =0A=
does not work after boot.=0A=
=0A=
Using the kernel command line 'i8042.dumbkbd=3D1' makes the keyboard =0A=
functional, but the CapsLock LED does not work. Adding the =0A=
'atkbd_deactivate_fixup' quirk fixes the keyboard and CapsLock LED=0A=
natively without requiring boot parameters.=0A=
=0A=
DMI: HONOR ZQC-P/ZQC-P-PCB, BIOS 1.09 03/19/2026=0A=
=0A=
Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when sk=
ipping ATKBD_CMD_GETID")=0A=
Signed-off-by: Donglin Lyu <donglin_lyu@outlook.com>=0A=
---=0A=
v2: Correct From header (previously overwritten by mail provider)=0A=
=0A=
 drivers/input/keyboard/atkbd.c | 8 ++++++++=0A=
 1 file changed, 8 insertions(+)=0A=
=0A=
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.=
c=0A=
index 8cb4dc6fb..4a7e91290 100644=0A=
--- a/drivers/input/keyboard/atkbd.c=0A=
+++ b/drivers/input/keyboard/atkbd.c=0A=
@@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_ta=
ble[] __initconst =3D {=0A=
 		},=0A=
 		.callback =3D atkbd_deactivate_fixup,=0A=
 	},=0A=
+	{=0A=
+		/* HONOR MagicBook Pro 14 2026 */=0A=
+		.matches =3D {=0A=
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),=0A=
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),=0A=
+		},=0A=
+		.callback =3D atkbd_deactivate_fixup,=0A=
+	},=0A=
 	{ }=0A=
 };=0A=
