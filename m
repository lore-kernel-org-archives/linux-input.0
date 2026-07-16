Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058843BF698;
	Thu, 16 Jul 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188418; cv=fail; b=SyjFYXSt/jOSas00mc2e3VdCnZlrPs1ycZKrDWizpAEvRPz5jY8+swxQnudYoF73CL0xik8aDkkaMmrViQrLTkCj5I8lDz1jejCuxeg4w+YcBGrnROJZBiiWDnxYCEFiP8erOm+bMNr1bKZlcG1pfirr850T1SwTArHWHi9MJ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188418; c=relaxed/simple;
	bh=AbZiQSotNLnM9VPl8NsH+RSaACinojKOwJaygwv/Xp0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KqJMKe/o9LN4VK1wLNyfzzsQZMsXcZxagBieXtKKzJQ2viCefV9FmFQBM4DHhbStlOVwfdKzQ4GhXdlf6C+CHGYtq0U4/PsMuo3vvRIhJ7mWMT7VIl57+zK+u8AbYwKa6SzrEa3MJIKzdtCfSoahPil3l21vtUwncKPCXgkkXIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qpYipxYj; arc=fail smtp.client-ip=40.107.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qpYipxYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1lYTEPQ6XIHNBSo/9+/wudcJqw8kLqJ5jdP1RQURzx1ZIhKXiWBw716M4nZ0i19Di2r/23pWBStsfn1/9v4Zyh1IEnH1/L/mKu/0ZSZ10rekz5AT1sq1YLPD+6qjQmw7NHqbw5grvQ/H5ezrRH2jHC8zwBH2N7l9qCjqk+WovdpzNWMIfo2thYeNV4sZWF6RO4Ieo4Topqq4IlIi/6b8TcjX9mpoMPdoW/My32xCiiBRyCSujQvWdD7waO/u+6bk9H66oOvko+gNStdkawT4g2/rR67gLCNe7/7Yb6GCHKUdVMxL9o9s6DhM7s1/U/0Sx+LFvGJFFZsWSx3gStu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCwb5SPdXApF7/+ig261f6D977/m8+2ACnjvAZisoak=;
 b=c3uAX0wdcEnb3ucm0VeIgiX6O9uggkmHSKRo7nXc4NIx6DGhRoACbPwGWivMpRFuJkWpxBXinT1smX3doDOpk4/xshtdZXxFw4Gf0NzgCkpE1BzjObTax1WkhXf0trgr8tsDOQjl6+j7nfhvx3V5zQnGOwu1okz16AF9IToc9NuzN3pt1XAE4aLlV+mmK1zAzyDit19iRKAK0qwP+qpOePZcYJaXMrd+W+EklDfFLegDl3M2wsEhGhgO4ncOBDFr6CW+bppdgOXWEcr3O2tb87RVMfE8XT+aQA7roMPJhiOeLuc0JuH9KC9uNP9ePB+MDIgitAE55F17XIAjfzUVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCwb5SPdXApF7/+ig261f6D977/m8+2ACnjvAZisoak=;
 b=qpYipxYjMoJD4XYiQoWOoc7s8irK2OWkjTfci2oRjZ8ghEBo5za19fN+qaP1NJMGncelILhbYNn2UTXcQ/tY6InIY+TGx2wVH2FULwVPV0UCKNf2UAnbE8Lvxoyv+MASokxhU3T5mB/PrBYDW6BjJqgR8ewxKH0DVIou9dTtUZ2TI8vxJmdP25JUWnlLvMVE7KTzdVrOjEmHjyi9QFaOGdWqBXy6SEwQcuO1wKFdpJl4DWuV4Qvri+jwoqLsd94zawovQjMytVv0IwXtTcK3m/mqVuETgbG1RZpFWU74hoq9YFVWcKMwgppi+il+uLk9kDrcAeeewywe8npBCRwxYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8506.apcprd06.prod.outlook.com (2603:1096:d10:8f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 07:53:26 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:53:26 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Pan Chuang <panchuang@vivo.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org (open list:AMD SENSOR FUSION HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/4] HID: Remove redundant error messages on IRQ request failure
Date: Thu, 16 Jul 2026 15:51:50 +0800
Message-Id: <20260716075203.593012-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a2ec49-5679-4212-6273-08dee30f5147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|10067099003|6133799003|11063799006|56012099006|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	Gk4gC3lIFGJUc+TwkTC2q7LG8kKmS4wjaymaKODGTER6sb2vsbGQM4IEFyfk381G3uW0cl5e/sGuH1adCDfCwTS7PnCfQKskM8CcCLWtLetDv3L0EdBMM6PdbXuqpH83CGUKuKgpMKjJqRJoOH/sZM1LSxGGtEk6TF7rAiucIo2utexp7NGVKib40h6QHcNA+W4Lwxu5JbFBfDFRjLhi6bPeUcLk52lvYlSDDZZL/E5IIhwRzYVaSDcSqLeqF/vYlvDU8hzRhn/imupxiBy5a4q4kkNT4CEm0H8mvktI3duJWX3VcUdVaX+DEh+TJcRo4dsWnBVBTLSdkrvI1XODlxonphywt5BosNytzb7mkvhGmaPZJx79q0qNjMRYUHPpCxM/Xx18PzSUlZFCGGTQiN6Gnmb9yj6Lu+YTLtbklSdtP6L09SOT7j2f3RinLAT+tSp4CIq+sR97mK4Xbx52pHxmt1AqH+kEULGJJ3cV6U/fkDvRBuUXe5otfJHTTLnq+/mIYcQDJbLUQxVVDvAmwOgwf5wjgqK6oRJopmSCn8drQfCUNi9hM16wumQe433btD2gJTaFyl48J9nq+f5C4vQCAcnj9IfM2pTIFE34C5L4Ugf7NqAfdrXUYYEwAlOvkoVb8tHvjcJMD1M4borj3QJj8BnC0vgYse6UnSIhH7/2/OZsrtmNoMNDAuRRcYF0D7k/3Z+0mK5q0wlYXi6q1S1x0pR+BhMlVLWvuu9O9EotRnlYHx5PY2Td8sICT6VH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apmZB6eJHW3L48RpkYaKlNB3+NweRgSRTu3wy5bnbY9Z30Nf3l6X2OIS6SHw?=
 =?us-ascii?Q?v0ovfJqwqbHBk8YeqS3WXfeFnUajz/72mroQ5y2nEyXcXJkV/4q7emGyxJx/?=
 =?us-ascii?Q?9rjlFoh145Zi42Lc4nr/EfQNNX/acv1vsMRzcEr0uITBefsWO27DWpjNUs0P?=
 =?us-ascii?Q?iRmLAjPfq3jmYSipZz9wrLZVCuTb7FatHgPY5HMqfQlVbhXI56Utm/ILagwS?=
 =?us-ascii?Q?Iaw5wMogYq0fpllXnwg5BXw6rKq+iPnOOT+lQeKFPXtmTAzUqIc8kBWoGBSb?=
 =?us-ascii?Q?QMQRdRmZ8keIhPGzJOqRfntiNgaVR3jKDYzQzCKbFHGabZrMsOwQcaubZVhI?=
 =?us-ascii?Q?3NnUOEMs1ppkhJfxGQ8OxOVXgB3mqMlI7lkGWWEC6SFjHhnx3lkboD0LFM+N?=
 =?us-ascii?Q?KAQ0EBX0xOEb92l1w3p/2Mh+086HfJF+LttD+RGEuG/Kac6wwzT1e0d7yRVf?=
 =?us-ascii?Q?EAd9JHtKGc38dxUUhsJjlPRrlMMi+UM+vrPJmzUAwZwOBjWOP4kugtog6ZSu?=
 =?us-ascii?Q?FeId4l647ikdg9BsuRh/ZI5a4rzFCd27NrFUdEa3MTqu4yxYaZ/2WXYZb3X+?=
 =?us-ascii?Q?uuUcI40nLOyDxykar/EGtlx0iKmysqgz4nxGeZXpT10lXHtM+TMDI5EXrERF?=
 =?us-ascii?Q?s3urUThkZCtRTTMxQpBw3G6kr4v6vgIvC/EIx2b4S93x+/38VmMA1nM0hxWi?=
 =?us-ascii?Q?oo6vpkTfCr/5nnqcHYIFAf/yYGsRrfEd89vEQWL/ylddbH64V2A4cyv2H3ku?=
 =?us-ascii?Q?1wm/qBI2MbmnOk2q5P3ykc3U4K+xkUuSGLOHhqqiDFR/rPRuhi1Wmlaofj4Y?=
 =?us-ascii?Q?+/5nv8VsEo0d6wwoTNc+KegaoOcwG/eK8Fr25E2ns32fPNcok4VU35ZfLNSW?=
 =?us-ascii?Q?UVoxEElu+uzA5WJY/5de/aufFLEWg2OPeb1PaS4hnz19ffT6xYFpIC1kfVMg?=
 =?us-ascii?Q?fUlcHyHHSb/nvUTbBzTvTdHuAntR1KVdOVkAEOXKO2gy8QBEDdlOUA1lXpaf?=
 =?us-ascii?Q?yQDYERoliigxt3imaC3K9hki2PEVkFXWZmRl1bImO30wGxkPVg1UI8MXgIxE?=
 =?us-ascii?Q?8UnJ58DCo9kNuvZ9cMTmN4W3LLX7rq/2HdLd1h3B+W2NDP+r/+NzF2SO7JNa?=
 =?us-ascii?Q?ty0vu4ehvNQ/Emj8GBCvSgm3uhk9GJDfr5/V2asWhBgI3oDZkccewYJFM74b?=
 =?us-ascii?Q?Rp/TKogXILw4RujunlZgD47dtHempmyBgt2oJrB5zhT2PGUPcSzuThbc6C+Z?=
 =?us-ascii?Q?ty4Cw28m9hzJ0q1Y/OBsjft+ye2IQHLMsd+QZNOratgEqHy5NFqpvqcbwAEo?=
 =?us-ascii?Q?NC9aoMFOkjfqT77EsLQ00PyG+QY7uBFk5tc3yLKshupDflkkcUOitUEVWd5x?=
 =?us-ascii?Q?NcrSYYAWU5ZAJEY8XSlrFCacL1TZHibtkHiCScg+dz9noMaVBZ2/NvmokYru?=
 =?us-ascii?Q?6oK+GyGQ4b/gfLjPblwe5HiDvEqAY1djyJ25wGPED9RSJeres6pca6TvX1wv?=
 =?us-ascii?Q?/+n3LSDa2lFE2HFTvPJuN+CnyrpqwBLo9iryaBXLCHkODG8nqrkrSfNW5Wi3?=
 =?us-ascii?Q?3HlY/b+Ts2YZd4+Ds/AQrJKEc/WMa22O4qBuElDrmiMchjKLqwmEnp4Z3q+l?=
 =?us-ascii?Q?Az/sPoDybWEx7MqLLAg9vzNRs58zOSDTpcmt1M4NORXgo5tok6YgVymqgOl5?=
 =?us-ascii?Q?2deEmhPGlUmsmZKEo5DSn+A+6lvwCN6VGZFJi4UfxbDArzHX58BKbfZECiDZ?=
 =?us-ascii?Q?+lxSte/5WA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a2ec49-5679-4212-6273-08dee30f5147
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:53:26.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqn9bWDWt4BRBcB7jE45mCncmzO5905eyY0J8BWNdmd01BLmIj5JkdYB5OUbje25Xc4bdHwa9WFFrX7UKNlXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8506

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in hid drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

v1 -> v2:
- Added the same change for the intel-quicki2c driver

Pan Chuang (4):
  HID: amd_sfh: Remove redundant dev_err()
  HID: hid-goodix: Remove redundant dev_err()
  HID: intel-ish-hid: ipc: Remove redundant dev_err()
  HID: Intel-thc-hid: Remove redundant dev_err()

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                  | 5 +----
 drivers/hid/hid-goodix-spi.c                            | 5 +----
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                 | 4 +---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 5 +----
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 5 +----
 5 files changed, 5 insertions(+), 19 deletions(-)

-- 
2.34.1

