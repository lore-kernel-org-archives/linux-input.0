Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010018.outbound.protection.outlook.com [52.103.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B474442FB7;
	Sat,  5 Sep 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603297; cv=fail; b=ZML8LBJMKoga1Un3T5ouWzm+GD+2pcHUJszwLLWvf49W49x93oClh01uQF/3aPc55lKnFUNt0v5hVbK3zaqJ3kuwDMkQgfmK+/L41jo04BOooAaVed5F8lHh17wXtAoP+uJ+TSjA9qg0h3aMgfwhyEFCfzX0qc8JpiAOWVnHhR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603297; c=relaxed/simple;
	bh=A+7TMOb+wb1vWI0exhVBrwDYV/RiNZKB6HQLl+0ZJ28=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VTg2Edvp5fonnbPVuYD6pEy9yCfIn7GyEQQaeE+Bk7QfdU08eGCqAewgsFrfLTG5UQvmX3gDroSlgBwk3hKmuoJhrWG/yuEMnzU/SolyC+SP2IM/3Vse/85njrslKjGy6HilgKtkFcnJNccqUJFEuOCr16I7SFWWHq8K+VxOWBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=fmlic+VS; arc=fail smtp.client-ip=52.103.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="fmlic+VS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSDQxm69jihtLVRuVlP5yPk2f7sYsDHM+sp0Jega8ZwvIoykQ6FXQP2+OEqI3DcxpevfblwcfCywEuwfiJwAw86NUxtgfPmKVMiYFD7M1DcF1ysTBMFsmcjvxhznqMm2zSa+Md9v8ZQlgoHKJDMlVQ6gMJAkqVuo8qWPzY4isf21td10SSQFEGGIL4Sj9snJ4mqpbF7nkSWdNg7EF9Y2YgHMbdtawDov5iuGEXW3ixE9D+7UZdwqyC9Lc4XtSUrVH9OujLBHgaIe9iKGra/IU0pBeih0l07JJfuWrnN3Wo99ed5FM2Daoqce77np4qETgRSjQ0kXKNnQ69jhLh4cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr5q2lvPD0PYk8sKqvq6fYx79Yk3O4PqsAYclFXi3V4=;
 b=cyZ/HZFuJOHuMTYNKzGzSqK+D+FfZl1luBIPIBDPg7qw0HLCb5ygAaG9RCT39YHBC90oNHWyrroJhJW8uGFcVOTchvOHTDQO9X/dNl6chVhFI6HmO1Nib0Dp3AJKIv0eNL7LiP3v3fQ71TeP539ACTr4gvw7bTOvf970aFOGbwlYEJXvABe1xecuOddWXp2/JGTVGMHdlZkj93BnvXiQkbALOOTzKFyr98rjAs/G33Rw/qPFVn0YA2mjluCcOFvxDMEhr1eVPSJssMz3SuTchWyndMhg6Hs06LVI1De/J0FaXG5loTQjQESD/OD2n2q9ACZmzrCQA0FA1AHTA1yPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mr5q2lvPD0PYk8sKqvq6fYx79Yk3O4PqsAYclFXi3V4=;
 b=fmlic+VSRO+DY08Bf/hP0t4GF0p3a2/DaS69ZOaDbPlk5VCftbmXDhcEXou3Mp7+CbClwM01GtVpDgWyy8Jym29khvTxN7nB+wniWMSyTEb7JHiBFN7U0HwS3WKLzFXZ+62zV/y4EvfMYhItVzWr241FQoVwmNqdcDyVBve2+e6P5JsvNravv0UtayPJbAhL6x5Zp/eFf6l9/ezVe09a7hbmL50+U3nKQHJokL9P3zcTWP9SD3OxfDjV9gJ1obg2ffOhVmgTVimr6nGzcOydm3VTmS4/h/xqahXibekp5iCLymzq6pwpSzgI4LJIUSo16XpUaBEtrVG0JZiWqXKL/w==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by DU4P251MB1095.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:55f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:14:51 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.007; Sat, 5 Sep 2026
 10:14:51 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] HID: wacom: validate GRAPHIRE_BT report length
