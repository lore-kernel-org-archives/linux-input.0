Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696913B6BF3;
	Mon, 20 Jul 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537179; cv=fail; b=MW4VOS+m+Oh9rTXrnj3iUD4G/lZRzIoMpUEUSzDpGyZM3eKy+mqX06hIxfgjB3XpAES4sFymDDEBQXk6FIt4WGuqIZkWtvCLgxpRTnIgrchfKwm4LTIqTxmcbqwbtEmxpgZpFYsKx31TSuJHLSbYYLPQxghwf1pM4tzY4xWTjoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537179; c=relaxed/simple;
	bh=ZcNcckda1dnWUwD9TdPwawLmDQnlGaq6LY8VZt+uOaM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAL3Ba6sDy7hb059IcNnVJQYr05IhatUY2klKE0u0O1tOXgIfHATcBumNxwi7l0+tsMzDCfiRhzqyswgkJrfa6Xa+IpMV+CgI8MYuYWvPY/zexB+TtT1Vu158C/phsTf1QHNhTIPhX1F1T9ERuUm/E9yH0ZnEIkKidkeVovCkqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NEtSLf/j; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="NEtSLf/j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdoEffqY/z3d/kHdjSQxN3ecPqIMOSNsMSv4GnrUj+GPROdzxgbcv4/LHR05lmhYN6HMk5qkvp6sNwymNQG+mCFquG1Z3+uJ8u5MraLhsV0yv/VfIeFcRN5x5hzOv8KlJhWWENB/aYLMaeEA83nAEJMZr1E282uY+jVTn5GFUU+CpUD4ZSfZDgS7ea+abpac+ecL8TIOOr0GJRLFddViwXR+jZxq541lSVl1dS66gBbr+V8DS3utdsVJND5aSlHYdBRThBtNL+b2jM8pjRi214Y7UKaIkoO0x6md63y1pAn8b5i2K1xBXjfoa0cuJxVhukpSd3aGggmH60/KPuaSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQqnkSRd4zAYbwzlRhVgThpJ44dUYWW6LZsP71AaZCU=;
 b=sxVyDsngTQqhXXFHkO9NthyQnNfWZuIzXk9YNUAPIoF+58fxSkSE90JleaJkz7kWaJp5a+ugv1ipz82VigMN2woiRbmkZI6iXVEXuhYPWs3J3KrbTBLNlzaMjLK22dzEBRm7PG0MiyTbrm55U2sDnO1pJ4GsCfe+8mlYYd0owudcxrdmt7l+Zv6mJ8l2T8GxMvJjRHydgsOWe8mBjboHFcL4x5UltEoURe7Xw/X7oTgTo8Esc9SHKhZkMi/2pJPIeTv20n7LF5ipz61GA5giUoTK+DM2HAdA7tDogVrKavZSIPk3Ca9U5zluAc1Uth/E8d+D1O7TjBCSBN3fePREkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQqnkSRd4zAYbwzlRhVgThpJ44dUYWW6LZsP71AaZCU=;
 b=NEtSLf/jBICQ5kjh5bgifQC61Gb/RUoPSO1+qpv5RQELSd4er8N3u0kVGKdwg/W4jczwt46Q56g+pG9oQ8Spk0Py9GstP1cb92Smnaj6VpDpD8lGbsmzN/Ov+Z4FxfLvAQD0pILSPkkZH7OnvT29P1qtx44paSUCsDB1/sUodtmN1kFviYq5HT0Li8SvoPt6+BOMkiZBVg90ZyGdiXcqYeEiWr4XDtNdwCpY0QD2URUCHfUlyHO2LbulPgBWgl0Cxl83YDZbA8FcDuL7bhibZKMZXCzT03i94rqKSZmikKjFnIs30E6lsHOswMfyG3lWaCveqKey1O93/sDiwH6jhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:46:07 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:46:07 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Pan Chuang <panchuang@vivo.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	linux-input@vger.kernel.org (open list:INTEL INTEGRATED SENSOR HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_err()
Date: Mon, 20 Jul 2026 16:43:01 +0800
Message-Id: <20260720084310.210976-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720084310.210976-1-panchuang@vivo.com>
References: <20260720084310.210976-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KL1PR06MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e00312a-e4e7-4686-0e8f-08dee63b5731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|23010399003|366016|38350700014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	YUk//l5mRzmuw3SvunEHSLeA2dwpk2yTc24Np1MJara1DpnbgzYBsq17qDDoiVR71kSIKWrycFfswV+r/g54TL3/5EkbW0goYcuM/3zXmU3YHy8IB5UUzJggPqxAHTnnyXjAwYbhelDvVBc43OrOvBmLIA6UWLjQ0I1vdLeuEqqE98Ot+GL9/IMucVHiVh4yGoQxgRVGfE6cSULoi22aLUmvrMCezjJDNtcIicKakmFo+oh3NGXJ4A2aeY05H/QAUJhfdUj4Vvcrfk1xfFGLomq/lUevG5qaHxehNncpxNt9juqngqeNz3ZCEDiHK+sOsz9MdDq8ospNcRtA8dZRx2+D3B9DLFsOmkalh6vPhuIK5FC/lKHLY9TZXW7gjx7BMpdLRk1Ps/5f8xsXFjsc9keySp3ZtFsz3ce6vqqkYgtF5Sa8xG+GQwsryoPbg8em3VlKQ/j6qWefdI153ECpekvbSFEsB3tP4O0L7yF5DcvoeJ4nUoYKvI5YVg/VfZtV80XNaGHCvi2ttyCUgCvV7/ZBktF0zv0UCY3UCZqk2WFcsHMnkXQzOzAbzS3kzvl3rOA+ABQR10V7qEC/6coQtc/IZr0kar9HT6PpNXXiwTffH5EEG0HntWR3nR//1hGjl+1z1Sw74VGCqv4s/a4teGioO/eIMYHu7Lz2a1of8UHfMapKTX3QgmhEbr5peLb68cQUkofqa9gplqDp0RbLl+QzhP9zFadzxim+AaFrG/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(23010399003)(366016)(38350700014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gdy3D/DRbWq0jKEgEHJc99P/+7YLDwtHchwpTSIB7JuJ7kozp4yvRweI2+WR?=
 =?us-ascii?Q?9jNXOs4egVE4JdymbPoAdqgAMj+C6LaR4QctpPJvL04n2TxwL+nidgdyDE71?=
 =?us-ascii?Q?db21D2aVF+80EIhLwFWYA7ySSf8WAlTCtnUAirqCyKuseIaipaFZVxVnXcme?=
 =?us-ascii?Q?77nVueW/u8NpcC2QGmbtn4QnIfILzOMIPYy8PPI9uvMqdD/kX0FayQwYYkBs?=
 =?us-ascii?Q?4L9mSs6rAFKKFYoI5S0FSu83tBEVG+rnAVDinxAkk7KzRVvc7ORi56zmI9a4?=
 =?us-ascii?Q?mu3omD+I1eWuvaF/LMVFfXv7DVKA9wDHZ6i6JBFFjKdZeNkKY+ZWzlCjL3Ey?=
 =?us-ascii?Q?oTbGmPfzySgFMlYYhTjqMQqOmIVgc7/2Xv5f86kt/O0wyOX3YJMr4WdqH0o4?=
 =?us-ascii?Q?EjLB5i3yPPrs8Ba0FK9zrS0DMa1Kh6oNd8MQlaM9G8aF1TnE7L2JHFhx9Ngt?=
 =?us-ascii?Q?ET2JsS2pgj+Ppr6cQ7HoYDu4cBA4TwxoYkwTmZxPhao7pQHwH0I/rkPC5R0D?=
 =?us-ascii?Q?9ShKMTL1/f/PRziVirb9d+yfsokZxdnfsvZnPCtE0iqoy5nwGSaYzKzMfmrQ?=
 =?us-ascii?Q?vFj8OGDgxpcH+9VKiQ1JwSvHe57/vFxYbG+FFNAPaBAQsPNu0mrMW/bYFJkG?=
 =?us-ascii?Q?h5p9ALMgmrU+rrTT+qHDJLQqPkuhuadsx2Vgu9MjZ+exszzK57RYzpKlCX0H?=
 =?us-ascii?Q?CcvL0QRe0SntU8sdDefx3i2geV8VxXOLlLxceH/e2mFL2WeahLF4LEsIUSgA?=
 =?us-ascii?Q?HTW4Ovq6lFiSBRQxBPzENYNfdC0YexM6n+GNIeBBCTfEFYYyOUg2AfLGkdd7?=
 =?us-ascii?Q?j4U8PkJydcUZjllbgXbiyV0/d50EZEzLk0p/t3z1nu/tW+4a/w06xJyhwllH?=
 =?us-ascii?Q?gfnTTRKGLXxRwXQ0sWsA6VtJ1wcwGCpCAgs1rXkdYy/4Z9K4MsrEbokL9Ope?=
 =?us-ascii?Q?p3KxF047BeVTDMaIqNwcgvAbjNBFB6gTjyDoO2yPJCusWsxapiGsWTmIhC/J?=
 =?us-ascii?Q?ZX6pcKKn+Pvv+ww6balkh75aDmu1biv8bNOKZWAWMyO6rgNJVAazoYarYhyN?=
 =?us-ascii?Q?EhTTWHkuELKXQc07CPFI57wHbFlfWHkeHtveb7ZzTpZxy5OcMviLuw5eRwCJ?=
 =?us-ascii?Q?BMlRCmLpPEAMD74JXszSSQXlM+YveXkkUtHG2LIfl0RTrooz93VY5x4ofBRf?=
 =?us-ascii?Q?IWAKjzsOql9kebBoYyfb6F7qu5f5O4lExQOzglcUlF8WonMalchBek7VsUzJ?=
 =?us-ascii?Q?pUpocgXppYpOcfzGW6ojncBiBl8BCuVjVS0cqJEoxypT51fN7hOU1MiKpBS+?=
 =?us-ascii?Q?cVXfeA1yz9cv9mX2Ut27lZfUzC1z7J5bKStl5oxlP5CB2hEYGRtr4pH3g0Dm?=
 =?us-ascii?Q?ptEV+11fv0o42JGux2TM7/sJQRKTJJ8roOHBnT7ldj+fGPDjUTBpqvodefwT?=
 =?us-ascii?Q?J7vss50+4R6srd4AK7a2MCnhhga+K48EUDlcoePdKPPiFfuK9tXsN3o/nG4r?=
 =?us-ascii?Q?3YOTk9VS+7jr+y80dapP/Q2Q16whTTbFeB2GHXcq3aSxpkbiKO0ehu87dOpm?=
 =?us-ascii?Q?WQkGthiMtDvT20J+KlryFR52752GG3WhVomk8SATJYYvSwQuk1e7/Bqc4nVv?=
 =?us-ascii?Q?421lXyMqMv9Nqc4+okK9mOM3bcuophIsuMoRUfVU8lstvnk63468WPa26/7X?=
 =?us-ascii?Q?SnMrGnh5Q/aDEk9UN8wra+T1AbzL1La+hy4WCqp4802Q6twG5MlMQJFOuiIg?=
 =?us-ascii?Q?1zIDOU1GIA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e00312a-e4e7-4686-0e8f-08dee63b5731
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:46:07.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J8DoevBMchzlzuStNPbzRIitfIC/PPS6HhyQ0C1jSBqV/nFyqV8UajjrnWlKGmVxvjc7MdIuHzwJ4l15r9NpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 8d36ae96a3ee..e7196e429c8b 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -232,10 +232,8 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = devm_request_irq(dev, pdev->irq, ish_irq_handler,
 			       irq_flag, KBUILD_MODNAME, ishtp);
-	if (ret) {
-		dev_err(dev, "ISH: request IRQ %d failed\n", pdev->irq);
+	if (ret)
 		return ret;
-	}
 
 	dev_set_drvdata(ishtp->devc, ishtp);
 
-- 
2.34.1

