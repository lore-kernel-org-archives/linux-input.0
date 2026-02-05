Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010006.outbound.protection.outlook.com [52.103.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FC342C9A;
	Thu,  5 Feb 2026 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300947; cv=fail; b=kgXZ+aZ4HQ3p2VqbZqbWM/tgUGvp84moHTW5CzfLhYRx80/B8VGB5SyqKd3XjB7OwkjvZN0TTzfypTiPA73yuN2/MzmSGEOzxcsor2EnSAUrxiJ35JhbzfeeSTFnX870S0EMEj/GLGYaJCHtDJ9hTYViZOcdw+jgz0/QxH9AoF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300947; c=relaxed/simple;
	bh=/fVxcH7gpdU8KBdrvLoJQHEUr7osjOpy6Y71PcQmS48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dE8x/jJ6q2XPC3lRYplGfD3zDiy54pxjUHOVJ9Nk3D+YCOcPSW1I5jIjtdOOYAVI+NhBx2eIG9ccXKcDlqu++4gh6WEvk97TOPDwf6DJxQFBa/jRR1ClqOmaWJVkS1dZNnLgxmZh64bjJm3r73wUUrfu1fQK4a5C1G2BYzAlyc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MqjYLHwQ; arc=fail smtp.client-ip=52.103.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MqjYLHwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAxn1/sLXZpJoFgxU86FoEK6aXft+ZLSWoRS0hiNXMoxrnOCRYKF6WqMqONTcwuVB/TltSTgprJesP2OULS253SHr6elryHKXb1eFhRjRGp9mJ/yWi+re42Ev0qPoHseTf3CrqT8NhZNFr/WUX9l/OX2KPuLglwZPLC2PZoSfn9b2J5D268zELEkYGN37KqXJbuYnqUfmUKue1F0/x3hmeejuTJaFcYj0QVbOu1HEoGAfC30rXDvkgx6x7aiE3ck7YUKu4dcI4d4ucd2nqO87DG+iTdYsJu435ERJAVFrQACWqhn8ilM2LY0mTRbwFmmfNrGe/2hnRTOs17dkYzbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iok8Nz2H5xBebTam1UCtAig7pu1hMan5iQ5aRQ8FvZA=;
 b=wTo+sSW1sw/h0UsDb/SMhK/Ohw9yc5ehRUybIIwmhmDcwqPvR2z2Idw6wFWZNoAlcEe9G0jgnHvHjMNYOOZhafSC1fYWRh9oLkIaZrkHmn/Hxe66AH99xdbIVMvt2NWTVhLTWV9dSxHt4Vs35u+7pJ+zQk0K7dO7L+4Qk55F/F9P8125Dhpz4Nxmi/bftshOwlwzVeJYhsnAaJ8H79iCnE3sfAtNq/A0TPeyyi/JyfjdQC8/neyOGtxsTemVkskBwGjUWmalPQo6DZ5Nb3SO5NWdfWT8S+MwdiLipylbTmakKsEqt4f5PyNk34IklsND2nks2DzxEkE09rrjJG9kbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iok8Nz2H5xBebTam1UCtAig7pu1hMan5iQ5aRQ8FvZA=;
 b=MqjYLHwQGZW9ranisXGmCXOcxxApUShivkwJ8LfrxDo6BfOkf/D8yFUsVrGPeXD1oayMoYzmDucTF5ex1BzUptyBhdQyjFMjz8s02jOawMfmWtPfw3EAaGew5azLjTNDJAcB3X85G+SDs75lmV7FUo/5h46fmU0hqzOEdkuYosnFNTLXTwAUJvlhKwe1qFEokkFTwLjcQepUslgULJFljY0f4LdyLrYfU4zzmIBzf/Ek+jJSmFx/lpIx7Gs5v3cPhjzFl+QK4UX4ZD5pmyh6yyp3iGGFba7DgIr4E3NLVarHD42vd+OupanIUFRAlvuWu5ItTRvkv92Mp+SDhqLyCw==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TYWPR01MB8558.jpnprd01.prod.outlook.com
 (2603:1096:400:171::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 14:15:33 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 14:15:33 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: dmitry.torokhov@gmail.com,
	vi@endrift.com,
	lkml@antheas.dev,
	niltonperimneto@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1] input: xpad: Add support for BETOP BTP-KP50B/C controller's wireless mode
Date: Thu,  5 Feb 2026 22:15:24 +0800
Message-ID:
 <TY4PR01MB1443218CD6B7089D3DBF893989899A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::11) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID: <20260205141524.10761-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TYWPR01MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bc21a3-85b9-4058-c687-08de64c105f6
