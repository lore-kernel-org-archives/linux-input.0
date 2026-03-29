Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011010.outbound.protection.outlook.com [52.103.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712451E505;
	Sun, 29 Mar 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807022; cv=fail; b=DkgcWs1vgm7tfShnRbMSwBpqkocv7UgFfRFStBe/ZyK7jwosXV2JHbAqK2dlGpnSNY+E017u3Ttd706e8wNKhPcbcKFcNN5wXX9yaPNbG+i7Q9/20do1LxXyGURHY0Jf5x8RTlYdgKsxBAdiDvPbXR7FE9P3zynJ0s42uxNQyrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807022; c=relaxed/simple;
	bh=v+4Dw/Wx84fdCyIXSpZBvsKgRudlVSeIZ1r/vGiaBXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BDKuk4q/rwJxWiDbr2enzHslsvJfUbIuwNFEMsIByRYJ0c5f6EY0IfRpiU77Ck45+qjZs3UHyiZYyGV3qngcjo17GsFnubmlqfibsDeGltXD+m9QrWc5aLjaoKGIfL7+lTQHQsh/dqEilsmZ5BEZBhoTaSOFNHjVt7s7m9tqma0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jfd7uObB; arc=fail smtp.client-ip=52.103.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jfd7uObB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwbyyVydwHNe4jSH4/nkJwXMkZBGN8DpVefTKZBFWx8Eqt7CbyIrSuwlenLSjtA8zGuScr5sIf22G0YUGiWXPYnCGeiR7bqAaEgch8A892nIqHD6bR1Z+i+f7nEZAjRDB9xRJcOpvAnob8rx4cKaUDtPfuJ38cr8wqETZpRCLt1zQP1uOqQK9lE9uLoH7L/lnuXyeLZ2DPQmDL7QHIL0O9766R7sOmJE4seVD5uE1yNF3nkAD6YncUhH1PncZM0LMLyd/DHq1OgD+KG9sT57rAkIEF5YCxPf5ooY2Vq9uR/Cw4jM4WxxMpr1X01Dn5phjgz10c5B2s0MpF6ISllZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tXcgDqSYY8Ka7FJteWoiSfpBCoXZJkGL5ZaTuuGFXA=;
 b=n+gI7githC1Q3l8CJrSeIiHafmjjpHVoXDzEPrCCkCvUvjrLTbSZvBQAVO3p7VtG+mwRs0tO3ai/wvpQU9q5oam9CBFCoh0UINzbCtaxAhoMYarMjk75/BqMdjP1nn82vS6FRUdRIXhudm18ogVoeum2NRFUjM+AoEeoIEtXBC6YQhMuI1wuX3LWcUbuFmxaWhX+TsZrQ/TOYa+nB8AUeyonWpY4sq4OVBe/+LeDkPpEZdNjHUrFnmMXmArSKqGJczbbJ7TtXZyfEXultsSZnOfuhr/qU9ssfR2LAb03oB0MJw5efOA/uy/NnOmWz1STsW0v52573CKh5fFiYHMDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tXcgDqSYY8Ka7FJteWoiSfpBCoXZJkGL5ZaTuuGFXA=;
 b=jfd7uObB8xTWh2/0JHSpuUwFug711m2CR1nH+66tN6i6J/Uwaj3ylGMxceFjWGT1pNFU7JG3ggztFqe7whcJLk4zGs12Wy6m4SsDIh3+8Add9CEgh9FaexhCP521uF5jnGx1lT40bnUksfAjLnbZrpcuZAVXrf1WyE9QvycicmycNvRHGaBvmwZUviOBnR8jmDEIHUxzjjnPau++Ynw27IKQrnVY4DjzT98AWNjW4rN/7u7NcXmzzzKSjMBpJ9V6jkiqh1PWwrub/LfB1mds/PE7NkrXHf+oL6a1v4/tsfo5LErRgaGJWIap6pQkw7ucDykgZw4Rb08VFDj3dmeCOg==
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10) by TY3PR01MB9951.jpnprd01.prod.outlook.com
 (2603:1096:400:1dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Sun, 29 Mar
 2026 17:56:58 +0000
Received: from TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2]) by TY4PR01MB14432.jpnprd01.prod.outlook.com
 ([fe80::de2b:6c81:9bd7:99c2%6]) with mapi id 15.20.9745.027; Sun, 29 Mar 2026
 17:56:58 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: dmitry.torokhov@gmail.com,
	vi@endrift.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH RESEND] input: xpad: Add support for BETOP BTP-KP50B/C controller's wireless mode
