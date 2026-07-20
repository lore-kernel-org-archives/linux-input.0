Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012006.outbound.protection.outlook.com [40.107.75.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FD73B3C14;
	Mon, 20 Jul 2026 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537169; cv=fail; b=aZWjj+fTv+SEhhjc5ZgCneXPe/HP8EaRTjWXPF/xp4biL3mCkOV12nLdk801yZNMx7m6G58FkfNNAbYFVGMEXMNWQwu1njsDcatfZbb43UkIb0jjUt8923jkc4gZNU5VLUXS4MOVcBxD79sI2QQU6a9w+44kIWQmQhx6+QxKZHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537169; c=relaxed/simple;
	bh=HKxLMyO/uAqHrxwkQrOd99u6GzKii0k1t2OrmCjAONM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=G7do5s3u5zapEXRrLhczlxHIEARB6LTO+63w1oYR2QwQ4I5LnBcVtb9iSKEeAESo/+PU5jZz4Yf3ul0MmbFGJjANqP11oHgnUhMOWTzjWKDByhl9k7uk2YXUJSLq79f/rngl6p8Jb2A7HgKo7nmsRICjCrPX+sNIku5pUJptQlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=enbXGol1; arc=fail smtp.client-ip=40.107.75.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="enbXGol1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxbCvY5urbYmF9Gfhr04zxDFOAHE56Jan/ioZWCQKuYFye5jfoCFHYz22BWZ38eGyx6JH4CkqQ+hDWi3nkyuHORjmJbpDb3WRSkLRPWupRMPuyAgjCdYu9D+5hiJ4TtgvhprFZHFe2FEER6w9IkZWVY1Z1fSqOIIwIB4RLWhkKy5vfgvSgXe56cBRAvk7lHl/6ytQlSaLAityOatxU+ZWJ8LFZzWupKILCirvni0oHsLKmEtLA1SJ4MgdTjKzM1c3XJwso+IrtHwQ5q088uqPoY40Ef5DPt65RxPgQBja3cZIm4r2V1op9JH01W8+cBnulc+uxNc+6micODRV+0eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Atwya5ARqjarxigCbn1S1UIvJ9CAqxRIEy34YYZKZsw=;
 b=ncbemSYfIBt3ye4RPWpIyEdiv5J+bkESygdBQTPCEht+O3nXN8scw207swR6NGWuBafxTvT7mVkKzZj4ey0llXZvjd89hj2Va8rqHkJz9GlzdMEwAoHdmf1f5k3BFQSVlJN1O9vb0dSMBfZl89mOqt6acEG1LHj1KbXYk+T6HpGCMQVzKySX8C6c/2O0EfcVkuiANtVYJgvC02/88qefwivHrwAhh9kijjKfWADJ8px1UU/gojf6ZujdLUGig2SlPXpnMLMkNxWn4xEe7nhvNbs5hYsQH0ej6nbCrSKC9lZhLuc3JbFwp4n7H7qIYNb1L1r4tt+ZXT8jiRXmyTI2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Atwya5ARqjarxigCbn1S1UIvJ9CAqxRIEy34YYZKZsw=;
 b=enbXGol1XsZYhcb3HuWGeVpSkgtg09QyAaMD5VMWfXk1OAYJHkzoJjtBzwkv8h42jHUY7HeRQA3nrDxciCsSLpKAR8mPyhR8Tg/W+0XsULoFcMaquqfS5s0QZP98rCdbFMWgi0wU8AczTZqGrt2uuZsmvXVkimz/Hx+SFnLWoV/poTntB7dGQU5oGhbf14wTg8w9zLbtso0L6TuvGLRwXQX05qWt7uCVsIKYObfLqcGEuLJO+i90QfdwZNZsvykZHDnbSv7mRyNQ9+QlOPrOYttvxIbXskuWSe7JD4VLHU2cqrY/lYRHhA+HKI2nM+Rqofa3sf/4kqINd/4PMc2xmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KL1PR06MB6044.apcprd06.prod.outlook.com (2603:1096:820:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 08:46:01 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 08:46:00 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Pan Chuang <panchuang@vivo.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org (open list:AMD SENSOR FUSION HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/4] HID: Remove redundant error messages on IRQ request failure
Date: Mon, 20 Jul 2026 16:42:58 +0800
Message-Id: <20260720084310.210976-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 26fbcb44-901b-4a58-434d-08dee63b5300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|23010399003|366016|921020|38350700014|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6JRKKQy3B03Pdqi/7pLXTYJllghzFVkRxXaIXy1Rh6fokhGIzhJfxgoHJwTmswfS42GXeDOjVztQ2EdyX4n+7QBpGX8H6y1oyAVgj3pNRlONgQhUizWP7XJkfOgudYmmsUiCW8ohyN0JjuAyLujrX4NVbzp+iUvdOimPwkYlW0BhFRW86v/G2VNV5zJSyiVuXa/gL/sqCL6KLfx1pYae2LBXQY09JqZxluaZ53Y06Gm92LCs6vmOZ26TnXj81MSdqooCCOY/C8px4dDWi3UVGQlEHihftxBs94RrOOz1IMMCR+IRVBUDhK/zIhMB8IWPkzimqZxOpQ6gTbzFckzLCGhuQbNsEttZz7Fc0UK68V242S8W0kcap6YsvNUqUYNrTrtv5jvvyTQElDHvM/VEWNEBQ+Dbrx3Xc5XltdhEtKth8Q0NcQZvo7D8zwGu8+rFnrA7Ncjl8v+Dsjiw/hUIm8VfPj8nfA9Mc+2m9iGm1eNrrSw4fGPA7l9LlpLqlGaUPx/8KL55OrFXRo6IdgTRGgx2Hzx+AMYD/gffWZDV70o5VJJcFaR/w4xGWxv9JrH2mPlVM5YSsKVXHtn2VPU+iI+ygnW56RslgFzPfvjsuLCobzUbDZubzCv9hjcPU5TRxp2sXtOoY2RD61uQVABnoRlDD6kj4Ja5vcfQRIu51kYEcbXYVI+zaoVTkkIX1zwvTYv6w/PTbF5KybebQ4xqTn2I/4TNsH76lkouFgtPguZLxzYzn0Y0FomJxZZ+a4/v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(23010399003)(366016)(921020)(38350700014)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5VIcD42DE0XmkFFedsRZpzDWKtiXnmKG0aiMmFn51DXs0IB6oIVLD2tD4f3?=
 =?us-ascii?Q?BWXlzj5bTsG7Vn6z0bBCOGUm1gr4wa8Q2xbGysc71vhXNOOGvnyRCmI31TDQ?=
 =?us-ascii?Q?fnQXFFcU9K9zLA7Y0XJBAJpEG1T+jC6I53duvr0GApwxyb8JT917ybaA9b+f?=
 =?us-ascii?Q?+UDgRMjLtHkipoiF5VKBYwWbUd/YF43u+GZEZqjkhnC3NGN7+6nYc7B7mE3/?=
 =?us-ascii?Q?xvPhxOaYoTXgUi3vG19MRuAzWqfSAAnLCO05V7Gr9dccVqvUzgquJobETGCT?=
 =?us-ascii?Q?oGbM2Sap6dCNe5ocmad8+mk8CuiRLCJ7s8ciYk9KqNmzhh2yuotukJPxDLxP?=
 =?us-ascii?Q?ssw3c3Jp5aguZweIJM3PuEejglNrySk/XBOM0eqQ0Dn5fbEVIP5xeAZeQ6Db?=
 =?us-ascii?Q?dq40FK+g6IYcu7hzQiYhlJXjWGeXC634JojY0dRJA1X3UhX1lNVEfiHhROy0?=
 =?us-ascii?Q?iAYYWsNRvEuZRfSMn37JywNv9OnadLvMNy5ShRl0W1Wa6jdvHx1/BSVjh2A4?=
 =?us-ascii?Q?GHen+CIY0DoMWdje5pBJnRgjyHfs2r+KtCoAiuWqsx5X4RcJWZEIpB6TXdlM?=
 =?us-ascii?Q?fIsorSGndcUtRuuTpUD4rzOGpYT2fiKXOHYs7hNdZWp7tf4B2SN28UP5qIrD?=
 =?us-ascii?Q?G93QUqIvSPHLR045XhAiih7ljYKTmXJ2Ndmu22vyIVUo630MBtUGDO2Hf/Nz?=
 =?us-ascii?Q?JDGI/qNroNbuvI/h85elNPTxuAl+hdrIjIpEIgLKzYSBlG5rbPV9A3ltxmf5?=
 =?us-ascii?Q?MVfa42ZbUDFiqx81NM+rSWQhVhYrHwV0eY0P35Tfh2rU6GrfJDDj908Tx0fd?=
 =?us-ascii?Q?dI88Unq873XHhmuK/L19wEGHQUGCc3u5gYjBvrBdWh9wkdsMJ+2Rk4ySOUOp?=
 =?us-ascii?Q?jhu+GJlcH98WIxSwSwamxZ/V6fdXsQJetNAbaaJWzWpANXGDwmwHLk81ByxA?=
 =?us-ascii?Q?9jRztPqULemTqyDV3j/WsjZc2jFq6pjpcg5uhOj5mwOX1qqEapSH+3nl+5H4?=
 =?us-ascii?Q?4Q9w3iDoKvUVvmSqHXx0VJmVRK8711whIA+kLk31lUsk8l3vwTs0Rx/Uppkt?=
 =?us-ascii?Q?qQ04g3LsOnk/uaHV0qKx2wyLFa1NUuQCUITntuJgLzeR34TuHiSxgVuAloST?=
 =?us-ascii?Q?0rAisJRg7UpRhD07iYfH+A0nMdSaqoKePNDZjDZFkByCb7QWhO8pw7XJtaga?=
 =?us-ascii?Q?LajdXXIkdqaWJ9dKWrkdEj/TmpdulqyB+ax7iSZZ5l6XPS+JDMpiPLt21qVg?=
 =?us-ascii?Q?S7cbkAeLMbASvODR2zwkmY6sKDMqikveOtCcmpisdDOOJTBl3JnOfXzIixsn?=
 =?us-ascii?Q?vgL2+kreefAhL2toMTTRwHEtNf4KLihdVM6uUf4wYVY+SoBrvVTYRg0CFdbc?=
 =?us-ascii?Q?ib1M3a9BHA6tlgOuJ48JZnEOUvEpWsVmHj4lyDVz6HyincskbLo4p9dunHTM?=
 =?us-ascii?Q?7Q+toHBr2/uqrEBKJYQR8bQiNrAul4kuXl7KJpOmuAqRetsAtfOA76y7YFaa?=
 =?us-ascii?Q?U3+eEmsIlVLWa8mXD3MnoxJGSeZV3kWKkYlYtuf/7lND9krWaLsPPn3D707k?=
 =?us-ascii?Q?lxnZBNWdtz1QDb9zjvPOFgsX7pg+A7wyGDNUkI+SwIjOdKIET9BcQEtO8G8t?=
 =?us-ascii?Q?kpD1EOw4tPBev6L/g+JEKQ6RMoD5Y02IJrGhTnnDrDaalibwBdOdxvYLcIOq?=
 =?us-ascii?Q?F66FTYLKhkygMvNxVSnVpSd+68Q5kts5LYT2aMPxubQpNxLRxeW0dLGNSkCz?=
 =?us-ascii?Q?jrhXxSS9kw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fbcb44-901b-4a58-434d-08dee63b5300
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:46:00.6795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpy483cbWpG1YIYXxaxbbrW6rWyZ6kAW6TuUST0XRuyGG3n06BIgGMHzKHxAiVF5Tbl71yDl3mY2hpdYCpJAsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6044

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

v2 -> v3:
- amd_sfh: directly return devm_request_irq() result

Pan Chuang (4):
  HID: amd_sfh: Remove redundant dev_err()
  HID: hid-goodix: Remove redundant dev_err()
  HID: intel-ish-hid: ipc: Remove redundant dev_err()
  HID: Intel-thc-hid: Remove redundant dev_err()

 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c              | 13 ++-----------
 drivers/hid/hid-goodix-spi.c                        |  5 +----
 drivers/hid/intel-ish-hid/ipc/pci-ish.c             |  4 +---
 .../hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c |  5 +----
 .../hid/intel-thc-hid/intel-quickspi/pci-quickspi.c |  5 +----
 5 files changed, 6 insertions(+), 26 deletions(-)

-- 
2.34.1

