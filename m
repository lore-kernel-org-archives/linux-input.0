Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.72.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795592178;
	b=YGUK5ipXSyqkcMrYILCzz+UFuMhfGD7j3PDJDKviIibeA9IdAdnQKSDaBXAcfwsUAibb
	 N27sCm4jj3/fgQh2OAB63rHJTSsJOQMeLHIvCM4gtY4ZFqpq6haoO+nOzP07JVsbau1GT
	 j9oged1Ml1KPkjZUaH3W7FdM90ZDX4i5xCVBe64KWsbdKV1sYpvlC2KhlfFV6fYCvZt0z
	 JB69tvYRmRvX/Ex1Nu0t3bCGy5h5NGDFNGdEgUD3Psd8ACCSAgJORJyJij2/HPuOrMn//
	 QixeB3C+uAZcznFGH/qjMjh+N57SfwkCq6+6cs/24jF4vSHFhAhQCMx2h3nWvLW9WcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592178;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JleQ7s3YyocF8B9RLUr9X9UF0GMCFl/dZd2bfITDJOM=;
	b=D9uj4yHaNY/oALkehrJm/WM8+5mt6Z+1v0wf1DPMzkIuS0Pq1O10ynn7MtoF/cgt9v7J
	 6iZnKg0aFL6ho2tBWMePdk3QxPLIxQSsyigE1tXOF1wBIBls29tBozYzkXgO3V7DBmFnt
	 UfMnFa4v9GMJv/D9uCcSjYwkgQ252R5KW/EBvHhW3m/TY1+n/BmLPRokasdbM51fb5z3K
	 EEmam+xMp8zON2xB9XvA+qkyA86KUBrYvP/Aha6ZkvC5LDr+v1n9Q3cavuteLn64EYDdr
	 CA3pjSQwpGdxfAPJ8hmOblT2/ynY0ZeHWRk3rk87+1NSor72JAlSLDN+FNk9NSkAJOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pjpMiReK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.72.56
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011056.outbound.protection.outlook.com [52.103.72.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39795606A31E;
	Wed, 25 Nov 2026 07:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39795606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=pjpMiReK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlR5isXnSe71ZRI1KGvtZ8BTxhE78CGkssZNilId6fssnBbM7QkVvf4kpHuvMqahcbqyVBVWtOzThTDhHjAdy1P65tXUmhNf+KFHHRqPmOJr3NMK2MLPZdDiYKdFa4ivPsNPCSVJUWcUMN54uv0QqdlXMRZUOUBObdvjGQBGWoHNs4v0HW5cF8kUGIPvWHyPVJ74uOmuUobbmC2AlQ77qoysP5C6EjOkS76+LgMD4eRkjG2+hMo2HoSU0NV8lw81fLiJDZM9EK0bcczQc3CptgmLMZdbRyo9AVINriwlbQTb41D25yl/U2ZDaWYI8KoWREzQRxZcJHfCJjkWc7+oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JleQ7s3YyocF8B9RLUr9X9UF0GMCFl/dZd2bfITDJOM=;
 b=UFi3QEdIh1AxjRxUJtOGySb9YyKTnOnKnu5QZd+8Wxm2GMIW71lXhtEYmgkdezEOD9YYRs10OBDtxUYUvnAlrgeiebiHU1Dx4E/nZy+wtMZQzwcxpmyLGdLUBTmy90d2SLhElsWpouwe8wzk6zoqw8NHA2X2UIMq8NLc2L4vqK2RyKJf7pq45h+WJEBX4kwwI/iTBZKW9rG+GjMcAxhQZkP3FhMtR/GwXz4rsSlPrA3k1PzhOr1IvZwf1IbwB5MbVEVE2iqVN2Z9f8eclh/Xi3/wqZn8f96LiOvV2K/MKtPlCaUDMQSnPdbxVao0yTcWiDKhksrRYThWY0zzoOEDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JleQ7s3YyocF8B9RLUr9X9UF0GMCFl/dZd2bfITDJOM=;
 b=pjpMiReKjs2bJOGKof6XoBznDwbGYddD9z+4E0PqrKQGx1vjNXBgHYvuvj+bXSWsQxBiZnBg3BZvNAuSskM5KqVC8kz8CFXPB4FZ4/C1Bq0sOJ0W2bkL6NN0zrlRdvJzPEAOyLhB3wswX8OIglcKvnb2lXdLblethMoBKsXvSVsTMLj9tn4Xs7FWE9zX4UV9xfe7NiyPJtxu3JGVqe8ikXjHfhuP4DcEn56QmYyBClqE/pk/o1J6rj+B1L2AmiFUgVh3MXg9Qn8oDYB322hUsmaKoK/7Hgmnr1b0CNz/54xEXWDtYDdKAl+iu4BWCCfRxFuEAZR/WlnCusR7nH3PLw==
Received: from SY8PR01MB9299.ausprd01.prod.outlook.com (2603:10c6:10:22e::6)
 by SY4PR01MB5547.ausprd01.prod.outlook.com (2603:10c6:10:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 07:36:13 +0000
Received: from SY8PR01MB9299.ausprd01.prod.outlook.com
 ([fe80::eef8:27e8:2765:92d3]) by SY8PR01MB9299.ausprd01.prod.outlook.com
 ([fe80::eef8:27e8:2765:92d3%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:36:13 +0000
From: Du Yijie <nathandu@outlook.com>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Du Yijie <nathandu@outlook.com>,
	linux-input@vger.kernel.org,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: playstation: ignore DualSense Bluetooth microphone reports
Date: Wed, 25 Nov 2026 15:34:55 +0800
Message-ID:
 <SY8PR01MB9299DCC08E94B1569D076B62D1432@SY8PR01MB9299.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0150.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::15) To SY8PR01MB9299.ausprd01.prod.outlook.com
 (2603:10c6:10:22e::6)
X-Microsoft-Original-Message-ID: <20261125073456.7153-2-nathandu@outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8PR01MB9299:EE_|SY4PR01MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e62a5be-55fe-4f5c-d6c3-08df4ac6c7e0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|24021099003|23021999003|15080799012|25010399006|51005399006|37011999003|12121999013|5072599009|5062599005|260925184616899003|41001999006|1602099012|10035399007|40105399003|4302099013|440099028|26104999009|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pulhz10vP5nmpIf3ZZPlo4J2tSbKbJS+HZiNhKseK2N7/qiq6kgEGXktgCH1?=
 =?us-ascii?Q?Xu80rT8A2WKToEkR34mHbZfw+TvlOw4mFHg/eM1coy8ZrrYuBW/9jmiSdIAJ?=
 =?us-ascii?Q?uFB3cWt/5m83wIQg6VpirnbqLGxzOY5kx1hANl7EtllV2p52n7VUw909NBwY?=
 =?us-ascii?Q?3FQh7aAOuCeyVRhqAdM+iocL3VCpho1I9u3zVjiJ0/gecj1h2Ut776fqvIUN?=
 =?us-ascii?Q?wLiaqIBTxzHAnM2PSwy6yk39tjIRvbvTYZbhHnvScDxOWooNwGrv1tX8BXai?=
 =?us-ascii?Q?c3reuSsa/XdH+4qZ2BZzEC2rWWejr+o32vWqJPM3Vgw19K9OP52D6fJXbM7d?=
 =?us-ascii?Q?T8jCQlAKbmhz8fIRYUjK4iXbhUktfZEdkWoHFAHr1STXxD0qHHLIqZrqrKL0?=
 =?us-ascii?Q?oxePUKYj83JXajAd58JgVFusEAUZWDO3KBxIP23HRbX3HzSPKfV/lG0iXNc3?=
 =?us-ascii?Q?V11BUzs4x/AKzUwdyhc0mWGnbQ+qVaWs4NamH9fsoOb6YaaoW4wwqBJoDGHr?=
 =?us-ascii?Q?0+p/I6pcg2uMQSB8Qdo/YGTHbm2t9ub0k7Qzxshh0CFaH0qfwPXbM/Und4vo?=
 =?us-ascii?Q?Q2BbVMEDl4PN5DPJzxnKQ2qd4KANkNIMxuN66ZwhLOOcFQCfAxgq2uvb9cXx?=
 =?us-ascii?Q?ZMuBhp58ggJmFarQdCJD+J7CkzQ5ozbTOPsnWQIZ9cOJtPfj1UfWxp5Affw/?=
 =?us-ascii?Q?OCeCXQkIQ+bENeC9AH1D9oZ2xULbRMdZeMsFQ96TNg6VinaHvPTpYA94Q5WI?=
 =?us-ascii?Q?hVbt+Ph/erj1IBSvPRf1SlQW2bvQzqzUIb7gIo7gdqvR3HNcE3BrGoJULKMi?=
 =?us-ascii?Q?SK+Gu+7vfa+8UZBhNVc9BF8xl6WJix4ad/jyXUr+uryZSR0Q/yvLJNWWYpzo?=
 =?us-ascii?Q?ROylqlx4aSN8FvR1ipcenMgLEX0s7Z29IpnhFpixfROZpCTL2Us4q/Gb7gSj?=
 =?us-ascii?Q?ntjUcBr6LWbjUiwd6aul0qGI/sbbtLcgvayAFi94lmuQV4wiZvIAgh9Q9/+7?=
 =?us-ascii?Q?6lCcTRbhQMqeOfPqOfBWNsIOyUHbTvVp/PJcLMYevsaWq2FtkcTRQ34l5u9X?=
 =?us-ascii?Q?+jjDx73r2nxtptSk7D2KUKU/IvxG6xAbPcGnIgMzufAC5KuPsbQTaoiwvwtn?=
 =?us-ascii?Q?dL2riyV8Lt03?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFR42XymPbcQkEaVo4BgWC52cgYwUw7TCELzeYzCKZ73g+a8qbh4MGzAkYjH?=
 =?us-ascii?Q?hk8QgWT+6bFpwsYXaYMlTUF12Fwutau0/3O0ZtHeSOtr/S2Xt5sNaUTk4Dz9?=
 =?us-ascii?Q?GVxnZGZEfO2hp6NpXCfw/gZ4zdqObvdrZilRFvI2USsZyLrRzSPCrX2TwPLJ?=
 =?us-ascii?Q?mrSB+b/HWi4nibgUyvtD3UhWMf/dbTixswi3nVtkXw6/qMpc5UWvEoRB16Zf?=
 =?us-ascii?Q?sYAE+gL0OTHGnxNRtwbYoae1UGPdjZLx9Z+R3AtEOlGnchBxR9+JL6HKgbcj?=
 =?us-ascii?Q?pC12YNmOc3b69XoY876S8tuXVHM9IQnN2oMVgA47beSdHVIaPlSfdOzhZzqf?=
 =?us-ascii?Q?cIbiZVBRM28KnK8NAFGLv9RqHII3CTA1Unz13LUHsT+0ig3hZFlFoQS/7nvn?=
 =?us-ascii?Q?pMOHeKjfDbSsPGFhJ0r8txRPqGi5d97DIDw0c80VA/tpSItHGLQcfmVdeWEF?=
 =?us-ascii?Q?aHeUjWvUdJyG/UKk9ITMEabzSGoAUvNa/FiRiNxSKoepow+mORe2Gzj3lFMH?=
 =?us-ascii?Q?943BHbWJ9GiLKQA/s8uvgIeF3T7Vb8iHAjPacX3ZWN5jyj6bQJ8aElMOVY/W?=
 =?us-ascii?Q?mmASXValCWD9LcwVzCqFw3F/hkn1uh4+xP1fCeU8L0gxSC6MpAsqSUnstgta?=
 =?us-ascii?Q?kf8rM4ti/7cr8I3mEVtD7L6E996dm59GPXxCVcDO0JbG/VbZGoNRFsgMhqI6?=
 =?us-ascii?Q?VJHm0GReyxUMZp9DmEQcD04nUUCxf7XRUB1Un94NwX9LtsjRKfVBHNiWlpTO?=
 =?us-ascii?Q?QufXB2VIwQcbZCh7cUtv1duLI/6r/T5WWsUMReL+x5AXHWxTOjpysgebTh8u?=
 =?us-ascii?Q?xn564F2LR9wyR5OoEtEuETMj/cR41v+I+OiQyZOEI79HcsX00dmyW3alIvPA?=
 =?us-ascii?Q?CL9I9fU7RVeJRTUzXY6Mr8vbwfo95g0dknleH4j4303MRotNHa5AYYjtKaI1?=
 =?us-ascii?Q?Ow84nkMKdEij5I7NWC2vdSsdRrf2KhcTZBDAkyYimYe45LTr02i1BauIYt2N?=
 =?us-ascii?Q?qn1mbQO2ijqbwSN51btnAkvyMb6ttUK8OVE2GZ4kmD0kpHurYQr5FebkgJoU?=
 =?us-ascii?Q?3sWkUv5l9FWUyfX7VJ4PZTnyzFK3YcJCBHA0V9bKVehXwEbW5kojWhl0rV2O?=
 =?us-ascii?Q?M2kO3+ud7SAo9O2stQRKKwA760vilZ9YEfxOsep9ruwdyKRohf8MKvX3VV2U?=
 =?us-ascii?Q?5MhlHDBGw7u9+3O+JRSN0thz6miocfDcHPfshkuRpWK68omotCIFoixLkwfG?=
 =?us-ascii?Q?3F6B0xcGClDSkeJPY7prtGXC4r/PDQN7xWyjNDuyFE1GZGcsrod6dwhNHVR0?=
 =?us-ascii?Q?fU3fFztDek2HqDBxlbYPRIboSfQc0/+35JiyxVXTdypMduSqbMfhpypWz/gO?=
 =?us-ascii?Q?3x+raUdPL3iOzpeC2L7jn5AOLaT6tXXzbSWl4ZBLzhJvlJrKp27Rg+rcMm3Q?=
 =?us-ascii?Q?8828PE09TTp6Ocbs1TSIfxo+FCkyrGKW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e62a5be-55fe-4f5c-d6c3-08df4ac6c7e0
X-MS-Exchange-CrossTenant-AuthSource: SY8PR01MB9299.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:36:13.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB5547

If userspace enables microphone reports from a DualSense connected
via Bluetooth, by sending a specific output report through hidraw,
hid-playstation will misinterpret the microphone data as regular
input reports, resulting in spurious events.

Check the byte after report ID, which contains information necessary
to distinguish the typical HID input report from other stuff like mic
data, before parsing. If the byte indicates anything other than the
typical HID input report, do not parse it. If the report looks like
mic data, silently ignore it, otherwise report an error.

Link: https://bugzilla.redhat.com/attachment.cgi?id=2161437
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2554570
Fixes: 799b2b533a29 ("HID: playstation: add DualSense Bluetooth support.")
Signed-off-by: Du Yijie <nathandu@outlook.com>
---
Changes in v2:
- Rename a few local variables and macros per maintainer suggestion
- Link to v1: https://lore.kernel.org/all/SY8PR01MB9299F0BA16B832F89BC6A4EDD1612@SY8PR01MB9299.ausprd01.prod.outlook.com/
---

 drivers/hid/hid-playstation.c | 50 ++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 143eb891e4a1..0e6a891bfcf6 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -94,6 +94,12 @@ struct ps_led_info {
 #define DS_FEATURE_REPORT_FIRMWARE_INFO		0x20
 #define DS_FEATURE_REPORT_FIRMWARE_INFO_SIZE	64
 
+#define DS_INPUT_SEQ_TAG	GENMASK(3, 0)
+#define DS_INPUT_SEQ_NO		GENMASK(7, 4)
+
+#define DS_INPUT_TAG_INPUT	1
+#define DS_INPUT_TAG_MIC	2
+
 /* Button masks for DualSense input report. */
 #define DS_BUTTONS0_HAT_SWITCH	GENMASK(3, 0)
 #define DS_BUTTONS0_SQUARE	BIT(4)
@@ -242,7 +248,7 @@ struct dualsense_touch_point {
 static_assert(sizeof(struct dualsense_touch_point) == 4);
 
 /* Main DualSense input report excluding any BT/USB specific headers. */
-struct dualsense_input_report {
+struct dualsense_input_report_common {
 	u8 x, y;
 	u8 rx, ry;
 	u8 z, rz;
@@ -264,7 +270,22 @@ struct dualsense_input_report {
 	u8 reserved4[8];
 } __packed;
 /* Common input report size shared equals the size of the USB report minus 1 byte for ReportID. */
-static_assert(sizeof(struct dualsense_input_report) == DS_INPUT_REPORT_USB_SIZE - 1);
+static_assert(sizeof(struct dualsense_input_report_common) == DS_INPUT_REPORT_USB_SIZE - 1);
+
+struct dualsense_input_report_usb {
+	u8 report_id; /* 0x01 */
+	struct dualsense_input_report_common common;
+} __packed;
+static_assert(sizeof(struct dualsense_input_report_usb) == DS_INPUT_REPORT_USB_SIZE);
+
+struct dualsense_input_report_bt {
+	u8 report_id; /* 0x31 */
+	u8 seq_tag;
+	struct dualsense_input_report_common common;
+	u8 reserved[9];
+	__le32 crc32;
+} __packed;
+static_assert(sizeof(struct dualsense_input_report_bt) == DS_INPUT_REPORT_BT_SIZE);
 
 /* Common data between DualSense BT/USB main output report. */
 struct dualsense_output_report_common {
@@ -1438,7 +1459,9 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 {
 	struct hid_device *hdev = ps_dev->hdev;
 	struct dualsense *ds = container_of(ps_dev, struct dualsense, base);
-	struct dualsense_input_report *ds_report;
+	struct dualsense_input_report_common *ds_report;
+	struct dualsense_input_report_bt *ds_report_bt;
+	struct dualsense_input_report_usb *ds_report_usb;
 	u8 battery_data, battery_capacity, charging_status, value;
 	int battery_status;
 	u32 sensor_timestamp;
@@ -1452,18 +1475,31 @@ static int dualsense_parse_report(struct ps_device *ps_dev, struct hid_report *r
 	 */
 	if (hdev->bus == BUS_USB && report->id == DS_INPUT_REPORT_USB &&
 	    size == DS_INPUT_REPORT_USB_SIZE) {
-		ds_report = (struct dualsense_input_report *)&data[1];
+		ds_report_usb = (struct dualsense_input_report_usb *)data;
+		ds_report = &ds_report_usb->common;
 	} else if (hdev->bus == BUS_BLUETOOTH && report->id == DS_INPUT_REPORT_BT &&
 		   size == DS_INPUT_REPORT_BT_SIZE) {
-		/* Last 4 bytes of input report contain crc32 */
-		u32 report_crc = get_unaligned_le32(&data[size - 4]);
+		ds_report_bt = (struct dualsense_input_report_bt *)data;
+		u32 report_crc = le32_to_cpu(ds_report_bt->crc32);
 
 		if (!ps_check_crc32(PS_INPUT_CRC32_SEED, data, size - 4, report_crc)) {
 			hid_err(hdev, "DualSense input CRC's check failed\n");
 			return -EILSEQ;
 		}
 
-		ds_report = (struct dualsense_input_report *)&data[2];
+		unsigned int tag = FIELD_GET(DS_INPUT_SEQ_TAG, ds_report_bt->seq_tag);
+
+		if (tag == DS_INPUT_TAG_MIC) {
+			/* Microphone reports are silently ignored. */
+			return 0;
+		}
+
+		if (tag != DS_INPUT_TAG_INPUT) {
+			hid_err(hdev, "Unknown tag=%d\n", tag);
+			return -1;
+		}
+
+		ds_report = &ds_report_bt->common;
 	} else {
 		hid_err(hdev, "Unhandled reportID=%d\n", report->id);
 		return -1;

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.56.1