Date: Sat,  5 Sep 2026 11:13:00 +0100
Message-ID:
 <AS8P251MB00012F559DCFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905101300.1075-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|DU4P251MB1095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e12800e-9d81-499b-3d89-08df0b368574
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|23021999003|22141099003|12121999013|15080799012|39105399006|25031999004|37011999003|24021099003|5062599005|4140399003|25010399006|5072599009|40105399003|2607281247196008|440099028|3412199025|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p1Day5ACnAZAo6LNf48FIRQfADDNEAT84SxcXSn65sJCTfmp670Temaeg4gc?=
 =?us-ascii?Q?sB5Acr6Z6vV2wdLRucG2EjbdIn6BBnLziZ+shRjrRpPFWdRmui6YX/DwU/pY?=
 =?us-ascii?Q?bfdDpsjDtiTMAgoQF4ePFVO6O4UDT/MFfTnEc/Q6Hfhi9I9GZYfAhxQ9NaTX?=
 =?us-ascii?Q?JgUqBu+FAIh+qGJjtprS3fpRskYzQAXpj6VVaarcggzGDya9ItQ7D7GSpjD+?=
 =?us-ascii?Q?1l+AmO1lGPdR/7HxIjY/qhxXE15nUNw6zv/z22PqnYGsv/u0akGoW9PJlWR2?=
 =?us-ascii?Q?sMrCRes3LL4xZijFAdhgakQL978auIznfd8hgen36rTCnLWXk5W5ZscCNMgP?=
 =?us-ascii?Q?ufU1uNjsxSMF4GzqdpqCNlKlmGl4IIquM5HHuWaxhZIlPUMEQ5Mn5/CERAUs?=
 =?us-ascii?Q?sfl/MaRa5OdQjEhe+rKFi9L+UhYapYBH5TG0WwIS7eSFvMPVNEBdp8ZjhSeI?=
 =?us-ascii?Q?J5iEso/2WQp/Z6cUFhzW+rp6tbCfES4tfjKhevc9qdFr0V+tZFuXW5Ar2TlJ?=
 =?us-ascii?Q?bhwsDOuY3jG6odYh7Is/CfX/AYpPcfWeaTwox0jeneFWF9KEMtU27towynSb?=
 =?us-ascii?Q?voOzBLfuBPkhEFPcD/cBoSieZQfLVR3l76NbD1j/1XHFihIJBXBiU2VjdnyV?=
 =?us-ascii?Q?Yi0Ibs6PftHlRn1cwMvLzwYfRlH+2P3Pi5tr3gyvbiEDnTlZcu12U7BnC9Wo?=
 =?us-ascii?Q?wdZ+r41/zOfyJLMx7CxHTu6oNqZwdr0Z8UOagNTxrvA0lLT7asZOBae9E1o6?=
 =?us-ascii?Q?eTan7jjMqFfnVAuyXPfH4ZPbIaS/SQZqB8khPfCLyxp9YatMtN8c9TuIWkxC?=
 =?us-ascii?Q?xiqxN0HmX+6DZSMpnuZ95DN0CdZmuvG9zLDcJQzKliJQnhg3gqNxMZkP6Hye?=
 =?us-ascii?Q?4ZBxgXSaod2IPrq13n+wDdocdOredcEjKWZ/Har2NC3IjW1sVSdcEdSU04UE?=
 =?us-ascii?Q?JI196nNSDyqd+a2n3yoRg6S/+iW8Ml9LnZI3D6ozh/H7T1L21cJ35cs5Iw4h?=
 =?us-ascii?Q?+QzMOjDv4GhFYaMBl2TpMcLe0Kjp2myuI8L+z8ihvSF1rwffDRJC3IhPrFVA?=
 =?us-ascii?Q?cjVzZaU3Ez34Dy6Xf1dHHx22jmiumay94fDBH1bw0j+N5K5HBjB5vJ58U/FZ?=
 =?us-ascii?Q?Nw6E9sbrvqLH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdgxtXku3akeUu3ql1xwzWobf3kS77vWHJTSrm+mI4zVy6FFAF1qE/ZxCsNH?=
 =?us-ascii?Q?+v0IHb89IRmcdmly5yiCvBX0TpHWV+o8s2iOZ5QMD55icBy7CpNZQ0K6EXFL?=
 =?us-ascii?Q?dljdIO6WQQnGC1Ug7LDYbWRATU6snuNKFSKNQgajysLhehtwu8Pm0ZIPstbI?=
 =?us-ascii?Q?kHh+AGmIBTwiiQCEfNNWD8jqR+Enq400FcHMfwuSPehqrtsr5HMMPhC9U770?=
 =?us-ascii?Q?Jn6MJkIfXEq3cepZWsjZwFV2mMP6slPHQeQwNTaXozPSIwWMReg7J08M8CgW?=
 =?us-ascii?Q?hX656O2qphDA/RNpvy5HOKMhFpR+5okPPYrCy+ee6zhRxuvupFiAugJZ7c5B?=
 =?us-ascii?Q?ggfkFUORVY1ODBhutRJIwjmpOCPMQtn5nPoz2IX0o9b0gegsq+2hEHkeUMi/?=
 =?us-ascii?Q?mK4D3Bs+G6wl6edp64aBt+A93JYzcBa+S4iLFCDWh7Ey95zvUSsq2PSA8pP9?=
 =?us-ascii?Q?Aoa8jzXKRgZ+rKGpqDa+A8nw1Pi2wSyXq2Q22oK3uuM82NaozCMfsGdGAqP0?=
 =?us-ascii?Q?dtgxbN+tehDZPEn78ZdSlN2Hl5Xmg5yrJ/jSDMnAO5fdm1vmTSm/sTlPhdrC?=
 =?us-ascii?Q?/RqUth7sJHT75JmYmxo7r9X4/5exIIyzLIHS/4lY7p2PEj3gwjo9nwRAcTY2?=
 =?us-ascii?Q?k3Ck2533bT2n8pti/c0azvUQfsH9oCI2MP7VEpiHkLdaeTlU46kGzbB9DMKT?=
 =?us-ascii?Q?vuXK5CQE9psIwzbIMeOM4J/q67uZHlh+GiEni570g5FCLWkGWapCuYuHPGlg?=
 =?us-ascii?Q?GmWqd3G9Q3TX3JWaNh573fqrLVWfgvR+pYEyjoR/XEW+RIf2aJhxLWTmMWIh?=
 =?us-ascii?Q?2zEblWT75ez7KSTj0VC84Myyo5oUgdcmb/upR7UaMnmgO7MJoRJFgXMpZULc?=
 =?us-ascii?Q?A6nkuo8PyOxR1IOfO5n+yyRFtaRBE31Zj0NjMPJB3xtV+CPG9sTYEc8ZTl1W?=
 =?us-ascii?Q?fXKmrAWVR5sDyNYiD3I0TjhcwxBnDa2FIdwFmBPA6trd+UJU+wO7zXMkzpZP?=
 =?us-ascii?Q?/Nmg3VxB5ZSaaECI3dEsatm7bs59VPJPVhb9Mhk55h68fzZe8EdQryADnAn5?=
 =?us-ascii?Q?drUB+mpgdnT+VPrf8lf4jAv4Ac2NmNxQU6B3R5DoJDE8Ies9MC1YbuRQs/lH?=
 =?us-ascii?Q?YC7NearEfoNc22oDJIlo/o38BNnP01nGRKgXh4Fe7+trB84bJkp5TXNTVEf6?=
 =?us-ascii?Q?Ieg1UrEGVrlvJMZDJNtecSsZ78FP6IGOjPWNTrzEsLj3PCPEz+m8Lnb2Fq//?=
 =?us-ascii?Q?fXCAE4SrPLhsedpMXRgSApShwmsV5LlAL7A6Wn3xcRnWhASSKglQYZ3MRlYU?=
 =?us-ascii?Q?eRBuv/5hLtFetmVtjQeM5V5xZpbs+yHlQKVMnDEf4vmzdDbvq5VrQmksO+dK?=
 =?us-ascii?Q?tNJlk1B1SBtp7Oq8b119m0T9UUA0CunfKQq7VXnV/v9jLqLuURgizbkcsHQq?=
 =?us-ascii?Q?WbYVmaFow+q2/QaeWzxUJdXzKt5Lb7yC?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e12800e-9d81-499b-3d89-08df0b368574
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:14:51.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P251MB1095