Date: Mon, 30 Mar 2026 01:56:49 +0800
Message-ID:
 <TY4PR01MB14432B4B298EA186E5F86C46B9855A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0152.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::11) To TY4PR01MB14432.jpnprd01.prod.outlook.com
 (2603:1096:405:235::10)
X-Microsoft-Original-Message-ID: <20260329175649.84015-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB14432:EE_|TY3PR01MB9951:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f05e22c-5909-47d8-350e-08de8dbc90a0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|23021999003|8022599003|19110799012|8060799015|5072599009|5062599005|440099028|3412199025|26104999006|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3iLVlVwOVGULoqDxElSb6wIqTSo6tjnYW0Io1VCB4yvUSxy6AP4UnwPifdLO?=
 =?us-ascii?Q?0oplmDkhkGaVKpnHpThW7vEL69KLBBJKAB1Lr2XCwO4NSVuH5FKA5QkvPSQ9?=
 =?us-ascii?Q?hY5geBv1O9wLCsn3K0fK6C/cEmycmauz97QEI9BMk7pGxsXtScXMHDAbNOK0?=
 =?us-ascii?Q?acGJM6dahWrVSZg2fvAcb4leDbfaH56B1P++dfvWAYZn59X1W1dqnu4duPSd?=
 =?us-ascii?Q?nlWcFxja3VDY1UCmEzypCq6cunG/3+9qAzB4uKa+u7RLZPksYXS8xkVI270F?=
 =?us-ascii?Q?cUnjTgWIXSMUP3Ls9rAl6lqBVmqY+alD11td4lPOaBt+PNcVoJknrmTC3Rn7?=
 =?us-ascii?Q?O1IQkpRNIBCnehe6ThwMhQMbR5b6ebq0HXdfg7mzXHz68vWQqJWQCVcx2KI1?=
 =?us-ascii?Q?HwPfiEBbxBvOuogYQHHK6rUe65v/GwxQq/RTxQmT6T8osOYnA/79qs5ZApCs?=
 =?us-ascii?Q?OX1cMte1C4VDqTGk3AXbqCQv9Sv4LP2XBsPcSGxxj7X0sRU4A+cMph6UWMab?=
 =?us-ascii?Q?qUs/kGF5SKNSSJu6qRFxUO3VAbimkwIcZf9qhg7ghmAcGF8BlylJMd2cSJcc?=
 =?us-ascii?Q?1S9lG06uInbiSUf/ugLj+77qyg/MSoWoAZSSslNuc76+I+EYQLZgBPRALu/G?=
 =?us-ascii?Q?EHmdxbM461RqOxQKNR3EORSJRmQpw95zmfbPCU4XzcqFrDY4VOXhzV3Ald3h?=
 =?us-ascii?Q?aHdjkxDGYj8GfHynRuaVUx87QT08mVUxN90x8p2RqwGICkhELNcZJKxBkrYq?=
 =?us-ascii?Q?aJHvwzyTwSVQOYOopDepTaG9X14qLkNkmIBw7PSauP7q0qrwuyYlbVVikjCq?=
 =?us-ascii?Q?Tfii5uK9drDrq9b6m2JNy0iMZBiQaOGzwAapCX0tcMQRK9Yvw/gCXJyPlSCW?=
 =?us-ascii?Q?QLsp3x93bCUpafw/0JXEBQM883h4KPER0QSlAJFYwzlhcgiz/WW5quJn+wGV?=
 =?us-ascii?Q?IiEHHnd+K5Ao8JlkViPVQg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?if1hhP6HGf39anZ6iRdJAqcduCdOkJR++NwJEGHsXchLeMKdazCf20g0aEWQ?=
 =?us-ascii?Q?8hCpvvn3vEZD97kDhM6o1pTab0k+bbmX5FRDnJ/YD+/H9npW7Gf91prfq6Op?=
 =?us-ascii?Q?8NusTUxxpk5l2mVFrISQ/Lw/kFXhc3MbZ0ovRNE0zlZIuQ10K3M+3umh7A2P?=
 =?us-ascii?Q?n+5BonGId5bDOp3BVmUH2cWKFmb8I1OPlfeewODHo4iQYegA3a3Hbr66Xa9X?=
 =?us-ascii?Q?mgON2g9mYZGY7U/KKpG0WMwM64SZp3WXW94B8n37qwQyEHuI3vzeSFU6T/qe?=
 =?us-ascii?Q?D0tIVM06zq688/zcVgkESk5FHVGOI5S/Aa3aXcQd+dSKGvglce8X4ZaJAjSM?=
 =?us-ascii?Q?FsoPMgcDl/aBharzSml8AtRSkA83nNDgudDV6WgzMM6p7Jp8Z7/3YKll5kGB?=
 =?us-ascii?Q?byho1dJSWy7SnLQ00djA6X09+cvIk7UDVNAZ0dWn3HPd04OuZurFiaV6R14Z?=
 =?us-ascii?Q?m/LEn6FWy0KF1ql/eO4ZY3qch2sJSTijgxRJVd5wpEOaRcPN3L1xA0jdyjaC?=
 =?us-ascii?Q?uN65iPPd1U1YurTeNwWPAYhWymLEKxfjrF2jW1OoMHjUMA0qnTdtwfqPVBgS?=
 =?us-ascii?Q?NDJ4sXSfaOSUW5tbICyn9ITCK8vgDhesDNcZrBndi1d0TnqQQaktk7UJRF74?=
 =?us-ascii?Q?9vAfL21kDWxL1Pbv1YuuSffPPg+I+PUqN5xLkd2mFto81vOELARceFus6tld?=
 =?us-ascii?Q?2D/xH9Ksw335jeYJXMBhqzo4erZbZw50ddGXEdQFJIo7DLGxOuVPR6Tn1xyU?=
 =?us-ascii?Q?ZO6f/6nScKdpYNml74hA6nQKBwjuqj81z9nKvg/620bVU5QrZG7v1p1u+1Av?=
 =?us-ascii?Q?0qs7YN3xuBOWKkZvv6XVL7HKpR8kEF57LDn8NdN9pM9MdvEIssbcQFBOFftM?=
 =?us-ascii?Q?f5xFFZMfhaYvrV3Qt4cVFiXgDFiTXZmakE1MX/838TODGn4NsnOOpAz9/MaN?=
 =?us-ascii?Q?JzarnOzNw20dmencwwdANKmZmDX/qqH6loBhp/lEWjjOl7T/aTYiczl3tnuR?=
 =?us-ascii?Q?DLuwSmdHHuHKjeuqV8zSdVKpbHywqs6JhYGBlhIFV9NDp1v97ZeqNa6m3uJp?=
 =?us-ascii?Q?Q3+CftKR1/G9jDWymBUBN2uw1aoElrfBNe1yzLK0uXJyXX/sCI8iFgTgQQbM?=
 =?us-ascii?Q?EFCMgcQ/K+XYMLdKgqNY4V1hGd++KPo4mj8vB/FIbz4Y2HQvilZvp/C+rlrs?=
 =?us-ascii?Q?qciR4wk7ZY+M9urG221hgnLslCfn7yJqe0yK5aYjTEZDx2Ht03frn56JRN3p?=
 =?us-ascii?Q?bNPdYbH/2RYATaZRZ9t5CYCVw6+TTqsBFwJnPOYtoimcwEj+JoOdb9LzUF+i?=
 =?us-ascii?Q?qsewfAVghnAj1heb7uD0Dklt7xf3GKdcw16M/NWxlhcIwihZB0H2JxmhRq5I?=
 =?us-ascii?Q?GG9mQjQY0q4G/HLWIr5O0hoCpGet1fW/IyRaDVYPIHVQ+FNzBnsx7RcYSMlU?=
 =?us-ascii?Q?Pot0bf0fIvXsRWPH/2DpE9aal/acrQHL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f05e22c-5909-47d8-350e-08de8dbc90a0
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB14432.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 17:56:57.7400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9951

BETOP's BTP-KP50B and BTP-KP50C controller's wireless dongles are both
working as standard Xbox 360 controllers. Add USB device IDs for them to
xpad driver.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index bf4accf3f581b..4eb85fa933f4b 100644
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
2.53.0

