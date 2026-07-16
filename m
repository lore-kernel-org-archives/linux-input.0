Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09409353A6B;
	Thu, 16 Jul 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188421; cv=fail; b=ffHWYDkH9VSfE6dHpkaDjtFW6GN5WvPm9+VISOZ86O+dWRGCQ9skzSiYpxnG6tRlDjWXlWt6UG4EoIS7mTQ956dG5ARiWiYpoZ5cAcqL1bToMB39lubpTi9wuW8DrCX34uaXDZEcpSIg0hONgUecFqExxmBYw6sfuUruh9ZpRKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188421; c=relaxed/simple;
	bh=RfcLwio2xhj+JmVFhCDTCcCpVApUvZ5JC1yq4Kst0K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ms6NgIAW+lBpCJwTm015P59/uFkCsMYygPSItBCNHPUD0f3r0weFCyqUa8rgoh9dOkOscqhv4DTv7WfAk80ngcMplDVWblLErrZYE9svVJcWMd+X8DpZ/VwzqN2LMRF4oe9xMU+wVh7l/NZbKqkkPnsooUNGN8JWmCNnx5zG/qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FAauIkHE; arc=fail smtp.client-ip=40.107.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FAauIkHE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wslwxy8zFLV/uTQaBGIEWbne320kDFVNwAChAxctosXjXEUUpK0qfn+/5cpkGacUyQhGNOoUf1+ddXsEiWUaFt9FODQiQ+q6eqCM+SfCGuB8lnOvGMmmThnPpZwRojmFDExn2wze13h6O9hy6ASu8nt1CP10Nsh6q8Y7zsXVQg99UvJkArxhoSyyroGHYEEoy0ZGVjvdaWsK+v2m+nJXCSr4dEEBug2fb7WBAepneUgt4W0OZ3gu1I3mV2pkolkvD++0WRJT0REQ/7c18/FlN/On2r45vydygIVv4Pho2dp+kVE20FveDz7HblTB8jYtNIUzluxexR8gxvpb1mnURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EljfDAkC2xOndzkvxHtJyc4iXYMghDoSHgInh4tw6fo=;
 b=BvtTk8kYmLoHIB+jA8WnOV3cmcnnDOomTcirGkBE5hUdlh9hiQu5S4EINgQ5o4xWPEvdZ+61gqCJODt2JC2PzJaKJ62so/xPPMZ7kqswSQN36BnZKolvdaCK0Xqx/fvrpScIh4BEMrTOq+hWylLvm31tMfBPaUMFSwpXMdz6sYKH3jFTMAFkf8W0UCyk7xF7L0X4UCNmg7/liOnLGTH/2COJ9aSv4oFb2IsRfyiBxekxKHqqpGVdu1AWpicL3i8nfXTFZjD5eiI3Ks7TGqje1UIHR/QuTGp2AdLwcGlnSInog6D+gP53Ta7duQfPkQsoKjpao0nrrLxtcPWf6h8jHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljfDAkC2xOndzkvxHtJyc4iXYMghDoSHgInh4tw6fo=;
 b=FAauIkHEL+SbKsj84WKw4mDwJaILeS9tTZ/rIYiZb8inT8d2MgTyE+w34FJ66rPLLOia9qrjoo3L+0ZnjoXS1es/cCZ3K1NuoGvBowZNiuEVnyW+yT5eJqHek93mVCJpb168/QJACOiqq2pV9lWsUSHGW6FAV907FKozvhS2WCNJTDVCUdQ5DD5uLXU6J/KFkGwZisnUk46FN17a/CzAofyBicqeaOcdimDM6SkIWvR+j8byyc4Kl2aWz4Nn0BwlOP9Q1Uy2mKDon6oE1W8H7+M/qc3hgbVxAhF7g98YPYT7W0YYecUcZ0mSwzLFubacVPaRvOMhs/6MuWS8Fi98cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8506.apcprd06.prod.outlook.com (2603:1096:d10:8f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 07:53:28 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:53:28 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org (open list:AMD SENSOR FUSION HUB DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v2 1/4] HID: amd_sfh: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 15:51:51 +0800
Message-Id: <20260716075203.593012-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716075203.593012-1-panchuang@vivo.com>
References: <20260716075203.593012-1-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77da3db5-82ab-4dce-7c56-08dee30f5245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|10067099003|6133799003|11063799006|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	D8YqX20p7uCcJPqom2n4+GrnquXqnJh9t13DiQD9V357FJxBB9kTOye9Ghjl14E/8Wt/90fqlVeINfQYOrxDxkuPveGg0tlXygJspMcdpGK1aVn0965Q+J3iZoFcGZAmVmLHlPpTgj9/c8xWJhzGhwckLCbjtFV8rvlh2ARoxfackmp8adY4ByhVjVHT0pmpGFmyknePeapI1og4Pu7Gy83Gtav8VLFyu+gY87dOOJmlfpvqR7FAftO04lze4bdieV/GOABKp5TdxXcVch4JdJ5fUGyyAcLefaAIHR3KYkZbAfaaujYOrKoj7HYfShmYwyOwlbsaOr2ivNqASBtFsXvqukVz9akRi6rS785RRQKXRK16LMjoVbVw1Od6qHqrRX/G8k2Uvylf0KTrscVTWeFbsDcqHZhXTEbOeLpWz+emMxi2RZlLMEfG9eLbWl6TfKTXsekLaLXPT4iMlmJpTAlbiwo60EtlwGju5q1Ndm/dRdW5LEVbp+c48eFCGBeRzF1bE9sPEh7PryYwaKp6sBU6/ut8tB7/SK4bhoX1amRVcLw90lvsGlVWKyYHxakE0SSJj9z25jGJQlzTyjF/Z7cyJwyShMV88xfrIi0XFCaIGiHf+gk1OrOzB1CaVmG8zPkSBTkSiSkXC8NVxqtTKjQtGzKgIiNYjkHgGYAPO77XN0HlLYpXEwQzZY2gO4QHtMELM7usP9meWuuL/cP27dnnxeE92z9JoEmkuFBTxU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(10067099003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pKAyjEj5HoPp4H7jABxX3PevrvICbTOk/h0ygRS+I3t4Kw3PVXQkVYz9lREh?=
 =?us-ascii?Q?c1sr/1sYdHhZqmqudfJDSCSg/5NmTXxnSSxjHVXHPiVqePvihDqKLh9BIIh3?=
 =?us-ascii?Q?L/ssttdCCyvEfwdsKT3Yf88ZHQB8aP4dO7uSEF5t0giMsIAgOyX8t27Fq/AF?=
 =?us-ascii?Q?E8nPKluvmjy4TJcnp02IdDVAP8eIpCBepWVYQIJW0uYohu2tKAtVOJ/DcejS?=
 =?us-ascii?Q?UwqgtubO5Bmha+jDF0ZX4irPX/vfPu6zBzvlQ2iGcWKgRcXEDFr/Rd9+O4aj?=
 =?us-ascii?Q?Z618y3KlaXtcYr9ouFMvU1gBX5fXmsdqr0e+OPEZqBGehz5PssUnNpQj717z?=
 =?us-ascii?Q?YkK0M12AQ/7AMS/DeSvz8ykZFjAKu9b7FfGcoWn9wef20FKkiQy1ZmFhdlzn?=
 =?us-ascii?Q?qxncP47B2QT55p89vSykt2FbnbPYTeftETeX55YM13YaItuz7wHeFPLlvq+r?=
 =?us-ascii?Q?xKLEBISgmBCweiAgnbGMH8z7LBSC2LjkoxGL5Wnyl+A0Apv11i8zVDK1DDit?=
 =?us-ascii?Q?7xRtj1B933EWVJxvizdQuWxvRqzfmchHsVT+NDvyOXyDIRmgV1UwWgIK3ay/?=
 =?us-ascii?Q?vdgqf/4la40d3wjwnzv01NKa1Yq/aFRxonE42ClZAA+Zzad6UinNFn6gnBTE?=
 =?us-ascii?Q?n3opmexHcc53b0u2Jz8JP6oOYrmNcxXpE9ooge7Ca67qnPImVaK5tIXCAbS4?=
 =?us-ascii?Q?KdosBJ1reYDPT9h9ZiNG6eFYCJszf153uEC3vQ4YE+haw11k5chxZHoUQQla?=
 =?us-ascii?Q?Ih3ZLfoHtcr/GsEZxxQFeMb4xLRsPlaLUSpoXHLG8YJOz65BMsKC3qO1DY6j?=
 =?us-ascii?Q?KDLUadoSLZRhmqXZvPYO5rKwv5vbuf/VZ5ZXSdFQpxg3G4e9YwGMt6gH22Mn?=
 =?us-ascii?Q?ZiykWdfya88EIThlsa7P1NH1ZU2HW2dYey5F62t87wpxkIgYBhZquU9lDsEQ?=
 =?us-ascii?Q?q/cNe7DX+J2/YB+1LxYlHNLOS6tTKN8D8YD9MQCg4UUzybtDdv2E6POz31D2?=
 =?us-ascii?Q?4owczJ4Mxs07NpaWpffLFtYkYWZCZrktKb9fiRXvvzELb3D/qqnebZBRJDBJ?=
 =?us-ascii?Q?U6BucE3GTPPu7Wex0H73juS+ERkYHOCidrDz/pFh8Ez0EQkjuT062481LKpR?=
 =?us-ascii?Q?8xolVm54kCAaOx522BRPyZv/vx3QO17P5vks8Ri6DRY3gHimgUDNAjJoFylf?=
 =?us-ascii?Q?qDeuygUcHAGhGFHfOgXUgYTKSxNvepPzElTCoKhB4Ih1nEkWfJHTQQDNogC6?=
 =?us-ascii?Q?qj5920MCRzqvKlEqmMaKAayrqCcUf52/oJr2UFdH0nYZQgQ1YDmPDaeT61OA?=
 =?us-ascii?Q?KcHARClLkQnmaV5511uQUtBeU0p1bGMjjS+EldRMOxKDchpgh3BpdwaotSiE?=
 =?us-ascii?Q?UIb/nMfQ+UpHPHmWoE24UCzXuKdaG7cNTUsmtmXFZMyEgCIkb4CuP475H7gi?=
 =?us-ascii?Q?CkBkcu+HG5u3/rIao/v9lWCDCYV/GMRuWMkzkelDroqslnRZqyd1BIuB559H?=
 =?us-ascii?Q?pLacdwPGsNOzskvxW5znj/T9lRaPzQs8hnuOwzcfcL4DLzqsr6dwiGeYnO/n?=
 =?us-ascii?Q?MOlDNQeE4/z41WGVzTebus75LCp7QIblehInNrW1II2M9IDnxJhYzDqNYvSr?=
 =?us-ascii?Q?+8Vp2QqoXrxSEWvDYLLL3+4njjjZjbIMCSKgAKpmlMm3BvdIf2zK9xjJ4Rq8?=
 =?us-ascii?Q?JKdxNvYOqAMqH++MSOvBr87JxSiQU27vhqe0TUAuhZIwVmGzYgLoEKDJnU+e?=
 =?us-ascii?Q?dRyBsHVzQQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da3db5-82ab-4dce-7c56-08dee30f5245
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:53:27.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOlwig63v57CkmN0fKPO/F7vNLWaLHfi0beN4wiyof/S/PimJQqgUfkQDCFqD7ITGuaIAyp6YiWGLcyOadREyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8506

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 4b81cebdc335..a2acd3ca20e2 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -128,11 +128,8 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 
 	rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
 			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
-	if (rc) {
-		dev_err(&privdata->pdev->dev, "failed to request irq %d err=%d\n",
-			privdata->pdev->irq, rc);
+	if (rc)
 		return rc;
-	}
 
 	return 0;
 }
-- 
2.34.1