wacom_graphire_irq() parses GRAPHIRE_BT reports by dereferencing
wacom->data at fixed offsets up to data[7], guarded only by the
data[0] == WACOM_REPORT_PENABLED_BT report-id check. It never consults
the report length, and wacom_wac_irq() does not pass len down for this
device type.

A malformed, malfunctioning or spoofed Bluetooth Graphire (VID 0x056a,
PID 0x81) can send a report shorter than 8 bytes that still passes the
report-id check. The handler then reads past the received report and
forwards the bytes to userspace as ABS_X/ABS_Y/ABS_PRESSURE/ABS_MISC/
ABS_DISTANCE and battery state.

On the Bluetooth transports the backing buffer is large and fixed (hidp
copies into input_buf[HID_MAX_BUFFER_SIZE]; uhid uses UHID_DATA_MAX), so
this reads stale in-buffer bytes rather than overrunning the allocation.
It is the same missing-length-check class already fixed in the sibling
handlers wacom_intuos_bt_irq() (commit 2f1763f62909 ("HID: wacom: fix
out-of-bounds read in wacom_intuos_bt_irq")) and
wacom_intuos_pro2_bt_irq() (commit a8e04f3f894c ("HID: wacom: validate
report length in wacom_intuos_pro2_bt_irq")); the GRAPHIRE_BT handler was
not covered by those changes. The issue was found by LLM-assisted variant
analysis of those two fixes.

Pass the wire length to wacom_graphire_irq() and reject GRAPHIRE_BT
reports shorter than the furthest offset the parser dereferences.

Fixes: 387142bb8fcb ("Input: wacom - handle Graphire BT tablets in wacom.ko")
Assisted-by: LLM:opus-4.8
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---

Notes (not part of the changelog):
- Compile-tested on x86_64 with CONFIG_HID_WACOM=m; builds with no new
  warnings. No runtime reproducer: per the changelog, on the hidp/uhid
  transports this is a stale-buffer read, so KASAN is not expected to fire.
- Found by LLM-assisted variant analysis of the two sibling fixes cited
  above (see the Assisted-by tag).
 drivers/hid/wacom_wac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8feb8027be95..31da8b956607 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -338,7 +338,7 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
 	}
 }
 
-static int wacom_graphire_irq(struct wacom_wac *wacom)
+static int wacom_graphire_irq(struct wacom_wac *wacom, size_t len)
 {
 	struct wacom_features *features = &wacom->features;
 	unsigned char *data = wacom->data;
@@ -350,6 +350,12 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 	int retval = 0;
 
 	if (features->type == GRAPHIRE_BT) {
+		if (len < WACOM_PKGLEN_PENABLED) {
+			dev_warn(input->dev.parent,
+				 "Graphire BT report too short: %zu bytes\n",
+				 len);
+			goto exit;
+		}
 		if (data[0] != WACOM_REPORT_PENABLED_BT) {
 			dev_dbg(input->dev.parent,
 				"%s: received unknown report #%d\n", __func__,
@@ -3475,7 +3481,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case GRAPHIRE:
 	case GRAPHIRE_BT:
 	case WACOM_MO:
-		sync = wacom_graphire_irq(wacom_wac);
+		sync = wacom_graphire_irq(wacom_wac, len);
 		break;
 
 	case PTU:
-- 
2.53.0.windows.1