X-MS-Exchange-SLBlob-MailProps:
	ZILSnhm0P3mCsD4RYpiBXP8G60zXrCmRiRF7pJxbSVFxdgsfSpAs2wEKssr5QoiAWriiz3b0TjpaZhbZGpaeNp+e0dny1thtPW6Zsb3ra4GWZuBkdB/2lC3uH3EEU0pkXzcnDfc4pX/hp+jtvbK7ibYeAtXLGd/QIbireGqu29aS8RayhrjxeihHFW7u4jjUu+T6gkUxpkERR/bBpWOqGmnX35xoBoInA+RRAraQpHAWD/wRDbQLCeXgGarW4DXpReTaPDTVcERAoY7ogDz5KA04j6kpS8xt2FWD5V+F18063fQ1NnnvGRNZKbgbbycWrNKdcRroohz/knrmGcloj5lOr/GdWAxf7SDFXE+TdVFbetss7IK0tBZ8IrGuIrjJVFq+gdwQCvAqonmEwpStNae5z36f8KNqX1ErFSJ92rnu4e8WXApH11eIZxfqB48gBzmr//wQXpdmtGImVN/fKtmBcKoS5DpraMr/czURGUBYLDg0vQXiYG74o3tNua3VJiI9biZLs4QGEQs97u/EI5X000gpHyjj0U9fJYESourkRyLRDlqSyCkF6GXXdeINDLMMbav05evBAFhILcvefIUb5jlBc1IWkcYOHNF/P1KW8gSWNkXEAZ0PULAl4ZRpX+w5n5TCpAS/czmgB1xlaaDGIdC6lSiC9VLJkbXHE8YTAxsWrADV1a2c+gPCxDcvGua0dNcy6HU/VKlD4wFvQcAb/fafRGwdNvpWP3FaHEBDT/o/92VgypJp6FUgigloaJ0zfJT6fdVKfEzlWCvhA0FYBAoKLznK
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|15080799012|5072599009|5062599005|23021999003|19110799012|3412199025|440099028|26104999006|40105399003|52005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ML/q6uD6IloPh2RAmrIR2i6krWOfcuhAB6XI+/z9hzAHms3L/JmiZF6tQtZU?=
 =?us-ascii?Q?0MeWoDdnaydzTzHxJo/xyD7tL/9O6vqXkL0yVqrUh4QBnE0xJFBUIbliFcRl?=
 =?us-ascii?Q?EHFQdq3rsDWTmsN3rDXvmWw9WVMfwPu55O16uHcESBuniy6dRTg1G75l05xI?=
 =?us-ascii?Q?ePr+faTXLMKvtHThWGWhW4O+LrtTiyI2z7+4M3Uy7X5kQw7k4hHdJChkR8jf?=
 =?us-ascii?Q?koGdmJ1lOHiIYdsn0HpfGXn5oWP2Q5WoaFQCPbXjP9nsM5bwkc0ojlug+TqH?=
 =?us-ascii?Q?vWN3LPwOgNPjjKM5frH3qS3qE+iKWdiKCMOBLHLu9+MZdYkDM0bgcLo/Oeu8?=
 =?us-ascii?Q?38H/2qMV7nOIvpgYSpRnyu3f7ktVpFL7zb+NQhrfgPa5Hn5241Ga8BK5612W?=
 =?us-ascii?Q?t7hVIkVpMwQfqsktZJsBVn3ck/Hj0AxOzsSWEOnAerKCLAnS7yYjn4tMRAiJ?=
 =?us-ascii?Q?O+YBPkSQd0B1WvzB4XWulSbi1qRFqkOBUnipcbQQykaRcLOLJvxs0DA+V6mp?=
 =?us-ascii?Q?aWgcekI7aF2byr8vJYI8O+heIH+GAZjR3CH4O8rMSpsxtKNohiwzpxugvWRc?=
 =?us-ascii?Q?SuNdV7+PS7bAVmiJN7eiNQidHjFvLU85isJyhv5hIGrzqm+4palvnXD+ZrVd?=
 =?us-ascii?Q?wJZ7GUQpnqyubdfGiroUszPca9qSIsnqEfrbE5zaei9+BvwXWtsv7DGerdWK?=
 =?us-ascii?Q?Z79SENYc0AD2zV/Dn4+I1TcSturvlldQmIAP0H5T7h7hjrnwxaeRPpp8+ubg?=
 =?us-ascii?Q?GR6MMW6zC5p9iYB0ti75CeVE3MghHkpDSIETI2qvKgrEQewKzTYUEEhmiGqw?=
 =?us-ascii?Q?IcyC7z/GTQ55ifEZUsIMUZ98RIDAWzo+rfAtsq5zrXOQeaFBDDLlefsreLBO?=
 =?us-ascii?Q?PkrwXi7gdwiaB7HcH3lt90qbcaqs0wm0dOdcZqDojRMpm1qHhYcV8ZnCoDOv?=
 =?us-ascii?Q?TJvKX5lX6TYSXsIrxbB3jTZataRaDDk/RBGQ7jmeNChDJQ/siGc9H6GLFYsh?=
 =?us-ascii?Q?d2mgOnM03kQ6cVow0rQFGI6q7wNXq4GBnpFYwFbIWYxFBIX+V2uVVtwY14n8?=
 =?us-ascii?Q?2xRLf9A7ysdJDgkTCNWhwmVoQJ7wvCAjrEgeFt/fRgtbcE3jZwEjxenpV3BJ?=
 =?us-ascii?Q?wiHTStu2p3xCafQyhrI9FM4GQombGTMIuwaTNhzrzOC8LPTiyDW9rF9UtXTr?=
 =?us-ascii?Q?TPvXMZ9b+TWVNM8FLdpDdvVfzU16f6Np+E1pMtQey6wVunWwt+dlm9jPV/Es?=
 =?us-ascii?Q?hLmg7C79EJcljRb41l7FETZllXPqG1Ih8UjnIzv5Og=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xHvrTEuvPvgy7Xh661kPkNT2LsVIWueiIGk+vG82Cx69JCh+Yg0SQNX8fIhM?=
 =?us-ascii?Q?y/dSRqfnRaEkWOPYlb4pUNbT7iZQMgWKfl+12VTnxovYgysaEjwUOAfqzsEZ?=
 =?us-ascii?Q?abHmhpPw09gUQMoRKB5IjJAuwq+QNfL65LuqtyApx4AWmt33dCKr/rgdTruo?=
 =?us-ascii?Q?xL8YJY4C8z9pEKCx4IfhoPefymZvqyid2xRk9elMNg3UkGaAYtxbO2TIIh11?=
 =?us-ascii?Q?Khx/+8RgOYuawMOYHxyiccW9wcuapAES8vKOW3nCYRUXuP6artBtpr4uOocm?=
 =?us-ascii?Q?G2GZLc6g589Wq3310+lSmj4BPVKI3e1Ai3AfJUKg3e498+9Acei1OerGsLcB?=
 =?us-ascii?Q?r/IXgWVsA32Da5AX6tekXVRzUvRbOg10ChxKTOQmaEYLfWqY8BxfdW/ZjaFt?=
 =?us-ascii?Q?GGbS5omivGz9qtjb5czuCg86YoF2RbBTN4Nd2uCWzBwH864kfe38L2p9qlXC?=
 =?us-ascii?Q?Me8VEI/gyzyP+JBVJgx/AB6asYCMTadAoMXWpQ4DbPIg0MPZpjjvFzm0djE2?=
 =?us-ascii?Q?L4jwhnVkM9TKLAl9FSFDMQMCM/WRoe2eQ1wTO2X9ylElJfjhPmetmu80Rf0a?=
 =?us-ascii?Q?Hb+C5ZkxrYjnV6zlg/VMDXWdtQLjV20gWvlonXaq/hzquTa4j7lO3+qIFOrV?=
 =?us-ascii?Q?YWVp8JF8iNnDorUflrPWliyGbgjM3Wjn81hz8Wi+eklJwj3+jl37gNhjJTzK?=
 =?us-ascii?Q?svpVfx0oPwX6Z0B3lyiBpiAHan+t/QeNGrZv7L9U4JZtsJhI0N4v93vCIP97?=
 =?us-ascii?Q?2jiU0XyeLdTrjwEZOwjrCcrtCJtXGDuPeN0T/u2ezszghqaaO0czCFsXHDjD?=
 =?us-ascii?Q?RDmSz+RKzkh5tNUv53OOHc9F0Hr+AbrAOm0KsZFtSfbotf+srmJsl5P7l9N4?=
 =?us-ascii?Q?5fW2I6WWFiNDvUCe73MLyLyr2d7yZDJMwYiyQo6+uc3+N2pV1ET+CFUcpqLP?=
 =?us-ascii?Q?4ZHRogEu944Te/JklGKs1y/IGxBJmAqRsCcFO0VcdVY4UxauaOpOo4CJQv9v?=
 =?us-ascii?Q?C+DdIBtqG6wERyoTCSSiTpcF9ggQdMo4fLM9sO1HUFlokQwRrQ52xW+b7NZv?=
 =?us-ascii?Q?9FuNpp3qp1qobd0XqEwjuA7SLLYkqvO7lmIU1AZ7FH12f45dgprwPBOy1nZL?=
 =?us-ascii?Q?bmeqMrfyJXekr79UDMpq1cE8ba+Tk3Jw8pri+ileMC5bv3A/ponTdZZMmE/2?=
 =?us-ascii?Q?/DyanftTCIFY3t5oAst7Nn+XJJZrvawgWA4pKpfORBmynxgsVC3vPtcq6j2p?=
 =?us-ascii?Q?YfFsHLruaikPM5sdr7qgvCIqWqDikiwf+MNf90BXLpYk6WptD7JO3VIolk/R?=
 =?us-ascii?Q?VuWDxpVYQUiLKQ4ZWihiXZ6mfF1FqjF2fb7QG0cg3m2kVZd861Jdbk056wIm?=
 =?us-ascii?Q?ouT387Hq6PwFQeWyRXcwNtk+IufaezB+6VW4xWJIN3q1UC8pYEckYxYe+II4?=
 =?us-ascii?Q?d+aVRztcsTv7ZZLiUaByzn9FonK/OX9g?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bc21a3-85b9-4058-c687-08de64c105f6
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:15:33.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8558

BETOP's BTP-KP50B and BTP-KP50C controller's wireless dongles are both
working as standard Xbox 360 controllers. Add USB device IDs for them to
xpad driver.

Both controllers can't work as Xbox controllers when using wired mode and
have different USB IDs.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 363d50949386..260dd41ea6e5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -360,6 +360,8 @@ static const struct xpad_device {
 	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
 	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Series X|S", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2064, "PowerA Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
@@ -562,6 +564,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x1a86),		/* Nanjing Qinheng Microelectronics (WCH) */
 	XPAD_XBOX360_VENDOR(0x1bad),		/* Harmonix Rock Band guitar and drums */
 	XPAD_XBOX360_VENDOR(0x1ee9),		/* ZOTAC Technology Limited */
+	XPAD_XBOX360_VENDOR(0x20bc),		/* BETOP wireless dongles */
 	XPAD_XBOX360_VENDOR(0x20d6),		/* PowerA controllers */
 	XPAD_XBOXONE_VENDOR(0x20d6),		/* PowerA controllers */
 	XPAD_XBOX360_VENDOR(0x2345),		/* Machenike Controllers */
-- 
2.43.0

