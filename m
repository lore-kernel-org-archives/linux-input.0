Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010022.outbound.protection.outlook.com [52.103.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2514346ADC;
	Sun, 30 Aug 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788095988; cv=fail; b=ceo3UEhSju5D89QEGTzU9nF3iWp5omiGAtsE76LsIBdxq4yTALAEBLKDygQx3N68Jwktyt1vEtAZP74G77GNImyMv6RgEH2rp7B9QBP9eQxIwSiORIYjiOOxyu9ovRvnuzyr1YTTfCQY7GxNIHsWCiJZLmM9sZrzIv5XtA+EmLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788095988; c=relaxed/simple;
	bh=zKHQo/4x6m1me1rtN4tV1rt/aqiP4uZUp4Vv/lPYR8w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ncyEhc4Oa23W3BW/I/G3/svJpXwjnM50Bu6nhxO5Nj+xBnQb0lEztxmlbQOy0do1kdL33zF6kEI1sq5Yk2NHn8ww82BBTQWWiUUPF1pGUUaf/u4CWbmrMmUcKRgVolI25BlMlaK+CVYPx2zbG7c/X0Ow64S9S+9LyvbM/WZneww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XA2lZzkL; arc=fail smtp.client-ip=52.103.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XA2lZzkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT5ZYjAmzUNqbtNzcnSRUh32vShHuUeVzhHRGlpStrSAiyB8HZ0bloWOTzCIytnHqJeWd204br6dv2sAC5k6VXkejEl4JuSF63SRpzpSiDGAgX00v+UFTX7f+naE84xHtfwm3ThOhc55Ql/6zSZCWjzm9izLDtNdQMBD8kCW9wYuykQqH5T8HD9nvQK5ZrS6HgiijxoEr06ju/mNo3Sw9Voy/5s8B+Lic+IROMZ+8OrMPH7Ja8qciA4HvOBF0XDW+btNI7VSc8z2dYoTE3X8vCwyF1SmOPxzEVDHZf+UDQn/CnINNB9TqgkPHaHV/182onetA/fef0yXNv7vU+dNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwZ4KJi5+/jTaRxsYh2DpPfP/2NizKFq1tmd4JGpw70=;
 b=l/Z6jgtDJDrH+p4DyvOgra60tQQE5ciu2WCcq+sRdoTzRO8Ws2BevhpAJeniAJk5iC9iGiDtWjYaCkVrsv6zzz2OQuNcA3wMbhin57RZn00DFmfvD96h+zt5cMmsbyoXlovZo2E3UskZxdBHQO4IhprYgyywLkdiO5M2xOuJXEXyUAc9Tem1Hz78W0DPvjS3YEp9rbnreWnJeGtQGmr9x++9PzEcJ3TUZ+VZZsPQh0vsrWMeBCEOMMSTPSMbfOWarWqFrJvSPaDi/NE6sjYNaiNH70gNdvRSmS5bs8c3d9OKOHOL1I1oYePKVd2I/yjQA99yd/paNEcz6Xyd1ASj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwZ4KJi5+/jTaRxsYh2DpPfP/2NizKFq1tmd4JGpw70=;
 b=XA2lZzkLZ/HditOCHijo/OJGKacyZOeSuLvUwDsoZdaBRGjQXtG9IUWCFrfhOnW35Q/vVN4tBEZlJyE4ZUiW8+DrAo5CcKZ2XQszXn6v1rm8siaAoZ+pdDTKu9NCB7jyafIC4UXlznd2igNEZIBL/DwILzsW3TbZ3NYijxZQ5A7SZlAmNBNZkcyAZxEf+sLnlTO4QGQv9wdAn/AOO66dIwv7PjMDE8ZLliJYnru2459iNZIzKLRy11Sye08WYa4XzbMd1AxDNgeXKBmB2asIoK+sr9vBuwTcyAkO/n4dhQOuPw0shPPmUpHMUOfh0Z9xBftCu64fxXe8l9XZdwx+4w==
Received: from OS7PR01MB11728.jpnprd01.prod.outlook.com (2603:1096:604:242::6)
 by TY1PR01MB10864.jpnprd01.prod.outlook.com (2603:1096:400:322::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 13:19:42 +0000
Received: from OS7PR01MB11728.jpnprd01.prod.outlook.com
 ([fe80::b92b:45d1:965e:b6fc]) by OS7PR01MB11728.jpnprd01.prod.outlook.com
 ([fe80::b92b:45d1:965e:b6fc%7]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 13:19:42 +0000
From: chenshuyang.cn@outlook.com
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	fombuena@outlook.com,
	chenshuyang <chenshuyang.cn@outlook.com>
Subject: [PATCH] HID: multitouch: Add required quirk for Synaptics 0xce4b device
Date: Sun, 30 Aug 2026 21:19:21 +0800
Message-ID:
 <OS7PR01MB11728B83FE23453EF8BC361BC80AA2@OS7PR01MB11728.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0002.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::7) To OS7PR01MB11728.jpnprd01.prod.outlook.com
 (2603:1096:604:242::6)
X-Microsoft-Original-Message-ID:
 <20260830131921.3874546-1-chenshuyang.cn@outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB11728:EE_|TY1PR01MB10864:EE_
X-MS-Office365-Filtering-Correlation-Id: b41493d6-57ee-44b2-5b0a-08df069959d6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|39105399006|23021999003|4140399003|25010399006|5072599009|5062599005|19110799012|24021099003|37011999003|8060799015|22141099003|3412199025|440099028|4302099013|1602099012|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLPvJyyo7Z0n20dpzHFEs+7dHvX0CtmLjDnKG4EzslidkJFU3/3uFOE+lOQA?=
 =?us-ascii?Q?6Tf3Ga+CRC6pJE8P6m9369nE8WME58ErFMYux1k9prxczZvh4Ebce0nFGWd9?=
 =?us-ascii?Q?Pwq8aCGFNAe8DUlluVfSMZ4oHT8aPoKGzXbVJyel1K+HRTXOhgIpIQPXJPyy?=
 =?us-ascii?Q?sefo3vJceuwHLre2Dc5Y9/Poi4TV9eyQyP4Gu+WLpxk9PIvhw4+kLgHRdHNw?=
 =?us-ascii?Q?LIioEgYFvh5xnvu5lSuFSF9iG4wWylOIjItDlZWapBuOSsdMdXsbaumuILB1?=
 =?us-ascii?Q?bTkajDykzEfQGUGQWCgcDURAcmFdrOZSt0GOjS2l9LL1dObIEQzbqdtlzDyD?=
 =?us-ascii?Q?t1+JCIugTxCvH4mKBZAj01Z5dIC/WfYpAx1R47DQ9PQM5YlmXpM2fTutmjbS?=
 =?us-ascii?Q?gg/cABYWfUDj9DGrcjPm6WQlaFWvSI9lPRKyz2B2oDMRB4dowrfH7kmHQObk?=
 =?us-ascii?Q?iaRXYQ/HySUGQDZaL6qSnUNarfq1PesTDgrohbifppuCZnA6PZxx/g0/6Aib?=
 =?us-ascii?Q?UhZ9WBlx1r9HnUcla4GozAM1F9Pc3wlmPpjxT/ds9SgM0YZghzsv6YL3oFW4?=
 =?us-ascii?Q?qC/mKQFPn38c++8Dlwus+nbhgAqgjN98kDaJmvFYa7jgA8sEjhG1giuzfLue?=
 =?us-ascii?Q?RsgQYnZDxd5Lw9d2Lgjwr8rqBncf1Lpal5WRYhAWAuChMCACsKfG2HhStuWb?=
 =?us-ascii?Q?Oo/b/pyEjRSnfbHsn5IPotlqIRlDfE0+5nf4mzekQvWyOyPFA9XJJA3Ez1hx?=
 =?us-ascii?Q?Yso2kPYArDYkiiUkV3TDjtql15+k/2Xe/ot9pXcniJKj0z2ARU3fCuqM7rRY?=
 =?us-ascii?Q?EwI4DfHZfQrpM3OUjSClSdWUanxAJFr4P5FTr+5nEq2iyM0ZbWV8MiZwruUT?=
 =?us-ascii?Q?u+pMn3GTYvnD/Z7GZ9wcg2FFJKWXwFXUz8qVvoOtroDFpo7yEG7zXL5Z+es5?=
 =?us-ascii?Q?eMrA2PxDrUSeECUEfD7U1NUVs1MPrgEve2JUQim64ASbfg8MNgKPGiFIYeJA?=
 =?us-ascii?Q?YDynNKc7PLje7+SNVGz8cbVXFHSxarJtNayO/KaG6z97+xHewi6L9wkZlrxu?=
 =?us-ascii?Q?MSKRkOQEWyZvwSvV45c6UF8q/Zwh6stOOxdskKWmRj0u/reJNsYO0FjNHwut?=
 =?us-ascii?Q?1dGMynL6RfIuYgNj1qzIIlgAajyLXKmPTQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PUgVcdYWuEK3G9hhXCz9GYgrxnpIizoi8w3Fae0KjXxAyFjH4L65jq7QQgMg?=
 =?us-ascii?Q?zEz6UAJVisS8ifYN0H+TS4Com2HGW6VJkj3pyXfnemH6N3ShTFdbgjDp55YJ?=
 =?us-ascii?Q?re0BY9WYKh4FdPhfjXVNhdPqFkm7AaMKNMBmhcfblSbKJuRAJZZlQy96UG0Q?=
 =?us-ascii?Q?jYrRDMzbJ/PT3oEOdzOdk9VdvEpay6Q9vP/HvvQt6r9Ns65bbDthieNL2PAk?=
 =?us-ascii?Q?wtdkwYh2u+T9UzphnbKD4hCCWa+YnV/OojW7o6zEHX8mVsauQV3GeKy5j+9s?=
 =?us-ascii?Q?EzUQI3isXXoj4SG90rZb/cstRjFMe4JFDyN3DQf6x782jyHSCTY6JoFNWTNR?=
 =?us-ascii?Q?nNB1UJHgE/dxiRd+aunCr0w5b5zhXybJlZRL7lC3s3PxNwdGuLVPjGLa81gT?=
 =?us-ascii?Q?GoKPccyfooRys5iSeCz+tp6nU+tq+jXUHu7SzP6GjQ34lWP3jCHo0a1RgEho?=
 =?us-ascii?Q?tZmrTBWC4xkRRhD7KqKIRuqvoBW3Ps5HfQyPAsnbiCgNF2LutzNqWeUR6BwS?=
 =?us-ascii?Q?k0HWrxhE0R37+dEPFD14ZQHA4dSDQRO16GVQoH6wRmF550oHAJ/9JZFm8DdM?=
 =?us-ascii?Q?2Ee4V3cd1/e/pGxCnpO3P/eXVMtbREOFSyi70+d5partzvRiXJkIo8zY7Aiq?=
 =?us-ascii?Q?kAb3yaUgldlefOOHtOBNPJ0TtyxE8XT5U3+hB2FqvSRDT8Ab9hcrk0IwDV9L?=
 =?us-ascii?Q?6GJPZzavRProoXpTqiqWoFdKvjmcRraxuqT8gWSXHjmFxJlIq5gdzDsAtNOF?=
 =?us-ascii?Q?P77y6o3+v3OY8ycWFV5Bv4M4yReKwvcvaRJeMn/YmXnyg3qNxEX1eE16/lFE?=
 =?us-ascii?Q?tF9YGZUR7eN7uJJdOblcUCI6r0O/eOqxX3cIkl2zsk3WJdSq1K4SVsknGo98?=
 =?us-ascii?Q?r/sT0SopGnyU/6SSN23QusVpWUBfA8mHb6uVaOXboo88YsJ5IhtFQeIH7ccT?=
 =?us-ascii?Q?bgunQXXhkq6/ly4xJyo3Pvm9KwoI7AAI5w7JcDo8Rx2oOXtedmMmG6lgMSqv?=
 =?us-ascii?Q?lCi11E/pVGH5Pm7oTiS/T7z561omMREWWBS7ErQ2aW9D/bY1zqdxURMhkH5K?=
 =?us-ascii?Q?6v+63TAuqava4/yngcDDEyBPRMj9Ibvq9JV6oLahgZgtxp4PESvz+FPM3yMo?=
 =?us-ascii?Q?CtZIhyAl5l1ipowYES/BfvktXrV6NUKaKuKxDX+albMs6L6q29B+8mF01BGB?=
 =?us-ascii?Q?5IT8ESOLU3QpLwBkiowA2EX4ECKrNWaRHq6jWYQ42KRNnyRzJZUhQ9CNbveT?=
 =?us-ascii?Q?cfUhZM3hPptYH4yYHtffLDbPMGymnjiQcgrFH/4BZJhP/50z6NN0w6EH6ZXb?=
 =?us-ascii?Q?UNFJyIIegwuMPeCqoYtidIx3h3gVtIX1u/g4YwGPaMu9nFH8/sO/aqAXi/cx?=
 =?us-ascii?Q?w/7PPrrASYw3E5G+L//jt8aOjs8MqreXV4WHti/kEcN14hNhnQqcFBZ/Nwj2?=
 =?us-ascii?Q?WvBKHW9IfEw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41493d6-57ee-44b2-5b0a-08df069959d6
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11728.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 13:19:42.6867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10864

From: chenshuyang <chenshuyang.cn@outlook.com>

The Synaptics 0xce4b is a touchpad + Accupoint pointing stick combo
found in the Dynabook Portege X40-J. The kernel enumerates it as two
input nodes ("06CB:CE4B Touchpad" and "06CB:CE4B Mouse"), but the
stick node never receives events: pushing the stick makes the device
generate a steady stream of I2C interrupts, so the firmware is
reporting data - the reports are just never forwarded to the stick
input node.

The device currently falls back to the default Win8 class, which
keeps HID_QUIRK_INPUT_PER_APP. That report routing does not work for
this hardware. The 0xcddc sibling found in some Toshiba/dynabook
Portege X30 and X40 models had the exact same problem, fixed by commit
1741a8269e1c ("HID: multitouch: Add required quirk for Synaptics 0xcddc device")
by switching to HID_QUIRK_MULTI_INPUT.

Add the same MT_CLS_WIN_8_FORCE_MULTI_INPUT quirk for 0xce4b.

Tested on a Dynabook Portege X40-J (PPH11A-09J002) with kernel v7.1.9:
with the quirk applied, the Accupoint moves the pointer, its three
buttons work, and touchpad movement and gestures behave as before.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205817
Signed-off-by: chenshuyang <chenshuyang.cn@outlook.com>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2c41bac..57e37e7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2620,6 +2620,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce09) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xce4b) },
+
 	/* TopSeed panels */
 	{ .driver_data = MT_CLS_TOPSEED,
 		MT_USB_DEVICE(USB_VENDOR_ID_TOPSEED2,
-- 
2.55.0

